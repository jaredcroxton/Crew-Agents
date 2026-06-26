#!/usr/bin/env bash
# Crew skill-pack installer.
# Copies selected packs into a Claude skills directory. Idempotent, no-clobber.
# Never touches settings, hooks, or CLAUDE.md. Pure file copy.
#
# Usage:
#   ./install.sh                      install all packs into ./.claude/skills
#   ./install.sh --pack sales         install the sales pack (core is always included)
#   ./install.sh --pack sales --pack hr
#   ./install.sh --all                install every pack
#   ./install.sh --global             install into ~/.claude/skills
#   ./install.sh --target DIR         install into DIR
#   ./install.sh --force              overwrite skills that already exist
#   ./install.sh --dry-run            show what would happen, copy nothing
#   ./install.sh --list               list available packs and exit

set -uo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"
PACKS_DIR="$HERE/packs"

TARGET=""
GLOBAL=0
ALL=0
FORCE=0
DRY=0
PICKED=()

while [ $# -gt 0 ]; do
  case "$1" in
    --pack) PICKED+=("$2"); shift 2 ;;
    --all) ALL=1; shift ;;
    --global) GLOBAL=1; shift ;;
    --target) TARGET="$2"; shift 2 ;;
    --force) FORCE=1; shift ;;
    --dry-run) DRY=1; shift ;;
    --list)
      echo "Available packs:"
      for d in "$PACKS_DIR"/*/; do
        id="$(basename "${d%/}")"; id="${id#*-}"
        n="$(find "${d%/}" -maxdepth 1 -type d -name 'crew-*' | wc -l | tr -d ' ')"
        printf "  %-12s %s skills\n" "$id" "$n"
      done
      exit 0 ;;
    *) echo "unknown option: $1"; exit 2 ;;
  esac
done

# resolve target
if [ -n "$TARGET" ]; then DEST="$TARGET"
elif [ "$GLOBAL" = 1 ]; then DEST="$HOME/.claude/skills"
else DEST="$PWD/.claude/skills"; fi

# resolve pack list
declare -a PACKDIRS=()
add_pack() { # by id
  for d in "$PACKS_DIR"/*/; do
    local id; id="$(basename "${d%/}")"; id="${id#*-}"
    [ "$id" = "$1" ] && PACKDIRS+=("${d%/}") && return 0
  done
  echo "warning: pack '$1' not found, skipping" >&2
}
if [ "$ALL" = 1 ] || [ "${#PICKED[@]}" = 0 ]; then
  for d in "$PACKS_DIR"/*/; do PACKDIRS+=("${d%/}"); done
else
  add_pack core   # core is the handoff floor, always included
  for p in "${PICKED[@]}"; do [ "$p" = core ] || add_pack "$p"; done
fi

echo "Crew install -> $DEST"
[ "$DRY" = 1 ] && echo "(dry run, nothing will be written)"
[ "$DRY" = 1 ] || mkdir -p "$DEST"

INSTALLED=0; SKIPPED=0; BAD=0
for packdir in "${PACKDIRS[@]}"; do
  packid="$(basename "$packdir")"; packid="${packid#*-}"
  for sd in "$packdir"/crew-*/; do
    [ -d "$sd" ] || continue
    skill="$(basename "${sd%/}")"
    f="$sd/SKILL.md"
    # validate name == folder before copying
    nm="$(awk 'NR==1&&/^---$/{f=1;next} f&&/^---$/{exit} f&&/^name:/{sub(/^name: */,"");print;exit}' "$f" 2>/dev/null)"
    if [ "$nm" != "$skill" ]; then echo "  BAD   $skill (frontmatter name '$nm' != folder), not installed"; BAD=$((BAD+1)); continue; fi
    if [ -d "$DEST/$skill" ] && [ "$FORCE" != 1 ]; then echo "  skip  $skill (already present)"; SKIPPED=$((SKIPPED+1)); continue; fi
    if [ "$DRY" = 1 ]; then echo "  would install  $skill ($packid)"; INSTALLED=$((INSTALLED+1)); continue; fi
    rm -rf "$DEST/$skill"
    cp -R "$sd" "$DEST/$skill"
    echo "  ok    $skill ($packid)"
    INSTALLED=$((INSTALLED+1))
  done
done

echo "------------------------------------------------------------"
echo "Installed: $INSTALLED   Skipped (already present): $SKIPPED   Failed validation: $BAD"
IDS=""; for p in "${PACKDIRS[@]}"; do b="$(basename "$p")"; IDS="$IDS${b#*-} "; done
echo "Packs: $IDS"
[ "$DRY" = 1 ] || echo "Reload skills in Claude Code to pick them up."
[ "$BAD" = 0 ]
