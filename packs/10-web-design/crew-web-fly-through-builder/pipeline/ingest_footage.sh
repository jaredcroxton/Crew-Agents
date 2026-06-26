#!/usr/bin/env bash
# Ingest user-supplied fly-through footage (third-party generators: Runway, Kling,
# Sora, Pika, Veo, Luma, or a real drone/FPV clip) and turn it into the frame
# sequence the site scrubs. Use this for the "bring your own video" route when the
# user has no KIE key or prefers an external app.
#
# Usage:
#   pipeline/ingest_footage.sh clipA.mp4 [clipB.mp4 clipC.mp4 ...]
#   pipeline/ingest_footage.sh /path/to/folder        # ingests *.mp4/*.mov in order
#
# One clip  -> normalised and frame-extracted as is (the whole descent in one take).
# Many clips -> normalised, joined with 0.75s crossfades, then frame-extracted.
set -euo pipefail
cd "$(dirname "$0")/.."
mkdir -p .tmp/raw assets/video

# Resolve inputs: a single dir arg expands to its videos, sorted.
if [ "$#" -eq 1 ] && [ -d "$1" ]; then
  shift_dir="$1"
  mapfile -t INPUTS < <(find "$shift_dir" -maxdepth 1 -type f \( -iname '*.mp4' -o -iname '*.mov' -o -iname '*.webm' \) | sort)
else
  INPUTS=("$@")
fi
[ "${#INPUTS[@]}" -ge 1 ] || { echo "No input videos. Pass clip paths or a folder." >&2; exit 1; }
for f in "${INPUTS[@]}"; do [ -f "$f" ] || { echo "MISSING $f" >&2; exit 1; }; done

NORM="scale=1920:1080:force_original_aspect_ratio=increase,crop=1920:1080,fps=30,setpts=PTS-STARTPTS"
XFADE=0.75   # crossfade seconds between adjacent clips

echo "[1/2] normalise + join ${#INPUTS[@]} clip(s) -> master.mp4"
if [ "${#INPUTS[@]}" -eq 1 ]; then
  ffmpeg -y -i "${INPUTS[0]}" -vf "$NORM" -r 30 -c:v libx264 -crf 18 -pix_fmt yuv420p -an assets/video/master.mp4
else
  # Build the xfade chain dynamically. offset = (running duration) - XFADE per join.
  args=(); fc=""
  i=0; for f in "${INPUTS[@]}"; do args+=(-i "$f"); fc+="[$i:v]$NORM[v$i];"; i=$((i+1)); done
  prev="[v0]"; off=0
  # crossfade offsets need each clip's duration; probe them.
  durs=(); for f in "${INPUTS[@]}"; do
    d=$(ffprobe -v error -show_entries format=duration -of csv=p=0 "$f"); durs+=("$d"); done
  acc=${durs[0]}
  for ((i=1; i<${#INPUTS[@]}; i++)); do
    off=$(awk "BEGIN{printf \"%.3f\", $acc - $XFADE}")
    out="[x$i]"; [ "$i" -eq $((${#INPUTS[@]}-1)) ] && out="[vout]"
    fc+="${prev}[v$i]xfade=transition=fade:duration=$XFADE:offset=$off$out;"
    prev="$out"
    acc=$(awk "BEGIN{printf \"%.3f\", $acc + ${durs[$i]} - $XFADE}")
  done
  fc=${fc%;}
  ffmpeg -y "${args[@]}" -filter_complex "$fc" -map "[vout]" -r 30 -c:v libx264 -crf 18 -pix_fmt yuv420p -an assets/video/master.mp4
fi

echo "[2/2] extract frames @30fps, 1600w -> .tmp/raw"
rm -f .tmp/raw/*.jpg
ffmpeg -y -i assets/video/master.mp4 -vf "fps=30,scale=1600:-2" -q:v 2 .tmp/raw/f%04d.jpg
N=$(ls .tmp/raw/*.jpg | wc -l | tr -d ' ')
echo "DONE. $N frames -> .tmp/raw"
echo ">> run pipeline/to_webp.py, then set FRAME_COUNT = $N in index.html"
