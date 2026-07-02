#!/usr/bin/env python3
"""P4 consult-honor sweep: append the consult-mode clause to Step 0 of every
consulted-class skill (packs 12 design-standards, 13 design-styles, 14 animation).
Anchored on the Step 0 line-start literal, idempotent via sentinel."""
import pathlib

ROOT = pathlib.Path("/Users/jc/Desktop/cluade/crew-skill-packs/packs")
PACKS = ["12-design-standards", "13-design-styles", "14-animation"]
STEP0 = "**Step 0: Context Recovery.**"
SENTINEL = "CREW CONSULT from"
CLAUSE = ' Sub-skill consult: if the instruction opens with the literal preamble "CREW CONSULT from crew-<caller>: brand gate passed, brand-context at ~/.claude/crew-state/brand-context.md", first check that `~/.claude/crew-state/brand-context.md` actually exists; if the file is absent the preamble is VOID (a preamble is a claim, the file is the fact) and the full hard stop runs. With the file present, skip this step\'s onboarding stop and the Final Step context-save prompt (still read the brand context and still write this skill\'s own handoff); absent the literal preamble, run the full Step 0 including the brand hard stop, even if the request mentions another skill (per the Crew Method, Sub-skill consult).'

applied, skipped = [], []
for pack in PACKS:
    for f in sorted((ROOT / pack).glob("crew-*/SKILL.md")):
        lines = f.read_text().split("\n")
        done = False
        for i, line in enumerate(lines):
            if line.startswith(STEP0):
                if SENTINEL in line:
                    skipped.append(f.parent.name)
                else:
                    lines[i] = line + CLAUSE
                    applied.append(f.parent.name)
                done = True
                break
        if not done:
            print(f"NO STEP 0: {f.parent.name}")
        else:
            f.write_text("\n".join(lines))

print(f"applied: {len(applied)}  (12: {sum(1 for _ in (ROOT/'12-design-standards').glob('crew-*'))}, "
      f"13: {sum(1 for _ in (ROOT/'13-design-styles').glob('crew-*'))}, "
      f"14: {sum(1 for _ in (ROOT/'14-animation').glob('crew-*'))} dirs)")
print(f"already had it: {len(skipped)}")
