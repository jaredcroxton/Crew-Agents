# Fixture: crew-sales-outreach-draft

## Case A: clean
INPUT:
Upstream: a crew-sales-prospect-brief handoff at .claude/crew-state/sales/crew-sales-prospect-brief-handoff.md, eligibility recorded clear, chosen angle the careers page.
Audience: Dana Vogel, COO of Northwind Logistics, a regional cold-chain 3PL, around 50 to 200 staff. Fits because they are scaling ops fast.
Offer: fractional ops support. One outcome: onboarding does not stall during a hiring push.
Hook (from the brief): their careers page lists four open ops roles and no ops manager (source: northwind.com/careers, live 2026-06-17).
Channel: email.

EXPECT:
- Eligibility check is run first and noted as clear (no do-not-contact, opt-out, existing-customer, or open-opportunity signal in the inputs or the upstream handoff).
- The chosen angle is reused from the prospect-brief handoff, not reinvented.
- Output begins with "OUTREACH DRAFT" and includes For, Channel: email, Offer, and Outcome promised lines.
- A Subject line under 7 words.
- Hook line names the four open ops roles and missing ops manager (the specific mechanism, not "they need help scaling"), stated as an observation, not flattery.
- The hook passes the competitor test: it could not be pasted to a rival 3PL unchanged.
- Exactly one outcome promised, no feature list.
- Body between 50 and 90 words.
- Exactly one next step (a single low-friction ask), not a menu.
- A Length line stating the word count (body only, excluding the signature and unsubscribe line).
- Hook check reads "Specific, could not be sent to a competitor unchanged".
- The email draft includes a sender-identity block (rep name, company, role or contact) and an "[Unsubscribe + physical address: business to supply at send]" placeholder line.
- The deliverability check passes: no spam-trigger vocabulary, one link or none, no ALL-CAPS or "!!!", subject truthfully matches the body, plain-text-first.
- No em dashes, no "I hope this email finds you well", no stacked adjectives, no hype.
- Handoff file written at .claude/crew-state/sales/crew-sales-outreach-draft-handoff.md recording channel, hook, outcome, and next step for crew-sales-follow-up-sequence.

## Case B: messy
INPUT:
Audience: "the marketing people at TechCo, or maybe sales, not sure who." Company is TechCo, a SaaS firm.
Offer: described two ways, "we do lead gen" and also "actually it is more of an analytics platform." Wants "all our benefits" in the message and asks for it to "sound exciting and punchy."
Specific fact: "they posted something on LinkedIn last week about hiring, I think, and they seem to be growing."
Channel: not stated.

EXPECT:
- Audience flagged as a role, not a named person, and written to the role (for example "Assumed: writing to the Head of Marketing role, named person not provided").
- Offer contradiction surfaced: picks ONE framing and the ONE outcome, states which it chose and why, does not blend both (a Decision brief for the contradictory offer is acceptable).
- Refuses the "all our benefits" request (one outcome, no feature dump) and the "exciting and punchy" request (no hype, no stacked adjectives), per the Anti-template and Guardrails sections.
- The vague LinkedIn fact is firmed into a usable specific observation only if it can be stated verifiably, or marked "Weak: needs the actual post". Does NOT invent the post's contents.
- A channel recommended with a one-line reason since none was given, matched to where the hook lives.
- Correct taxonomy applied to whichever channel is chosen (length and format rules).
- No fabricated quote, metric, or event.
- Handoff file written, recording the offer ambiguity and the weak hook as unfinished work.

## Case C: missing-input
INPUT:
Audience: a fresh list of 30 ecommerce founders, names and companies only, no research done.
Offer: a returns-automation tool that cuts refund processing time.
Specific fact (hook): none, no research, nothing prospect-specific provided.
Channel: email.

EXPECT:
- Loop 1 behaviour: names the gap explicitly (no prospect-specific hook, which is required before sending) and asks once, plainly, for one real fact per prospect (a post, a site detail, a recent event).
- Does NOT write a generic opener to fill the gap and does NOT pretend a hook exists.
- Marks the hook line "Not provided, hook required before sending".
- Invents nothing: no fake compliment, no assumed metric, no imagined LinkedIn post.
- May produce a reusable scaffold (offer line, one outcome, channel format, a placeholder hook clearly labelled not sendable) so the rep only drops in the hook, but it is explicitly marked not sendable until the hook is supplied. Not a sendable generic message.
- Handoff file written, recording the missing hook as the blocking gap and what the next run needs.
