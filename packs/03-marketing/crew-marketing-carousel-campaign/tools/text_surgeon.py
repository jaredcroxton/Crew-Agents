#!/usr/bin/env python3
"""
text_surgeon.py - per-pixel masked type repair for 4K plates. No box fills: only
detected glyph pixels (dilated) are replaced; wall pixels get a vertical lerp of
clean rows, hair pixels get cloned rows from below.

  ADAPT PER CAMPAIGN: the fix_h1/h3/h4 functions below carry hardcoded pixel
  coordinates, filenames and wall-colour classifiers from ONE worked campaign
  (the fictional Saltbrook example, 4672x3504). They are a WORKING PATTERN, not
  a runnable-as-is script. For a new campaign: re-measure each text region's
  bbox (scan for dark/light glyph pixels), update the window rects, the
  is_wall() lambda for that room colour, and the Helvetica sizes/tracking. The
  masked_fill() helper is fully general, reuse it.
"""
import os
from PIL import Image, ImageDraw, ImageFilter, ImageFont

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
P4K = os.path.join(ROOT, "plates4k")
FONT = "/System/Library/Fonts/HelveticaNeue.ttc"


def font_named(size, want):
    for idx in range(14):
        try:
            f = ImageFont.truetype(FONT, size, index=idx)
            if f.getname()[1] == want:
                return f
        except Exception:
            break
    return ImageFont.truetype(FONT, size)


def draw_tracked(im, text, font, x, y, tracking, fill):
    d = ImageDraw.Draw(im)
    cx = x
    for ch in text:
        d.text((cx, y), ch, font=font, fill=fill)
        cx += d.textlength(ch, font=font) + tracking
    return cx


def width_tracked(text, font, tracking):
    d = ImageDraw.Draw(Image.new("RGB", (8, 8)))
    return sum(d.textlength(ch, font=font) for ch in text) + tracking * (len(text) - 1)


def masked_fill(im, window, is_wall, thresh=115, dilate=9, clone_dy=120, skip_col=None):
    """Replace only glyph pixels inside window. is_wall(r,g,b) classifies the
    background sampled above/below; wall -> lerp fill, else -> clone from below."""
    x0, y0, x1, y1 = window
    g = im.convert("L")
    mask = Image.new("L", (x1 - x0, y1 - y0), 0)
    gp, mp = g.load(), mask.load()
    for y in range(y0, y1):
        for x in range(x0, x1):
            if gp[x, y] < thresh:
                mp[x - x0, y - y0] = 255
    mask = mask.filter(ImageFilter.MaxFilter(dilate))
    src = im.copy()
    sp, ip, mpx = src.load(), im.load(), mask.load()
    for y in range(y0, y1):
        for x in range(x0, x1):
            if mpx[x - x0, y - y0] == 0:
                continue
            if skip_col and skip_col(x):
                continue
            above = sp[x, max(0, y0 - 46)]
            below = sp[x, min(im.size[1] - 1, y1 + 46)]
            if is_wall(*above) and is_wall(*below):
                t = (y - (y0 - 46)) / float((y1 + 46) - (y0 - 46))
                ip[x, y] = tuple(int(a * (1 - t) + b * t) for a, b in zip(above, below))
            else:
                ip[x, y] = sp[x, min(im.size[1] - 1, y + clone_dy)]
    region = im.crop(window).filter(ImageFilter.GaussianBlur(0.8))
    im.paste(region, (x0, y0), mask.filter(ImageFilter.GaussianBlur(1.5)))


def fix_h1():
    im = Image.open(os.path.join(P4K, "hero1-announcement-fix.png")).convert("RGB")
    wall = lambda r, g, b: g > 140 and r > 150 and b < 140
    masked_fill(im, (1855, 715, 2410, 905), wall)
    masked_fill(im, (2925, 715, 3660, 905), wall, clone_dy=140)
    ink = (26, 26, 22)
    f = font_named(102, "Medium")
    w = width_tracked("Saltbrook", f, 3)
    draw_tracked(im, "Saltbrook", f, int(2350 - w), 738, 3, ink)
    draw_tracked(im, "· 14.11", f, 3130, 738, 3, ink)
    im.save(os.path.join(P4K, "hero1-final.png"))
    print("h1 rebuilt")


def fix_h3():
    im = Image.open(os.path.join(P4K, "hero3-credentials-fix.png")).convert("RGB")
    wall = lambda r, g, b: r > 140 and g > 70 and (r + g + b) > 300
    # doorway (dark) columns: glyphs there are invisible, leave untouched
    masked_fill(im, (560, 1142, 3960, 1340), wall, clone_dy=110)
    ink = (34, 24, 18)
    f = font_named(96, "Bold")
    tr = 26
    text = "STOCKED IN THREE GALLERIES · 14.11"
    w = width_tracked(text, f, tr)
    draw_tracked(im, text, f, int((im.size[0] - w) / 2), 1146, tr, ink)
    im.save(os.path.join(P4K, "hero3-final.png"))
    print("h3 rebuilt")


def fix_h4():
    im = Image.open(os.path.join(P4K, "hero4-mechanism-fix.png")).convert("RGB")
    wall = lambda r, g, b: r > 170 and g > 120 and b < 150
    masked_fill(im, (3345, 1245, 3750, 1440), wall)
    ink = (30, 28, 24)
    f = font_named(108, "Bold")
    draw_tracked(im, "14.11", f, 3400, 1272, 14, ink)
    im.save(os.path.join(P4K, "hero4-final.png"))
    print("h4 rebuilt")


if __name__ == "__main__":
    fix_h1()
    fix_h3()
    fix_h4()
    print("TEXT SURGEON DONE")
