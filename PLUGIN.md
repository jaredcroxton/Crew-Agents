# Installing Crew as a Claude Code plugin

The zips in `dist/` are the manual option. The plugin marketplace here is the automated option. Add the marketplace once, then use either path below.

```
/plugin marketplace add <path-or-git-repo-to-this-crew-skill-packs-folder>
```

A local path works for testing. For real distribution, host this folder as a git repo and buyers add it by owner/repo.

There are two ways to install, because they do genuinely different things.

## Path 1 (recommended): project-local install, exactly like install.sh

Install the small installer plugin, then use its command:

```
/plugin install crew-installer@crew-packs
/crew:install sales        # Core is always included
/crew:install full         # all 9 packs
/crew:install sales global # into ~/.claude/skills for every project
/crew:uninstall sales      # remove a pack (only Crew skills, leaves core and your own)
/crew:uninstall all purge  # remove everything and clear saved handoffs
/crew:list                 # show packs and counts
```

`/crew:install` runs the bundled `install.sh`. It copies the skill folders into this project's `.claude/skills`, and it follows every rule:

- Project-local by default (this project only), `global` is opt-in.
- Idempotent and no-clobber: a skill that already exists is skipped, not overwritten.
- Reports what was installed and what was skipped.
- Never touches settings, hooks, or CLAUDE.md.

This is the path that matches the manual installer's behavior.

## Path 2: standard plugin skill loading, per pack

Each pack is also a normal plugin, so you can install one with the plugin manager:

```
/plugin install crew-sales@crew-packs
/plugin install crew-full@crew-packs
```

What to know about this path (it is how Claude Code plugins work, not a Crew choice):

- It is user-level (global). The skills become available in every project, not just this one.
- Skills load from the plugin cache and are namespaced by plugin, for example `crew-sales:crew-sales-lead-research`.
- The plugin manager handles install and updates. There is no per-skill no-clobber report, and it does not copy into your project's `.claude/skills`. Plugins have no install hook, so the project-local, no-clobber, reported copy is only available through Path 1.

Use Path 2 if you want a pack available everywhere with one command. Use Path 1 if you want it inside one project, reversible by deleting the folders, with a report.

## Regenerating the plugins

`packs/` is the single source of truth. After editing any skill, rebuild the plugin tree:

```
bash build-plugins.sh
```

This regenerates `plugins/` (the per-pack plugins, `crew-full`, and `crew-installer`) from `packs/`, and validates against `.claude-plugin/marketplace.json`.
