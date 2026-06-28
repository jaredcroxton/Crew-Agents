# Fixture: crew-finance-invoice-workflow

## Case A: clean payable
INPUT:
Business: Harbour Coffee Roasters, 6 staff. Direction: payables (how we pay suppliers). Invoices arrive two ways: suppliers email accounts@harbourroasters.com, and a couple still post paper invoices that Priya scans in. Priya (office manager) checks them, the owner approves anything over 1,000 AUD, Priya pays the rest. They use an accounting tool and pay by bank transfer on receipt. Recent examples: green coffee supplier (monthly, around 4,000 AUD), packaging supplier (around 600 AUD), and a one-off equipment repair (350 AUD).
EXPECT:
- Header "INVOICE WORKFLOW" with Business, Mapped date, Direction Payable, and people in the flow.
- Maps the payable arc end to end: receive, check, approve, pay, reconcile.
- Process map names channels by taxonomy term: Shared-inbox (accounts@) and Post-or-paper.
- Checks listed with status across the full taxonomy: Match, Goods-received, Duplicate, Detail, Coding, each Done/Sometimes/Not-done.
- Approval tier rule captured (Single under, owner-approve over) with Threshold 1,000 AUD captured from the input.
- The missing duplicate check surfaced as a [Blocker] (a supplier could be paid twice).
- The supplier bank-detail-change-without-callback risk surfaced as a [Blocker] and flagged as a fraud risk.
- Segregation of duties assessed: Priya checks, pays, and reconciles, owner approves by exception; one-person risk flagged with a compensating control (owner reviews the payment run).
- Improvements ordered risk first, each tied to a named step and a named mechanism.
- A run-it-yourself approval checklist with checkboxes ending in "Recorded in [tool] with approver name and date".
- Handoff file written at ~/.claude/crew-state/finance/crew-finance-invoice-workflow-handoff.md naming crew-finance-admin-automation as next.
- No em dashes anywhere.

## Case B: receivable chaos
INPUT:
"different problem this time. WE send invoices to our customers and getting paid is the chaos. we raise invoices in our accounting tool but honestly whenever someone remembers, sometimes weeks after the job. no one looks at who owes us until they're months behind. customers pay late and we just... dont chase, then suddenly it's a panic. one customer is disputing an invoice and refusing to pay. another only paid half of theirs. and there's an old debt from last year my partner wants to just write off to clean up the books. we're a 4 person trades business, I raise the invoices, I also collect, and I guess I'd be the one writing stuff off too."
EXPECT:
- Direction recognised as Receivable; maps the receivable arc: issue, send, track, follow up, receive, reconcile/allocate.
- Produces an AGING view (current / 1-30 / 31-60 / 61-90 / over 90) so debts stop aging unseen, noting the oldest is over 90 days without inventing an exact band or amount.
- Produces a REMINDER CADENCE (before due, on due, set intervals after), not a single chase at day 90.
- The dispute is handled correctly: pause the chase, log it, route it to the relationship owner, and explicitly NOT written off to tidy the ledger.
- The partial payment is allocated to the invoice with the residual tracked and a note of why it was short.
- The write-off is ESCALATED (a business decision with a tax dimension, the owner and accountant decide), never made by the skill, and never used to hide the open dispute.
- Segregation of duties flagged: one person raises invoices, collects, AND would write off; credit/write-off authority not separated from collection; a compensating control named (partner or owner approves any credit or write-off).
- No customer name, amount, or payment term is invented; "Not provided" where unknown.
- A late fee is mentioned only if the terms allow it, otherwise Escalated to the agreed terms and local law, never invented.
- No currency, tax, or statute assumed in the skill's reasoning (the input's mention of money is mapped without the skill asserting a currency or a tax rate).
- STATUS DONE_WITH_GAPS (write-off and credit authority Escalated, fields "Not provided").
- No em dashes anywhere.

## Case C: missing-input
INPUT:
"Can you build me an invoice approval checklist? We're a small building firm." (No detail on direction, how invoices arrive or are issued, who checks, issues, approves, or collects, the approval amount, or what tools they use.)
EXPECT:
- Loop 1 behaviour: asks the DIRECTION first as part of the question (are we mapping how you pay suppliers, how you get paid, or both), then names the specific gaps (how invoices arrive or are issued, who checks or issues, who approves and at what amount, what tools), and asks once, plainly, rather than guessing.
- Does NOT fabricate a direction, a channel, an approver name, an approval threshold, a supplier, a customer, or a payment method.
- If it proceeds at all, every unknown field reads "Not provided" and the approval tier reads "Threshold: Not provided", with approval authority marked Escalated.
- Any checklist emitted is generic-but-honest, with a clear note that it cannot be made firm-specific until the direction, intake or issue process, approvers, and threshold are supplied.
- STATUS is NEEDS_CONTEXT or BLOCKED, never DONE.
- Handoff file still written, recording the gaps and that input is pending.
- No em dashes anywhere.
