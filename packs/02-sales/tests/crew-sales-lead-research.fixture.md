# Fixture: crew-sales-lead-research

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the output, and that the handoff file was written.

## Case A: clean
INPUT:
Company: Northwind Logistics (northwind.com). Offer we sell: fractional ops support for 3PLs.
Public facts available: careers page lists 4 open ops roles and no ops manager; markets same-day cold-chain delivery; LinkedIn shows around 50 to 200 staff.
EXPECT:
- Output begins with "LEAD RESEARCH BRIEF" and includes a "Company:", "Researched:", and "For offer:" line.
- At least 2 ranked pain points, each naming a specific mechanism and tagged "Evidence" or "Inference".
- A conversation angle with a "Strength:" line.
- A "Trigger:" line in the summary block, naming the most recent dated event or "none found".
- An eligibility pass before the contact map: no do-not-contact, existing-customer, or jurisdictional block surfaced, so the brief proceeds.
- A decision-maker line with a "Type:" of Economic buyer, Champion, or Blocker, and an "Email:" that is an address or "not found".
- A "Sources:" line, with dates on any time-sensitive fact (for example the live careers page).
- Handoff file `.claude/crew-state/sales/crew-sales-lead-research-handoff.md` was written.

## Case B: messy
INPUT:
Company: "that logistics place up north, think they do cold storage?" Offer: fractional ops support.
No URL given. One stale 2019 article says headcount 500. LinkedIn today suggests far smaller.
EXPECT:
- Skill does not state a precise headcount as fact. It uses a band with a basis, or marks the 2019 figure as stale with its date.
- The contradiction between the 2019 article and current LinkedIn is flagged, not silently averaged into one number.
- The unconfirmed company identity is restated in Step 1 for the rep to correct before research effort is spent.
- Fabrication avoided: no invented revenue, no invented contact email (uses "not found").
- Handoff file written, noting the unverified company identity as unfinished work.

## Case C: missing-input
INPUT:
Company: Apex Freight. (No offer provided.)
EXPECT:
- Skill follows Loop 1: it asks once for the offer, because the angle and pain points depend on it, rather than guessing what is being sold.
- It does not fabricate pain points against an unknown offer.
- If it proceeds at all, "likely pain points" and "conversation angle" are marked as pending the offer, not invented.
- Handoff file written, recording the missing offer as the blocker the next run needs.
