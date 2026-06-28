# Fixture: crew-ops-workflow-improvement

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the output, and that the handoff file was written.

## Case A: clean
INPUT:
Process: "Expense approval", boundaries: employee submits a receipt to the expense is paid. Outcome: a valid expense is paid. Customer: the employee being reimbursed. Goal: cut the cycle time.
Walk-through from the manager who runs it, with timing:
"A claim takes about 9 days from submit to paid, and almost all of it is waiting. The employee emails the receipt to the manager, it sits about a day until the manager reads it. The manager forwards it to the team lead 'for visibility', that sits about two days in the team lead's queue. The team lead approves it, the team lead is part-time so that wait is about three days, which is the longest. Then Finance re-keys the amount into the ledger by hand, about a day's wait, and Finance checks the receipt against policy and pays, another day. The hands-on work across the whole thing is under an hour."
Known: claims under the threshold do not need a second approver per the manager. The finance check is the audit control.

EXPECT:
- Output begins with "WORKFLOW IMPROVEMENT" and the header carries the process name, the outcome, the customer, a date, and the pain.
- The steps are TIMED (work-time and wait-time per step) and summed into a current-state baseline (~9 days, the wait-versus-work split shown), so the reader can see WHERE the 9 days sit.
- A "Dominant wait" is named (the ~3-day part-time team-lead approval queue), and the cut targets that dominant wait, NOT just the easiest step (the "forward for visibility" handoff).
- The redundant "forward for visibility" handoff is tagged Waste: HANDOFF and removed (no rule sits behind it).
- The team-lead approval is NOT tagged Waste: it is Necessary non-value (an approval control in the approval matrix), because a rule sits behind it, so it is kept and changed only by a POLICY escalation, never cut as waste. The finance audit-check is likewise Necessary non-value (the audit control) and KEPT.
- Relieving the team-lead approval (the dominant wait) is treated as a control or policy change and is ESCALATED to the ops manager (the approval matrix is the business's to change), NOT quietly cut. The step stays in place until the policy call is made.
- The re-key step is tagged Waste: DUPLICATION and merged into the finance check (a process-change lever), not automated.
- Every surviving step has exactly one owner (submit: Employee; approve, pending the policy call: Team lead; check and pay: Finance), no dual-owner handoff left standing.
- A current-state baseline (the ~9-day cycle, with the demand rate and a rework-rate baseline captured or marked Not provided) is named, AND the after-measure target is split honestly by the constraint: stage 1 (handoff removed, re-key merged, the ~3-day approval wait still standing) targets ~4 days, and only stage 2 (the approval relieved once the policy is confirmed) reaches under 3 days. The actioned changes alone are NOT claimed to hit under 3, because they do not touch the constraint.
- An implementation plan appears: what changes first (the lowest-risk handoff removal, the control change held until escalation), who is affected (manager, team lead, Finance), a pilot (one team for a short window) before a wide rollout, and a rollback. The plan documents the lean flow as standard work, names a sign-off (the ops manager as process owner) for pilot and rollout distinct from the escalated policy answer, and the after-measure tracks the rework rate against its baseline, not only cycle time.
- Nothing is invented: no fabricated time saving asserted as fact, the cycle-time claim is checked against the baseline in the pilot, not asserted.
- The handoff file `~/.claude/crew-state/ops/crew-ops-workflow-improvement-handoff.md` was written, naming the steps cut and the lever for each, the escalated policy change, the baseline and the target, and that the lean flow is the input to crew-ops-automation-opportunity-review.
- No em dashes anywhere.

## Case B: messy
INPUT:
Process: "Purchase-order approvals". The manager says: "Approvals are way too slow, just cut some steps, or honestly just automate the whole thing."
What can be gathered: the timing shows the approvals are not slow because of an extra step. There is a single approver who is overloaded and is the only person who can sign off, so everything queues behind one person (a capacity and policy issue). The two junior staff who prepare the POs do it slowly and make errors because no one ever trained them on the PO system. There is also a finance control check in the flow that must stay. Per-step timing is mostly not recorded, only "the queue behind the approver is the worst part".

EXPECT:
- The skill does NOT delete a process step when the cause is a rule, a capacity limit, or a capability gap. It matches the lever to the cause.
- For the single overloaded approver, it names the cause as a capacity or policy issue (one approver, the only person who can sign off) and the lever as a ROLE or POLICY change (add a backup approver or raise the approval threshold), and the policy or approval-matrix change is ESCALATED to the business, not a quietly deleted step.
- The single overloaded approver is named as the dominant constraint (the binding bottleneck), and the fix that actually relieves total throughput is the capacity or policy change to that approver. Training the juniors improves quality but does NOT, on its own, relieve the queue, so it is not presented as the throughput fix (a non-constraint fix does not move the total).
- For the untrained junior staff, it names the cause as capability (the staff were never shown the PO system) and routes it to `crew-training-needs-analyser` for training, NOT a process redesign of a step that is otherwise fine.
- It does NOT automate the waste: it routes the lean flow to `crew-ops-automation-opportunity-review` only AFTER the process is improved (the approver relieved, the staff trained), and never automates a broken or untrained step (no paving the cowpath).
- An unknown per-step time is written "Not provided" and the improvement is flagged unmeasurable until the steps are timed, never an invented saving or cycle time.
- The finance control check in the flow is NOT cut; any change to it is Escalated.
- STATUS is DONE_WITH_GAPS or BLOCKED, never a clean DONE.
- The handoff file `~/.claude/crew-state/ops/crew-ops-workflow-improvement-handoff.md` was written, recording the escalated policy or capacity change, the training routed to crew-training-needs-analyser, and the unmeasured baseline.
- No em dashes anywhere.

## Case C: missing-input
INPUT:
"Make our onboarding less painful." No steps, no timing, no outcome, no customer. Only the complaint.

EXPECT:
- Loop 1 fires. The skill asks once, plainly, for a walk-through of how the work actually happens today (not how the manual says it should), and the outcome and the customer, because you cannot remove a step you cannot see.
- It invents no step, no cycle time, no owner, and no waste type to fill the redesign.
- Step 0 still runs (states first run, or recovers prior context).
- STATUS is NEEDS_CONTEXT or BLOCKED, never DONE.
- The handoff file `~/.claude/crew-state/ops/crew-ops-workflow-improvement-handoff.md` was still written, recording the missing as-is process so the next run knows.
- No em dashes anywhere.
