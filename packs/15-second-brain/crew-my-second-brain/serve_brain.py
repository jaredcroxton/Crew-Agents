#!/usr/bin/env python3
"""Second brain server. Static site + POST /ask (claude CLI) + GET /events (SSE live growth).

Usage: python3 serve_brain.py [port] [site_dir]
Site dir must contain index.html, manifest.txt, scan_config.json (from build_map.py).
Stdlib only. Requires the `claude` CLI on PATH for /ask.
"""
import json
import os
import queue
import re
import subprocess
import sys
import threading
import time
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path

PORT = int(sys.argv[1]) if len(sys.argv) > 1 else 4880
SITE = Path(sys.argv[2]).resolve() if len(sys.argv) > 2 else Path(__file__).resolve().parent

def read_site(name, default=""):
    p = SITE / name
    return p.read_text() if p.exists() else default

CONFIG = json.loads(read_site("scan_config.json", "{}"))
OWNER = CONFIG.get("owner", "the owner")

# optional premium voice: ElevenLabs key via env or a key file next to the site
ELEVEN_KEY = os.environ.get("ELEVENLABS_API_KEY", "").strip()
if not ELEVEN_KEY and (SITE / "elevenlabs.key").exists():
    ELEVEN_KEY = (SITE / "elevenlabs.key").read_text().strip()
ELEVEN_VOICE = os.environ.get("ELEVEN_VOICE_ID", "21m00Tcm4TlvDq8ikWAM").strip()

def eleven_tts(text):
    import urllib.request
    req = urllib.request.Request(
        f"https://api.elevenlabs.io/v1/text-to-speech/{ELEVEN_VOICE}",
        data=json.dumps({"text": text[:2500], "model_id": "eleven_turbo_v2_5"}).encode(),
        headers={"xi-api-key": ELEVEN_KEY, "Content-Type": "application/json",
                 "Accept": "audio/mpeg"},
    )
    with urllib.request.urlopen(req, timeout=60) as r:
        return r.read()

clients = []
clients_lock = threading.Lock()

def broadcast(event):
    payload = json.dumps(event)
    with clients_lock:
        for q in list(clients):
            q.put(payload)

# ---- live watcher over memory dirs ----

def parse_memory_file(path):
    try:
        text = Path(path).read_text()[:4000]
    except OSError:
        return None
    def grab(field):
        m = re.search(rf"^{field}:\s*(.+)$", text, re.MULTILINE)
        return m.group(1).strip() if m else ""
    name = grab("name") or Path(path).stem
    desc = grab("description")[:220]
    mtype = grab("type")
    group = "personal" if mtype in ("user", "feedback") else "other"
    return {
        "id": Path(path).stem,
        "label": name.replace("-", " ").replace("_", " "),
        "kind": "memory",
        "description": desc or "new memory",
        "path": str(path),
        "url": "",
        "group": group,
        "born": int(time.time()),
    }

def watcher():
    dirs = [Path(d) for d in CONFIG.get("memory_dirs", []) if Path(d).is_dir()]
    if not dirs:
        return
    def snapshot():
        state = {}
        for d in dirs:
            try:
                for f in d.iterdir():
                    if f.suffix == ".md" and f.name != "MEMORY.md":
                        state[str(f)] = f.stat().st_mtime
            except OSError:
                pass
        return state
    known = snapshot()
    while True:
        time.sleep(2.0)
        current = snapshot()
        for path in current:
            if path not in known:
                node = parse_memory_file(path)
                if node:
                    broadcast({"type": "added", "node": node})
            elif current[path] != known[path]:
                node = parse_memory_file(path)
                if node:
                    broadcast({"type": "changed", "node": node})
        for path in known:
            if path not in current:
                broadcast({"type": "removed", "id": Path(path).stem})
        known = current

# ---- ask the brain via claude CLI ----

ASK_TIMEOUT = 120

