#!/usr/bin/env python3
"""P7.3 diff-shape checker: every changed line in packs/ must be its original
plus the approved Final Step insert, or the approved consult-clause replacement.
Run from the repo root against the uncommitted diff."""
import subprocess, sys, importlib.util

spec = importlib.util.spec_from_file_location("sweep", "shared/verify/p7_3_sweep.py")
sweep = importlib.util.module_from_spec(spec)
try:
    spec.loader.exec_module(sweep)  # module-level code exits early if counts differ post-hoc
except SystemExit:
    pass

INS1, OLD, NEW = sweep.INS1, sweep.OLD_CLAUSE, sweep.NEW_CLAUSE

out = subprocess.run(['git', 'diff', '-U0', '--', 'packs'], capture_output=True, text=True).stdout
minus, plus = [], []
cur = None
for ln in out.split('\n'):
    if ln.startswith('--- a/'):
        cur = ln[6:]
    elif ln.startswith('-') and not ln.startswith('---'):
        minus.append((cur, ln[1:]))
    elif ln.startswith('+') and not ln.startswith('+++'):
        plus.append((cur, ln[1:]))

bad = 0
if len(minus) != len(plus):
    print(f"FAIL unpaired ({len(minus)} vs {len(plus)})"); bad += 1
for (mf, m), (pf, p) in zip(minus, plus):
    candidate = p.replace(INS1, '')
    if candidate == m and mf == pf:
        continue
    candidate = p.replace(NEW, OLD)
    if candidate == m and mf == pf:
        continue
    # a line may carry both changes (consult clause + insert share no line, but be safe)
    candidate = p.replace(INS1, '').replace(NEW, OLD)
    if candidate == m and mf == pf:
        continue
    print(f"FAIL non-template change in {pf}:\n  - {m[:120]}\n  + {p[:120]}")
    bad += 1
print(f"paired line-changes: {len(plus)}  non-template: {bad}")
sys.exit(1 if bad else 0)
