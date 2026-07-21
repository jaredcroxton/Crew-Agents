#!/usr/bin/env python3
"""
regen_4k.py - re-render Flow plates at premium quality via KIE seedream-v4-edit.

Input : the six Flow plates (nano-banana quality) in plates/
Output: plates4k/heroN-*.png, same composition and wording, 4K, cinematic grade.

image_size variants are discovered live (seedream accepts named sizes and
explicit WxH depending on rollout); the loop below tries each until one takes.

ADAPT PER CAMPAIGN: edit HEROES (stem, source filename, optional one correction).
The corrections shown are the fictional worked example; the pattern they teach:
one instruction per call, quote the exact text, demand it sit clear of the
subject. Never ask seedream to fix text AND preserve framing in the same call
(see failure-modes Stage 2b: erase first, then text_surgeon.py).
"""
import base64, json, os, sys, time, urllib.request, urllib.error

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SRC = os.path.join(ROOT, "plates")
OUT = os.path.join(ROOT, "plates4k")
CREATE_URL = "https://api.kie.ai/api/v1/jobs/createTask"
POLL_URL = "https://api.kie.ai/api/v1/jobs/recordInfo"
UPLOAD_URL = "https://kieai.redpandaai.co/api/file-base64-upload"
EDIT_MODEL = "bytedance/seedream-v4-edit"
POLL_INTERVAL = 8
POLL_TIMEOUT = 1800
UA = "Mozilla/5.0"

BASE = ("Recreate this exact advertisement image at dramatically higher photographic quality: "
        "identical composition, same person, same pose, same camera angle, same room, same set "
        "colors, same objects, and exactly the same text in the same positions and typographic "
        "style. Upgrade everything else: true photorealistic depth of field, rich cinematic "
        "color grade, realistic skin and fabric texture, soft studio shadows, premium fashion "
        "campaign lighting, crisp high-resolution detail. Every letter must remain exactly as in "
        "the original, no spelling changes, no new text, no watermarks, no logos. ")

HEROES = [
    ("hero1-announcement", "hero1-announcement-flow.jpeg", ""),
    ("hero2-differentiator", "hero2-differentiator-flow.jpeg", ""),
    ("hero3-credentials", "hero3-credentials-flow.jpeg",
     "Correction: the small subline under the headline must read exactly "
     "\"STOCKED IN THREE GALLERIES · 14.11\" and be fully visible, placed clear of the "
     "subject's head so no letters are hidden behind her."),
    ("hero4-mechanism", "hero4-mechanism-flow.jpeg",
     "Correction: the subline must read exactly \"COLLECT IN TWO WEEKS · 14.11\" and be fully "
     "visible, placed clear of the hand so no letters are hidden."),
    ("hero5-close", "hero5-close-flow.jpeg",
     "Correction: the kicker above the headline must read exactly "
     "\"ONE DAY · 6 HOURS AT THE WHEEL\" with every word spelled exactly, no hyphenation."),
    ("hero6-keepsake", "hero6-keepsake-flow.jpeg", ""),
]

SIZE_VARIANTS = [
    {"image_size": "4096x3072"},
    {"image_size": "4K"},
    {"image_size": "landscape_4_3", "image_resolution": "4K"},
    {"image_size": "landscape_4_3"},
    {},
]


def load_key():
    key = os.environ.get("KIE_API_KEY", "").strip()
    if not key:
        p = os.path.join(ROOT, ".env")
        if os.path.exists(p):
            for line in open(p):
                line = line.strip()
                if line.startswith("KIE_API_KEY=") and not line.startswith("#"):
                    key = line.split("=", 1)[1].strip().strip('"').strip("'")
    if not key:
        sys.exit("ERROR: KIE_API_KEY not found (set the env var or fill this project's .env, see .env.example)")
    return key


def post(url, payload, key):
    req = urllib.request.Request(url, data=json.dumps(payload).encode(), method="POST", headers={
        "Authorization": "Bearer " + key, "Content-Type": "application/json", "User-Agent": UA})
    with urllib.request.urlopen(req, timeout=300) as r:
        return json.loads(r.read().decode())


