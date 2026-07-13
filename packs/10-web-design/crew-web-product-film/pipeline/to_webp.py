#!/usr/bin/env python3
"""
to_webp.py - convert extracted .tmp/raw/*.jpg into two WebP frame sequences.

  frames/d/fNNNN.webp  desktop : 1440w, quality 58   (~landscape, cover-fit)
  frames/m/fNNNN.webp  mobile  : 720x1080 portrait   (center-crop, quality 56)

Portrait crop is the single biggest mobile-quality fix: landscape frames
cover-fit to a blurry sliver on phones. Source frames are 1600x900 (16:9);
we center-crop a 600x900 column then upscale to 720x1080 (2:3).
"""
import glob, os, shutil
from concurrent.futures import ThreadPoolExecutor
from PIL import Image

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
RAW = os.path.join(ROOT, ".tmp", "raw")
DST_D = os.path.join(ROOT, "frames", "d")
DST_M = os.path.join(ROOT, "frames", "m")

for d in (DST_D, DST_M):
    shutil.rmtree(d, ignore_errors=True)
    os.makedirs(d, exist_ok=True)

files = sorted(glob.glob(os.path.join(RAW, "*.jpg")))
if not files:
    raise SystemExit("No frames in .tmp/raw - run stitch_frames.sh first")


def conv(args):
    i, f = args
    name = "f%04d.webp" % (i + 1)
    im = Image.open(f).convert("RGB")
    w, h = im.size

    # Desktop: 1440 wide, keep aspect.
    dw = 1440
    dh = max(1, round(dw * h / w))
    im.resize((dw, dh), Image.LANCZOS).save(
        os.path.join(DST_D, name), "WEBP", quality=58, method=5)

    # Mobile: center-crop a 2:3 column, then size to 720x1080.
    target_ratio = 720 / 1080
    crop_w = min(w, round(h * target_ratio))
    x = (w - crop_w) // 2
    im.crop((x, 0, x + crop_w, h)).resize((720, 1080), Image.LANCZOS).save(
        os.path.join(DST_M, name), "WEBP", quality=56, method=5)


with ThreadPoolExecutor(max_workers=8) as ex:
    list(ex.map(conv, enumerate(files)))

print("done: %d frames -> frames/d and frames/m" % len(files))
print(">> set FRAME_COUNT = %d in index.html" % len(files))
