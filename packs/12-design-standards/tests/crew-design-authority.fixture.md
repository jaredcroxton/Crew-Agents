# Fixture: crew-design-authority

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the output, and that the handoff file was written.

## Case A: clean
INPUT:
Review this law firm homepage for authority (Careful mode). Register goal: institutional. Audience: corporate clients and general counsel.
It has a centered playful hero with a big rounded geometric sans headline, a bright teal accent with a subtle gradient glow on the buttons, flat-vector illustrations of cartoon lawyers, bouncy hover animations on the practice-area cards, and emoji in the section headers.
EXPECT:
- Output begins with "DESIGN AUTHORITY REVIEW" and includes an Artifact line, a Register goal line, an Audience line, a Reviewed date, and a Mode.
- A "Right lens:" line confirming authority fits (a law firm must read established).
- A "Verdict:" of "Reads startup" (or "Credible" at best) with a "Highest-impact move:".
- An "Authority reads:" block marking Typography, Colour, Layout, and Imagery as Undercuts, each with a one-line reason.
- An "Undercuts authority (with the establishing swap):" block that names each anti-SaaS tell and its establishing swap: the rounded geometric sans (a serif or serious grotesque), the teal gradient accent (one deep muted accent on a warm neutral), the centered playful hero (a structured serif masthead), the vector illustrations (real photography of the firm), and the bouncy motion plus emoji (stillness and a formal register).
- No invented element; only elements actually described are flagged.
- No em dashes anywhere in the output.
- Handoff file `.claude/crew-state/design-standards/crew-design-authority-handoff.md` was written.

## Case B: wrong-lens
INPUT:
I am building a playful, colourful habit-tracker app for Gen Z, all bright gradients, rounded type, and bouncy animation. Should I apply authority design to make it look more serious and trustworthy?
EXPECT:
- The reviewer judges that authority is the WRONG lens here: a young, energetic consumer brand should read fresh and lively, and forcing serifs, deep muted colour, and stillness would make it read stiff and dated, not trustworthy.
- It does not run the full authority sweep or recommend serifs and navy; it states the mismatch plainly and sends the brand to the fresh register (crew-design-patterns and crew-design-quality) instead.
- It distinguishes trust from gravity: a Gen Z app earns trust through clarity, speed, and delight, not through institutional weight.
- It invents nothing and does not pretend a bright playful brand is broken just because it is not authoritative.
- Handoff file written, recording that authority was not the right lens and where the brand was routed.

## Case C: missing-input
INPUT:
"Make it look powerful." No artifact, no audience, no register goal is provided.
EXPECT:
- The skill follows Loop 1 (Missing Input): it asks once for the design to review and who must trust it (the audience and the register goal), because the authority lens needs both a design and a register.
- It does not invent a design, fabricate an authority read, or run the anti-SaaS playbook against nothing.
- If it emits any partial output, the Artifact, Register goal, and Verdict fields are marked "Not provided" rather than filled.
- Handoff file `.claude/crew-state/design-standards/crew-design-authority-handoff.md` written, recording the missing artifact and register as the blocker the next run needs.
