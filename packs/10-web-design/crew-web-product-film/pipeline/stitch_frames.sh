#!/usr/bin/env bash
# Stitch the 4 Seedance Lite product-film clips into one continuous master.
# Lite is single-frame i2v, so clips are joined with 0.75s crossfades (not
# shared boundary frames). Each clip is seeded by its scene keyframe
# (A hero reveal -> B detail macro -> C anatomy -> D environment settle),
# so the dissolve reads as one continuous product film.
#
# Default (the quality / video-scrub path): builds assets/video/master.mp4 ONLY.
# The next step is the Step 6 scrub-pair encode (scrub_d.mp4 / scrub_m.mp4 /
# poster.jpg). The shipped scrub engine drives a <video> element, never crushed
# frames (SKILL.md How-it-thinks #2), so this script does NOT extract frames and
# there is no FRAME_COUNT to set.
#
# --legacy-frames: ALSO extracts JPG frames for the legacy canvas fallback that
# to_webp.py feeds. Do NOT use this for a quality build: the crushed WebP frames
# are exactly what made earlier builds fuzzy (SKILL.md line 149, How-it-thinks
# #2). The shipped reference is a pure <video> scrub with no canvas and no
# FRAME_COUNT, so this branch has no consumer unless you are deliberately
# building the legacy canvas variant.
set -euo pipefail
cd "$(dirname "$0")/.."

LEGACY_FRAMES=0
for arg in "$@"; do
  case "$arg" in
    --legacy-frames) LEGACY_FRAMES=1 ;;
    *) echo "unknown arg: $arg (only --legacy-frames is supported)" >&2; exit 2 ;;
  esac
done

mkdir -p assets/video

for c in clip1 clip2 clip3 clip4; do
  [ -f "assets/video/$c.mp4" ] || { echo "MISSING assets/video/$c.mp4 - run generate_assets.py --clips first" >&2; exit 1; }
done

# Normalise each clip (1920x1080, 30fps, zeroed PTS) then crossfade-chain.
# Clips are 5s; crossfade 0.75s -> offsets 4.25 / 8.50 / 12.75 -> ~17.75s master.
NORM="scale=1920:1080:force_original_aspect_ratio=increase,crop=1920:1080,fps=30,setpts=PTS-STARTPTS"

echo "[stitch] crossfade 4 clips -> assets/video/master.mp4"
ffmpeg -y \
  -i assets/video/clip1.mp4 \
  -i assets/video/clip2.mp4 \
  -i assets/video/clip3.mp4 \
  -i assets/video/clip4.mp4 \
  -filter_complex "\
[0:v]$NORM[v0];\
[1:v]$NORM[v1];\
[2:v]$NORM[v2];\
[3:v]$NORM[v3];\
[v0][v1]xfade=transition=fade:duration=0.75:offset=4.25[x01];\
[x01][v2]xfade=transition=fade:duration=0.75:offset=8.5[x02];\
[x02][v3]xfade=transition=fade:duration=0.75:offset=12.75[vout]" \
  -map "[vout]" -r 30 -c:v libx264 -crf 18 -pix_fmt yuv420p -an assets/video/master.mp4

echo "DONE. assets/video/master.mp4 built."
echo ">> next: encode the Step 6 scrub pair (scrub_d.mp4 / scrub_m.mp4 / poster.jpg). Do NOT run to_webp.py for a quality build."

if [ "$LEGACY_FRAMES" -eq 1 ]; then
  # LEGACY canvas fallback ONLY (SKILL.md line 149). The quality path stops above.
  mkdir -p .tmp/raw
  echo "[legacy-frames] extract frames @30fps, 1600w -> .tmp/raw"
  rm -f .tmp/raw/*.jpg
  ffmpeg -y -i assets/video/master.mp4 -vf "fps=30,scale=1600:-2" -q:v 2 .tmp/raw/f%04d.jpg
  N=$(ls .tmp/raw/*.jpg | wc -l | tr -d ' ')
  echo "DONE (legacy canvas fallback). $N frames -> .tmp/raw"
  echo ">> legacy canvas variant only: set FRAME_COUNT = $N in a canvas build, then run pipeline/to_webp.py. NOT the quality path."
fi
