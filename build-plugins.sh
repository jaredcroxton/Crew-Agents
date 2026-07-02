#!/usr/bin/env bash
# Generate the Claude Code plugin tree and the marketplace manifest from packs/.
# packs/ stays the single source of truth. Re-run after editing any skill.
#
# Produces (under OUT, default plugins/):
#   crew-<id>/       one plugin per pack (skills bundled inside), for /plugin install crew-<id>@crew-packs
#   crew-full/       every skill, for /plugin install crew-full@crew-packs
#   crew-installer/  install.sh + packs + the /crew:install command (project-local, no-clobber install)
# And (default OUT only): .claude-plugin/marketplace.json, GENERATED from the packs
# just built, with counts derived from disk. Never hand-maintain the manifest.
#
# Usage:
#   ./build-plugins.sh              build plugins/ + regenerate the manifest
#   ./build-plugins.sh --out DIR    build into DIR (no manifest write; used by the QA parity check)

set -uo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"
cd "$HERE"

OUT="plugins"
while [ $# -gt 0 ]; do
  case "$1" in
    --out) OUT="$2"; shift 2 ;;
    *) echo "unknown option: $1"; exit 2 ;;
  esac
done

VERSION="$(cat VERSION 2>/dev/null | tr -d ' \n')"
VERSION="${VERSION:-1.0.0}"

rm -rf "$OUT"
mkdir -p "$OUT"

desc() { case "$1" in
  core)             echo "Core Crew skills: the safe way every job starts, runs, and ships." ;;
  sales)            echo "Sales: find the right people and start better conversations." ;;
  marketing)        echo "Marketing: turn one idea into content that travels." ;;
  ops)              echo "Operations: make repeatable work faster and more reliable." ;;
  hr)               echo "HR and People: hire and support your team with less guesswork." ;;
  finance)          echo "Finance and Admin: keep the money side clear, current and calm." ;;
  support)          echo "Customer Support: answer customers faster, in one consistent voice." ;;
  docs)             echo "Documentation: capture how the business works, clearly." ;;
  training)         echo "Training and L&D: build capability that sticks." ;;
  web-design)       echo "Web Design: premium websites, decks, dashboards, and immersive builds." ;;
  infrastructure)   echo "Infrastructure: deterministic project scaffolding and automation builds." ;;
  design-standards) echo "Design Standards: the quality gates that keep every build premium." ;;
  design-styles)    echo "Design Styles: committed aesthetic lenses from brutalist to soft." ;;
  animation)        echo "Animation: motion specs for every stack, GSAP to CSS to Rive." ;;
  *)                echo "Crew skills." ;;
esac; }

pack_skill_count() { find "$1" -maxdepth 1 -type d -name 'crew-*' | wc -l | tr -d ' '; }

write_plugin_json() { # dir name description
  mkdir -p "$1/.claude-plugin"
  cat > "$1/.claude-plugin/plugin.json" <<JSON
{
  "name": "$2",
  "version": "$VERSION",
  "description": "$3",
  "author": { "name": "Crew" }
}
JSON
}

TOTAL_SKILLS=$(find packs -mindepth 2 -maxdepth 2 -type d -name 'crew-*' | wc -l | tr -d ' ')
TOTAL_PACKS=$(find packs -mindepth 1 -maxdepth 1 -type d | wc -l | tr -d ' ')

# one plugin per pack, skills copied in
PACK_IDS=""
for packdir in packs/*/; do
  id="$(basename "${packdir%/}")"; id="${id#*-}"
  PACK_IDS="$PACK_IDS $id"
  n="$(pack_skill_count "${packdir%/}")"
  pdir="$OUT/crew-$id"
  write_plugin_json "$pdir" "crew-$id" "$(desc "$id") ($n skills)"
  mkdir -p "$pdir/skills"
  for sd in "${packdir}"crew-*/; do [ -d "$sd" ] && cp -R "${sd%/}" "$pdir/skills/"; done
done

# crew-full: every skill
write_plugin_json "$OUT/crew-full" "crew-full" "The full Crew library: all $TOTAL_PACKS packs, $TOTAL_SKILLS skills."
mkdir -p "$OUT/crew-full/skills"
for sd in packs/*/crew-*/; do [ -d "$sd" ] && cp -R "${sd%/}" "$OUT/crew-full/skills/"; done

# crew-installer: install.sh + packs + the /crew:install command (project-local install)
INST="$OUT/crew-installer"
write_plugin_json "$INST" "crew-installer" "Project-local installer commands (/crew:install) that copy packs into .claude/skills with no-clobber and a report."
mkdir -p "$INST/commands"
cp install.sh "$INST/install.sh"
cp uninstall.sh "$INST/uninstall.sh"
cp shared/crew-method.md "$INST/crew-method.md"
cp -R packs "$INST/packs"
find "$INST/packs" -type d -name tests -exec rm -rf {} + 2>/dev/null

