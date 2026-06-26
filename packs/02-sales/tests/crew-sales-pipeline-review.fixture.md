# Fixture: crew-sales-pipeline-review

## Case A: clean
INPUT:
Current date 2026-06-17. Default stage thresholds. 5 open deals with clean data:
- Acme Corp, 40,000, Negotiation, close 2026-06-30, last activity 2026-05-29, next step: none. Note: champion is a VP, no CFO engaged. Proposed 40k is below the discount floor.
- Globex, 15,000, Proposal, close 2026-06-11, last activity 2026-06-02, next step: none. Note: Procurement asked for a revised proposal on the 2nd.
- Initech, 7,000, Discovery, close 2026-07-15, last activity 2026-06-10, next step: none.
- Hooli, 60,000, Negotiation, close 2026-07-01, last activity 2026-06-15, next step: signature call booked 2026-06-19.
- Umbrella, 18,000, Prospecting, close 2026-08-01, last activity 2026-06-16, next step: discovery call booked 2026-06-20.

EXPECT:
- Output begins "PIPELINE REVIEW", dated 2026-06-17, Open deals 5, Total value 140,000.
- A one-line Health summary with open count and value, stuck count and value, overdue count and value, insufficient-data count and value (0), and the single biggest risk by name and value (Acme, 40,000) with its reason.
- A stage-distribution roll-up line: count and value per stage (Negotiation 2 deals 100,000, Proposal 1 deal 15,000, Discovery 1 deal 7,000, Prospecting 1 deal 18,000).
- A coverage line reading "Coverage not assessable, no target provided" because no target or quota was supplied (no invented target).
- Stalled deals listed ranked by exposure (gross deal value at stake, not a weighted forecast): Acme above Globex above Initech.
- Acme: State Stuck (no next step) AND Stuck (stage-age), 19 days in Negotiation vs the 10-day threshold, last activity 2026-05-29, diagnosed cause no decision-maker with the signal (champion is a VP, no CFO engaged, marked Evidence or Inference), and exactly one concrete next action with a person and a timeframe (get the CFO into the room this week).
- Globex: State Overdue, 6 days past close 2026-06-11, last activity 2026-06-02, one next action (send the revised proposal Procurement asked for and reset a realistic close date).
- Initech: State Stuck (no next step), inside its Discovery threshold so no stage-age flag, one next action.
- Hooli and Umbrella tallied Moving (healthy), not flagged. Insufficient data: 0.
- Exactly ONE concrete next action per flagged deal, no "follow up" or "touch base".
- An Escalated line: Acme's 40k is below the floor, a manager must approve the discount.
- No invented values, dates, stages, or probabilities. No committed forecast number.
- Handoff file written at .claude/crew-state/sales/crew-sales-pipeline-review-handoff.md.

## Case B: messy
INPUT:
No current date given. Mixed and contradictory export:
- "Big Deal", value blank, stage "Negotiating" (non-standard name), close 03/12 (ambiguous format), last activity "a while ago", next step blank.
- Wayne Enterprises, 25,000, stage "Proposal", close 2026-05-20, last activity 2026-06-14, next step "send contract".
- Stark Inc, 30000, stage missing, close 2026-07-10, last activity missing, next step missing.
- Rep note in the file: "Wayne is basically closed, do not worry about it."

EXPECT:
- The assumptions stated up front: uses today as the current date and states "Assumed: aging against today, no date provided".
- "Big Deal": value marked "value not provided" and ranked last on any value tie, never invented. Ambiguous close date 03/12 flagged "Assumed" with the read used, or "not provided" if unreadable. Non-standard stage "Negotiating" mapped to the nearest known stage (Negotiation) and marked Assumed, not silently renamed and not invented.
- Stark Inc: marked Insufficient data because stage and last-activity are missing, with the missing fields named, no guessed state.
- Wayne: flagged Overdue (close 2026-05-20 is past) despite the rep's note, the data leads, with the rep's "basically closed" claim recorded, not silently obeyed.
- No fabricated value, stage, date, or probability anywhere. Inferences labelled Evidence or Inference.
- Handoff records the assumptions (aging against today), the stage-name mapping, and the rep note as a Learned note, plus any threshold the user corrected.

## Case C: missing-input
INPUT: "Can you review my pipeline and tell me what is stuck?" No opportunity list, export, or deal data attached.

EXPECT:
- Loop 1 (Missing Input) behaviour: names the gap plainly (no opportunity list, so stuck versus moving cannot be judged).
- Asks once for the one thing needed: the open-deals export with deal name, value, stage, close date, and last activity. Not a batched survey.
- Produces no PIPELINE REVIEW with invented deals. Invents no deal names, values, stages, or dates.
- If pressed to proceed with nothing, returns an empty review marked "Not provided" rather than fabricating a pipeline.
- Handoff file still written at .claude/crew-state/sales/crew-sales-pipeline-review-handoff.md, recording "No output, run completed [date]" and that the opportunity list is the blocking input.

## Case D: continuing, slip and closed-lost candidate
INPUT:
Current date 2026-06-25. Default stage thresholds. A prior handoff exists at .claude/crew-state/sales/crew-sales-pipeline-review-handoff.md recording: Acme close date 2026-05-30, Globex close date 2026-06-11, and a deal "Cyberdyne" 12,000 in Proposal, close 2026-05-01, flagged Overdue last review. This export:
- Acme Corp, 40,000, Negotiation, close 2026-06-30, last activity 2026-06-20, next step: none.
- Globex, 15,000, Proposal, close 2026-06-11, last activity 2026-06-24, next step: proposal call booked 2026-06-27.
- Cyberdyne, 12,000, Proposal, close 2026-05-01, last activity 2026-04-28, next step: none.

EXPECT:
- A one-line trend stated up front because a prior handoff exists (regardless of mode): which deals cleared, which are still stuck and now older, any new stalls, and the net direction.
- Acme flagged "Slipping (close date moved from 2026-05-30 to 2026-06-30, ...)" because its close date moved out from the prior handoff, marked Evidence, and lifted up the ranking.
- Globex not flagged Slipping (its close date 2026-06-11 is unchanged from the prior record), and not Stuck (it now has a booked dated next step).
- Cyberdyne surfaced as a Closed-lost candidate: 55 days past its 2026-05-01 close (more than the 14-day Proposal threshold) and 58 days dormant (no activity since 2026-04-28, past the 30-day window), with the next action "Closed-lost candidate, recommend removing from the active forecast", the signal named (days overdue, days dormant), and marked Inference. The actual close-lost call is left to the rep or manager, not decided.
- No slip is asserted for any deal without a prior recorded close date. No invented target, value, date, stage, or probability.
- Handoff records each deal's current close date for next-time slip comparison.
