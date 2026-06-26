#!/usr/bin/env bash
# Generate the Claude Code plugin tree under plugins/ from packs/.
# packs/ stays the single source of truth. Re-run after editing any skill.
#
# Produces:
#   plugins/crew-<id>/      one plugin per pack (skills bundled inside), for /plugin install crew-<id>@crew-packs
#   plugins/crew-full/      all 58 skills, for /plugin install crew-full@crew-packs
#   plugins/crew-installer/ install.sh + packs + the /crew:install command (project-local, no-clobber install)
#
# Pairs with .claude-plugin/marketplace.json (hand-maintained list of the same plugins).

set -uo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"
cd "$HERE"
rm -rf plugins
mkdir -p plugins

desc() { case "$1" in
  core)      echo "Core Crew skills (7): the safe way every job starts, runs, and ships." ;;
  sales)     echo "Sales (7): find the right people and start better conversations." ;;
  marketing) echo "Marketing (7): turn one idea into content that travels." ;;
  ops)       echo "Operations (5): make repeatable work faster and more reliable." ;;
  hr)        echo "HR and People (5): hire and support your team with less guesswork." ;;
  finance)   echo "Finance and Admin (6): keep the money side clear, current and calm." ;;
  support)   echo "Customer Support (6): answer customers faster, in one consistent voice." ;;
  docs)      echo "Documentation (7): capture how the business works, clearly." ;;
  training)  echo "Training and L&D (8): build capability that sticks." ;;
  *)         echo "Crew skills." ;;
esac; }

write_plugin_json() { # dir name description
  mkdir -p "$1/.claude-plugin"
  cat > "$1/.claude-plugin/plugin.json" <<JSON
{
  "name": "$2",
  "version": "1.0.0",
  "description": "$3",
  "author": { "name": "Crew" }
}
JSON
}

# one plugin per pack, skills copied in
for packdir in packs/*/; do
  id="$(basename "${packdir%/}")"; id="${id#*-}"
  pdir="plugins/crew-$id"
  write_plugin_json "$pdir" "crew-$id" "$(desc "$id")"
  mkdir -p "$pdir/skills"
  for sd in "${packdir}"crew-*/; do [ -d "$sd" ] && cp -R "${sd%/}" "$pdir/skills/"; done
done

# crew-full: every skill
write_plugin_json "plugins/crew-full" "crew-full" "The full Crew library: all 9 packs, 58 skills."
mkdir -p "plugins/crew-full/skills"
for sd in packs/*/crew-*/; do [ -d "$sd" ] && cp -R "${sd%/}" "plugins/crew-full/skills/"; done

# crew-installer: install.sh + packs + the /crew:install command (project-local install)
INST="plugins/crew-installer"
write_plugin_json "$INST" "crew-installer" "Project-local installer commands (/crew:install) that copy packs into .claude/skills with no-clobber and a report."
mkdir -p "$INST/commands"
cp install.sh "$INST/install.sh"
cp uninstall.sh "$INST/uninstall.sh"
cp -R packs "$INST/packs"
find "$INST/packs" -type d -name tests -exec rm -rf {} + 2>/dev/null

cat > "$INST/commands/install.md" <<'MD'
---
description: Install Crew skill packs into this project's .claude/skills (project-local, no-clobber, with a report). Usage /crew:install <pack> | all | full [global]
---
You install Crew skill packs by running the bundled installer, which copies skill folders into .claude/skills exactly like the manual install.sh: idempotent, never clobbering an existing skill, never touching settings, hooks, or CLAUDE.md, and printing what was installed and what was skipped.

Interpret the user's argument ("$ARGUMENTS"):
- a pack id (core, sales, marketing, ops, hr, finance, support, docs, training): pass `--pack <id>`. Core is always included as the dependency floor.
- "full", "all", or "everything": pass `--all`.
- if the word "global" appears: also add `--global` (installs into ~/.claude/skills for every project instead of only this one).
- nothing given: default to `--all`.

Run exactly this, with the mapped flags substituted in:
`bash "${CLAUDE_PLUGIN_ROOT}/install.sh" <mapped-flags>`

Then report the installer summary (installed count, skipped-already-present count, packs) back to the user. Do not edit any other files.
MD

cat > "$INST/commands/uninstall.md" <<'MD'
---
description: Remove Crew skill packs from this project's .claude/skills (reports what was removed, never touches other skills). Usage /crew:uninstall <pack> | all [global] [purge]
---
You remove Crew skill packs by running the bundled uninstaller, which deletes only Crew skill folders (crew-*) from .claude/skills, reports what was removed, and never touches other skills, settings, hooks, or CLAUDE.md.

Interpret the user's argument ("$ARGUMENTS"):
- a pack id (core, sales, marketing, ops, hr, finance, support, docs, training): pass `--pack <id>`. This does NOT remove core, because other installed packs may still need it.
- "all", "full", or "everything", or nothing: pass `--all` (removes every Crew pack, including core).
- if "global" appears: add `--global` (target ~/.claude/skills).
- if "purge" appears: add `--purge` (also clears saved handoffs under crew-state).

Run exactly this, with the mapped flags substituted in:
`bash "${CLAUDE_PLUGIN_ROOT}/uninstall.sh" <mapped-flags>`

Then report the uninstaller summary (removed count, not-present count, packs) back to the user. Do not delete anything else.
MD

cat > "$INST/commands/list.md" <<'MD'
---
description: List the available Crew packs and their skill counts.
---
Run `bash "${CLAUDE_PLUGIN_ROOT}/install.sh" --list` and show the output to the user.
MD

# summary
n_pack=$(find plugins -maxdepth 1 -type d -name 'crew-*' | wc -l | tr -d ' ')
n_skill=$(find plugins -path '*/skills/crew-*' -maxdepth 4 -type d | wc -l | tr -d ' ')
echo "built $n_pack plugins under plugins/ (skill folders copied: $n_skill)"
echo "marketplace: .claude-plugin/marketplace.json"
