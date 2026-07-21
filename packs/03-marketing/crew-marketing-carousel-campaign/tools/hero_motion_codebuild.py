#!/usr/bin/env python3
"""
hero_motion_codebuild.py - code-built hero motion, the two-strikes fallback when
Seedance vandalises a hero (grows a held-out object, garbles its label, morphs a
face). The plate stays 100% pixel-frozen; motion is a slow diagonal light sheen +
a gentle brightness pulse confined to a masked halo around the glowing object
(object core excluded) + live film grain. 125 frames @ 25fps -> H.264, loops.

  ADAPT PER HERO: CUBE_CX/CUBE_CY, HALO_R, CORE_R and STILL/DST below are set for
  ONE worked hero (a glowing object centred at 566,470 in a 1080x1350 plate). For
  a new hero: point STILL at its 1080x1350 export, and move the halo centre and
  radius onto that hero's glowing element. The build loop is general. This same
  shape (sheen sweep + grain, optionally a masked glow pulse) also rescues any
  hero whose only intended motion is a light effect.
"""
import math, os, shutil, subprocess
from PIL import Image, ImageChops, ImageDraw, ImageFilter

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
STILL = os.path.join(ROOT, "exports", "hero2-differentiator.png")
OUT = os.path.join(ROOT, "exports", "motion")
TMP = os.path.join(OUT, "_h2frames")
DST = os.path.join(OUT, "hero2-differentiator.mp4")
W, H, N, FPS = 1080, 1350, 125, 25

# glowing-object centre in the 1080x1350 plate (the halo radiates from here)
CUBE_CX, CUBE_CY = 566, 470
HALO_R = 300      # glow halo radius
CORE_R = 120      # object core kept unmodulated


def halo_mask():
    """Ring mask: bright in the glow halo, zero over the object core and far field."""
    m = Image.new("L", (W, H), 0)
    d = ImageDraw.Draw(m)
    d.ellipse([CUBE_CX - HALO_R, CUBE_CY - HALO_R, CUBE_CX + HALO_R, CUBE_CY + HALO_R], fill=110)
    d.ellipse([CUBE_CX - CORE_R, CUBE_CY - CORE_R, CUBE_CX + CORE_R, CUBE_CY + CORE_R], fill=0)
    return m.filter(ImageFilter.GaussianBlur(40))


def build_sheen():
    band = Image.new("L", (360, 1), 0)
    px = band.load()
    for x in range(360):
        dd = abs(x - 180) / 180.0
        px[x, 0] = int(60 * (1 - dd) ** 2)
    band = band.resize((360, int(H * 1.6)), Image.BILINEAR)
    canvas = Image.new("L", (W * 2, int(H * 1.6)), 0)
    canvas.paste(band, (W - 180, 0))
    return canvas.rotate(18, resample=Image.BILINEAR, expand=False)


def main():
    base = Image.open(STILL).convert("RGB")
    halo = halo_mask()
    sheen_master = build_sheen()
    shutil.rmtree(TMP, ignore_errors=True)
    os.makedirs(TMP, exist_ok=True)
    for i in range(N):
        t = i / (N - 1)
        frame = base.copy()

        # 1) halo glow pulse (brightness only, masked to the glow ring)
        pulse = 1.0 + 0.12 * math.sin(2 * math.pi * t)   # +/-12%
        bright = base.point(lambda v: min(255, int(v * pulse)))
        frame = Image.composite(bright, frame, halo)

        # 2) diagonal sheen sweep, fading at both ends so it loops
        sweep = -0.5 + t * 2.0
        fade = math.sin(math.pi * t)
        ox = int(sweep * W) - W // 2
        layer = Image.new("L", (W, H), 0)
        layer.paste(sheen_master, (ox, -int(H * 0.3)))
        layer = layer.point(lambda v: int(v * fade))
        sheen_rgb = Image.merge("RGB", (layer, layer, layer))
        frame = ImageChops.screen(frame, sheen_rgb)

        # 3) live film grain
        g = Image.effect_noise((W // 2, H // 2), 13).resize((W, H), Image.BILINEAR)
        g = g.point(lambda v: int((v - 128) * 0.09 + 128))
        frame = ImageChops.overlay(frame, Image.merge("RGB", (g, g, g)))

        frame.save(os.path.join(TMP, "f%03d.png" % i))
    subprocess.run([
        "ffmpeg", "-y", "-loglevel", "error", "-framerate", str(FPS),
        "-i", os.path.join(TMP, "f%03d.png"),
        "-c:v", "libx264", "-pix_fmt", "yuv420p", "-crf", "18", "-movflags", "+faststart",
        DST], check=True)
    shutil.rmtree(TMP, ignore_errors=True)
    print("wrote", DST, os.path.getsize(DST), "bytes")


if __name__ == "__main__":
    main()
