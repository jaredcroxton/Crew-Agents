# shared/verify: the sweep and proof scripts

Policy: any script used to justify a mass edit across the packs is committed
here IN THE SAME COMMIT as the edit it performed, with its insertion templates
matching the shipped text. A sweep whose checker lives in /tmp evaporates on
reboot and its proofs cannot be re-run; that has happened once and never again.

Contents:
- p2_sweep.py / p2_diffcheck.py: the context-chain sweep (handoff frame,
  copy-forward, upstream read, consumed record, staleness) and its diff-shape
  proof. Templates carry the current STATUS enum.
- p4_consult_sweep.py: the consult-honor clause sweep for packs 12-14. Clause
  updated to the current trusts-the-file version.
- p7_3_sweep.py / p7_3_diffcheck.py: the runtime-fallback sweep (staged
  handoff, post-write self-check, pause-writes-first; consult file check) and
  its proof.

All sweeps are idempotent (sentinel-checked) and count-asserted: run them twice
and the second run changes nothing. Run from the repo root.
