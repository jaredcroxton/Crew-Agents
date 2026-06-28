# Fixture: crew-ops-automation-opportunity-review

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the output, and that the handoff file was written.

## Case A: clean
INPUT:
Process: "Weekly client invoicing", boundaries: Friday billing run to invoice emailed and logged. Goal: cut errors.
Walk-through from the bookkeeper who does the work:
"Every Friday we run about 40 invoices. I pull the order totals out of the CRM and retype them into the invoice sheet by hand, and that is where most of the mistakes come from. Anything over 5k waits for the manager to approve, maybe six a week, usually about a day. Then the finished invoice gets emailed straight to the client. The steps are the same every week, the only odd ones are when a line item is unusual, maybe one in ten."
Volume: about 40 invoices a week, stated. Approval delay: about a day, the bookkeeper's estimate, not timed.

EXPECT:
- Output begins with "AUTOMATION OPPORTUNITY REVIEW" and the header carries the process name, a reviewed date, the goal (cut errors), the trigger and end state, and the process stability (stable and rule-based).
- Every recurring task is typed: the retype is MANUAL-COPY, the over-5k approval is APPROVAL-WAIT, the client email is REPEATED.
- Each candidate has a value score and a risk score, each with a stated basis (the retype is High value because it runs 40x a week and is the source of most rework, and Low risk because a human checks the draft before sending; the client email is High risk because it goes to a customer with no review).
- The MANUAL-COPY is checked for ELIMINATION by a CRM-to-invoice-sheet integration BEFORE it is recommended for a bot (eliminate before automate, because an integration that removes the copy beats a bot that mimics the typing), and the owner is asked whether the CRM exposes the totals via an export or an API.
- The first target is the safe high-value one (the manual-copy retype, semi-automated with a human check before send), NOT the high-risk auto-email-to-customer.
- The ROI is honest: the current-state cost is weighed against the build cost AND a maintenance tail, and the payback is stated as a RANGE with its assumptions (the volume holding near 40 a week, the exception rate near 1 in 10), never a fabricated precise figure.
- The maintenance burden appears in the ROI (the bot breaks if the CRM export format changes) and the ~1-in-10 exception rate is acknowledged as the reason the saving is most of the task, not all of it.
- The feasibility weak-spot is named (Integration is the weak axis, Medium to Low, depending on whether the CRM exposes an API rather than screen-scraping that breaks on UI changes), and the credentials/access the connector would hold are named.
- The recommendation states whether the bot runs attended or unattended (here attended, a person checks the draft each run, not an unattended overnight run), and a current-state baseline to measure before the build (the real per-copy minutes and the weekly rework count) is named so the saving can be proven after, not just projected.
- A build-vs-buy option is given (hybrid, an off-the-shelf connector wired to the existing sheet) WITHOUT naming a product, with the trade-off (subscription, lock-in) noted, and a named owner/maintainer after launch with the adoption risk is carried onto the chosen target.
- The high-risk auto-email is held back with what would lower its risk (a review step before send).
- Nothing is invented: no hours-per-week figure asserted as fact, no precise payback, no tool capability claimed. Assumed fields (the approval delay, the per-copy time) are marked Assumed.
- The handoff file `~/.claude/crew-state/ops/crew-ops-automation-opportunity-review-handoff.md` was written, naming the chosen first target, the ROI range, the feasibility gap, and what crew-ops-recurring-task-automation needs next.
- No em dashes anywhere.

## Case B: messy
INPUT:
Process: "Refunds". The owner says: "We do tons of refunds, just automate the whole thing for me."
What can be gathered: the refund process pays money back out to a customer. There is no clear volume ("tons", never counted). About four in ten refunds hit an edge case that needs judgment (a disputed amount, a partial refund, a goodwill call), so the process is high-exception and not stable. No timing numbers, no per-refund cost.

EXPECT:
- The skill does NOT recommend automating the broken, high-exception refund process as-is.
- It routes the redesign to `crew-ops-workflow-improvement` to eliminate or simplify FIRST (do not pave the cowpath, because automating a high-exception process locks the waste in), and automates only the rule-based slice if any survives the redesign.
- The unknown volume is marked Assumed with the basis ("tons", never counted), and is NEVER invented into an hours-per-week figure or a payback.
- The auto-refund (a payment, money out) is named High risk and is NOT the first target. It carries a human-in-the-loop requirement or an Escalation to the owner, with a compliance and financial-control flag (a refund moves money, so a named human stays accountable).
- The credential and identity attack surface of a money-moving bot is named: an unattended bot that can issue refunds holds standing access to a payment system, runs under a service account, and is a financial-control and fraud surface, so its access and its audit trail are named (not assumed), and broad standing payment access is itself a reason it is not a first target.
- The ~40-percent exception rate is named as the reason the saving is small (a bot automates the happy path and the human still does roughly four in ten refunds by hand), and whether those exceptions are caught (kicked to a human) or silent (processed wrongly) bears on the risk, not just the saving.
- The ROI is not fabricated: with no volume and no per-refund cost, the payback is marked "needs the volume and the per-run time", not asserted.
- STATUS is DONE_WITH_GAPS or BLOCKED, never a clean DONE.
- The handoff file `~/.claude/crew-state/ops/crew-ops-automation-opportunity-review-handoff.md` was written, recording the redesign route to crew-ops-workflow-improvement, the Assumed volume, and the escalated payment automation.
- No em dashes anywhere.

## Case C: missing-input
INPUT:
"What should we automate?" No workflow, no steps, no volume, no goal. Only the question.

EXPECT:
- Loop 1 fires. The skill names the gap plainly (no workflow, no steps, no volume, no goal, so there is nothing to rate) and why it matters (you cannot rate a task you cannot see).
- It asks once, plainly, for a walk-through of the process from trigger to done, and the volume and the goal, not a batch of questions.
- It invents no candidate task, no automation type, no metric, and no saving to fill the review.
- Step 0 still runs (states first run, or recovers prior context).
- STATUS is NEEDS_CONTEXT or BLOCKED, never DONE.
- The handoff file `~/.claude/crew-state/ops/crew-ops-automation-opportunity-review-handoff.md` was still written, recording the missing workflow so the next run knows.
- No em dashes anywhere.
