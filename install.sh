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
#   ./install.sh --prune              remove crew-* skills in the target that no longer exist in packs/
#                                     (crew-* prefixed dirs only; never touches any other skill; prints before deleting)
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
PRUNE=0
PICKED=()

while [ $# -gt 0 ]; do
  case "$1" in
    --pack) PICKED+=("$2"); shift 2 ;;
    --all) ALL=1; shift ;;
    --global) GLOBAL=1; shift ;;
    --target) TARGET="$2"; shift 2 ;;
    --force) FORCE=1; shift ;;
    --prune) PRUNE=1; shift ;;
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

# install the Crew Method doc beside the skills: every skill references it by name,
# so the buyer's machine must actually hold it.
if [ "$DRY" != 1 ] && [ -f "$HERE/shared/crew-method.md" ]; then
  cp "$HERE/shared/crew-method.md" "$DEST/crew-method.md"
  echo "  ok    crew-method.md (the Crew Method, referenced by every skill)"
fi

# prune: remove crew-* dirs in the target that have no source folder in packs/.
# Scoped to the crew-* prefix so no other skill (flow-*, gsap, hyperframes, ...) is
# ever touched, AND ownership-validated: a dir whose SKILL.md frontmatter name does
# not match its folder is not a Crew-shipped skill (a buyer-authored crew-acme-*
# variant stays put); it is reported and left in place.
PRUNED=0
if [ "$PRUNE" = 1 ] && [ -d "$DEST" ]; then
  for td in "$DEST"/crew-*/; do
    [ -d "$td" ] || continue
    tname="$(basename "${td%/}")"
    found=0
    for d in "$PACKS_DIR"/*/; do
      [ -d "${d%/}/$tname" ] && found=1 && break
    done
    if [ "$found" = 0 ]; then
      # ownership test 1: the name must sit in a family THIS product ships
      # (the crew-<family>- prefixes derived from the shipped skill names, e.g.
      # crew-web-, crew-design-, crew-core-). A buyer-authored crew-acme-* is
      # not ours; leave it.
      tfam="$(printf '%s' "$tname" | cut -d- -f1-2)-"
      fam=0
      for sd2 in "$PACKS_DIR"/*/crew-*/; do
        sfam="$(basename "${sd2%/}" | cut -d- -f1-2)-"
        [ "$sfam" = "$tfam" ] && fam=1 && break
      done
      if [ "$fam" = 0 ]; then
        echo "  keep  $tname (not in any Crew pack family; buyer skill, left in place)"
        continue
      fi
      # ownership test 2: frontmatter name must match the folder (a malformed or
      # foreign dir that merely shares the prefix is reported, never deleted)
      nm="$(awk 'NR==1&&/^---$/{f=1;next} f&&/^---$/{exit} f&&/^name:/{sub(/^name: */,"");print;exit}' "$td/SKILL.md" 2>/dev/null)"
      if [ "$nm" != "$tname" ]; then
        echo "  keep  $tname (frontmatter name '$nm' != folder; not a Crew-shipped skill, left in place)"
        continue
      fi
      if [ "$DRY" = 1 ]; then echo "  would prune  $tname (no source in packs/)"
      else echo "  prune $tname (no source in packs/)"; rm -rf "$td"; fi
      PRUNED=$((PRUNED+1))
    fi
  done
fi

echo "------------------------------------------------------------"
echo "Installed: $INSTALLED   Skipped (already present): $SKIPPED   Failed validation: $BAD   Pruned: $PRUNED"
IDS=""; for p in "${PACKDIRS[@]}"; do b="$(basename "$p")"; IDS="$IDS${b#*-} "; done
echo "Packs: $IDS"
[ "$DRY" = 1 ] || echo "Reload skills in Claude Code to pick them up."
[ "$BAD" = 0 ]
