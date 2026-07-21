#!/bin/bash
# frame_check.sh - extract early/mid/late frames from each hero clip into a
# single contact sheet per hero for Seedance-vandalism review.
set -e
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
M="$ROOT/exports/motion"
mkdir -p "$M/frames"
for f in "$M"/hero*.mp4; do
  name=$(basename "$f" .mp4)
  ffmpeg -y -loglevel error -i "$f" -vf "select='eq(n\,10)+eq(n\,60)+eq(n\,110)',scale=360:450,tile=3x1" -frames:v 1 "$M/frames/$name-check.png"
  echo "framecheck $name"
done
echo FRAMECHECK DONE
