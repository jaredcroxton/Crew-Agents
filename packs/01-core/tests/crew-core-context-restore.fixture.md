# Fixture: crew-core-context-restore

## Case A: clean
INPUT:
Restore project `smoketest`, skill `crew-sales-lead-research`. The record
`~/.claude/crew-state/projects/smoketest/crew-sales-lead-research-handoff.md` exists, saved 2026-06-10, and reads:
"Output: lead research brief for Northwind Logistics. Decisions: angle locked on the unfilled
ops-manager role. Unfinished: COO email not found, outreach not yet drafted. Next skill needs:
crew-sales-outreach-draft to write first touch. Status: In progress." The working directory still
matches the record (no files changed since the save date).

EXPECT:
- Output begins `CONTEXT RESTORE` with the resolved `Restored from:` record path and both Saved and Restored dates.
- `Previous status: In progress` and the saved status line quoted, not paraphrased.
- The saved status (In progress) maps to the In-progress band per the save-enum-to-band round-trip mapping, classified explicitly, not assumed.
- Last decisions lists the locked ops-manager angle as already decided (do not relitigate).
- Remaining work names the specific action (confirm COO email) tied to the "not found" field.
- `Drift check: No drift detected against saved record.`
- A single Current position line and two or three ordered Next actions, offered not started, one pointing to `crew-sales-outreach-draft`.
- The record `~/.claude/crew-state/projects/smoketest/crew-core-context-restore-handoff.md` was written.
- No em dashes anywhere.

## Case B: messy
INPUT:
Restore the sales lead research work. The saved record (2026-06-10) says "outreach not yet drafted,"
but the directory now contains `northwind-outreach.md` modified 2026-06-12, two days after the save.
The record also references `northwind-brief.md`, which is still present and unchanged. The user gives only
the topic ("the Northwind stuff"), not the exact project or skill name.

EXPECT:
- Maps the topic to the most recent matching project and states which project and record it chose before reading further.
- Reports `Previous status: In progress` from the record, then flags drift typed as `Work advanced` with evidence (northwind-outreach.md, modified 2026-06-12) and the unchanged brief noted under no-drift.
- Marks the saved "not yet drafted" status as stale rather than reporting it as current.
- The present environment wins for the file fact (the draft exists on disk) while the record still holds for the locked decision (the intent, the ops-manager angle), per the merge precedence.
- Current position reconciles record and drift into one honest line ("a draft exists beyond the saved record, review it first").
- Next actions start with reviewing the existing draft, not redrafting from scratch. Nothing in the draft is invented or summarised before it is read.
- No em dashes anywhere.

## Case C: missing-input
INPUT:
"Restore where I left off." No project name, no skill name, and no obvious single recent project (several
project folders exist under `~/.claude/crew-state/projects/` with records of different dates).

EXPECT:
- Loop 1 behaviour: names the gap (no project or skill named, multiple candidate projects exist).
- Lists the saved projects with their most-recent record dates, newest first, and asks once, plainly, which project to restore.
- Invents no previous status, decision, date, or remaining work. Does not pick a target silently or guess a history.
- If still unresolved, marks the target "Not provided" and stops rather than restoring the wrong context.
- STATUS is NEEDS_CONTEXT or BLOCKED, never DONE, and nothing outside the sanctioned writes is touched (the work stays read-only).
- No em dashes anywhere.
