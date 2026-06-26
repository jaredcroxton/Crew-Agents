#!/usr/bin/env bash
# Fallback master builder: synthesize the descent from the 4 real KIE keyframes
# (A space -> B cloud-top -> C tower -> D interior) using a slow zoom-push on each
# still plus 1s crossfades. Produces the SAME master.mp4 / frame sequence the
# seedance clips would, with zero video credits. Swap to real clips later via
# generate_assets.py --clips + stitch_frames.sh.
set -euo pipefail
cd "$(dirname "$0")/.."
mkdir -p assets/video .tmp/raw

K=assets/keyframes
for f in A B C D; do
  [ -f "$K/$f.png" ] || { echo "MISSING $K/$f.png - run generate_assets.py --keyframes" >&2; exit 1; }
done

ZP="zoompan=z='min(zoom+0.0016,1.40)':d=120:s=1600x900:fps=30,trim=end_frame=120,setpts=N/30/TB"
PRE="scale=1600:900:force_original_aspect_ratio=increase,crop=1600:900"

echo "[1/2] compose descent master from stills"
ffmpeg -y \
  -loop 1 -t 4 -i "$K/A.png" \
  -loop 1 -t 4 -i "$K/B.png" \
  -loop 1 -t 4 -i "$K/C.png" \
  -loop 1 -t 4 -i "$K/D.png" \
  -filter_complex "\
[0:v]$PRE,$ZP[v0];\
[1:v]$PRE,$ZP[v1];\
[2:v]$PRE,$ZP[v2];\
[3:v]$PRE,$ZP[v3];\
[v0][v1]xfade=transition=fade:duration=1:offset=3[x01];\
[x01][v2]xfade=transition=fade:duration=1:offset=6[x02];\
[x02][v3]xfade=transition=fade:duration=1:offset=9[vout]" \
  -map "[vout]" -r 30 -c:v libx264 -crf 18 -pix_fmt yuv420p assets/video/master.mp4

echo "[2/2] extract frames @30fps -> .tmp/raw"
rm -f .tmp/raw/*.jpg
ffmpeg -y -i assets/video/master.mp4 -vf "fps=30,scale=1600:-2" -q:v 2 .tmp/raw/f%04d.jpg
N=$(ls .tmp/raw/*.jpg | wc -l | tr -d ' ')
echo "DONE. $N frames -> .tmp/raw"
echo ">> set FRAME_COUNT = $N in index.html, then run pipeline/to_webp.py"
