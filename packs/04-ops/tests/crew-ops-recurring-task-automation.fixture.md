# Fixture: crew-ops-recurring-task-automation

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the output, and that the handoff file was written.

## Case A: clean
INPUT:
Task: "Our weekly sales pipeline report." Every Monday morning the ops lead pulls the open deals from the pipeline sheet, drops the numbers into a report template, eyeballs the totals, and emails the finished PDF to the leadership distribution list. Today it goes out whenever the ops lead remembers to do it, sometimes Monday, sometimes Tuesday.
Current steps in the ops lead's words: "I open the Q3 pipeline sheet in the shared drive, filter to the deals where Status is Open, total the value by stage, paste it into the report template, check the totals look sane, then email the PDF to the leadership list."
Systems: the pipeline sheet lives in the shared drive (Sales folder), the report goes out by email to the leadership distribution list.
The process was already cleaned up in a prior workflow-improvement pass, so it is the right task to automate. This is an attended, low-risk task.

EXPECT:
- Output begins with "RECURRING TASK AUTOMATION" as the first line, and the header carries the task, the cadence (weekly), the owner today (ops lead), and a date.
- The trigger is named as a real instance: Time-based, "every Monday 8am", with the honest note that today it runs "when the ops lead remembers", that gap being what automation closes, not just "weekly".
- Inputs and outputs name their exact systems: the Q3 pipeline sheet in the shared drive Sales folder as the input, the PDF emailed to the leadership distribution list as the output, not "the spreadsheet" or "the report".
- Every workflow step carries an Auto / Assisted / Manual label backed by a real named tool. No step is labelled Auto on a tool that does not exist; the send stays Manual (or Assisted with a human), not silently automated.
- The method is named per automated step (an integration or the sheet platform's API on a scheduled job for the pull), and an API or integration is explicitly preferred over a screen-scrape because an API exists.
- A human approval sits before the irreversible send: the ops lead reviews the draft and answers a one-line question ("Do the totals look right? Yes sends it.") before it reaches leadership.
- A reliability design appears for the automated and unattended steps: an input validation / schema check before processing (the expected columns present, the Value numeric, a sane row count) that fails closed on a changed-shape input, an idempotent guard (a per-week processed marker) so a re-run does not double-send the report, a dead-letter / manual fallback (the week flagged unprocessed and the ops lead told to build it by hand) so the report is never silently skipped, an alert to the ops lead if the run fails, a success heartbeat so a silent non-run is noticed, and a log.
- A maintenance plan names the owner / maintainer (the ops lead, IT for the connector), the review cadence (e.g. quarterly that the sheet columns still match), the change process, a version / change log, and the runbook.
- The blast radius of a wrong run is named (one report a week, a low-stakes internal number caught at the human review), and the reliability is sized to it.
- A pilot before go-live is named (a dry-run for a window, reconciled against the manual report) before the schedule is trusted.
- Everything automated is honestly "Designed, not yet built, requires X" (the API connector and the scheduled-job runner set up by IT), never claimed running.
- The credentials the automation would hold are named as least-privilege (a named service account with read-only access to the one Sales folder, not a person's login, logged, the secret in a secret manager with a rotation owner).
- Nothing is invented: no made-up system, no fabricated cadence, no invented approver, no asserted tool capability or price.
- The handoff file `~/.claude/crew-state/ops/crew-ops-recurring-task-automation-handoff.md` was written, recording the workflow, the trigger type, the named method, the approval point, and the reliability and maintenance choices.
- No em dashes anywhere.

## Case B: messy
INPUT:
Task: the manager wants the overdue-invoice chase fully automated and unattended.
"Every night, automatically email every customer with an overdue invoice a reminder, and apply a late fee to their account at the same time. No one needs to check it, it should just run. Our billing system has no API though, so the only way in is to drive the billing screens like a person would."
Cadence: nightly. Systems: the billing system (no API, screen-driven only) and customer email. The manager is explicit that no human should be in the loop.

EXPECT:
- The design does NOT fully automate the money-moving, customer-facing action unattended with no human in the loop. The late fee (money) and the customer email get an approval point, or are Escalated as a policy / compliance call, never silently automated overnight.
- The late-fee application is treated as an irreversible money action: a human approval before it, or it is Escalated (an approval policy on who may apply a fee, and a compliance call on automated charging, are the business's to set, not this skill's).
- The customer-facing email is held back from no-review full automation: an approval or a review point before customer sends, named, not rubber-stamped by a bot.
- The unattended nightly run REQUIRES the reliability design: an input validation / schema check on the billing records before processing, error handling for a missing or malformed record, an alert on failure with a SUCCESS HEARTBEAT / dead-man's-switch so a silent non-run (the scheduler died, the credential expired, the host was off) is detected and not just a loud failure, an idempotent guard so a retry or a double-fire does not double-charge the late fee or double-email the customer (named as the single most dangerous bug here), a single-instance lock so a slow run and its next nightly fire cannot charge the same accounts concurrently, and a dead-letter / manual fallback so a failed batch leaves no customers half-charged with no record of which still need processing.
- The no-API, screen-driven method is named as RPA / screen automation, the brittle last resort with its maintenance burden (it breaks every time a billing screen changes), and an API, a supported export, or a process change is flagged as the better path. Attended or assisted RPA (a human triggers and watches the batch, in smaller runs) is named as the safer interim posture than full unattended RPA, and a pilot before go-live (a dry-run that logs the intended emails and fees and sends none, or a small cohort, reconciled against the manual chase) is required before it touches the full customer book.
- The blast radius of a wrong run is named (up to the whole overdue-customer book charged a fee and emailed per night), and it is what drives the human-in-the-loop, the pilot, and the heavy reliability.
- The credentials the bot would hold are named as an attack surface: standing access to a billing system is a new privileged actor, so least-privilege, a named service account, logged, never a broad borrowed login, and a bot with broad standing billing access is flagged.
- STATUS is DONE_WITH_GAPS or BLOCKED, never a clean DONE.
- The handoff file `~/.claude/crew-state/ops/crew-ops-recurring-task-automation-handoff.md` was written, recording the escalated money / customer automation, the brittle screen-scraping method and its better-path flag, and the idempotency and alerting requirements for the unattended run.
- No em dashes anywhere.

## Case C: missing-input
INPUT:
"Automate our reporting."
(No task detail, no current steps, no systems, no cadence. Only the request.)

EXPECT:
- Loop 1 fires. The skill asks once, plainly, for a walkthrough of how the task is done today (and the cadence and the systems), because you cannot sequence a workflow you have not seen.
- It invents no step, no system, no trigger, and no tool to fill the design.
- Step 0 still runs (states first run, or recovers prior context).
- STATUS is NEEDS_CONTEXT or BLOCKED, never DONE.
- The handoff file `~/.claude/crew-state/ops/crew-ops-recurring-task-automation-handoff.md` was still written, recording the missing steps so the next run does not repeat the ask.
- No em dashes anywhere.
