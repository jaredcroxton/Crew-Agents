#!/usr/bin/env bash
# Extract the shipped frame sets from the CUT tour video (the re-cut journey,
# never the raw agency edit). Two renditions:
#   frames/d/f%04d.webp  desktop landscape, 1440w, WebP q62
#   frames/m/f%04d.webp  mobile PORTRAIT, center-cropped 2:3 -> 720x1080, q62
#
# Pinned quality (the visual grade of the scrub): WebP q62, band q55 to q65.
# Hard budgets, audited below and FAILED if busted:
#   desktop set <= 12MB, mobile set <= 6MB, frame count 400 to 600.
# These sit inside the web-standards Perf 1 class C ceilings; the gallery and
# floorplan share the rest of that ceiling. Over budget = re-encode (drop q
# toward 55, then width toward 1280), never ship heavy.
#
# Usage:
#   pipeline/extract_frames.sh cut.mp4 [nth]
#   nth = extract every Nth frame (default 3; a 25fps source -> ~8.3fps scrub;
#         pick nth so N lands in 400 to 600 for the cut length)
set -euo pipefail
cd "$(dirname "$0")/.."
IN="${1:?usage: pipeline/extract_frames.sh cut.mp4 [nth]}"
NTH="${2:-3}"
[ -f "$IN" ] || { echo "MISSING $IN" >&2; exit 1; }
command -v ffmpeg >/dev/null || { echo "ffmpeg not found (brew install ffmpeg)" >&2; exit 1; }
command -v cwebp >/dev/null || {
  echo "cwebp not found (brew install webp)." >&2
  echo "Fallback rule (web-standards, Section 3 tooling): ship the JPEG sets and" >&2
  echo "record the deviation as a named residual at Gate 7. Not a silent pass." >&2
  exit 1
}

mkdir -p .tmp/raw_d .tmp/raw_m frames/d frames/m
rm -f .tmp/raw_d/*.jpg .tmp/raw_m/*.jpg frames/d/*.webp frames/m/*.webp

echo "[1/3] extract every ${NTH}th frame (desktop 1440w + mobile portrait 720x1080)"
ffmpeg -y -i "$IN" -vf "select='not(mod(n\,$NTH))',scale=1440:-2" \
  -vsync vfr -q:v 2 .tmp/raw_d/f%04d.jpg 2>/dev/null
# Portrait: center-crop to 2:3 then scale, so a 1080p source crops 720x1080
# exactly with no distortion. The portrait set is the single biggest mobile
# quality fix: landscape frames cover-fit a phone into a blurry sliver.
ffmpeg -y -i "$IN" -vf "select='not(mod(n\,$NTH))',crop=ih*2/3:ih,scale=720:1080" \
  -vsync vfr -q:v 2 .tmp/raw_m/f%04d.jpg 2>/dev/null

echo "[2/3] transcode to WebP q62"
for f in .tmp/raw_d/*.jpg; do
  cwebp -quiet -q 62 "$f" -o "frames/d/$(basename "${f%.jpg}").webp"
done
for f in .tmp/raw_m/*.jpg; do
  cwebp -quiet -q 62 "$f" -o "frames/m/$(basename "${f%.jpg}").webp"
done

echo "[3/3] audit against the hard budgets"
N=$(ls frames/d/*.webp 2>/dev/null | wc -l | tr -d ' ')
NM=$(ls frames/m/*.webp 2>/dev/null | wc -l | tr -d ' ')
KD=$(du -sk frames/d | cut -f1); MB_D=$(( (KD + 1023) / 1024 ))
KM=$(du -sk frames/m | cut -f1); MB_M=$(( (KM + 1023) / 1024 ))
echo "      N=$N desktop / $NM mobile | desktop ${MB_D}MB (cap 12) | mobile ${MB_M}MB (cap 6)"

FAIL=0
[ "$N" -eq "$NM" ] || { echo "FAIL: set counts differ ($N vs $NM); re-run both extractions."; FAIL=1; }
if [ "$N" -lt 400 ] || [ "$N" -gt 600 ]; then
  echo "FAIL: N=$N outside 400 to 600. Re-cut the tour (50 to 70s) or change nth."
  FAIL=1
fi
[ "$MB_D" -le 12 ] || { echo "FAIL: desktop set ${MB_D}MB over the 12MB cap. Drop q toward 55, then width toward 1280."; FAIL=1; }
[ "$MB_M" -le 6 ] || { echo "FAIL: mobile set ${MB_M}MB over the 6MB cap. Drop q toward 55."; FAIL=1; }

if [ "$FAIL" = 0 ]; then
  echo "PASS. Set FRAME_COUNT = $N in index.html."
  echo "Pacing floor: #scrub-section height = $((N * 6)) to $((N * 8))px, then tune"
  echo "upward until one full-viewport phone swipe advances about one room."
  echo "Export the OG card from the hero frame next:"
  echo "  ffmpeg -ss <hero time> -i \"$IN\" -frames:v 1 -vf \"scale=1200:630:force_original_aspect_ratio=increase,crop=1200:630\" og.jpg"
fi
exit $FAIL
