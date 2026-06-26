# Fixture: crew-docs-meeting-notes-to-actions

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the output, and that the handoff file was written.

## Case A: clean
INPUT:
"Q3 launch planning, 2026-06-17, present Priya, Marcus, Dana. Agreed: ship the new pricing page in July but only if QA passes the checkout flow first. We dropped the free-trial extension for this quarter. Priya to send the revised pricing one-pager to the client by Friday. Marcus owns booking the QA regression slot for the checkout flow. Someone needs to draft the launch email. Open: do we have budget approved for the paid launch ads, or is that still pending finance? Dana flagged the checkout flow is the gating risk for the July date. Marcus mentioned trial conversion sits around 12 percent."
EXPECT:
- Output begins with a fenced block whose first content line is exactly "MEETING NOTES TO ACTIONS", with the Meeting, Date, and Present line filled from the notes (Q3 launch planning, 2026-06-17, Priya / Marcus / Dana).
- Every line is classified into one of the five buckets, and decisions are kept separate from actions (the July ship and the free-trial drop are Decisions, never in the action list).
- The conditional decision keeps its condition: "ship the new pricing page in July, only if QA passes the checkout flow first" is recorded with the IF-QA condition intact, not flattened to "ship in July".
- The dropped free-trial extension is recorded as a decision (an alternative considered and rejected), so the receiver does not silently reopen it.
- The conditional July-ship line is recorded as a Decision, and the QA-regression-slot task it depends on is recorded as an Action, so a line that is both a settled choice and the task it spawns lands in both blocks, neither collapsed into the other.
- Action items each carry a specific task (verb plus deliverable), one Owner, and one Deadline: Priya owns the one-pager with Deadline "Friday (to confirm)", Marcus owns the QA slot with "Deadline to confirm" (no date stated), the launch email is "Owner to confirm" (the notes name no person). No shared ownership, the ownership fork applied.
- The budget line is captured as an Open question, not resolved. The gating-risk line and the 12 percent figure are Key points, the figure tagged "to confirm" not stated as precise fact.
- A Follow-up block names what to revisit (the QA condition before the July date), when, and who.
- Nothing is invented: no owner, decision, or deadline appears that the notes do not support.
- Step 0 states first run or recovered context.
- Handoff written to `.claude/crew-state/docs/crew-docs-meeting-notes-to-actions-handoff.md`.

## Case B: messy
INPUT:
"voice-to-text dump, no attendee list, no date. 'ok so um we should probably do the pricing thing soon. someone needs to send the deck to the client, maybe by next week? big debate about whether to extend the trial, didnt land anywhere. [name garbled] reckons we should just sign the new contract, and we need the budget signed off before we commit to the launch spend. oh and revenue was up like a lot last quarter.'"
EXPECT:
- Output uses the "MEETING NOTES TO ACTIONS" header. Date and Present read "to confirm".
- The unowned deck action is "Owner to confirm", not a guessed name, and the unowned pricing task is also "Owner to confirm".
- The deck deadline is kept as "by next week (to confirm)", NOT converted to a calendar date.
- The trial-extension debate is classified as an Open question, not promoted to a Decision (no resolution landed), even though it reads like a strong opinion.
- The budget sign-off for the launch spend AND the contract-signing line both appear in the Escalations row ("needs sign-off by [finance/role]", Loop 3), never in the Decisions block as settled calls. Both are weighty commitments, escalated, not closed.
- The garbled "[name garbled]" attribution is marked "to confirm", never invented into a real name or a fabricated quote.
- "revenue was up like a lot" appears as a Key point flagged "to confirm", never sharpened into a precise figure.
- No invented owner, decision, or deadline anywhere.
- STATUS is DONE_WITH_GAPS (escalations open, owners and deadlines to confirm), not DONE.
- Handoff written to `.claude/crew-state/docs/crew-docs-meeting-notes-to-actions-handoff.md`, recording the unowned actions, the relative deadline, the open trial question, and the escalated budget and contract commitments.

## Case C: missing-input
INPUT:
"Can you write up my meeting?" with no notes, transcript, or attachment provided.
EXPECT:
- Loop 1 fires: the skill names exactly what is missing (no meeting notes or transcript supplied) and asks once, plainly, for the raw notes, because there is nothing to process without them.
- It does not invent a meeting, a decision, an owner, an action, or a deadline, and does not produce a fabricated summary.
- If it must show structure, it returns an empty MEETING NOTES TO ACTIONS scaffold with every field marked "Not provided" or "to confirm", never filled with invented content.
- STATUS is NEEDS_CONTEXT or BLOCKED, never DONE, so an empty scaffold is not mistaken for a finished summary.
- Handoff written at `.claude/crew-state/docs/crew-docs-meeting-notes-to-actions-handoff.md`, recording that the run was blocked on the missing notes, what was asked for, and "No output, run completed [date]".
