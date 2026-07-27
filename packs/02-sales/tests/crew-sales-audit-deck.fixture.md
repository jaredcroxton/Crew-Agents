# Fixture: crew-sales-audit-deck

## Case A: clean
INPUT:
Call notes: "Marlow & Finch Removals, family removalist, two trucks. Owner says quotes go out slow because everything is booked by phone and typed up later that night. About 4 quote requests a week fall through the cracks and go to a competitor, each job averages around $900. Also chasing deposits by hand, one person a full day a week. Wants faster quotes, fewer lost jobs, and to stop the manual deposit chase. Uses a paper diary and a shared inbox."
Library: drawer at ~/.claude/crew-state/library/sales/ holds six SHIPPED entries, including "Instant Quote Responder" (Pain it solves: quote requests lost to slow manual replies; Industry: trades, removals) and "Deposit Chase Automation" (Pain it solves: staff time lost chasing deposits by hand; Industry: services).
Brand context: present, so Step 0 passes.
Mode: not named (defaults to Careful).

EXPECT:
- Prints the AUDIT DECK PLAN block, opening "AUDIT DECK PLAN: Marlow & Finch Removals (removalist)".
- Two pain points captured in the client's own words (quotes go out slow, booked by phone and typed up later; deposits chased by hand), not paraphrased into a category.
- Objectives read as the client framed them (faster quotes, fewer lost jobs, stop the manual deposit chase), up to three.
- COI is a real figure with a shown basis, computed from stated numbers only and with a capture rate applied (4 lost quote requests/week at ~$900 each, a conservative conversion rate, annualised), presented as a conservative revenue-at-risk range, headline 20 characters or fewer, basis on its own line.
- Two genuine library matches returned, each with a two-sided reason tying the client's stated pain to the shipped proof from the entry: "Instant Quote Responder" tied to the slow-quote pain, "Deposit Chase Automation" tied to the manual deposit chase. No forced third match.
- Process steps per pain point are reconstructed and labelled inferred (for example: request by phone -> written in paper diary -> typed up that night -> competitor already quoted).
- Full three-month roadmap named from the matched workflows.
- Pricing slide carries a visible "DRAFT: pricing pending" stamp and the hero image is left blank or a branded fallback, the receipt lists them under what stays manual, and the deck is marked DONE_WITH_GAPS while pricing is pending.
- Render step consults crew-web-slide-deck-builder with the literal preamble "CREW CONSULT from crew-sales-audit-deck: brand gate passed, brand-context at ~/.claude/crew-state/brand-context.md", handing it the complete 10-slide plan to render, not re-plan.
- Handoff written to ~/.claude/crew-state/projects/<project>/crew-sales-audit-deck-handoff.md, with the STATUS frame, the library matches and COI basis recorded, and pricing and hero noted as manual.

## Case B: messy
INPUT:
Call notes (raw, partial): "quick chat with the cafe fit-out guy... said something about jobs running over AND leads going cold?? it is a mess, we lose track of stuff. no real numbers, did not want to say revenue. maybe get more reviews too. team is small."
Library: drawer holds three SHIPPED entries, none a clean fit for "jobs running over" or "leads going cold".
Brand context: present.
Mode: not named (defaults to Careful).

EXPECT:
- Pain points kept vague and in the client's words (jobs running over, leads going cold, "we lose track of stuff"), not sharpened into invented specifics.
- Process steps reconstructed from thin context and clearly labelled inferred, with the operator shown the extraction before any deck is built.
- COI slide BLANK with a reason (the client gave no frequency or dollar figures), and the receipt tells the operator to get volume and dollar numbers on the next call. No invented rate, volume, or amount.
- Library matching returns at most one tentative match or NONE, never a forced fit; if none, the recommendations slide is blank and the operator is told to seed more entries or pitch what they can deliver.
- Revenue, headcount, and tools left blank on the overview slide because the client did not state them, not guessed.
- Receipt lists pricing, hero, blank firmographics, and the inferred process steps as manual before send.

## Case C: missing-input
INPUT:
Library: drawer holds six SHIPPED entries.
Brand context: present.
(No call notes, transcript, or bullets provided.)

EXPECT:
- Loop 1 behaviour: names the missing input exactly (no call notes, so there is nothing the prospect said to extract from).
- Asks once, plainly, for the call notes, transcript, or typed bullets, and stops. No deck is built.
- Does NOT fabricate a prospect, a pain point, firmographics, or a COI to fill the template.
- Handoff written to ~/.claude/crew-state/projects/<project>/crew-sales-audit-deck-handoff.md recording that the deck is blocked on call notes, even with no deck produced ("No output, run completed [date]"), STATUS BLOCKED.
- Chat completion returns STATUS: NEEDS_CONTEXT.
