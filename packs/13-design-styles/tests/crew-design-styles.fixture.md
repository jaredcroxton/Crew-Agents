# Fixture: crew-design-styles

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the output, and that the handoff file was written.

## Case A: clean
INPUT:
CREW CONSULT from crew-web-landing-page-builder: brand gate passed, brand-context at ~/.claude/crew-state/brand-context.md. Lens wanted: soft. Review the drafted landing page for Little Reef Swim School, a learn-to-swim centre for under-fives. The draft has a sharp-cornered hero card, a harsh black drop shadow under the pricing table, snappy 100ms hover transitions, and a pastel palette that is otherwise on register.
EXPECT:
- The skill routes to `references/soft.md` and reads ONLY that reference file; no other file under `references/` is read.
- The brand onboarding hard stop is NOT re-run: the literal CREW CONSULT preamble plus the present brand-context file carve straight through Step 0.
- Output begins with "DESIGN STYLE VERDICT" and includes a Lens line naming Soft, a Reference line naming references/soft.md, a Subject line, a Built date, and a Fit line saying why soft is right for this brand.
- The Verdict speaks in the reference's own terms: the hard cold leaks are flagged (the sharp corner, the harsh shadow, the snappy transition) each with its concrete fix, and the verdict also watches the saccharine line rather than pushing rounder-is-always-better.
- A Register line commits to one register, and a Suits the brand line answers plainly.
- No em dashes anywhere in the output.
- Handoff file `~/.claude/crew-state/projects/<project>/crew-design-styles-handoff.md` was written, recording the lens chosen and the fixes ordered.

## Case B: wrong-lens
INPUT:
CREW CONSULT from crew-web-page-builder: brand gate passed, brand-context at ~/.claude/crew-state/brand-context.md. Lens wanted: brutalist. Review the homepage direction for Golden Wattle Fertility, a fertility clinic whose brand context asks for warmth, reassurance, and calm.
EXPECT:
- The skill says brutalist is the wrong lens for this brand: raw, high-contrast, uncommercial design fights a brief built on warmth and reassurance, and the reference's own when-NOT-to-use lines say so.
- It routes to the right reference instead, `references/soft.md`, reads it, and returns the verdict in that reference's terms.
- The output's Fit line records the reroute and why; the Lens line names Soft, not Brutalist, and the Suits the brand line reflects the corrected pairing.
- It does not force a brutalist verdict onto the clinic or blend the two registers into one answer.
- Handoff file `~/.claude/crew-state/projects/<project>/crew-design-styles-handoff.md` written, recording that brutalist was asked for, why it was refused, and which lens answered instead.

## Case C: missing-input
INPUT:
"Check the style of my design." No lens named, no design or page supplied, no brand feeling stated, and no build context to infer any of it from.
EXPECT:
- The skill asks once: which lens is wanted, or what the project should feel like, and what design it should look at, because routing and reviewing both need a subject.
- It does not pick a lens arbitrarily, does not read a reference file on a guess, and does not invent a verdict against nothing.
- If it emits any partial output, the Lens, Subject, and Register fields are marked "Not provided" rather than filled.
- The handoff records STATUS: BLOCKED with the missing subject and lens named as the blocker; the chat status is NEEDS_CONTEXT or BLOCKED, never DONE.
- Handoff file `~/.claude/crew-state/projects/<project>/crew-design-styles-handoff.md` written, recording what the next run needs.