PACK_ID_LIST="$(echo $PACK_IDS | tr ' ' ',' | sed 's/,/, /g')"

cat > "$INST/commands/install.md" <<MD
---
description: Install Crew skill packs into this project's .claude/skills (project-local, no-clobber, with a report). Usage /crew:install <pack> | all | full [global]
---
You install Crew skill packs by running the bundled installer, which copies skill folders into .claude/skills exactly like the manual install.sh: idempotent, never clobbering an existing skill, never touching settings, hooks, or CLAUDE.md, and printing what was installed and what was skipped.

Interpret the user's argument ("\$ARGUMENTS"):
- a pack id ($PACK_ID_LIST): pass \`--pack <id>\`. Core is always included as the dependency floor.
- "full", "all", or "everything": pass \`--all\`.
- if the word "global" appears: also add \`--global\` (installs into ~/.claude/skills for every project instead of only this one).
- nothing given: default to \`--all\`.

Run exactly this, with the mapped flags substituted in:
\`bash "\${CLAUDE_PLUGIN_ROOT}/install.sh" <mapped-flags>\`

Then report the installer summary (installed count, skipped-already-present count, packs) back to the user. Do not edit any other files.
MD

cat > "$INST/commands/uninstall.md" <<MD
---
description: Remove Crew skill packs from this project's .claude/skills (reports what was removed, never touches other skills). Usage /crew:uninstall <pack> | all [global] [purge]
---
You remove Crew skill packs by running the bundled uninstaller, which deletes only Crew skill folders (crew-*) from .claude/skills, reports what was removed, and never touches other skills, settings, hooks, or CLAUDE.md.

Interpret the user's argument ("\$ARGUMENTS"):
- a pack id ($PACK_ID_LIST): pass \`--pack <id>\`. This does NOT remove core, because other installed packs may still need it.
- "all", "full", or "everything", or nothing: pass \`--all\` (removes every Crew pack, including core).
- if "global" appears: add \`--global\` (target ~/.claude/skills).
- if "purge" appears: add \`--purge\` (also clears saved handoffs under crew-state, after a tar backup).

Run exactly this, with the mapped flags substituted in:
\`bash "\${CLAUDE_PLUGIN_ROOT}/uninstall.sh" <mapped-flags>\`

Then report the uninstaller summary (removed count, not-present count, packs) back to the user. Do not delete anything else.
MD

cat > "$INST/commands/list.md" <<'MD'
---
description: List the available Crew packs and their skill counts.
---
Run `bash "${CLAUDE_PLUGIN_ROOT}/install.sh" --list` and show the output to the user.
MD

# marketplace manifest: GENERATED, never hand-maintained. Default OUT only, so the
# QA parity check (--out .tmp/parity-plugins) never touches the real manifest.
if [ "$OUT" = "plugins" ]; then
  mkdir -p .claude-plugin
  {
    printf '{\n'
    printf '  "name": "crew-packs",\n'
    printf '  "owner": { "name": "Crew" },\n'
    printf '  "metadata": {\n'
    printf '    "description": "Crew business skill packs. %s packs, %s skills. Install a pack and Claude gains a focused specialist for that part of the business.",\n' "$TOTAL_PACKS" "$TOTAL_SKILLS"
    printf '    "version": "%s"\n' "$VERSION"
    printf '  },\n'
    printf '  "plugins": [\n'
    printf '    {\n'
    printf '      "name": "crew-installer",\n'
    printf '      "source": "./plugins/crew-installer",\n'
    printf '      "description": "Project-local installer. Adds /crew:install which copies packs into this project'"'"'s .claude/skills the same way install.sh does: idempotent, never clobbering, with a report."\n'
    printf '    },\n'
    for packdir in packs/*/; do
      id="$(basename "${packdir%/}")"; id="${id#*-}"
      n="$(pack_skill_count "${packdir%/}")"
      printf '    { "name": "crew-%s", "source": "./plugins/crew-%s", "description": "%s (%s skills)" },\n' "$id" "$id" "$(desc "$id")" "$n"
    done
    printf '    { "name": "crew-full", "source": "./plugins/crew-full", "description": "The full library: all %s packs, %s skills." }\n' "$TOTAL_PACKS" "$TOTAL_SKILLS"
    printf '  ]\n'
    printf '}\n'
  } > .claude-plugin/marketplace.json
fi

# summary
n_pack=$(find "$OUT" -maxdepth 1 -type d -name 'crew-*' | wc -l | tr -d ' ')
n_skill=$(find "$OUT" -path '*/skills/crew-*' -maxdepth 4 -type d | wc -l | tr -d ' ')
echo "built $n_pack plugins under $OUT/ (skill folders copied: $n_skill) at version $VERSION"
[ "$OUT" = "plugins" ] && echo "manifest generated: .claude-plugin/marketplace.json ($TOTAL_PACKS packs, $TOTAL_SKILLS skills)"
