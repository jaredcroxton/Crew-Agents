#!/usr/bin/env python3
"""
generate_assets.py - product-film asset pipeline (kie.ai REST, stdlib only).

Generates the four scene clips of the product film: A hero reveal, B detail
macro, C anatomy, D environment settle. The model is bytedance/v1-lite
image-to-video: single-frame seeding only (no last-frame anchor), each clip
is seeded by its scene keyframe and the seams are crossfaded later in
stitch_frames.sh.

Keyframes for a real branded product come from kie_edit_image seeded by the
brand's real plates (SKILL.md Step 3), which caches the hosted URLs to
.tmp/keyframe_urls.json. The --keyframes and --listing stages here are legacy
text-to-image paths: they need a pipeline/keyframes.json or listing.json you
write yourself, and must not be used for a real branded product.

KIE contract:
  create : POST https://api.kie.ai/api/v1/jobs/createTask {model, input} -> data.taskId
  poll   : GET  https://api.kie.ai/api/v1/jobs/recordInfo?taskId=...     -> data.state, data.resultJson

Usage:
  python3 pipeline/generate_assets.py --handshake   # 1 cheap nano-banana, confirms key
  python3 pipeline/generate_assets.py --clips       # generate clip1..4 (needs .tmp/keyframe_urls.json)
  python3 pipeline/generate_assets.py --keyframes   # LEGACY text-to-image stills (keyframes.json required)
  python3 pipeline/generate_assets.py --all         # keyframes then clips (legacy path)
"""
import argparse, json, os, sys, time, urllib.request, urllib.error

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
PIPE = os.path.join(ROOT, "pipeline")
ASSETS = os.path.join(ROOT, "assets")
TMP = os.path.join(ROOT, ".tmp")

CREATE_URL = "https://api.kie.ai/api/v1/jobs/createTask"
POLL_URL = "https://api.kie.ai/api/v1/jobs/recordInfo"
POLL_INTERVAL = 6
POLL_TIMEOUT = 900          # video can take many minutes
UA = "Mozilla/5.0"
URLS_CACHE = os.path.join(TMP, "keyframe_urls.json")


def load_key():
    key = os.environ.get("KIE_API_KEY", "").strip()
    if not key:
        p = os.path.join(ROOT, ".env")
        if os.path.exists(p):
            for line in open(p):
                line = line.strip()
                if line.startswith("KIE_API_KEY=") and not line.startswith("#"):
                    key = line.split("=", 1)[1].strip().strip('"').strip("'")
                    break
    if not key:
        sys.exit("ERROR: KIE_API_KEY not set. Copy .env.example to .env and paste your key.")
    return key


def _post(url, payload, key):
    req = urllib.request.Request(url, data=json.dumps(payload).encode(), method="POST", headers={
        "Authorization": "Bearer " + key, "Content-Type": "application/json", "User-Agent": UA})
    try:
        with urllib.request.urlopen(req, timeout=120) as r:
            return json.loads(r.read().decode())
    except urllib.error.HTTPError as e:
        sys.exit("HTTP %s from %s: %s" % (e.code, url, e.read().decode("utf-8", "ignore")))


def _get(url, key):
    req = urllib.request.Request(url, method="GET", headers={"Authorization": "Bearer " + key, "User-Agent": UA})
    with urllib.request.urlopen(req, timeout=60) as r:
        return json.loads(r.read().decode())


def create_task(model, inp, key):
    res = _post(CREATE_URL, {"model": model, "input": inp}, key)
    if res.get("code") != 200:
        sys.exit("createTask error: " + json.dumps(res))
    tid = (res.get("data") or {}).get("taskId")
    if not tid:
        sys.exit("no taskId: " + json.dumps(res))
    return tid


def poll(tid, key):
    start = time.time()
    while True:
        data = (_get("%s?taskId=%s" % (POLL_URL, tid), key).get("data") or {})
        state = data.get("state")
        if state == "success":
            urls = json.loads(data.get("resultJson") or "{}").get("resultUrls") or []
            if not urls:
                sys.exit("success but no urls: " + json.dumps(data))
            return urls[0]
        if state == "fail":
            sys.exit("FAILED: %s %s" % (data.get("failCode"), data.get("failMsg")))
        if time.time() - start > POLL_TIMEOUT:
            sys.exit("timeout (last state %s)" % state)
        print("    ...%s (%ds)" % (state or "pending", int(time.time() - start)), flush=True)
        time.sleep(POLL_INTERVAL)


