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
#   ./uninstall.sh --purge         also clear the business memory under ~/.claude/crew-state
#                                   (projects/, lessons/, brand-context.md, active-project,
#                                   legacy pack handoffs; always tars a backup first)
#   ./uninstall.sh --purge --all   additionally removes archived brand drawers (brands/)
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
# Skills write their handoffs to the home-global store regardless of where they
# were installed, so purge targets it unconditionally. Purge is the buyer's
# accumulated MEMORY: it is always backed up to a tar before anything is deleted.
STATE_BASE="$HOME/.claude/crew-state"
PURGE_BACKUP="$HOME/.claude/crew-state-backup-$(date +%Y%m%d-%H%M%S).tar.gz"
PURGED_ANY=0

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
    if [ "$DRY" = 1 ]; then
      echo "  would purge   $STATE_BASE/$packid (these handoff files):"
      find "$STATE_BASE/$packid" -type f | sed 's/^/                  /'
    else
      # back the memory up before deleting anything; one tar covers the whole run
      if [ "$PURGED_ANY" = 0 ]; then
        tar -czf "$PURGE_BACKUP" -C "$(dirname "$STATE_BASE")" "$(basename "$STATE_BASE")" 2>/dev/null \
          && echo "  backup   full crew-state saved to $PURGE_BACKUP"
      fi
      echo "  purging  $STATE_BASE/$packid:"
      find "$STATE_BASE/$packid" -type f | sed 's/^/                  /'
      rm -rf "$STATE_BASE/$packid"
      echo "  purged   $STATE_BASE/$packid"
      PURGED_ANY=1
    fi
  fi
done

# modern-layout purge: the per-pack loop above only knows the legacy pre-Projects
# layout ($STATE_BASE/<packid>). The modern store keeps the business memory at
# projects/, lessons/, brand-context.md, and active-project; a buyer clearing a
# machine expects --purge to remove it. Backed up to the same tar first.
if [ "$PURGE" = 1 ]; then
  MODERN_ITEMS=()
  for item in projects lessons brand-context.md active-project SWITCHING; do
    [ -e "$STATE_BASE/$item" ] && MODERN_ITEMS+=("$item")
  done
  [ "$ALL" = 1 ] && [ -d "$STATE_BASE/brands" ] && MODERN_ITEMS+=("brands")
  if [ "${#MODERN_ITEMS[@]}" -gt 0 ]; then
    if [ "$DRY" = 1 ]; then
      echo "  would purge   modern crew-state memory: ${MODERN_ITEMS[*]}"
      [ "$ALL" != 1 ] && [ -d "$STATE_BASE/brands" ] && echo "  would keep    brands/ (archived drawers; add --all to remove them too)"
    else
      if [ "$PURGED_ANY" = 0 ]; then
        tar -czf "$PURGE_BACKUP" -C "$(dirname "$STATE_BASE")" "$(basename "$STATE_BASE")" 2>/dev/null \
          && echo "  backup   full crew-state saved to $PURGE_BACKUP"
      fi
      for item in "${MODERN_ITEMS[@]}"; do
        rm -rf "${STATE_BASE:?}/$item"
        echo "  purged   $STATE_BASE/$item"
      done
      [ "$ALL" != 1 ] && [ -d "$STATE_BASE/brands" ] && echo "  kept     $STATE_BASE/brands (archived drawers; rerun with --all to remove)"
      PURGED_ANY=1
    fi
  fi
fi

# with --all and every crew-* skill gone, remove the installed Crew Method doc too
if [ "$ALL" = 1 ] && [ "$DRY" != 1 ] && [ -f "$DEST/crew-method.md" ]; then
  remaining=$(find "$DEST" -maxdepth 1 -type d -name 'crew-*' 2>/dev/null | wc -l | tr -d ' ')
  if [ "$remaining" = 0 ]; then rm -f "$DEST/crew-method.md"; echo "  removed  crew-method.md (no Crew skills remain)"; fi
  if [ "$remaining" = 0 ] && [ -f "$DEST/web-standards.md" ]; then rm -f "$DEST/web-standards.md"; echo "  removed  web-standards.md (no Crew skills remain)"; fi
fi

# with --all, also remove the bundled HyperFrames vendor skills (exact shipped names
# only, so a buyer's own similarly named work is never touched)
if [ "$ALL" = 1 ] && [ "$DRY" != 1 ]; then
  for v in hyperframes hyperframes-cli hyperframes-media hyperframes-registry remotion-to-hyperframes website-to-hyperframes; do
    if [ -d "$DEST/$v" ]; then rm -rf "$DEST/$v"; echo "  removed  $v (bundled vendor skill)"; REMOVED=$((REMOVED+1)); fi
  done
fi

echo "------------------------------------------------------------"
IDS=""; for p in "${PACKDIRS[@]}"; do b="$(basename "$p")"; IDS="$IDS${b#*-} "; done
echo "Removed: $REMOVED   Not present: $ABSENT   Packs: $IDS"
if [ "$PURGE" = 1 ]; then
  if [ "$DRY" = 1 ]; then echo "Dry run: the handoff state listed above would be purged (after a tar backup)."
  elif [ "$PURGED_ANY" = 1 ]; then echo "Handoff state purged for the above packs (backup: $PURGE_BACKUP)."
  else echo "Nothing to purge: no handoff state found for the above packs under $STATE_BASE."; fi
else
  echo "Saved handoffs under crew-state were left in place (use --purge to clear; a purge always tars a backup first)."
fi
