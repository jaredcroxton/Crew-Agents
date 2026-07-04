#!/usr/bin/env python3
"""P8 delivery-format sweep: insert the rendered-deliverables guardrail as the
first bullet after ## Guardrails in the document-producing packs (hr, finance,
docs, training) plus crew-web-learning-experience.
Idempotent (sentinel), count-asserted. Run from the repo root."""
import pathlib, sys

ROOT = pathlib.Path("packs")
if not ROOT.is_dir():
    sys.exit("run from the repo root")

TARGET_PACKS = ["05-hr", "06-finance", "08-docs", "09-training"]
EXTRA = [ROOT / "10-web-design" / "crew-web-learning-experience" / "SKILL.md"]

SENTINEL = "never raw markdown"
BULLET = ("- A file handed to the user is rendered, never raw markdown: tabular or programme "
          "content as a formatted spreadsheet, documents as a styled PDF or HTML, held to the "
          "`crew-design-documents` standard (no document ships unseen). Markdown stays internal "
          "(handoffs, drafts, chat artifacts).")

files = [f for p in TARGET_PACKS for f in sorted((ROOT / p).glob("crew-*/SKILL.md"))] + EXTRA
applied, skipped = [], []
for f in files:
    t = f.read_text()
    if SENTINEL in t:
        skipped.append(f.parent.name); continue
    anchor = "## Guardrails\n\n"
    assert t.count(anchor) == 1, f"{f.parent.name}: Guardrails anchor count != 1"
    t = t.replace(anchor, anchor + BULLET + "\n")
    f.write_text(t)
    applied.append(f.parent.name)

print(f"applied: {len(applied)}  skipped(sentinel): {len(skipped)}  total targets: {len(files)}")
expect = 27
if len(applied) + len(skipped) != expect:
    print(f"MISS: expected {expect} targets"); sys.exit(1)
