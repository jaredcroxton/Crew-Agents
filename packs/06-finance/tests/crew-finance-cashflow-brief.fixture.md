# Fixture: crew-finance-cashflow-brief

Three cases that exercise the skill: a clean run, a messy run, and a missing-input run. Each EXPECT lists the output markers that must appear and confirms the handoff file at `.claude/crew-state/finance/crew-finance-cashflow-brief-handoff.md` was written.

## Case A: clean

INPUT:
Decision: can we buy the new oven this month. Window: 8 weeks. As of 2026-06-17. Opening balance 14,200.
Money in: 2026-06-22, 9,800, client invoice INV-204 (invoiced, not yet paid); 2026-07-05, 6,400, retainer (contracted).
Money out: 2026-06-15, 7,500, payroll; 2026-06-18, 11,000, oven purchase; 2026-06-20, 2,100, card processing and supplies (estimate).

EXPECT:
- Header CASHFLOW BRIEF with Decision, Window, As of 2026-06-17, Opening balance 14,200.
- Each inflow tagged Confirmed / Expected / Speculative (INV-204 tagged Expected, retainer Confirmed).
- Each outflow tagged Fixed / Variable(est) / Discretionary / One-off (payroll Fixed, oven One-off, card Variable(est)).
- Position block with a Lowest forward balance, its date, a Closing balance, Headroom, and a Verdict of Holds, Tightens, or Breaks.
- The running balance is walked date by date and the LOW POINT is the lowest point of the walk (with the oven landing on the 18th before the 9,800 receivable clears on the 22nd, the balance runs negative mid-window, so the verdict is Breaks, not a soft Tightens, and the closing balance is shown not to rescue the mid-window low point).
- A "Holds only if" line naming the 9,800 Expected inflow as the dependency, and noting the oven timing sinks the account before it clears.
- A Runway line appears: because the window is a net drain (net -4,400 across the lines), it states the cash is burning and when the balance goes negative, rather than "not burning, inflows cover the window".
- A Downside line states the position if INV-204 (the 9,800 Expected) slips, so the worst case on the given lines is visible (the account stays negative longer until the retainer).
- Headroom is read sensibly: against a buffer if one were given, else zero with a flag (here no buffer, so flagged against zero, and the low point is below zero).
- A Timing issue naming the specific mechanism (oven and payroll landing before the receivable clears), not "cash gets tight".
- Risks ranked, each marked Evidence or Inference.
- Questions to ask next, each tied to a named line (for example INV-204 timing), recommending no spend decision.
- "Escalated: whether to buy the oven now, owner decision."
- Running balance arithmetic foots from opening through net to closing (opening 14,200, minus payroll, minus oven, minus card, plus 9,800, plus retainer, reconciles to the stated closing balance), and the stated low point is the actual lowest point of that walk.
- The cash-basis point is honoured: the closing balance is not used to declare the position fine while the mid-window low point is negative.
- No currency symbol or code, and no named tax or rate, anywhere.
- Handoff file written with the position verdict, the runway, and what the next finance skill needs.
- No em dashes anywhere.

## Case B: messy

INPUT:
"Cash position pls. We got about 14k in the bank I think. Big client owes us 9,800 but they always pay late, sometimes never. Maybe a new deal worth 20k coming, fingers crossed. Payroll is 7,500, runs the 15th. Rent. Oven we want is 11k-ish. Card fees whatever they are. Need to know if we can spend on the oven this week."

EXPECT:
- Opening balance shown as "Assumed: 14,000 (owner said about 14k, not confirmed)" and flagged, not stated as exact.
- The 9,800 receivable tagged Expected (or downgraded toward Speculative given "pay late, sometimes never") with the late-payment risk surfaced, never tagged Confirmed.
- The 20k "maybe" deal tagged Speculative and excluded from the holding position, not counted as income.
- Rent listed but amount marked "Not provided" rather than invented.
- Oven amount handled as approximate (around 11,000) and labelled an estimate, not a precise invented figure.
- Card fees marked "Not provided" or estimated and clearly labelled an estimate, never a made-up exact number.
- No as-of date given, so the skill states the assumed as-of date or asks once for it.
- Verdict states the position only holds if the Expected receivable lands, and a Downside line states explicitly that if the 9,800 slips (the known late-payer), the position Breaks.
- The runway or the cash-basis point is reflected: the read makes clear this is cash when it moves, not the invoiced 9,800 treated as money in hand, and where the window is a net drain the burn is named.
- No currency symbol or code, and no named tax or rate, is asserted anywhere (amounts are bare numbers, no tax treatment is stated).
- No fabricated inflow, outflow, or balance anywhere. Speculative kept out of the verdict.
- Handoff file written, recording the assumptions made and the lines marked Not provided.
- No em dashes anywhere.

## Case C: missing-input

INPUT:
"Can we afford to hire someone in July? Here is money going out: payroll 7,500 on the 15th, rent 2,400 on the 1st, loan repayment 1,200 on the 5th, the new hire would be about 4,000 a month. I do not have the opening balance or what is coming in to hand right now."

EXPECT:
- Loop 1 fires: names the gap plainly (no opening balance and no money-in lines, so no cash position can be stated).
- Asks once for the one thing that unblocks the position (opening balance and as-of date), not a batch survey.
- Invents no inflow and no opening balance. Position marked "Not provided, no opening balance".
- Produces the partial value it can: a timing view of the outflows in date order (rent the 1st, loan the 5th, payroll the 15th, new hire ongoing) so the work is not blank.
- No runway and no verdict (no Holds, Tightens, or Breaks) is asserted, because there is no balance to test against.
- Nothing is invented to fill the gap: no opening balance, no inflow, no closing figure, no downside is fabricated.
- Marks the affordability question "Escalated: owner decision, needs opening balance and expected receipts before a position can be stated".
- No currency symbol or code, and no named tax or rate, anywhere.
- STATUS is NEEDS_CONTEXT or BLOCKED, never DONE, because no position could be stated (a timing-only view may still be produced).
- Handoff file written, recording the missing opening balance and money-in lines so the next run starts from the gap.
- No em dashes anywhere.