def download(url, dest):
    os.makedirs(os.path.dirname(dest), exist_ok=True)
    req = urllib.request.Request(url, headers={"User-Agent": UA})
    with urllib.request.urlopen(req, timeout=300) as r, open(dest, "wb") as f:
        f.write(r.read())
    print("    saved -> %s (%.1f MB)" % (dest, os.path.getsize(dest) / 1048576), flush=True)


def load_json(name):
    with open(os.path.join(PIPE, name)) as f:
        return json.load(f)


def do_handshake(key):
    print("[handshake] 1 nano-banana test image...")
    tid = create_task("google/nano-banana", {
        "prompt": "a single glowing platinum sphere floating in a pure black void, cinematic, volumetric glow",
        "output_format": "png", "aspect_ratio": "16:9"}, key)
    url = poll(tid, key)
    download(url, os.path.join(TMP, "handshake.png"))
    print("OK. kie.ai link alive.")


def do_keyframes(key):
    cfg = load_json("keyframes.json")
    urls = {}
    for fr in cfg["frames"]:
        print("[keyframe %s] nano-banana..." % fr["id"], flush=True)
        tid = create_task(cfg["model"], {
            "prompt": fr["prompt"], "output_format": "png",
            "aspect_ratio": cfg["aspect_ratio"]}, key)
        url = poll(tid, key)
        download(url, os.path.join(ASSETS, "keyframes", fr["file"]))
        urls[fr["id"]] = url
    os.makedirs(TMP, exist_ok=True)
    with open(URLS_CACHE, "w") as f:
        json.dump(urls, f, indent=2)
    print("Keyframe anchor urls cached -> %s" % URLS_CACHE)
    return urls


def do_listing(key):
    cfg = load_json("listing.json")
    for img in cfg["images"]:
        dest = os.path.join(ASSETS, "listing", img["file"])
        if os.path.exists(dest):
            print("[listing %s] exists, skip" % img["file"], flush=True)
            continue
        print("[listing %s] nano-banana..." % img["file"], flush=True)
        try:                                  # tolerate per-image failures (e.g. content flag)
            tid = create_task(cfg["model"], {
                "prompt": img["prompt"], "output_format": "png",
                "aspect_ratio": cfg["aspect_ratio"]}, key)
            url = poll(tid, key)
            download(url, dest)
        except SystemExit as e:
            print("  SKIP %s: %s" % (img["file"], e), flush=True)
    print("Listing images done.")


def do_clips(key):
    cfg = load_json("clips.json")
    if not os.path.exists(URLS_CACHE):
        sys.exit("No keyframe urls. Run --keyframes (or --all) first.")
    urls = json.load(open(URLS_CACHE))
    # Seedance 1.0 Lite is single-frame image-to-video (no last_frame_url). Each clip is
    # seeded by its keyframe (clip['first']); seams are crossfaded later in stitch_frames.sh.
    for clip in cfg["clips"]:
        dest = os.path.join(ASSETS, "video", clip["id"] + ".mp4")
        if os.path.exists(dest) and os.path.getsize(dest) > 100000:
            print("[%s] exists (%.1f MB), skip" % (clip["id"], os.path.getsize(dest) / 1048576), flush=True)
            continue
        seed = urls.get(clip["first"])
        if not seed:
            sys.exit("Missing anchor url for %s" % clip["first"])
        # transient KIE 500s happen; retry the whole create+poll a few times
        for attempt in range(1, 5):
            print("[%s] %s  seed=%s (attempt %d)" % (clip["id"], cfg["model"], clip["first"], attempt), flush=True)
            try:
                tid = create_task(cfg["model"], {
                    "prompt": clip["prompt"],
                    "image_url": seed,
                    "resolution": cfg["resolution"],
                    "duration": cfg["duration"],
                    "camera_fixed": False}, key)
                url = poll(tid, key)
                download(url, dest)
                break
            except SystemExit as e:
                print("  retry %s after error: %s" % (clip["id"], e), flush=True)
                if attempt == 4:
                    raise
                time.sleep(12)
    print("All clips done.")


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--handshake", action="store_true")
    ap.add_argument("--keyframes", action="store_true")
    ap.add_argument("--clips", action="store_true")
    ap.add_argument("--listing", action="store_true")
    ap.add_argument("--all", action="store_true")
    args = ap.parse_args()
    key = load_key()
    if args.handshake:
        do_handshake(key)
    elif args.keyframes:
        do_keyframes(key)
    elif args.clips:
        do_clips(key)
    elif args.listing:
        do_listing(key)
    elif args.all:
        do_keyframes(key)
        do_clips(key)
    else:
        ap.print_help()


if __name__ == "__main__":
    main()
