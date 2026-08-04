# Fixture: crew-design-reference

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the output, and that the handoff file was written.

## Case A: clean
INPUT:
CREW CONSULT from crew-web-page-builder: brand gate passed, brand-context at ~/.claude/crew-state/brand-context.md. Reference wanted: the reference library. Building the editorial journal pages for Gullwing Sailing Journal, a long-form sailing magazine. Which sites in the library do editorial typography and long-form reading layout at world class, and what would an AI build get wrong chasing them?
EXPECT:
- The skill routes to `references/reference-library.md` and reads ONLY that reference file; no other file under `references/` is read.
- The brand onboarding hard stop is NOT re-run: the literal CREW CONSULT preamble plus the present brand-context file carve straight through Step 0.
- Output begins with "DESIGN REFERENCE" and includes a Lens line, a Reference line naming references/reference-library.md, a Question line, a Built date, and a Fit line.
- The Findings name real entries from the library's editorial section, each finding citing the specific reference section or entry it comes from, including the principle each site demonstrates and what an AI build would get wrong.
- Findings, not verdicts: no score, no ship or no-ship call; the For the build line points the page builder at what to apply and leaves the binding verdict to crew-design-quality.
- No em dashes anywhere in the output.
- Handoff file `~/.claude/crew-state/projects/<project>/crew-design-reference-handoff.md` was written, recording the reference consulted and the entries cited.

## Case B: wrong-reference
INPUT:
CREW CONSULT from crew-web-landing-page-builder: brand gate passed, brand-context at ~/.claude/crew-state/brand-context.md. Reference wanted: the reference library. Cooper's Creek Bait and Tackle has no brand, no designer, and no reference; pick the colour palette and font pairing for its first site.
EXPECT:
- The skill says the reference library is the wrong reference for this job: the library holds named sites and principles, it does not mint palettes; a no-brand palette and pairing is the design kit's exact ground.
- It routes to `references/kit.md`, reads it, and returns findings in that reference's terms: a feeling-led palette as a copy-paste :root token block with real hex values and a real Google Fonts pairing, each citing the kit section it comes from.
- The output's Fit line records the reroute and why; the Lens line names the design kit, not the reference library.
- It does not invent library entries about bait shops or fabricate a palette outside the kit.
- Handoff file `~/.claude/crew-state/projects/<project>/crew-design-reference-handoff.md` written, recording that the library was asked for, why it was refused, and which reference answered instead.

## Case C: missing-input
INPUT:
"Give me a design reference." No reference named, no design question, no build named, and no context to infer what the consult wants back.
EXPECT:
- The skill asks once: what is being built and what the consult wants back (a named site reference, a pattern check, a composition read, tokens, an authority read, or a palette and pairing), because routing needs a question.
- It does not pick a reference arbitrarily, does not read a reference file on a guess, and does not invent findings against nothing.
- If it emits any partial output, the Lens, Question, and Findings fields are marked "Not provided" rather than filled.
- The handoff records STATUS: BLOCKED with the missing question named as the blocker; the chat status is NEEDS_CONTEXT or BLOCKED, never DONE.
- Handoff file `~/.claude/crew-state/projects/<project>/crew-design-reference-handoff.md` written, recording what the next run needs.
