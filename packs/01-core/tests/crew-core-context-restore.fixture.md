# Fixture: crew-core-context-restore

## Case A: clean
INPUT:
Restore work for pack `sales`, skill `crew-sales-lead-research`. The handoff file
`.claude/crew-state/sales/crew-sales-lead-research-handoff.md` exists, saved 2026-06-10, and reads:
"Output: lead research brief for Northwind Logistics. Decisions: angle locked on the unfilled
ops-manager role. Unfinished: COO email not found, outreach not yet drafted. Next skill needs:
crew-sales-outreach-draft to write first touch. Status: In progress." The working directory still
matches the note (no files changed since the save date).

EXPECT:
- Output begins `CONTEXT RESTORE` with the resolved `Restored from:` handoff path and both Saved and Restored dates.
- `Previous status: In progress` and the saved status line quoted, not paraphrased.
- The saved status (In progress) maps to the In-progress band per the save-enum-to-band round-trip mapping, classified explicitly, not assumed.
- Last decisions lists the locked ops-manager angle as already decided (do not relitigate).
- Remaining work names the specific action (confirm COO email) tied to the "not found" field.
- `Drift check: No drift detected against saved note.`
- A single Current position line and two or three ordered Next actions, offered not started, one pointing to `crew-sales-outreach-draft`.
- The handoff file `.claude/crew-state/core/crew-core-context-restore-handoff.md` was written.
- No em dashes anywhere.

## Case B: messy
INPUT:
Restore the sales lead research work. The saved note (2026-06-10) says "outreach not yet drafted,"
but the directory now contains `northwind-outreach.md` modified 2026-06-12, two days after the save.
The note also references `northwind-brief.md`, which is still present and unchanged. The user gives only
the topic ("the Northwind stuff"), not the exact pack or skill path.

EXPECT:
- Maps the topic to the most recent matching handoff and states which file it chose before reading further.
- Reports `Previous status: In progress` from the note, then flags drift typed as `Work advanced` with evidence (northwind-outreach.md, modified 2026-06-12) and the unchanged brief noted under no-drift.
- Marks the saved "not yet drafted" status as stale rather than reporting it as current.
- The present environment wins for the file fact (the draft exists on disk) while the note still holds for the locked decision (the intent, the ops-manager angle), per the merge precedence.
- Current position reconciles note and drift into one honest line ("a draft exists beyond the saved note, review it first").
- Next actions start with reviewing the existing draft, not redrafting from scratch. Nothing in the draft is invented or summarised before it is read.
- No em dashes anywhere.

## Case C: missing-input
INPUT:
"Restore where I left off." No pack id, no skill name, and no obvious single recent handoff (several
`*-handoff.md` files exist under `.claude/crew-state/` across different packs).

EXPECT:
- Loop 1 behaviour: names the gap (no pack or skill named, multiple candidate handoffs exist).
- Lists the visible `*-handoff.md` files with their modified dates and asks once, plainly, which work to restore.
- Invents no previous status, decision, date, or remaining work. Does not pick a target silently or guess a history.
- If still unresolved, marks the target "Not provided" and stops rather than restoring the wrong context.
- STATUS is NEEDS_CONTEXT or BLOCKED, never DONE, and nothing is read-modified (the skill stays read-only).
- No em dashes anywhere.
