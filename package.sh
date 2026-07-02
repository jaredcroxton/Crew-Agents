#!/usr/bin/env bash
# Build distributable zips for the Crew skill packs.
#   dist/crew-NN-<id>-v<VERSION>.zip  per pack (self-contained: installer + uninstaller + credits + method + licence + the pack)
#   dist/crew-full-bundle-v<VERSION>.zip  the whole product
# Regenerates plugins/ + the marketplace manifest first (so the three install
# routes cannot diverge), then runs the QA gate and refuses to package if it fails.
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

VERSION="$(cat VERSION 2>/dev/null | tr -d ' \n')"
VERSION="${VERSION:-1.0.0}"

echo "== regenerating plugins + manifest (v$VERSION) =="
bash build-plugins.sh || { echo "build-plugins failed, refusing to package."; exit 1; }

if [ "$SKIP_QA" != 1 ]; then
  echo "== QA gate =="
  bash shared/qa-check.sh . || { echo "QA failed, refusing to package."; exit 1; }
fi

mkdir -p dist
ZIPCOMMON=(install.sh uninstall.sh LICENSE CREDITS.md README.md CHANGELOG.md VERSION shared/crew-method.md shared/SKILL-TEMPLATE.md shared/INSTALL.md)

zip_pack() {
  local packdir="$1" id zipname
  id="$(basename "$packdir")"
  zipname="dist/crew-$id-v$VERSION.zip"
  rm -f "$zipname" "dist/crew-$id.zip"
  zip -rq "$zipname" "${ZIPCOMMON[@]}" "$packdir" -x '*/.DS_Store' '*/crew-state/*'
  local n; n="$(find "$packdir" -maxdepth 1 -type d -name 'crew-*' | wc -l | tr -d ' ')"
  printf "  %-36s %s skills  %s\n" "$(basename "$zipname")" "$n" "$(du -h "$zipname" | cut -f1)"
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
  rm -f dist/crew-full-bundle.zip "dist/crew-full-bundle-v$VERSION.zip"
  # exclude the git store (ships every historical version), generated trees,
  # local state, and local databases
  zip -rq "dist/crew-full-bundle-v$VERSION.zip" . -x 'dist/*' '.git/*' 'plugins/*' '.claude/*' '.claude-plugin/*' '.tmp/*' 'tasks.db' '*.db' '.DS_Store' '*/.DS_Store' '*/crew-state/*'
  printf "  %-36s %s\n" "crew-full-bundle-v$VERSION.zip" "$(du -h "dist/crew-full-bundle-v$VERSION.zip" | cut -f1)"
fi
echo "done -> dist/ (v$VERSION)"
