#!/usr/bin/env bash
# Crew skill-pack uninstaller. The reverse of install.sh.
# Removes ONLY Crew skill folders (crew-<pack>-*) that this product owns.
# Never touches other skills, settings, hooks, or CLAUDE.md. Reports what it did.
#
# Usage:
#   ./uninstall.sh                 remove ALL Crew packs from ./.claude/skills
#   ./uninstall.sh --pack sales    remove only the sales pack (leaves core, others may need it)
#   ./uninstall.sh --all           remove every Crew pack (including core)
#   ./uninstall.sh --global        target ~/.claude/skills
#   ./uninstall.sh --target DIR     target DIR
#   ./uninstall.sh --purge         also clear saved handoffs under .claude/crew-state
#   ./uninstall.sh --dry-run       show what would be removed, remove nothing
#   ./uninstall.sh --list          list available packs and exit

set -uo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"
PACKS_DIR="$HERE/packs"

TARGET=""; GLOBAL=0; ALL=0; PURGE=0; DRY=0; PICKED=()
while [ $# -gt 0 ]; do
  case "$1" in
    --pack) PICKED+=("$2"); shift 2 ;;
    --all) ALL=1; shift ;;
    --global) GLOBAL=1; shift ;;
    --target) TARGET="$2"; shift 2 ;;
    --purge) PURGE=1; shift ;;
    --dry-run) DRY=1; shift ;;
    --list)
      echo "Available packs:"
      for d in "$PACKS_DIR"/*/; do id="$(basename "${d%/}")"; id="${id#*-}"; n="$(find "${d%/}" -maxdepth 1 -type d -name 'crew-*' | wc -l | tr -d ' ')"; printf "  %-12s %s skills\n" "$id" "$n"; done
      exit 0 ;;
    *) echo "unknown option: $1"; exit 2 ;;
  esac
done

if [ -n "$TARGET" ]; then DEST="$TARGET"
elif [ "$GLOBAL" = 1 ]; then DEST="$HOME/.claude/skills"
else DEST="$PWD/.claude/skills"; fi
STATE_BASE="$(dirname "$DEST")/crew-state"

# which packs
declare -a PACKDIRS=()
add_pack() { for d in "$PACKS_DIR"/*/; do local id; id="$(basename "${d%/}")"; id="${id#*-}"; [ "$id" = "$1" ] && PACKDIRS+=("${d%/}") && return 0; done; echo "warning: pack '$1' not found" >&2; }
if [ "$ALL" = 1 ] || [ "${#PICKED[@]}" = 0 ]; then
  for d in "$PACKS_DIR"/*/; do PACKDIRS+=("${d%/}"); done   # default and --all: every pack
else
  for p in "${PICKED[@]}"; do add_pack "$p"; done           # only named packs (do NOT auto-add core)
fi

echo "Crew uninstall <- $DEST"
[ "$DRY" = 1 ] && echo "(dry run, nothing will be removed)"

REMOVED=0; ABSENT=0
for packdir in "${PACKDIRS[@]}"; do
  packid="$(basename "$packdir")"; packid="${packid#*-}"
  for sd in "$packdir"/crew-*/; do
    [ -d "$sd" ] || continue
    skill="$(basename "${sd%/}")"
    if [ -d "$DEST/$skill" ]; then
      # validate name == folder before removing, so a buyer's own folder that
      # happens to share a name is never deleted
      nm="$(awk 'NR==1&&/^---$/{f=1;next} f&&/^---$/{exit} f&&/^name:/{sub(/^name: */,"");print;exit}' "$DEST/$skill/SKILL.md" 2>/dev/null)"
      if [ "$nm" != "$skill" ]; then echo "  skip     $skill (installed name '$nm' != folder, not a Crew skill, left in place)"; ABSENT=$((ABSENT+1)); continue; fi
      if [ "$DRY" = 1 ]; then echo "  would remove  $skill ($packid)"; else rm -rf "$DEST/$skill"; echo "  removed  $skill ($packid)"; fi
      REMOVED=$((REMOVED+1))
    else
      ABSENT=$((ABSENT+1))
    fi
  done
  if [ "$PURGE" = 1 ] && [ -d "$STATE_BASE/$packid" ]; then
    if [ "$DRY" = 1 ]; then echo "  would purge   crew-state/$packid"; else rm -rf "$STATE_BASE/$packid"; echo "  purged   crew-state/$packid"; fi
  fi
done

echo "------------------------------------------------------------"
IDS=""; for p in "${PACKDIRS[@]}"; do b="$(basename "$p")"; IDS="$IDS${b#*-} "; done
echo "Removed: $REMOVED   Not present: $ABSENT   Packs: $IDS"
[ "$PURGE" = 1 ] && echo "Handoff state purged for the above packs." || echo "Saved handoffs under crew-state were left in place (use --purge to clear)."
