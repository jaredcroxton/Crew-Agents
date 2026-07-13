#!/usr/bin/env bash
# compress-assets.sh (crew-web-cinematic-build pipeline)
#
# Converts the nine-photo manifest's generator output (jpeg/png) to .webp at the
# locked quality and dimension caps, re-encodes video loops, and prints the summed
# byte total against the weight budget (SKILL.md, The weight budget; web-standards
# Perf 1 and Perf 2).
#
# Usage:
#   ./compress-assets.sh <assets-dir> [--mobile]
#
# Plain run: desktop renditions (backdrops capped at 2560px long edge, heroes 2048px).
# --mobile: additionally writes _small renditions capped at 1280px for the mobile cut.
#
# Tooling rule (web-standards, Section 3 tooling box): if cwebp or ffmpeg is missing,
# ship the source format and record the deviation as a named residual at Gate 7,
# never a silent pass. This script says so out loud and exits nonzero.

set -euo pipefail

DIR="${1:?usage: compress-assets.sh <assets-dir> [--mobile]}"
MOBILE="${2:-}"

BUDGET_DESKTOP=$((8 * 1024 * 1024))   # this skill's ceiling: 8MB desktop
BUDGET_MOBILE=$((4 * 1024 * 1024))    # 4MB mobile cut
Q=82                                   # cwebp quality, locked
CRF=26                                 # ffmpeg H.264 quality, locked
BACKDROP_MAX=2560                      # desktop long-edge cap for s{n}_bg
HERO_MAX=2048                          # cap for s{n}_hero and s2_cards
MOBILE_MAX=1280                        # mobile rendition cap

missing=0
command -v cwebp >/dev/null 2>&1 || { echo "MISSING TOOL: cwebp (brew install webp). Stills stay in source format: record this as a named residual at Gate 7."; missing=1; }
command -v ffmpeg >/dev/null 2>&1 || { echo "MISSING TOOL: ffmpeg (brew install ffmpeg). Video stays as delivered: record this as a named residual at Gate 7."; missing=1; }
[ "$missing" -eq 1 ] && exit 1

cd "$DIR"

# Long-edge cap for cwebp: -resize fits inside WxH keeping aspect when one side is 0.
webp_pass() { # $1 src, $2 out, $3 max long edge
  local src="$1" out="$2" max="$3" w h
  read -r w h < <(sips -g pixelWidth -g pixelHeight "$src" 2>/dev/null | awk '/pixelWidth/{w=$2}/pixelHeight/{h=$2}END{print w, h}')
  if [ "${w:-0}" -ge "${h:-0}" ] && [ "${w:-0}" -gt "$max" ]; then
    cwebp -quiet -q "$Q" -resize "$max" 0 "$src" -o "$out"
  elif [ "${h:-0}" -gt "$max" ]; then
    cwebp -quiet -q "$Q" -resize 0 "$max" "$src" -o "$out"
  else
    cwebp -quiet -q "$Q" "$src" -o "$out"
  fi
  echo "  $src -> $out ($(du -h "$out" | cut -f1 | tr -d ' '))"
}

echo "== Stills to .webp (q$Q, backdrops <=${BACKDROP_MAX}px, heroes <=${HERO_MAX}px) =="
shopt -s nullglob
for src in s*_bg.jpeg s*_bg.jpg s*_bg.png; do
  webp_pass "$src" "${src%.*}.webp" "$BACKDROP_MAX"
done
for src in s*_hero.jpeg s*_hero.jpg s*_hero.png s2_cards.jpeg s2_cards.jpg s2_cards.png; do
  webp_pass "$src" "${src%.*}.webp" "$HERO_MAX"
done

if [ "$MOBILE" = "--mobile" ]; then
  echo "== Mobile renditions (<=${MOBILE_MAX}px) =="
  for src in s*_bg.jpeg s*_bg.jpg s*_bg.png s*_hero.jpeg s*_hero.jpg s*_hero.png; do
    webp_pass "$src" "${src%.*}_small.webp" "$MOBILE_MAX"
  done
fi

echo "== Video loops (H.264 crf$CRF, faststart, audio stripped, target under 6MB) =="
for src in s*_bg.mp4; do
  case "$src" in *_c.mp4) continue ;; esac
  out="${src%.mp4}_c.mp4"
  ffmpeg -y -loglevel error -i "$src" -an -c:v libx264 -crf "$CRF" -pix_fmt yuv420p -movflags +faststart "$out"
  echo "  $src -> $out ($(du -h "$out" | cut -f1 | tr -d ' '))"
  echo "  NOTE: wire $out under a NEW filename if $src was ever loaded (browsers cache by name)."
done

echo "== Weight budget (web-standards Gate 7) =="
desktop_bytes=$(find . -maxdepth 1 \( -name '*.webp' -o -name '*_c.mp4' \) ! -name '*_small.webp' -print0 | xargs -0 stat -f %z 2>/dev/null | awk '{s+=$1}END{print s+0}')
echo "  Shipping set (desktop): $desktop_bytes bytes ($(echo "$desktop_bytes" | awk '{printf "%.1fMB", $1/1048576}'))"
if [ "$desktop_bytes" -gt "$BUDGET_DESKTOP" ]; then
  echo "  FAIL: over the 8MB desktop budget. Compress harder or cut an asset. This blocks the gate."
  exit 2
fi
if [ "$MOBILE" = "--mobile" ]; then
  mobile_bytes=$(find . -maxdepth 1 -name '*_small.webp' -print0 | xargs -0 stat -f %z 2>/dev/null | awk '{s+=$1}END{print s+0}')
  echo "  Mobile rendition set: $mobile_bytes bytes ($(echo "$mobile_bytes" | awk '{printf "%.1fMB", $1/1048576}'))"
  if [ "$mobile_bytes" -gt "$BUDGET_MOBILE" ]; then
    echo "  FAIL: over the 4MB mobile budget. This blocks the gate."
    exit 2
  fi
fi
echo "  PASS: inside budget. State these numbers in the build report."
