#!/usr/bin/env python3
"""P7.3 runtime-fallback sweep.

Insert 1 (all conventional skills, Final Step): staged-handoff fallback for a
denied write + post-write frame self-check + pause-writes-first rule.
Anchor: the end of the P2 copy-forward sentence, present once per skill.

Replace 1 (the 25 consulted-class skills, packs 12/13/14, Step 0): the consult
clause now trusts the FILE, not the sentence: the literal preamble is void
unless ~/.claude/crew-state/brand-context.md actually exists.

Idempotent (sentinel-checked), count-asserted. Run from the repo root:
    python3 shared/verify/p7_3_sweep.py
"""
import pathlib, sys

ROOT = pathlib.Path("packs")
if not ROOT.is_dir():
    sys.exit("run from the repo root (packs/ not found)")

SKIP = set()

ANCHOR1 = "a rewrite must never erase a lesson or an open flag."
SENT1 = "STAGED HANDOFF (write denied)"
INS1 = (' If the handoff write is denied or fails, retry once; if it still fails, do not fake '
        'success: print the full handoff body inline in the run receipt under the literal '
        'heading "STAGED HANDOFF (write denied)" so the user can save it, and mark STATUS: '
        'BLOCKED. After a successful write, re-read the file and confirm the frame is present '
        '(the title line, the Date line, and a STATUS from the sanctioned list); fix it before '
        'finishing if not. A Loop 1 or Loop 3 pause counts as finishing for the Context Loop: '
        'write the handoff FIRST (STATUS: BLOCKED, the gap or escalation named), then ask and '
        'wait.')

OLD_CLAUSE = (' Sub-skill consult: if the instruction opens with the literal preamble "CREW CONSULT '
              'from crew-<caller>: brand gate passed, brand-context at '
              '~/.claude/crew-state/brand-context.md", skip this step\'s onboarding stop and the '
              'Final Step context-save prompt (still read the brand context and still write this '
              'skill\'s own handoff); absent that literal preamble, run the full Step 0 including '
              'the brand hard stop, even if the request mentions another skill (per the Crew Method, '
              'Sub-skill consult).')
NEW_CLAUSE = (' Sub-skill consult: if the instruction opens with the literal preamble "CREW CONSULT '
              'from crew-<caller>: brand gate passed, brand-context at '
              '~/.claude/crew-state/brand-context.md", first check that '
              '`~/.claude/crew-state/brand-context.md` actually exists; if the file is absent the '
              'preamble is VOID (a preamble is a claim, the file is the fact) and the full hard '
              'stop runs. With the file present, skip this step\'s onboarding stop and the Final '
              'Step context-save prompt (still read the brand context and still write this '
              'skill\'s own handoff); absent the literal preamble, run the full Step 0 including '
              'the brand hard stop, even if the request mentions another skill (per the Crew '
              'Method, Sub-skill consult).')
SENT2 = "the preamble is VOID"

c1, c2 = [], []
for f in sorted(ROOT.rglob("SKILL.md")):
    skill = f.parent.name
    if skill in SKIP:
        continue
    t = f.read_text()
    orig = t
    if SENT1 not in t and ANCHOR1 in t:
        assert t.count(ANCHOR1) == 1, f"{skill}: multiple copy-forward anchors"
        t = t.replace(ANCHOR1, ANCHOR1 + INS1)
        c1.append(skill)
    if OLD_CLAUSE in t:
        assert t.count(OLD_CLAUSE) == 1, f"{skill}: multiple consult clauses"
        t = t.replace(OLD_CLAUSE, NEW_CLAUSE)
        c2.append(skill)
    if t != orig:
        f.write_text(t)

print(f"insert1 staged-handoff+self-check+pause-first: {len(c1)} files (expect 96)")
print(f"replace1 consult trusts-the-file:              {len(c2)} files (expect 25)")
missing1 = 96 - len(c1)
missing2 = 25 - len(c2)
if missing1 or missing2:
    print(f"MISS: insert1 short by {missing1}, replace1 short by {missing2}")
    sys.exit(1)
