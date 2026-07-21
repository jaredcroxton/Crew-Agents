#!/usr/bin/env python3
"""
animate_heroes.py - bring all 6 finished hero posters alive via KIE Seedance i2v.

Input : exports/hero*.png (1080x1350 4:5 finished posters)
Model : bytedance/v1-lite-image-to-video, 1080p, 5s (aspect follows input image)
Output: exports/motion/hero*.mp4

Flow: base64-upload each hero -> createTask all 6 -> poll all -> download.
Resumes via tasks.json; retries once on "internal error" (no charge on that path).

ADAPT PER CAMPAIGN: edit HEROES below (stem + one motion clause each). The six
clauses shown are proven PASS patterns from real runs (sheen sweep, paint
glisten, smear drift, particle rise, wet-paint sheen, brushstroke ripple);
keep the formula: BASE freeze clause + "The only motion: [one existing effect
element]" + "Extremely subtle, loops cleanly."
"""
import base64, json, os, sys, time, urllib.request

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
OUT = os.path.join(ROOT, "exports", "motion")
CREATE_URL = "https://api.kie.ai/api/v1/jobs/createTask"
POLL_URL = "https://api.kie.ai/api/v1/jobs/recordInfo"
UPLOAD_URL = "https://kieai.redpandaai.co/api/file-base64-upload"
VID_MODEL = "bytedance/v1-lite-image-to-video"
RESOLUTION = "1080p"
DURATION = "5"
POLL_INTERVAL = 8
POLL_TIMEOUT = 1500
UA = "Mozilla/5.0"

BASE = ("The printed poster comes alive with restrained motion. Camera locked, no zoom, no pan, "
        "the poster fills the frame edge to edge and stays perfectly flat. All type stays exactly "
        "as printed, no new writing appears, nothing changes shape, nothing new appears, every "
        "face stays perfectly still like a photograph. ")

HEROES = [
    ("hero1-announcement", "The only motion: a gentle sheen of soft light sweeps slowly across "
     "the poster from left to right, and the film grain shimmers. The lime circle does not move "
     "or change size, the subject stays perfectly still like a photograph, all type stays "
     "exactly as printed. Extremely subtle, loops cleanly."),
    ("hero2-differentiator", "The only motion: the thick acid-lime paint stroke across the "
     "subject's eyes glistens as a soft sheen passes along it once from left to right, and its "
     "dry-brush tail flickers slightly. Extremely subtle, loops cleanly."),
    ("hero3-credentials", "The only motion: the horizontal acid-lime paint smear behind the "
     "subject's head drifts very slowly to the right like wet paint being dragged, its rough "
     "dry-brush tail shimmering. Extremely subtle, loops cleanly."),
    ("hero4-mechanism", "The only motion: the small acid-lime squares and dots floating above the "
     "open palm drift slowly upward like rising bubbles, a few rotating gently as they rise. "
     "Extremely subtle, loops cleanly."),
    ("hero5-close", "The only motion: a slow wet-paint sheen travels along the lime and "
     "white paint smears. The paint does not grow or spread, no new paint appears, the circle "
     "stays the same size, the subject stays perfectly frozen like a photograph, all type stays "
     "exactly as printed. Extremely subtle, loops cleanly."),
    ("hero6-keepsake", "The only motion: the thick brushstrokes of the painted lime head "
     "ripple very subtly like wet paint settling, and the small flicked droplets between the two "
     "faces drift slightly. The real face stays perfectly frozen. Extremely subtle, loops "
     "cleanly."),
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
    r = post(UPLOAD_URL, {"base64Data": "data:image/png;base64," + b64,
                          "uploadPath": "carousel-campaign", "fileName": os.path.basename(path)}, key)
    url = (r.get("data") or {}).get("downloadUrl")
    if not url:
        sys.exit("upload failed for %s: %s" % (path, json.dumps(r)[:300]))
    return url


def fetch(url, dest):
    req = urllib.request.Request(url, headers={"User-Agent": UA})
    with urllib.request.urlopen(req, timeout=300) as r:
        open(dest, "wb").write(r.read())


def create(name, motion, key, retried=False):
    src = os.path.join(ROOT, "exports", name + ".png")
    print("upload", name, flush=True)
    img_url = upload(src, key)
    payload = {"model": VID_MODEL, "input": {
        "prompt": BASE + motion,
        "image_url": img_url,
        "resolution": RESOLUTION,
        "duration": DURATION,
        "camera_fixed": True}}
    try:
        r = post(CREATE_URL, payload, key)
    except Exception as e:
        if not retried:
            print("createTask error, retrying once:", str(e)[:120], flush=True)
            time.sleep(5)
            return create(name, motion, key, retried=True)
        raise
    tid = (r.get("data") or {}).get("taskId")
    if not tid:
        msg = json.dumps(r)[:300]
        if not retried and "internal error" in msg.lower():
            print("internal error, retrying once", flush=True)
            time.sleep(5)
            return create(name, motion, key, retried=True)
        sys.exit("createTask failed for %s: %s" % (name, msg))
    return tid


def main():
    key = load_key()
    os.makedirs(OUT, exist_ok=True)
    state_path = os.path.join(OUT, "tasks.json")
    tasks = {}
    if os.path.exists(state_path):
        tasks = json.load(open(state_path))

    for name, motion in HEROES:
        dst = os.path.join(OUT, name + ".mp4")
        if os.path.exists(dst) and os.path.getsize(dst) > 100000:
            print("skip", name, "(mp4 exists)", flush=True)
            tasks.pop(name, None)
            continue
        prev = tasks.get(name)
        if prev and prev.get("state") not in ("fail", None):
            print("resume", name, prev["taskId"], flush=True)
            continue
        tid = create(name, motion, key)
        tasks[name] = {"taskId": tid, "state": "waiting"}
        print("task", name, tid, flush=True)
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
                    dst = os.path.join(OUT, name + ".mp4")
                    try:
                        fetch(urls[0], dst)
                        print("DONE", name, os.path.getsize(dst), "bytes", flush=True)
                    except Exception as e:
                        print("DOWNLOAD FAIL", name, str(e)[:150], flush=True)
                else:
                    print("FAIL", name, "no resultUrls", flush=True)
                pending.discard(name)
            elif state == "fail":
                print("FAIL", name, str(d.get("failMsg"))[:200], flush=True)
                pending.discard(name)
        json.dump(tasks, open(state_path, "w"), indent=2)
        done = len(tasks) - len(pending)
        print("progress %d/%d" % (done, len(tasks)), flush=True)

    if pending:
        print("TIMEOUT still pending:", sorted(pending), flush=True)
        sys.exit(1)
    print("ALL DONE", flush=True)


if __name__ == "__main__":
    main()
