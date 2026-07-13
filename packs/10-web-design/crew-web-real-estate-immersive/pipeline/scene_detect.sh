#!/usr/bin/env bash
# Scene-detect the REAL tour video and build a contact sheet so every scene can
# be mapped to a room before the journey cut. Real footage only: this pipeline
# never generates or alters property imagery.
#
# Usage:
#   pipeline/scene_detect.sh tour.mp4 [threshold]
#
# threshold: ffmpeg scene score, default 0.3. It catches room-to-room cuts in
# agency walkthroughs; raise toward 0.4 if slow pans inside one room
# false-trigger, lower toward 0.2 if dissolves between rooms are missed.
#
# Output:
#   .tmp/scenes/scenes.txt          scene-cut timestamps (seconds)
#   .tmp/scenes/scene_%03d.jpg      one thumbnail per detected scene
#   .tmp/scenes/contact_sheet.jpg   tiled sheet to read and map scenes to rooms
set -euo pipefail
cd "$(dirname "$0")/.."
IN="${1:?usage: pipeline/scene_detect.sh tour.mp4 [threshold]}"
TH="${2:-0.3}"
[ -f "$IN" ] || { echo "MISSING $IN" >&2; exit 1; }
command -v ffmpeg >/dev/null || { echo "ffmpeg not found (brew install ffmpeg)" >&2; exit 1; }

mkdir -p .tmp/scenes
rm -f .tmp/scenes/scene_*.jpg .tmp/scenes/contact_sheet.jpg .tmp/scenes/scenes.txt

echo "[1/3] scene-cut timestamps at threshold $TH"
ffmpeg -i "$IN" -vf "select='gt(scene,$TH)',showinfo" -f null - 2>&1 \
  | grep showinfo | grep -o 'pts_time:[0-9.]*' | cut -d: -f2 > .tmp/scenes/scenes.txt || true
CUTS=$(wc -l < .tmp/scenes/scenes.txt | tr -d ' ')
echo "      $CUTS cuts found"

echo "[2/3] one thumbnail per scene"
ffmpeg -y -i "$IN" -vf "select='gt(scene,$TH)',scale=480:-2" -vsync vfr \
  .tmp/scenes/scene_%03d.jpg 2>/dev/null

N=$(ls .tmp/scenes/scene_*.jpg 2>/dev/null | wc -l | tr -d ' ')
if [ "$N" -eq 0 ]; then
  echo "No scenes detected. Lower the threshold (try 0.2) or check the input." >&2
  exit 1
fi

echo "[3/3] contact sheet ($N scenes, 6 per row)"
ROWS=$(( (N + 5) / 6 )); [ "$ROWS" -lt 1 ] && ROWS=1
ffmpeg -y -pattern_type glob -i '.tmp/scenes/scene_*.jpg' \
  -filter_complex "tile=6x${ROWS}" -frames:v 1 .tmp/scenes/contact_sheet.jpg 2>/dev/null

echo "DONE. Read .tmp/scenes/contact_sheet.jpg, map every scene to a room,"
echo "then re-cut into the tour arc (50 to 70 seconds) before extracting frames."
