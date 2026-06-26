# Fixture: crew-ops-operations-dashboard-plan

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the output, and that the handoff file was written.

## Case A: clean
INPUT:
Operation: "Same-day dispatch team", a warehouse pick-and-ship team that has to get the day's orders out by a 4pm carrier cutoff.
Decisions the manager keeps making:
"Each morning the shift lead decides whether to pull in a temp picker, based on how many open orders there are versus how many pickers are on shift. Each week the ops manager reviews whether late dispatches are trending up enough to need a process change. And the head of operations wants a monthly read on whether dispatch is healthy enough to take on a new account."
Data today: the WMS holds the live order queue and a reconciled dispatch log (shipped, by cutoff, timestamps), and the ops team has access. The shift roster lives in a shared spreadsheet someone fills in at shift start. Per-picker pick rates are in the WMS too.
Users and cadence: shift lead looks live through the day, ops manager weekly, head of operations monthly.
A cutoff target has not been agreed yet.

EXPECT:
- Output begins with "OPERATIONS DASHBOARD PLAN" and the header carries the operation, a date, the cadence, and the three audiences (shift lead, ops manager, head of operations).
- A "Decisions this dashboard drives" spine names the actor and the action for all three decisions (pull a temp, review the late-dispatch trend, decide on the new account), not "track dispatch performance".
- Every metric carries a Type from the taxonomy (Outcome / Driver / Health / Diagnostic) AND a leading or lagging tag, and traces to a named decision number.
- "Open orders vs pickers on shift" is classified a Driver (leading), served to decision 1, with a live or shift-start refresh that matches the morning decision.
- "Orders shipped by cutoff (%)" is an Outcome (lagging) AND is paired with a COUNTER-METRIC that catches the gaming (a wrong-order or returns rate, so hitting the cutoff by shipping the wrong thing is caught, not rewarded). The cutoff outcome and the open-orders driver are both present, so the screen is not a rear-view mirror of lagging outcomes only.
- Every metric states its calculation/definition (the numerator, denominator, and inclusion rules), for example the cutoff percent names its denominator (orders with a same-day SLA, not all orders in the WMS), so the percentage cannot lie about what it is a percent of.
- The above-the-fold driver (open orders vs pickers) carries an actionable read: a temp-trigger ratio, or "[temp-trigger ratio to be set by the shift lead and ops manager]" Escalated, not just a bare prior-day comparison, so the metric the dashboard is built around is readable as good or bad.
- Every metric has a named source (WMS.dispatch_log, WMS.order_queue, the roster spreadsheet) OR a "No source yet" flag, with its RELIABILITY noted: the WMS dispatch log is a reconciled system field (strong), the roster is flagged a manual entry that goes stale silently.
- The refresh of each metric matches its decision (live or hourly for the shift lead's driver, weekly trend for the ops manager), no daily glance promised on a source that cannot meet it.
- The unset cutoff target is written "[target to be set by owner]" and ESCALATED to the ops manager, never invented as a 95 percent or any other made-up number.
- The audience views are DIFFERENTIATED from the same source of truth: the shift lead's live operator view (open orders vs pickers, the hourly cutoff) versus the ops manager's weekly cutoff trend with the wrong-order rate beside it versus the head of operations' monthly roll-up and exceptions, same data, different cadence and granularity.
- The individual-level per-picker pick rate is tested DECISION-FIRST: because no listed decision turns on an individual's rate (the shift lead's call is about total capacity), it is CUT from the shared dashboard, not smuggled in via an audience view. A per-person view, if a manager later wants it for coaching, is Escalated as an HR or manager-private matter, never posted per named picker, with a generic privacy and fairness flag (may breach local privacy law), not a specific jurisdiction's act assumed.
- The layout puts the most-frequent-decision metric (open orders vs pickers, the shift lead's morning call) above the fold / top-left, and holds a scannable handful, not a wall.
- An "Owner and review" line names who owns the dashboard and a review-and-retire cadence (e.g. quarterly, any metric whose decision no longer fires is cut), so the screen does not rot into vanity.
- Nothing is invented: no fabricated source, no made-up target, no refresh the source cannot meet.
- The handoff file `.claude/crew-state/ops/crew-ops-operations-dashboard-plan-handoff.md` was written, recording the metrics that made the cut, the wrong-order counter-metric added, the no-source reason-code capture routed on, and the escalated cutoff target.
- No em dashes anywhere.

## Case B: messy
INPUT:
Operation: the same dispatch warehouse, but now the manager's wish list:
"Put total orders processed this year on the dashboard, the big number, it always makes the board feel good. Set us a target on picks per hour, faster is better. And I want a leaderboard of pickers by name so we can see who is slowest. Also add cost-per-order, though I am honestly not sure where that number would even come from."

EXPECT:
- The "total orders processed this year" cumulative number is CUT or flagged as a vanity metric, because no decision uses it: it only ever rises and drives no action. It does not get a place on the screen just because it looks good.
- The picks-per-hour speed target is given a COUNTER-METRIC (a quality or error or rework metric, for example wrong-order rate or returns), because a speed target with no quality guardrail gets gamed (pickers go faster and sloppier). The target is not accepted bare.
- The per-name picker leaderboard is NOT built as posted individual rates. It is tested decision-first and, with no decision turning on an individual's rate, cut from the shared dashboard or at most aggregated to a team average; the per-person view is ESCALATED as an HR or surveillance matter, with a privacy and fairness flag (may breach local privacy law, the regime named only when the jurisdiction is known), not a specific act assumed. Named individual rates are never posted on a wall.
- The cost-per-order metric has no source in the inputs, so it is marked "No source yet" as a data-capture request and routed to `crew-ops-recurring-task-automation`, never invented or pulled from a guessed system.
- STATUS is DONE_WITH_GAPS or BLOCKED, never a clean DONE.
- The handoff file `.claude/crew-state/ops/crew-ops-operations-dashboard-plan-handoff.md` was written, recording the cut vanity metric, the counter-metric added to the speed target, the escalated individual-metric leaderboard, and the no-source cost-per-order capture request.
- No em dashes anywhere.

## Case C: missing-input
INPUT:
"Build us a dashboard."
(No decisions, no operation detail, no data sources, no users or cadence. Only the request.)

EXPECT:
- Loop 1 fires. The skill asks once, plainly, for the decisions the dashboard must drive (the actor and the action), because a metric chosen without a decision is a guess.
- It invents no metric, no source, no target, and no refresh frequency to fill the screen.
- Step 0 still runs (states first run, or recovers prior context).
- STATUS is NEEDS_CONTEXT or BLOCKED, never DONE.
- The handoff file `.claude/crew-state/ops/crew-ops-operations-dashboard-plan-handoff.md` was still written, recording the missing decisions so the next run does not repeat the ask.
- No em dashes anywhere.
