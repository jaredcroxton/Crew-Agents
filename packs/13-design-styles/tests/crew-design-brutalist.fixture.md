# Fixture: crew-design-brutalist

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the output, and that the handoff file was written.

## Case A: clean
INPUT:
Review this design studio portfolio for brutalist execution (Careful mode). Intended mode: tactical telemetry (dark). Audience: prospective clients who expect a confident, raw, anti-corporate studio.
The page has rounded corners and soft drop shadows on the project cards, a purple-to-blue gradient on the hero, buttons that fade their background on hover over 300ms, a friendly geometric sans for body text, and a light-coloured section in the middle of an otherwise dark page.
EXPECT:
- Output begins with "DESIGN BRUTALIST REVIEW" and includes an Artifact line, a Mode line (tactical telemetry), an Audience line, a Reviewed date, and a Run mode.
- A "Right lens:" line confirming brutalist fits a studio portfolio.
- A "Verdict:" of "Diluted" with a "Highest-impact move:".
- A "Brutalist reads:" block marking Typography, Colour and substrate, Layout and structure, and Interactions as Diluted or Off, each with a one-line reason.
- A "Commercial defaults leaking in (with the raw fix):" block that names each leak and its raw fix: the rounded corners (square every corner, no border-radius), the soft drop shadows (1px solid borders or gap:1px dividers), the gradient hero (a flat single substrate), the 300ms hover fade (instant invert or block fill, no transition), the friendly geometric body sans (uppercase monospace plus a heavy grotesque), and the mixed light section (commit to the dark substrate).
- An "Accessibility floor:" note (focus visible, contrast readable, or the defect to fix).
- No invented element; only what is described is flagged.
- No em dashes anywhere in the output.
- Handoff file `.claude/crew-state/design-styles/crew-design-brutalist-handoff.md` was written.

## Case B: wrong-lens
INPUT:
I am building a retail banking app and I want it to look edgy and brutalist so it stands out from other banks. Should I apply the brutalist aesthetic?
EXPECT:
- The reviewer judges brutalist is the WRONG lens here: a retail bank must signal trust, safety, and stability, and a raw, uncommercial brutalist look reads unstable and unfinished to a risk-averse financial audience.
- It does not run the full brutalist sweep or recommend hazard-red and CRT scanlines; it states the mismatch plainly and routes the brand to the established register (crew-design-authority).
- It distinguishes standing out from looking unsafe: a bank can differentiate through clarity, restraint, and craft, not through rawness that undercuts trust.
- It flags the accessibility risk of brutalist for a product that must be universally usable.
- It invents nothing and does not soften brutalist into a half-measure to make it fit.
- Handoff file written, recording that brutalist was not the right call and where the brand was routed.

## Case C: missing-input
INPUT:
"Make it brutalist." No artifact, no mode, no audience, and no description of the design is provided.
EXPECT:
- The skill follows Loop 1 (Missing Input): it asks once for the design to review and the intended mode (Swiss industrial print or tactical telemetry), because the brutalist read needs both a design and a committed mode.
- It does not invent a design, fabricate a brutalist read, or flag leaks against nothing.
- If it emits any partial output, the Artifact, Mode, and Verdict fields are marked "Not provided" rather than filled.
- Handoff file `.claude/crew-state/design-styles/crew-design-brutalist-handoff.md` written, recording the missing artifact and mode as the blocker the next run needs.
