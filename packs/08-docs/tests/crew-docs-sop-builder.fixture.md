# Fixture: crew-docs-sop-builder

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the output, and that the handoff file was written.

## Case A: clean
INPUT:
- Process: client onboarding. Trigger: a signed contract is received. Done when the first invoice is sent.
- Steps in order: log the signed contract in the CRM within 4 hours; Finance Analyst runs a credit check in the credit portal by next business day (pass continues, fail goes to the Finance Manager and onboarding holds); Onboarding Coordinator creates the portal account same day; Account Manager approves the portal config and pricing before go-live (within 1 business day); Account Manager sends the welcome email and login details by email within 24 hours of approval.
- Roles: Onboarding Coordinator, Finance Analyst, Account Manager, Finance Manager.
- Document owner: Onboarding Coordinator. Reviewed annually.

EXPECT:
- Output begins with a fenced block whose first content line is exactly "SOP DOCUMENT".
- The metadata line below the header carries SOP name, Trigger, Goal, and Owner of process, plus a Version, Owner of document, Effective date, and Next review line. Because the input gave a cadence ("reviewed annually") and not a past review event, no concrete past review date is fabricated; the cadence renders as the Next review (for example 2027 annual).
- Numbered, ordered steps, each with exactly one accountable "Owner:" and a "Type:" tagged Action, Decision, Handoff, Wait, or Approval.
- All five step types are represented in the taxonomy used (Action, Decision, Handoff, Wait, Approval appear as tag options), and the credit check is tagged a Decision with both named "pass" and "fail" branches, each routed to a real destination; the "fail" branch routes to its own numbered, owned step (a Wait owned by the Finance Manager with a maximum hold), not an inline un-owned escalation.
- Where the input names a role beyond a step's accountable owner (the Finance Manager consulted on a borderline credit score, the Onboarding Coordinator informed of the result), it is rendered on the step's RACI line, not dropped.
- The Account Manager approval appears as an Approval step naming the approver, what exactly is approved (portal config and pricing), and a rejection path routed to a numbered step with a maximum hold before escalation.
- Timing is concrete (for example "within 24 hours of approval", "within 4 hours of receipt"), never "promptly", and the named system is concrete (CRM, credit portal, client portal, email), never "the system".
- An "Approval checkpoints:" line and an "Exceptions:" block are present, the Exceptions block naming the credit-fail destination (its own held step owned by the Finance Manager, with a max hold then escalation) and the approval-rejection destination (a numbered step, held with a max hold).
- Document owner, version (for example v1.0), an effective date, and a next review (for example 2027 annual) are captured, not left blank.
- Nothing is invented: no role, deadline, threshold, or system appears that the input did not state.
- Handoff file `.claude/crew-state/docs/crew-docs-sop-builder-handoff.md` was written, naming the granularity chosen and what crew-docs-training-guide-creator needs next.

## Case B: messy
INPUT:
"We get a contract, someone logs it, then finance checks the credit, then the coordinator sets the client up in the portal and emails them. Somewhere in there a manager has to OK it but I am not sure when, and there is no set rule for what fails the credit check. This is a financial onboarding so there are probably some compliance controls but I do not know which ones. Do it fast." Roles mentioned: a coordinator, finance, a manager. No exact timings given except "fast".

EXPECT:
- Confirmed steps are documented as discrete one-action steps with the real verb (log the contract, check the credit, create the portal account, email the client), and where the flow runs out the break is marked "Process undocumented from here" rather than invented to completion.
- The uncertain approval ("not sure when") is surfaced as its own Approval step and marked Escalated, not assigned to a guessed point, and the missing fail threshold ("no set rule for what fails the credit check") is marked Escalated, never set by the skill.
- The financial-compliance control question ("probably some compliance controls but I do not know which ones") is flagged and routed to crew-docs-compliance-review-check, with no invented regulatory reference, control number, or safety step.
- "Do it fast" does not become a deadline: steps with no stated timing have a blank Timing field, not a fabricated "within X hours".
- Any owner never named is written "Owner: not provided" rather than guessed, and no system name is invented (no "CRM" unless the input gave one).
- Handoff file `.claude/crew-state/docs/crew-docs-sop-builder-handoff.md` was written, noting the unconfirmed approval point, the unset threshold, and the routed compliance question as unfinished work.

## Case C: missing-input
INPUT:
"Write me an SOP for client onboarding." (No steps described, no roles, no timing, no approval points given.)

EXPECT:
- Loop 1 fires: the skill asks once, plainly, for the process steps and who does them, because an SOP cannot be written from a title alone.
- It asks once, not a batched survey, and does not fabricate a generic onboarding process, invent role titles, or invent step timings to fill the page.
- If it proceeds at all, it produces only the spine it can confirm (the process name) and marks the body "Process undocumented from here", inventing nothing.
- Every field it cannot fill is marked "not provided" or "Not set", and no version history or past review date is fabricated.
- Handoff file `.claude/crew-state/docs/crew-docs-sop-builder-handoff.md` was written, recording the missing process description as the blocker the next run needs.
