#!/usr/bin/env python3
"""Crew learning-experience relay server. Stdlib only, no dependencies.

Serves the build with no-cache headers on EVERYTHING (scar 4: plain
http.server heuristic-caches stale builds into trainers' browsers for days)
and relays phone-remote commands over SSE. It stores nothing but the last
STATE-type message, replayed to a newly joined client, so the relay carries
commands and display state only; course and gate authority never leave the
presenter tab.

Endpoints:
  /events   SSE fan-out, per-client queues, 15 second keepalive comments,
            replays the last STATE to a new client
  /cmd      POST, broadcasts the JSON body to all SSE clients, remembers
            the last STATE-type message
  /netinfo  returns the LAN IP (the UDP-connect trick) so the drawer can
            print the remote URL and QR code
  anything else: static files from the working directory, no-cache

Usage: python3 serve.py [port]     (default 8000)
"""
import json
import queue
import socket
import sys
import threading
from http.server import SimpleHTTPRequestHandler, ThreadingHTTPServer

CLIENTS = []            # one queue.Queue per connected SSE client
CLIENTS_LOCK = threading.Lock()
LAST_STATE = None       # last STATE-type message body, replayed to joiners


def lan_ip():
    """The UDP-connect trick: no packet is sent, the OS just picks a route."""
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    try:
        s.connect(("8.8.8.8", 80))
        return s.getsockname()[0]
    except OSError:
        return "127.0.0.1"
    finally:
        s.close()


class Handler(SimpleHTTPRequestHandler):

    def end_headers(self):
        # Mandatory no-cache on everything (scar 4).
        self.send_header("Cache-Control", "no-cache, no-store, must-revalidate")
        self.send_header("Pragma", "no-cache")
        self.send_header("Expires", "0")
        SimpleHTTPRequestHandler.end_headers(self)

    def do_GET(self):
        if self.path.startswith("/events"):
            return self.sse()
        if self.path.startswith("/netinfo"):
            body = json.dumps({
                "ip": lan_ip(),
                "port": self.server.server_address[1],
            }).encode()
            self.send_response(200)
            self.send_header("Content-Type", "application/json")
            self.send_header("Content-Length", str(len(body)))
            self.end_headers()
            self.wfile.write(body)
            return
        return SimpleHTTPRequestHandler.do_GET(self)

    def do_POST(self):
        global LAST_STATE
        if not self.path.startswith("/cmd"):
            self.send_response(404)
            self.send_header("Content-Length", "0")
            self.end_headers()
            return
        length = int(self.headers.get("Content-Length", 0))
        raw = self.rfile.read(length)
        try:
            msg = json.loads(raw)
        except ValueError:
            self.send_response(400)
            self.send_header("Content-Length", "0")
            self.end_headers()
            return
        text = raw.decode("utf-8", "replace")
        if msg.get("type") == "STATE":
            LAST_STATE = text
        with CLIENTS_LOCK:
            for q in CLIENTS:
                q.put(text)
        self.send_response(204)
        self.send_header("Content-Length", "0")
        self.end_headers()

    def sse(self):
        q = queue.Queue()
        with CLIENTS_LOCK:
            CLIENTS.append(q)
        self.send_response(200)
        self.send_header("Content-Type", "text/event-stream")
        self.send_header("Connection", "keep-alive")
        self.end_headers()
        try:
            if LAST_STATE:
                self.wfile.write(("data: %s\n\n" % LAST_STATE).encode())
                self.wfile.flush()
            while True:
                try:
                    msg = q.get(timeout=15)
                    self.wfile.write(("data: %s\n\n" % msg).encode())
                except queue.Empty:
                    # keepalive comment so proxies and phones hold the pipe open
                    self.wfile.write(b": keepalive\n\n")
                self.wfile.flush()
        except (BrokenPipeError, ConnectionResetError, OSError):
            pass
        finally:
            with CLIENTS_LOCK:
                if q in CLIENTS:
                    CLIENTS.remove(q)

    def log_message(self, *args):
        pass  # quiet by default; the run receipt speaks, not the server


if __name__ == "__main__":
    port = int(sys.argv[1]) if len(sys.argv) > 1 else 8000
    server = ThreadingHTTPServer(("0.0.0.0", port), Handler)
    print("Serving on http://%s:%d  (no-cache, SSE relay live)" % (lan_ip(), port))
    print("Remote URL: http://%s:%d/?role=remote" % (lan_ip(), port))
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        pass
