# Fixture: crew-ops-process-map

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the output, and that the handoff file was written.

## Case A: clean
INPUT:
Process: "New customer onboarding", boundaries: signed contract to first login.
Walk-through from the account executive who does the work:
"It starts when the customer e-signs the contract. Sales emails the account details to ops, and that email sits in a shared inbox until ops checks it, usually the next morning, so about a day. Ops then creates the account and waits on IT to provision the license. That takes 2 to 3 days because there is one part-time approver and no backup. Then a welcome email goes out, but honestly ops and sales each assume the other one sends it, so I am not sure who owns it. The customer logs in."
Timing: shared-inbox handoff ~1 day (from the AE, not yet timed); license provisioning 2 to 3 days (from the IT ticket log).

EXPECT:
- Output begins with "PROCESS MAP" and the header carries the process name, a mapped date, boundaries stated as the trigger to the end state, the Output and its Customer (from the SIPOC), a total current-state lead time with the wait-versus-work split, and the end-to-end process owner (or "none named" flagged as a finding).
- The trigger is named to the specific event ("customer e-signs the contract") tagged with its type (System event), not a vague "a request comes in".
- Because the process crosses several owners (sales/AE, ops, IT) and every bottleneck is a cross-owner handoff, the flow is rendered in swimlanes (one lane per owner) with the handoffs crossing lanes, not as a flat linear list.
- Every step is marked Confirmed or Assumed; the welcome-email step, which no one owns clearly, is Assumed.
- The contested welcome-email owner is flagged "Ownership contested", not assigned to ops or sales to tidy the map.
- Every delay carries a duration or "duration unknown" and a specific cause, with the work-time distinguished from the wait-time: the shared-inbox wait (~1 day, sits until ops checks it) and the license wait (2 to 3 days of queue but only minutes of actual work, one part-time approver, no backup).
- Failure points are classified (the no-ticket shared inbox is a Handoff drop; the unconfirmed welcome email is a No check).
- The two bottlenecks are ranked, each with a Basis label: the license wait is Evidence (IT tickets), the shared-inbox handoff is Inference ("things slip", not yet timed). The license-wait cost is expressed as a share of the total lead time (2 to 3 days of a roughly 4 to 5 day total) and the constraint behind it is named (one part-time approver, no backup).
- The improvement for the top bottleneck RELIEVES the constraint by removing the single-approver gate: it adds a backup approver, grants provisioning rights to another role, or eliminates the approval. Merely pre-provisioning the license at signing is NOT accepted as the relieving fix on its own (the same one part-time approver is still the gate); if pre-provisioning (a rearrange) appears, it is paired with added approver capacity, not shipped alone as the fix.
- An eliminate or simplify option appears before any automate option.
- Nothing is invented: no step, no wait time, no owner name, no volume beyond the inputs.
- The handoff file `.claude/crew-state/ops/crew-ops-process-map-handoff.md` was written, naming the two bottlenecks and the open owner gap.
- No em dashes anywhere.

## Case B: messy
INPUT:
Process: "Invoice approval" (boundaries not stated clearly). Only a manager's assumption is offered, no one who does the work was asked.
- Manager's note: "Invoices come in, get approved, and we pay them. The approval bit is always slow, everyone knows it, but I have never timed it. Just automate the slow bit for me."
No doer account, no ticket data, no timing numbers.

EXPECT:
- The map is built from what is given but flagged the OFFICIAL path, with every unconfirmed step marked Assumed, and it is NOT presented as the real current state (it says a doer account is needed to confirm where it actually waits).
- Boundaries were not stated, so it restates an assumed boundary or asks the one boundary question, and does not invent the scope.
- The known-bad approval delay is recorded "duration unknown", never given an invented number of days.
- The manager's "just automate the slow bit" is NOT taken at face value: the skill names the eliminate or simplify option first (do not pave the cowpath, because automating an unmeasured approval locks the waste in), and routes the automation question to crew-ops-automation-opportunity-review.
- The skill does not decide the fix; any fix or target-time call is Escalated to the manager.
- The approval bottleneck, resting only on "everyone knows it", is labelled Inference, not Evidence.
- Nothing is invented: no duration, no step, no owner, no volume.
- STATUS is DONE_WITH_GAPS or BLOCKED, never a clean DONE.
- The handoff file `.claude/crew-state/ops/crew-ops-process-map-handoff.md` was written, recording the assumed steps, the untimed delay, and the escalated fix.
- No em dashes anywhere.

## Case C: missing-input
INPUT:
"Map our sales process." No boundaries, no walk-through, no steps, no timing, no one who does the work has described it. Only the process name.

EXPECT:
- Loop 1 fires. The skill names the gap plainly (no description from anyone who actually does the work, and no boundaries, so the real steps and the delays are unknown) and why it matters (a map from an assumption is the official path with every delay missing).
- It asks once, plainly, for the walk-through from someone who does the work and the boundaries (where it starts, where it ends, what counts as done), not a batch of questions.
- It invents no step, no delay, no owner, and no boundary to fill the map.
- Step 0 still runs (states first run, or recovers prior context).
- STATUS is NEEDS_CONTEXT or BLOCKED, never DONE.
- The handoff file `.claude/crew-state/ops/crew-ops-process-map-handoff.md` was still written, recording the missing doer account so the next run knows.
- No em dashes anywhere.
