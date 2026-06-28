# Fixture: crew-web-stitch

Three cases that exercise the skill: a clean DESIGN.md taste contract, a wrong-tool routing case, and a vague brief missing the brand and reference. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the behaviour and output, and that the handoff file was written.

## Case A: clean

**Input.**

> Generate a Google Stitch DESIGN.md for a premium fintech dashboard. Reference our design key on Linear (linear.app): calibrated neutral palette, weight-driven type. Audience is finance operators inside a B2B treasury console, so it is a dense data product. Dials: Variance 6, Motion 5, Density 7. Target screens are the dashboard, the settings page, and an empty state. Careful mode.

**Expect.**

- Step 0 reads `~/.claude/crew-state/web-design/crew-web-stitch-handoff.md` and states what was recovered (or "No prior context, first run").
- The brief is captured first: Linear as the reference, finance operators in a B2B treasury console as audience, dials Variance 6 / Motion 5 / Density 7, the dashboard plus settings plus empty state as target screens.
- The reference is analyzed across all nine dimensions: atmosphere and the three dials, color palette and roles, typography rules, the hero section, component stylings, layout principles, responsive rules, motion philosophy, and the anti-pattern / AI-tell list. No dimension is left descriptive-only.
- The seven-part DESIGN.md is drafted with precise values: a Visual Theme and Atmosphere section, a Color Palette and Roles section (an absolute neutral base, a single accent below 80 percent saturation with its hex, no purple/neon, no pure black), Typography Rules (Inter and generic serifs banned, distinctive type forced, mono for high-density numbers since density exceeds 7), Component Stylings, Layout Principles, Motion and Interaction (spring physics constants, perpetual micro-loops, transform and opacity only), and Anti-Patterns (the full ban list enumerated).
- Every descriptive rule carries an exact value (hex, rem, px); values are precise, not vague.
- The anti-pattern / AI-tell check is run, and no banned signature leaked into the earlier sections.
- The build report begins with the exact line `STITCH OUTPUT`.
- The Design review gate is run against `crew-design-quality`, `crew-design-composition`, `crew-design-patterns`, `crew-design-soft`, `crew-animation-motion`, and `crew-animation-css`, with Criticals and Majors fixed, and a fail blocking the handover to Stitch.
- No em dashes anywhere.
- The handoff is written to `~/.claude/crew-state/web-design/crew-web-stitch-handoff.md`.

## Case B: wrong-tool

**Input.**

> Build and deploy the actual cinematic landing page for me. I want the immersive scroll site live on a Vercel link, not a spec.

**Expect.**

- The skill recognises this is a real site build and deploy, not a Google Stitch DESIGN.md taste contract.
- It routes to `crew-web-cinematic-build` (or the right builder for the brief) and explains the boundary: Web Stitch produces a DESIGN.md taste contract that Stitch interprets to generate screens, it does not build or deploy a site; an immersive single-file cinematic scroll site that ships to a Vercel link is exactly what Cinematic Build is for.
- It does NOT draft a DESIGN.md, analyze across the nine dimensions, or write any screen-generation contract.
- No `STITCH OUTPUT` report is produced for a contract that was not the deliverable.
- No em dashes anywhere.

## Case C: missing-input

**Input.**

> Make me a DESIGN.md.

**Expect.**

- Loop 1, Missing Input. The skill does NOT invent a brand, does NOT pick a reference, and does NOT draft any taste.
- It asks once for the brief: the brand or reference (a URL, a brand name, or an existing product), the audience and product type, and the design intent / dials, plus the target screens.
- It invents no taste, no palette, and no dials on a guess; it does not start drafting the seven-part contract.
- It records the blocker in the handoff at `~/.claude/crew-state/web-design/crew-web-stitch-handoff.md` and pauses rather than fabricating a brief.
- No em dashes anywhere.
