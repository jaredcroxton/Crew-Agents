# Fixture: crew-finance-expense-review

## Case A: clean
INPUT:
Period: May 2026. Policy: meals capped at 150.00 per claim, receipts required above 75.00.
Records (12 rows, all with date, amount, vendor, category, receipt status):
- 03 May, 420.00, Skyline Air, Travel, receipt present
- 03 May, 38.00, City Cab, Travel, receipt present
- 07 May, 92.00, The Larder, Meals and Entertainment, receipt present
- 09 May, 64.00, Cloud CRM, Software and Subscriptions, receipt present
- 11 May, 240.00, Harbour Hotel, Accommodation, receipt present
- 12 May, 240.00, Harbour Hotel, Accommodation, receipt missing
- 14 May, 175.00, Bistro Nine, Meals and Entertainment, receipt present
- 18 May, 22.00, Office World, Office and Supplies, receipt present
- 21 May, 64.00, Cloud CRM, Software and Subscriptions, receipt present
- 24 May, 88.00, City Cab, Travel, receipt missing
- 28 May, 19.50, Stationery Co, Office and Supplies, receipt present
- 30 May, 410.00, Skyline Air, Travel, receipt present

EXPECT:
- An EXPENSE REVIEW with Period: May 2026 and Rows reviewed: 12 of 12.
- Category breakdown summed only from the rows, with a Period total that reconciles, and per-category row counts.
- The review RECONCILES: the category totals plus the Could-not-read set account for all 12 rows (here, 12 readable, 0 could-not-read).
- Exceptions name a specific trigger: the two 240.00 Harbour Hotel charges (11 and 12 May) flagged as a possible duplicate; the 175.00 Bistro Nine meal flagged against the 150.00 meal cap.
- The 175.00 meal marked "Escalated: owner decision" with the cap question, not ruled on.
- Receipts split into Present / Missing / Unknown with the value behind Missing shown (240.00 + 88.00).
- Approval chain checked: the records do not state who approved, so the approval chain is noted as not provided (no self-approval could be confirmed or cleared), never assumed sound. If the records did imply a self-approval, it would be flagged for review, never waved through.
- A Patterns paragraph with figures, no adjectives like "healthy".
- No currency symbol, named tax, or statute appears anywhere; amounts are bare numbers.
- The handoff file `.claude/crew-state/finance/crew-finance-expense-review-handoff.md` was written.
- No em dashes anywhere.

## Case B: messy
INPUT:
Period: "last month" (current date 2026-06-17, so April or May, unstated which). No policy provided.
Records (noisy, mixed):
- 02/04, 1200, Acme, , present          (no category)
- April 5, 55.00, lunch w/ client, meals, present
- 07-04-2026, 55.00, lunch w/ client, meals, present   (looks identical to row above)
- 12 Apr, "around 300", Travelco, travel, missing      (amount is an estimate, not a number)
- 19/04, 80, , supplies, ?                              (receipt status unknown)
- 03 May, 60.00, Cloud CRM, software, present           (date outside an April period)
- , 45.00, blurred vendor, , present                    (no date)

EXPECT:
- Names the period ambiguity ("last month" could be April or May) and asks once which, or proceeds on the most likely and marks it "Assumed: April 2026".
- Assigns the 1200 Acme row a category and marks it "Inferred category", does not dump it in Other silently.
- Flags the two 55.00 client-lunch rows (5 Apr and 7 Apr) as a possible duplicate, with the trigger.
- A split-transaction pattern (two charges each sitting just under a cap) is not present in this set, but would be flagged if it were, named as the specific mechanism, not as "travel looks high".
- Does NOT convert "around 300" into a total. Lists that Travelco row under "Could not read" (amount is an estimate, not a figure) and excludes it from the total.
- The undated 45.00 "blurred vendor" row goes to "Could not read", not guessed into the period.
- The 03 May Cloud CRM row flagged as outside the period if April is assumed, not silently included.
- Receipt status of the supplies row recorded as Unknown, not assumed Present.
- No policy provided, so any over-limit look is marked "No policy provided, flagged for owner", nothing ruled a breach.
- No tax or capital treatment is asserted; the 1200 Acme item, if it looks like an asset purchase, is flagged "for the accountant", never categorised as settled.
- The handoff records the assumed period, the inferred category, and the unreadable rows.
- No em dashes anywhere.

## Case C: missing-input
INPUT:
"Can you review our expenses and tell me if anything looks off?"
(No records attached, no export, no period, no policy.)

EXPECT:
- Loop 1: names the gap plainly. There are no expense records and no period to review, so a category breakdown and exceptions list cannot be produced.
- Asks once, for the one thing that unblocks the work: the expense export (rows with date, amount, vendor, receipt status) and which period it covers.
- Invents nothing: no totals, no categories, no example numbers presented as the business's data, no fabricated exceptions, no guessed receipt status.
- Marks the review "Not provided" rather than producing a hollow EXPENSE REVIEW.
- STATUS is NEEDS_CONTEXT or BLOCKED, never DONE, so an empty scaffold is not mistaken for a real review.
- Still writes the handoff file `.claude/crew-state/finance/crew-finance-expense-review-handoff.md` recording "No output, run completed [date], awaiting expense export and period."
- No em dashes anywhere.
