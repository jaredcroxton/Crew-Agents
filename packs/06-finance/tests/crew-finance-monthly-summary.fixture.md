# Fixture: crew-finance-monthly-summary

Three cases that exercise the skill against the Crew Method loops. Each EXPECT lists the output markers that must appear and asserts the handoff file at `~/.claude/crew-state/finance/crew-finance-monthly-summary-handoff.md` was written.

## Case A: clean

INPUT:
Business: Harbour Joinery. Month: May 2026. Compare to prior period (April).
Revenue May 94,000, April 84,000. Expenses May 71,000, April 53,000. Cash opening 41,000, closing 18,000. 9 new retainer clients (deals export). 14,000 in invoices over 30 days past due (AR aging sheet). The expense jump includes a 22,000 one-off supplier prepayment. Sources: revenue and expense export, bank balance screenshot, AR aging sheet.

EXPECT:
- Header `MONTHLY SUMMARY` with Business, Month May 2026, and `Compared to: Prior period`.
- Revenue line shows 94,000 with variance against 84,000 stated as both absolute (+10,000) and percent (+12%), tagged Given.
- Expenses line shows 71,000 with +18,000 and +34% versus 53,000, tagged Given.
- Net shown as 23,000 and tagged `[Derived: 94,000 minus 71,000]`.
- Gross profit / margin marked "Not computable, no COGS split provided" because the inputs give only a single 71,000 expense total, with no COGS split invented to force a margin.
- Net (23,000) is kept on a separate line from the cash close (18,000), never read as the cash position.
- Any KPI shown (for example net margin) lists its formula and the two source numbers it came from (net 23,000 divided by revenue 94,000), and no KPI is shown whose components are not in the inputs.
- At least one Win naming the specific mechanism (9 new retainer clients), with the two figures shown.
- A `[Now]` risk on cash falling to 18,000, naming the 22,000 prepayment as a one-off and runway as the trend.
- A `[Soon]` risk on the 14,000 overdue invoices.
- Next actions each have a verb and an owner (for example "owner: finance").
- Sources section lists the named exports.
- Handoff file written, recording the chosen base (prior period) and the prepayment flagged as a one-off.
- No em dashes anywhere.

## Case B: messy

INPUT:
"may report for the cafe. sales were strong, did about 30k maybe a bit more. costs were high, card machine fees and a new fridge. cash is fine i think. last month we did similar. oh the fridge was 4k, wont happen again. revenue actually 31,200 per the till export."
No expense total given, only the fridge cost and a mention of card fees. No opening or closing cash balance. Prior month described only as "similar".

EXPECT:
- Revenue reported as 31,200 (the precise till figure), not 30k, tagged Given, with an "Assumed" or flag note that the till export is the authoritative source over the spoken "30k".
- Total expenses marked "Not provided" (only the 4,000 fridge is a Given line item, card fees have no figure), so Net cannot be Derived and is marked "Not provided", no invented expense total.
- Gross profit / margin marked "Not computable" (no COGS split, and no expense total either), with no invented split.
- No KPI invented from the missing components: any margin, CAC, or per-customer metric whose components are absent is marked "Not provided, needs [the input]", never computed.
- Comparison base handled honestly: "similar" is not a number, so `Compared to: No comparison` or prior period marked "Not provided", no fabricated April figure.
- Cash close marked "Not provided" (no balance given), no estimate.
- The 4,000 fridge classified explicitly as a one-off, separated from recurring card fees.
- No AI-slop: the phrase "sales were strong" is replaced with the actual number, not echoed.
- No currency symbol or code and no named tax is asserted anywhere in the output.
- Handoff file written, recording which figures were Not provided so the next run knows the gaps.
- No em dashes anywhere.

## Case C: missing-input

INPUT:
"Can you do the monthly summary for June?"
No business named, no revenue, no expenses, no cash figures, no comparison base provided.

EXPECT:
- Loop 1 (Missing Input) fires: the skill names exactly what is missing (the period's revenue, expenses, and cash figures, and the business name) and why each matters to the summary.
- Asks once, plainly, for the core figures rather than batching a long survey or guessing.
- Produces no fabricated numbers. No revenue, expense, cash, or percent appears. Any structure shown has every figure field marked "Not provided".
- No KPI and no gross margin asserted without inputs: every metric field is "Not provided, needs [the input]", nothing computed.
- No comparison invented, base marked "Not provided".
- STATUS is NEEDS_CONTEXT or BLOCKED, never DONE, so an empty scaffold is not mistaken for a real report.
- Handoff file still written, recording "No output, run completed [date]" and the list of figures requested, so a follow-up run resumes without re-asking everything.
- No em dashes anywhere.