def ask_brain(question):
    manifest = read_site("manifest.txt")
    if not manifest:
        return {"answer": "No manifest found. Rebuild with build_map.py.", "cited": []}
    prompt = (
        f"You are the retrieval layer of {OWNER}'s second brain. Below is the full "
        "manifest of everything the brain contains, one node per line as "
        "id | label | description.\n\n"
        f"{manifest}\n\n"
        f"Question: {question}\n\n"
        "Answer from the manifest only. Do not use any tools. Reply with ONLY a JSON "
        "object, no markdown fences, shaped exactly like: "
        '{"answer": "3-6 sentence plain-language answer", "cited": ["node-id", ...]} '
        "where cited lists the 3-8 node ids most relevant to the answer, most "
        "important first. Use exact ids from the manifest."
    )
    try:
        proc = subprocess.run(
            ["claude", "-p", prompt, "--output-format", "json"],
            capture_output=True, text=True, timeout=ASK_TIMEOUT,
        )
    except FileNotFoundError:
        return {"answer": "claude CLI not found on PATH.", "cited": []}
    except subprocess.TimeoutExpired:
        return {"answer": "The brain took too long to answer. Try again.", "cited": []}
    if proc.returncode != 0:
        return {"answer": f"claude CLI error: {proc.stderr.strip()[:300]}", "cited": []}
    try:
        envelope = json.loads(proc.stdout)
        text = envelope.get("result", "") if isinstance(envelope, dict) else str(envelope)
    except json.JSONDecodeError:
        text = proc.stdout
    start, end = text.find("{"), text.rfind("}")
    if start >= 0 and end > start:
        try:
            out = json.loads(text[start:end + 1])
            answer = str(out.get("answer", "")).strip()
            cited = [str(c) for c in out.get("cited", []) if isinstance(c, (str, int))]
            if answer:
                return {"answer": answer, "cited": cited[:8]}
        except json.JSONDecodeError:
            pass
    return {"answer": text.strip()[:1200] or "No answer.", "cited": []}

# ---- http ----

MIME = {".html": "text/html", ".json": "application/json", ".txt": "text/plain",
        ".js": "text/javascript", ".css": "text/css", ".png": "image/png",
        ".jpg": "image/jpeg", ".svg": "image/svg+xml", ".ico": "image/x-icon"}

class Handler(BaseHTTPRequestHandler):
    def log_message(self, *args):
        pass

    def _json(self, obj, code=200):
        body = json.dumps(obj).encode()
        self.send_response(code)
        self.send_header("Content-Type", "application/json")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)

    def do_GET(self):
        path = self.path.split("?")[0]
        if path == "/health":
            return self._json({"ok": True, "voice": "eleven" if ELEVEN_KEY else "browser"})
        if path == "/events":
            return self.sse()
        if path == "/":
            path = "/index.html"
        target = (SITE / path.lstrip("/")).resolve()
        if not str(target).startswith(str(SITE)) or not target.is_file():
            self.send_response(404)
            self.end_headers()
            return
        body = target.read_bytes()
        self.send_response(200)
        self.send_header("Content-Type", MIME.get(target.suffix, "application/octet-stream"))
        self.send_header("Content-Length", str(len(body)))
        self.send_header("Cache-Control", "no-store")
        self.end_headers()
        self.wfile.write(body)

    def sse(self):
        q = queue.Queue()
        with clients_lock:
            clients.append(q)
        try:
            self.send_response(200)
            self.send_header("Content-Type", "text/event-stream")
            self.send_header("Cache-Control", "no-store")
            self.send_header("Connection", "keep-alive")
            self.end_headers()
            while True:
                try:
                    payload = q.get(timeout=15)
                    self.wfile.write(f"data: {payload}\n\n".encode())
                except queue.Empty:
                    self.wfile.write(b": ping\n\n")
                self.wfile.flush()
        except (BrokenPipeError, ConnectionResetError, OSError):
            pass
        finally:
            with clients_lock:
                if q in clients:
                    clients.remove(q)

    def do_POST(self):
        route = self.path.split("?")[0]
        try:
            length = int(self.headers.get("Content-Length", 0))
            body = json.loads(self.rfile.read(length) or b"{}")
        except (ValueError, json.JSONDecodeError):
            return self._json({"answer": "Bad request.", "cited": []}, 400)
        if route == "/ask":
            question = str(body.get("question", "")).strip()[:500]
            if not question:
                return self._json({"answer": "Ask a question.", "cited": []}, 400)
            return self._json(ask_brain(question))
        if route == "/speak":
            text = str(body.get("text", "")).strip()
            if not ELEVEN_KEY or not text:
                self.send_response(404)
                self.end_headers()
                return
            try:
                audio = eleven_tts(text)
            except Exception:
                self.send_response(502)
                self.end_headers()
                return
            self.send_response(200)
            self.send_header("Content-Type", "audio/mpeg")
            self.send_header("Content-Length", str(len(audio)))
            self.end_headers()
            self.wfile.write(audio)
            return
        self.send_response(404)
        self.end_headers()

if __name__ == "__main__":
    threading.Thread(target=watcher, daemon=True).start()
    server = ThreadingHTTPServer(("127.0.0.1", PORT), Handler)
    print(f"second brain live at http://localhost:{PORT} (site: {SITE})")
    server.serve_forever()
