#!/usr/bin/env python3
"""P2 diff-shape checker: every changed line in packs/ must be its original
plus one or more of the three approved insertion templates. Anything else fails."""
import subprocess, sys

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

out = subprocess.run(['git', 'diff', '-U0', '--', 'packs'],
                     capture_output=True, text=True,
                     cwd='/Users/jc/Desktop/cluade/crew-skill-packs').stdout
minus, plus, files = [], [], set()
cur = None
for ln in out.split('\n'):
    if ln.startswith('--- a/'):
        cur = ln[6:]
    elif ln.startswith('-') and not ln.startswith('---'):
        minus.append((cur, ln[1:]))
    elif ln.startswith('+') and not ln.startswith('+++'):
        plus.append((cur, ln[1:]))
        files.add(cur)

bad = 0
if len(minus) != len(plus):
    print(f"FAIL: unpaired hunks ({len(minus)} deletions vs {len(plus)} additions)")
    bad += 1
for (mf, m), (pf, p) in zip(minus, plus):
    stripped = p.replace(INS1, '').replace(INS2, '').replace(INS3, '')
    if stripped != m or mf != pf:
        print(f"FAIL non-template change in {pf}:")
        print(f"  - {m[:140]}")
        print(f"  + {p[:140]}")
        bad += 1
print(f"changed files: {len(files)}  paired line-changes: {len(plus)}  non-template: {bad}")
sys.exit(1 if bad else 0)
