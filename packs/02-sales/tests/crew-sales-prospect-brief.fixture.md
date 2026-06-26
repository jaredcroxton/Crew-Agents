# Fixture: crew-sales-prospect-brief

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the output, and that the handoff file was written.

## Case A: clean
INPUT:
Lead information (from a crew-sales-lead-research brief): Dana Vogel, COO at Northwind Logistics,
a regional cold-chain 3PL serving food and beverage clients, around 50 to 200 staff. Careers page
lists four open ops roles and no ops manager (source: northwind.com/careers, live 2026-06-17).
Dana is measured on on-time delivery and margin.
Offer: fractional ops support (an ops lead embedded from week one).
Call context: cold outbound.
EXPECT:
- Output begins with "PROSPECT BRIEF".
- Header fields present: Person (Dana Vogel, COO), Company (Northwind Logistics), Context (cold outbound),
  For offer (fractional ops support), and a Prepped date.
- "Who they are" classifies Dana by buyer type (Economic buyer), labels the type an Inference from title,
  and states "Measured on: on-time delivery and margin" (the lever).
- "Why they care" ties the four open ops roles and missing ops manager to on-time delivery, tagged
  Basis: Evidence: northwind.com/careers (the specific mechanism, not "they want efficiency").
- Opener is one spoken line in the rep's voice with a Strength line (Strong), specific to Northwind.
- Two or three objections, each tagged with a taxonomy type (Price, Timing, Status quo, Trust, Authority,
  or Fit), each with a one-line response; any unbacked response carries a "Needs: [proof]" tag.
- One next step, a single concrete ask phrased in the rep's voice, not multiple options.
- Handoff file written at .claude/crew-state/sales/crew-sales-prospect-brief-handoff.md naming the chosen
  opener, objection picks, next step, and what crew-sales-outreach-draft needs.

## Case B: messy
INPUT:
Raw expo notes, partial and contradictory: "Met someone from Harbor Freight Co at the expo, think his name
was Marcus, maybe ops or maybe finance, not sure. Company does warehousing? Or freight forwarding.
One slide said 200 staff, the booth guy said 'about 40 of us'. Wants to cut costs, also said budget is
locked till next FY. We sell route optimisation software."
No call context given.
EXPECT:
- Inputs restated with the conflicts flagged, not silently resolved. Size shown as a band with the
  conflict noted ("40 to 200 staff, slide and booth disagree") rather than a single invented number.
- Buyer type marked uncertain because the role is unknown ("Buyer type: uncertain, ops or finance, confirm on call"),
  not guessed as fact.
- Name shown as "Marcus (unconfirmed)" since it is uncertain, never hardened into a quote.
- "Why they care" works the one usable signal (cost-cutting against route optimisation) and labels it
  Inference, since the basis is a vague note, not Evidence.
- A Timing objection surfaced from "budget locked till next FY", tagged Timing, with a response that does
  not invent a discount or a price.
- Missing call context marked "Not provided" rather than fabricated.
- No fabricated metric, no invented reference, no opener presented as Strong when it rests on guesses.
- Handoff records the unconfirmed name, the role gap, and the size conflict as unfinished work for the next run.

## Case C: missing-input
INPUT:
"Prep me for my call with COO Priya Nair at Meridian Foods this afternoon. Here is the research brief: Meridian is
a mid-size food manufacturer, Priya is measured on plant uptime, they run three aging packing lines."
No offer provided (the rep did not say what they sell).
EXPECT:
- Loop 1 behaviour: the skill names the gap precisely ("the offer is missing, and the opener plus why-they-care
  are meaningless without knowing what you sell") and asks once for that one thing.
- It does not invent an offer, an opener, or a reason Priya would care. It does not fabricate a product or a price.
- "Who they are" is still filled from the brief (Priya Nair, COO, Economic buyer, measured on plant uptime),
  so that part is produced.
- The offer-dependent fields (Why they care, Opener, Objections) are marked "Not provided, pending offer",
  not invented.
- Handoff file written, noting the missing offer as the blocking gap and what is needed to complete the brief.
