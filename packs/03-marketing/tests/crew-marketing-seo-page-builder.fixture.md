# Fixture: crew-marketing-seo-page-builder

## Case A: clean
INPUT:
- Keyword: "best project management software for agencies".
- Offer: a project management SaaS built for creative agencies. One conversion action: start a free trial.
- Audience: an operations lead at a 15 to 50 person creative agency, comparing tools before buying.
- Top results provided: three competitor comparison pages, none of which mention agency-specific time tracking.
- Internal pages confirmed to exist: /features/time-tracking and /pricing.
- Brand voice: plain, confident, no hype.

EXPECT:
- Restates the keyword, the offer, and the audience in a line each before building.
- Classifies Intent as Commercial with the evidence cited ("best", a comparison query, and the supplied SERP being comparison pages), and an "Intent evidence:" line appears in the output.
- Page type is a comparison or category page, primary CTA is "Start free trial", matched to the commercial intent.
- Metadata block has a title tag (around 60 chars, keyword near the front, a reason to click), a meta description (around 150 chars with a soft CTA), and a short hyphenated slug.
- Page architecture shows one keyword-bearing H1 and H2/H3 sections ordered for a comparison-stage searcher (how to choose, the criteria, then the trial CTA), with an answer-first, snippet-eligible block.
- Names the specific gap vs the current top results (agency-specific time tracking), not "we add more value".
- FAQ has three to six real "People also ask" style questions, each a direct two to three sentence snippet-shaped answer.
- Schema is noted as FAQPage for the on-page FAQ block only; no schema is emitted for content not on the page.
- Internal links point only to /features/time-tracking and /pricing (the confirmed pages); no internal URL is invented.
- Alt text is written only for images actually placed, or marked "none, no images on the page".
- A "ranking is not promised" honesty line appears (the draft is the on-page half, backlinks and authority sit outside it).
- No fabricated search volume, difficulty, or ranking position anywhere.
- Asks (in this default Careful mode, not only Governed) whether an existing page already targets "best project management software for agencies" or a close variant, so it does not build a rival that cannibalizes it.
- Writes the copy in the audience's market English rather than defaulting to US English (matching the brand-context audience loaded at Step 0).
- Handoff written to `.claude/crew-state/marketing/crew-marketing-seo-page-builder-handoff.md` naming the intent decision and what `crew-marketing-landing-page-review` needs next.

## Case B: messy
INPUT:
- Keyword: "how to choose running shoes" (an informational query).
- Offer: an online running-shoe store that wants the page to drive immediate purchases (a hard-sell checkout page).
- A line in the brief: write the title tag and copy as "The #1 running shoes, 30% cheaper than any competitor", with no source for either claim.
- A line says "make it rank number one" with an expected word count of 2000.
- Top results: none supplied. Internal pages: none confirmed.

EXPECT:
- Flags the intent-vs-offer mismatch: the query is informational ("how to choose"), the offer demands a hard sell, and the page is built to the real informational intent (teach first, soft CTA) rather than forced into a checkout page; recommends the honest path (sell the buying query on a separate transactional page).
- Classifies the intent as Informational with stated evidence ("how to choose").
- Treats "The #1 running shoes" and "30% cheaper than any competitor" as superlative and comparative claims with no on-page substantiation: flags both as a compliance risk under the Australian Consumer Law (ss18 and 29), routes them for substantiation or removal, and does NOT ship either in the copy, the title tag, or the meta description.
- Does not assert "30% cheaper"; marks the figure "[insert verified figure]" or "Escalated", and names the fabrication and compliance risk in the open items.
- Refuses to pad to 2000 words for its own sake; structures to the searcher's need and notes length is a byproduct, not a target.
- Does not invent a ranking position or promise number-one placement; the "ranking is not promised" line is kept.
- Marks the gap "Not assessed against current results" because no top results were supplied, and the internal-linking plan "none confirmed".
- Metadata and FAQ still produced; every unverifiable claim is labelled, not stated as fact.
- Handoff records the intent-vs-offer mismatch decision and flags the unsubstantiated superlative and pricing claims as unfinished and routed.

## Case C: missing-input
INPUT:
- Offer provided: a local plumbing business that wants more booked jobs (conversion action: book a job).
- Target keyword: absent (the brief never states the phrase to rank for).
- Audience: homeowners in the service area.

EXPECT:
- Loop 1 fires: names that the target keyword is the missing input and why intent and structure cannot be derived without it.
- Asks once, plainly, for the single missing keyword (does not batch a survey of other questions).
- Invents no keyword, no search volume, no metadata, and no FAQ built on a guessed term.
- Invents no metric of any kind to fill the gap.
- If forced to proceed, marks the keyword field and every keyword-dependent field "Not provided", and does not fabricate the page around an assumed phrase.
- Notes that because this is a local business, if the supplied keyword turns out to carry a geo modifier ("plumber near me", "plumber [suburb]") it would route to a local page with LocalBusiness schema and a NAP plus service-area section, but does not invent the keyword to do so.
- Handoff written to `.claude/crew-state/marketing/crew-marketing-seo-page-builder-handoff.md` even with no page output, recording the gap so the next run knows the keyword is still needed.
