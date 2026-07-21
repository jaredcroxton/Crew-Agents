#!/bin/bash
# export_pages.sh - render all 18 body pages via headless Chrome.
# Serve the campaign project from a /tmp copy on $PORT first (see failure-modes:
# @font-face and relative assets need an HTTP origin, never file://).
# EDIT PER CAMPAIGN: PORT, and IDS if the carousel count differs.
set -e
CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
OUT="$ROOT/exports/pages"
PORT=5021
mkdir -p "$OUT"
IDS="c1p2 c1p3 c1p4 c2p2 c2p3 c2p4 c3p2 c3p3 c3p4 c4p2 c4p3 c4p4 c5p2 c5p3 c5p4 c6p2 c6p3 c6p4"
for id in $IDS; do
  "$CHROME" --headless=new --disable-gpu --hide-scrollbars \
    --window-size=1080,1350 --force-device-scale-factor=1 \
    --virtual-time-budget=6000 \
    --screenshot="$OUT/$id.png" \
    "http://localhost:$PORT/pages.html?page=$id" 2>/dev/null
  echo "exported $id"
done
echo "ALL PAGES EXPORTED"
