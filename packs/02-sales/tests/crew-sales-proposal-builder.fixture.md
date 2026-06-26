# Fixture: crew-sales-proposal-builder

## Case A: clean
INPUT:
Discovery notes: "Harbour Dental, two-chair practice. Owner says they turn away weekend bookings because the front desk cannot keep up with phone volume at peak. New patients who cannot get through book the practice down the road. No after-hours capture. Wants a fixed cost and a fixed end before their new financial year (1 July)."
Offer: website booking-capture widgets and enquiry-form automation for small clinics.
Price posture: business will confirm a fixed Project fee, not yet provided.

EXPECT:
- Output starts "PROPOSAL: Harbour Dental" with Engagement: Project.
- "The problem" paraphrases the client's own words (front desk cannot keep up with phone volume, patients book elsewhere) and names the specific mechanism, not "they want to grow".
- The recommended solution ties to a real capability in the offer (booking-capture widget, enquiry-form automation), not a wish.
- Engagement shape is Project and the reason cites the client's stated constraint (a fixed cost and a fixed end before the new financial year), per the Proposal structure and Decision briefs sections.
- Deliverables are concrete artifacts (booking-capture widget, after-hours enquiry form, handover guide) with an explicit "Out of scope" line drawing the boundary (per Scope definition).
- Timeline uses named stages with relative weeks (Week 1, Weeks 2 to 3), not invented calendar dates, plus what the client provides per stage.
- Assumptions listed (website allows embedding, sign-off speed), each a thing that if false changes the deal (per Risk and assumptions).
- Price line reads "to be set by the business" with the basis noted (fixed Project fee, pending owner approval), no invented figure (per Pricing and packaging).
- A Terms block appears under the price, with validity and payment terms each marked "to be set by the business" (consistent with the unset price), an acceptance mechanism, and the line that this proposal is not a binding contract (per the Terms section and Output format).
- A next-step email with one clear ask, with real urgency only (the client's stated financial-year deadline, not manufactured pressure), per Close design.
- Handoff written to .claude/crew-state/sales/crew-sales-proposal-builder-handoff.md noting scope agreed and price pending.

## Case B: messy
INPUT:
Discovery notes (raw, partial): "called Tuesday... they said something about leads not converting AND also too many leads to handle?? owner wants it 'sorted by spring'. mentioned a budget once, think it was 5k but not sure, might have been 15k. wants a logo too maybe. team is 3 people, or was it 5."
Offer: lead-qualification and follow-up automation.
Price posture: unclear.

EXPECT:
- Flags the contradiction in the problem (leads not converting vs too many leads to handle) rather than picking one silently, marks the unresolved item (per Decision briefs: contradictory or thin notes).
- Headcount written as "Assumed: 3 to 5 staff (notes conflict)", never a single invented number (per Risk and assumptions).
- "Sorted by spring" handled as a vague client timeline, expressed as relative stages, not converted into a fabricated calendar date (per Close design and the Workflow timeline step).
- The budget figure is NOT used as a price. Marks "Price: to be set by the business" because 5k vs 15k is contradictory and unconfirmed (Loop 3 Escalation), names the gap (per Pricing and packaging: a mentioned budget is not a price).
- Logo request flagged as out of scope or "confirm" rather than silently added as a deliverable (per Decision briefs: an out-of-scope extra the client mentioned).
- No invented quote, date, price, or quantity. Thin notes acknowledged, with a request for the one detail that settles the contradiction.

## Case C: missing-input
INPUT:
Offer: monthly social-media management retainer.
Price posture: retainer is $1,200/month, confirmed by the business.
(No discovery notes or call summary provided.)

EXPECT:
- Loop 1 behaviour: names the missing input exactly (no discovery notes, so there is no stated client problem to summarise).
- Asks once, plainly, for the call summary or discovery notes before building the problem statement.
- Does NOT fabricate a client problem, a client name, or quotes to fill the template.
- If it proceeds at all, the client-specific fields are marked "Not provided", and only the confirmed retainer price ($1,200/month, Retainer basis) appears, no invented numbers.
- Handoff written recording that the proposal is blocked on discovery notes, even with no proposal produced ("No output, run completed [date]").
