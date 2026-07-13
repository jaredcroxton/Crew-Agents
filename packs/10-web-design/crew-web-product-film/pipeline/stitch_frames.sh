#!/usr/bin/env bash
# Stitch the 4 Seedance Lite product-film clips into one continuous master.
# Lite is single-frame i2v, so clips are joined with 0.75s crossfades (not
# shared boundary frames). Each clip is seeded by its scene keyframe
# (A hero reveal -> B detail macro -> C anatomy -> D environment settle),
# so the dissolve reads as one continuous product film.
set -euo pipefail
cd "$(dirname "$0")/.."
mkdir -p .tmp/raw assets/video

for c in clip1 clip2 clip3 clip4; do
  [ -f "assets/video/$c.mp4" ] || { echo "MISSING assets/video/$c.mp4 - run generate_assets.py --clips first" >&2; exit 1; }
done

# Normalise each clip (1920x1080, 30fps, zeroed PTS) then crossfade-chain.
# Clips are 5s; crossfade 0.75s -> offsets 4.25 / 8.50 / 12.75 -> ~17.75s master.
NORM="scale=1920:1080:force_original_aspect_ratio=increase,crop=1920:1080,fps=30,setpts=PTS-STARTPTS"

echo "[1/2] crossfade 4 clips -> master.mp4"
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

echo "[2/2] extract frames @30fps, 1600w -> .tmp/raw"
rm -f .tmp/raw/*.jpg
ffmpeg -y -i assets/video/master.mp4 -vf "fps=30,scale=1600:-2" -q:v 2 .tmp/raw/f%04d.jpg
N=$(ls .tmp/raw/*.jpg | wc -l | tr -d ' ')
echo "DONE. $N frames -> .tmp/raw"
echo ">> set FRAME_COUNT = $N in index.html, then run pipeline/to_webp.py"
