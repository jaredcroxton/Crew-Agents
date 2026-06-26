# Fixture: crew-marketing-landing-page-review

## Case A: clean
INPUT:
- Page: full copy of acme.io/demo provided verbatim. H1: "Acme CRM for plumbers". Subhead: "Manage jobs and invoices in one place". One section of features. One testimonial: "Saved us hours. - Priya N., Brightflow Plumbing". Pricing not shown. Primary button: "Submit". A second button "Learn more" sits beside it. Form asks for name, company, phone, email, team size.
- Goal: book a product demo.
- Traffic: cold paid ad. Visitor: owner of a small plumbing firm.
- Competitor: none supplied.

EXPECT:
- Restates the goal (book a demo), the cold-ad traffic, and the visitor before scoring.
- Output begins "LANDING PAGE REVIEW" with "Conversion readiness: [n]/100" and the five part scores shown (Headline /25, Offer /20, Proof /20, CTA /20, Layout /15) that sum to the total.
- Explicit note that the score is a readiness judgement, not a predicted conversion rate.
- Competitor comparison line marked "Not assessed, no alternative supplied" (no rival invented).
- Flags the two competing primary CTAs (Submit vs Learn more) splitting intent, the generic button text "Submit", and the five-field form as friction too high for cold traffic, each with a location. The form friction is quantified (counts the required fields, calls out phone and team size as high-cost fields on a cold ad).
- Separately from the friction finding, flags the form (name, company, phone, email, team size) as a compliance risk because no visible privacy or collection notice is shown beside a form collecting personal data, and routes it (Australian Privacy Act APP 5).
- States the readiness band (ship / fix critical issues first / do not send paid traffic yet) as a one-line verdict, kept a readiness judgement and not a predicted rate.
- The fold, CTA visibility, and form-friction judgements are made on a mobile viewport, and a "Judged on: mobile" line appears.
- Grades the single testimonial on the proof ladder as a named result without a number (mid-ladder), and flags hidden pricing as a silent offer killer.
- "Weakest CTA rewrite" block replaces "Submit" with value-stating button text in the page's voice, with a one-line why.
- Issues ranked by conversion impact, each citing a location or line and each carrying a fix tier (Quick win / Moderate / Rebuild).
- Names the cheapest change that moves the score most first.
- Handoff file `.claude/crew-state/marketing/crew-marketing-landing-page-review-handoff.md` was written.

## Case B: messy
INPUT:
- Page given as a screenshot plus a paraphrase ("it basically says we are the best and to sign up"), not the real words. Headline text is legible in the image but the body is blurred. One logo strip visible. A testimonial is described as "a five-star quote" but the name and number are not readable.
- Goal: stated twice and contradictory, once as "start a free trial" and once as "book a call".
- Traffic: not stated. Visitor: "everyone".
- Competitor: none supplied.

EXPECT:
- States it is reviewing a paraphrase and a partly blurred screenshot, so body-copy findings are provisional and confidence is lowered.
- Names the contradictory goal and asks once which is primary (free trial or book a call), or marks "Assumed: [the one chosen], confirm" rather than scoring both silently.
- Does NOT invent the blurred body copy, the testimonial name, or a star count it cannot read. Logo strip graded as named-logos proof only if actually visible, else "Not legible".
- Treats the paraphrased "we are the best" superlative as a claim the page is reported to make, not a fact confirmed from a paraphrase; notes that if the page genuinely makes an unsubstantiated superlative claim it is a compliance risk under consumer law to be routed, but flags it provisionally given the paraphrase rather than asserting it.
- Flags "everyone" as too broad to judge the page against, and missing traffic source as lowering scoring confidence.
- Part scores still sum to the total, with the unreadable parts marked "Not provided" and not padded; the competitor line marked "Not assessed, no alternative supplied".
- Handoff file written, recording the contradictory goal, the assumption made, and the unreadable parts.

## Case C: missing-input
INPUT:
- Page: full copy of a pricing page provided verbatim and well-formed.
- Goal: not provided (no conversion action named anywhere).
- Traffic and visitor: provided (warm newsletter, existing free users).
- Competitor: none supplied.

EXPECT:
- Loop 1 fires: names that the conversion goal is the missing input and why it matters (a page cannot be scored against an action that has not been named).
- Asks once, plainly, for the single conversion goal. Does not batch other questions.
- Invents nothing: does not guess the goal, does not produce a fabricated score for an unnamed action.
- If it proceeds, reviews only the goal-independent parts (headline clarity, proof inventory, layout) and marks the goal-dependent parts (CTA, Offer) "Not provided"; labels the overall score as withheld pending the goal rather than padding it.
- Competitor line marked "Not assessed, no alternative supplied".
- Handoff file written, recording the gap (goal not provided) so the next run knows.
