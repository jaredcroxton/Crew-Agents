#!/usr/bin/env python3
"""P2 chain sweep: 3 anchored, idempotent inserts across the crew skills.
Insert 1: upstream-read + consumed-record (Step 0 line, end-of-line append)
Insert 2: staleness statement (after the "No prior context, first run." literal)
Insert 3: handoff frame + copy-forward (after the "Always write ..." sentence)
"""
import re, pathlib

ROOT = pathlib.Path("/Users/jc/Desktop/cluade/crew-skill-packs/packs")
SKIP = {"crew-web-app-builder"}  # BLAST exception: no Step 0 / Final Step

INS1 = (' If this run was chained from an upstream skill, also read only the handoffs of the '
        'skills this skill\'s Handoffs section names as sources, at most two files; state what '
        'was inherited, and record "Consumed: [upstream skill] handoff dated [date]" in this '
        'run\'s own handoff. If a named upstream handoff does not exist, proceed without '
        'comment. Never scan the folder outside Governed mode.')
INS2 = (' When a handoff was recovered, state its date; if it is older than the artifacts it '
        'references, treat it as possibly stale and verify against the live files before '
        'relying on it.')
INS3 = (' Open the handoff with the frame: a `# <skill> handoff` title line, a `Date:` line '
        '(ISO, today), and a `STATUS:` line (NOT STARTED / IN PROGRESS / BLOCKED / READY FOR '
        'REVIEW / DONE / DONE_WITH_GAPS / NO OUTPUT); then the required content as its own headed blocks, with '
        'LEARNED and ESCALATED blocks when present. When rewriting an existing handoff, carry '
        'forward every prior Learned note and any unresolved Escalated or Not-provided item; a '
        'rewrite must never erase a lesson or an open flag.')

SENT1, SENT2, SENT3 = 'Consumed: [upstream skill]', 'possibly stale', 'carry forward every prior Learned'
STEP0 = '**Step 0: Context Recovery.**'
FIRSTRUN = 'state "No prior context, first run."'
ALWAYS = re.compile(r'(Always write (?:it|the handoff), even with no output(?: \("No output, run completed \[date\]"\))?\.)')

counts = {1: [], 2: [], 3: []}
misses = {1: [], 2: [], 3: []}

for f in sorted(ROOT.rglob("SKILL.md")):
    skill = f.parent.name
    if skill in SKIP:
        continue
    lines = f.read_text().split("\n")
    changed = False

    for i, line in enumerate(lines):
        # Insert 1 + 2 target the Step 0 line
        if line.startswith(STEP0):
            if SENT2 not in line and FIRSTRUN in line:
                assert line.count(FIRSTRUN) == 1, f"{skill}: multiple first-run literals"
                line = line.replace(FIRSTRUN, FIRSTRUN + INS2, 1)
                counts[2].append(skill)
            if SENT1 not in line:
                line = line + INS1
                counts[1].append(skill)
            lines[i] = line
            changed = True
        # Insert 3 targets the Final Step line
        elif line.startswith('**Final Step: Handoff Save.**') and SENT3 not in line:
            m = ALWAYS.search(line)
            if m:
                line = line[:m.end(1)] + INS3 + line[m.end(1):]
                lines[i] = line
                counts[3].append(skill)
                changed = True
            else:
                misses[3].append(skill)

    # miss detection for 1/2
    text = "\n".join(lines)
    if STEP0 not in text:
        misses[1].append(skill); misses[2].append(skill)
    elif FIRSTRUN not in text:
        misses[2].append(skill)

    if changed:
        f.write_text("\n".join(lines))

print(f"insert1 upstream+consumed: {len(counts[1])} files")
print(f"insert2 staleness:         {len(counts[2])} files")
print(f"insert3 frame+copyforward: {len(counts[3])} files")
print(f"MISS insert1 (no Step 0):  {sorted(set(misses[1]))}")
print(f"MISS insert2 (no firstrun literal): {sorted(set(misses[2]) - set(misses[1]))}")
print(f"MISS insert3 (hand-edit):  {sorted(set(misses[3]))}")
