# Fixture: crew-design-reference

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the output, and that the handoff file was written.

## Case A: clean
INPUT:
I am building a SaaS billing dashboard. Audience is finance operators. It needs to feel trustworthy and exact, and it is dense (invoices, line items, totals). What references should I study? (Careful mode.)
EXPECT:
- Output begins with "DESIGN REFERENCE BRIEF" and includes a Problem line, an Aesthetic goal line, a Category line, and a Mode.
- A "References (best match first):" block returns at least three real sites, each with a real URL, a named principle, a "Why premium:" line that is specific (not "looks clean"), and an "AI would get wrong:" line.
- At least one reference covers Stripe-level information design (Stripe for the billing surface, or Sentry for legible data density), with a concrete reason.
- A "Primary north star:" line names the one site to anchor on and why.
- An "Emulate:" line and an "Avoid:" line, where Avoid names the category's AI-slop defaults (centered hero, Inter, gradient glow, equal-weight cards).
- No invented sites or URLs; every site named is real.
- No em dashes anywhere in the output.
- Handoff file `~/.claude/crew-state/design-standards/crew-design-reference-handoff.md` was written.

## Case B: cross-category
INPUT:
I need a look that is luxury e-commerce meets editorial typography, for a high-end print magazine that also sells subscriptions. What should I reference?
EXPECT:
- The brief crosses categories: it pulls from luxury and fashion (for example Aesop, Bottega Veneta, or Saint Laurent for whitespace-as-luxury) AND from editorial and long-form (for example Stripe Press or Medium for reading craft), rather than forcing one category.
- Each reference still carries a principle, a specific why-premium, and a what-AI-gets-wrong lesson; the bridge between the two aesthetics is named (restraint plus reading craft).
- No site is fabricated to fit the cross-category brief; if the library lacks a perfect single match, the brief composes two real references instead of inventing one.
- A primary north star is chosen and the tension between the two directions is acknowledged (this is a candidate for a decision brief).
- Handoff file written, recording the chosen references.

## Case C: missing-input
INPUT:
"What looks good?" No project, no category, no aesthetic goal, no artifact.
EXPECT:
- The skill follows Loop 1 (Missing Input): it asks once what is being built and the aesthetic goal, because a reference match needs a problem to match against.
- It does NOT dump the whole library or invent a project, and it names no references against an unknown problem.
- If it emits any partial output, the Problem, Category, and References fields are marked "Not provided" rather than filled.
- Handoff file `~/.claude/crew-state/design-standards/crew-design-reference-handoff.md` written, recording the missing problem as the blocker the next run needs.
