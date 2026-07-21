#!/usr/bin/env python3
"""
extend_plates.py - landscape Flow plates (e.g. 2400x1792) -> 1080x1350 portrait.

No horizontal crop (headlines span full width). Vertical extension continues the
plain backdrop from the exact edge-row colors (per column), so the seam color
matches perfectly; matched grain hides the texture change. Downscale to 1080x1350.

v2: constant per-column continuation replaced strip-stretching, which left
visible streak bands on the light gray backdrops.

ADAPT PER CAMPAIGN: edit FILES, RAMP_BOTTOM, and FADE_BOTTOM below. The stems
shown are the fictional worked example; use your campaign's plate names.
"""
import os
from PIL import Image, ImageEnhance, ImageChops

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
PLATES = os.path.join(ROOT, "plates")
OUT = os.path.join(ROOT, "exports")

TOP_ADD = 980
BOT_ADD = 228
TARGET = (1080, 1350)

FILES = [
    "hero1-announcement.jpg",
    "hero2-differentiator.jpg",
    "hero3-credentials.jpg",
    "hero4-mechanism.jpg",
    "hero5-close.jpg",
    "hero6-keepsake.jpg",
]

# bottom extensions that must ramp to black (subject fades out through the seam)
RAMP_BOTTOM = {"hero4-mechanism.jpg"}

# plates whose subject touches the bottom edge: fade last N rows to near-black
# before extending, else the body smears into the extension as a gray block
FADE_BOTTOM = {"hero5-close.jpg": 110}

def edge_fill(im, y0, y1, height):
    """Constant per-column continuation of rows y0..y1, with matched grain."""
    w = im.size[0]
    row = im.crop((0, y0, w, y1)).resize((w, 1), Image.BOX)
    # horizontal smoothing: keep only low-frequency column color, else per-column
    # JPEG noise turns into vertical stripes across the whole extension
    row = row.resize((60, 1), Image.BOX).resize((w, 1), Image.BICUBIC)
    base = row.resize((w, height), Image.NEAREST)
    # film grain: coarse noise so it survives the 2.2x downscale
    n = Image.effect_noise((w // 2, height // 2), 26).resize((w, height), Image.BILINEAR)
    n = n.convert("L")
    lighter = ImageEnhance.Brightness(base).enhance(1.05)
    darker = ImageEnhance.Brightness(base).enhance(0.95)
    mixed = Image.composite(lighter, darker, n)
    return Image.blend(base, mixed, 0.55)

def fade_bottom_rows(im, rows, floor=(10, 10, 10)):
    w, h = im.size
    black = Image.new("RGB", (w, rows), floor)
    mask = Image.linear_gradient("L").resize((w, rows))  # 0 top -> 255 bottom
    zone = im.crop((0, h - rows, w, h))
    im.paste(Image.composite(black, zone, mask), (0, h - rows))
    return im

def extend(path, dst):
    im = Image.open(path).convert("RGB")
    if os.path.basename(path) in FADE_BOTTOM:
        im = fade_bottom_rows(im, FADE_BOTTOM[os.path.basename(path)])
    w, h = im.size
    canvas = Image.new("RGB", (w, h + TOP_ADD + BOT_ADD))
    canvas.paste(edge_fill(im, 0, 3, TOP_ADD), (0, 0))
    bot = edge_fill(im, h - 3, h, BOT_ADD)
    if os.path.basename(path) in RAMP_BOTTOM:
        black = Image.new("RGB", bot.size, (6, 6, 6))
        ramp = Image.linear_gradient("L").resize(bot.size)  # 0 top -> 255 bottom
        ramp = ramp.point(lambda v: min(255, int(v * 1.6)))
        bot = Image.composite(black, bot, ramp)
    canvas.paste(bot, (0, TOP_ADD + h))
    canvas.paste(im, (0, TOP_ADD))
    out = canvas.resize(TARGET, Image.LANCZOS)
    out.save(dst, "PNG")
    print("wrote", dst, out.size)

def main():
    os.makedirs(OUT, exist_ok=True)
    for f in FILES:
        extend(os.path.join(PLATES, f), os.path.join(OUT, f.replace(".jpg", ".png")))

if __name__ == "__main__":
    main()