def get(url, key):
    req = urllib.request.Request(url, headers={"Authorization": "Bearer " + key, "User-Agent": UA})
    with urllib.request.urlopen(req, timeout=120) as r:
        return json.loads(r.read().decode())


def upload(path, key):
    b64 = base64.b64encode(open(path, "rb").read()).decode()
    # Flow download names sometimes carry an ellipsis character; strip it or the upload 422s
    r = post(UPLOAD_URL, {"base64Data": "data:image/jpeg;base64," + b64,
                          "uploadPath": "carousel-campaign", "fileName": os.path.basename(path).replace("…", "")}, key)
    url = (r.get("data") or {}).get("downloadUrl")
    if not url:
        sys.exit("upload failed for %s: %s" % (path, json.dumps(r)[:300]))
    return url


def create_task(name, prompt, img_url, key):
    last = None
    for sv in SIZE_VARIANTS:
        inp = {"prompt": prompt, "image_urls": [img_url], "output_format": "png"}
        inp.update(sv)
        try:
            r = post(CREATE_URL, {"model": EDIT_MODEL, "input": inp}, key)
        except urllib.error.HTTPError as e:
            last = "HTTP %s %s" % (e.code, e.read().decode()[:160])
            continue
        tid = (r.get("data") or {}).get("taskId")
        if tid:
            print("task", name, tid, "size=", sv or "default", flush=True)
            return tid
        last = json.dumps(r)[:200]
    sys.exit("createTask failed for %s after all size variants: %s" % (name, last))


def fetch(url, dest):
    req = urllib.request.Request(url, headers={"User-Agent": UA})
    with urllib.request.urlopen(req, timeout=600) as r:
        open(dest, "wb").write(r.read())


def main():
    key = load_key()
    os.makedirs(OUT, exist_ok=True)
    state_path = os.path.join(OUT, "tasks.json")
    tasks = json.load(open(state_path)) if os.path.exists(state_path) else {}

    for name, src_file, fix in HEROES:
        dst = os.path.join(OUT, name + ".png")
        if os.path.exists(dst) and os.path.getsize(dst) > 500000:
            print("skip", name, "(exists)", flush=True)
            tasks.pop(name, None)
            continue
        prev = tasks.get(name)
        if prev and prev.get("state") not in ("fail", None):
            print("resume", name, prev["taskId"], flush=True)
            continue
        src = os.path.join(SRC, src_file)
        print("upload", name, flush=True)
        img_url = upload(src, key)
        tid = create_task(name, BASE + fix, img_url, key)
        tasks[name] = {"taskId": tid, "state": "waiting"}
        json.dump(tasks, open(state_path, "w"), indent=2)

    start = time.time()
    pending = set(tasks)
    while pending and time.time() - start < POLL_TIMEOUT:
        time.sleep(POLL_INTERVAL)
        for name in list(pending):
            tid = tasks[name]["taskId"]
            try:
                r = get(POLL_URL + "?taskId=" + tid, key)
            except Exception as e:
                print("poll error", name, e, flush=True)
                continue
            d = r.get("data") or {}
            state = d.get("state")
            tasks[name]["state"] = state
            if state == "success":
                rj = d.get("resultJson")
                rj = json.loads(rj) if isinstance(rj, str) else (rj or {})
                urls = (rj.get("resultUrls") or [])
                if urls:
                    dst = os.path.join(OUT, name + ".png")
                    fetch(urls[0], dst)
                    print("DONE", name, os.path.getsize(dst), "bytes", flush=True)
                else:
                    print("FAIL", name, "no resultUrls", flush=True)
                pending.discard(name)
            elif state == "fail":
                print("FAIL", name, str(d.get("failMsg"))[:200], flush=True)
                pending.discard(name)
        json.dump(tasks, open(state_path, "w"), indent=2)
        print("progress %d/%d" % (len(tasks) - len(pending), len(tasks)), flush=True)

    if pending:
        print("TIMEOUT still pending:", sorted(pending), flush=True)
        sys.exit(1)
    print("ALL DONE", flush=True)


if __name__ == "__main__":
    main()
