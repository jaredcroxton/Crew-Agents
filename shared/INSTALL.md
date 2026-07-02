# Installing Crew from this zip

You downloaded a Crew skill pack as a zip. No git required. Three steps.

## 1. Unzip and install

```
unzip crew-*.zip -d crew
cd crew
bash install.sh --all --global
```

`--global` installs into `~/.claude/skills` so every project can use the skills.
Drop `--global` to install into the current project only (`.claude/skills`).
If this zip is a single pack, the same command installs that pack (core is always
included; it is the floor the other packs stand on).

## 2. Restart your Claude session

Skills load when a session starts. After any install or update, start a fresh
Claude Code session or the new skills stay invisible.

## 3. Onboard your business (once)

In the new session say:

```
Run crew-core-brand-context to onboard my business.
```

Eleven plain-language questions, one file written, and every skill you run from
then on knows who you are. To run more than one brand, see the examples under
`examples/brand-context/` and switch anytime with "switch to [brand]".

## Updating later

Download the newer zip (the version is in the filename, and CHANGELOG.md says
what changed), then:

```
bash install.sh --all --global --force --prune
```

`--force` overwrites the installed copies with the new versions. `--prune`
removes Crew skills that were renamed or retired (it never touches skills that
are not Crew's, and never touches your saved work).

## Uninstalling

```
bash uninstall.sh --all --global
```

Your saved work (the handoffs under `~/.claude/crew-state/`) stays in place
unless you add `--purge`, and a purge always writes a tar backup first.

## Notes

- Runs best on a Sonnet-class model or better. Smaller models hold the skill
  discipline less reliably (status vocabulary, the run receipt, the onboarding
  gate degrade first).
- The QA smoke suite (`bash shared/qa-check.sh --smoke`) invokes the Claude CLI
  roughly once per skill: about 98 metered calls on the full catalogue. Use
  `--pack <id>` to narrow it.
