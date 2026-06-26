#!/usr/bin/env bash
# Build distributable zips for the Crew skill packs.
#   dist/crew-NN-<id>.zip  per pack (self-contained: installer + credits + method + the pack)
#   dist/crew-full-bundle.zip  the whole product
# Runs the QA gate first and refuses to package if it fails.
#
# Usage:
#   ./package.sh                 all packs + full bundle
#   ./package.sh --pack core     one pack only
#   ./package.sh --full          full bundle only
#   ./package.sh --skip-qa       package without the QA gate (not recommended)

set -uo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"
cd "$HERE"
PACK_FILTER=""; FULL_ONLY=0; SKIP_QA=0
while [ $# -gt 0 ]; do
  case "$1" in
    --pack) PACK_FILTER="$2"; shift 2 ;;
    --full) FULL_ONLY=1; shift ;;
    --skip-qa) SKIP_QA=1; shift ;;
    *) echo "unknown option: $1"; exit 2 ;;
  esac
done

if [ "$SKIP_QA" != 1 ]; then
  echo "== QA gate =="
  bash shared/qa-check.sh . || { echo "QA failed, refusing to package."; exit 1; }
fi

mkdir -p dist
ZIPCOMMON=(install.sh CREDITS.md README.md shared/crew-method.md shared/SKILL-TEMPLATE.md)

zip_pack() {
  local packdir="$1" id zipname
  id="$(basename "$packdir")"
  zipname="dist/crew-$id.zip"
  rm -f "$zipname"
  zip -rq "$zipname" "${ZIPCOMMON[@]}" "$packdir" -x '*/.DS_Store' '*/crew-state/*'
  local n; n="$(find "$packdir" -maxdepth 1 -type d -name 'crew-*' | wc -l | tr -d ' ')"
  printf "  %-26s %s skills  %s\n" "$(basename "$zipname")" "$n" "$(du -h "$zipname" | cut -f1)"
}

echo "== packaging =="
if [ "$FULL_ONLY" != 1 ]; then
  for d in packs/*/; do
    id="$(basename "${d%/}")"; pid="${id#*-}"
    [ -n "$PACK_FILTER" ] && [ "$pid" != "$PACK_FILTER" ] && continue
    zip_pack "${d%/}"
  done
fi

if [ -z "$PACK_FILTER" ]; then
  rm -f dist/crew-full-bundle.zip
  zip -rq dist/crew-full-bundle.zip . -x 'dist/*' '*/.DS_Store' '*/crew-state/*'
  printf "  %-26s %s\n" "crew-full-bundle.zip" "$(du -h dist/crew-full-bundle.zip | cut -f1)"
fi
echo "done -> dist/"
