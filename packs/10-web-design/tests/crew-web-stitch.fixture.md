# Fixture: crew-web-stitch

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the behaviour and output, and that the handoff file was written. State root is `~/.claude/crew-state/`; project records live under `~/.claude/crew-state/projects/<project>/`.

## Case A: clean
INPUT:
Generate a Google Stitch DESIGN.md for a premium fintech dashboard. Reference our design key on Linear (linear.app): calibrated neutral palette, weight-driven type. Audience is finance operators inside a B2B treasury console, so it is a dense data product. Dials: Variance 6, Motion 5, Density 7. Scheme both, dark-first. Target screens are the dashboard, the settings page, and an empty state. Careful mode. Brand context already onboarded. Project name: ledger.
EXPECT:
- Step 0 Context Recovery runs first: it checks `~/.claude/crew-state/brand-context.md`, the gate passes silently (brand onboarded), it settles the project ("ledger"), then reads ONLY this skill's own record at `~/.claude/crew-state/projects/ledger/crew-web-stitch-handoff.md`, stating what was recovered or "No prior record in this project for this skill."
- The brief is captured first and confirmed back in one paragraph: Linear as the reference, finance operators in a B2B treasury console as audience, dials Variance 6 (Offset Asymmetric) / Motion 5 (Fluid CSS) / Density 7, scheme both (dark-first), the dashboard plus settings plus empty state as target screens.
- The reference is analyzed across all ten dimensions: atmosphere and the three dials, colour palette with scheme and contrast, typography rules, the hero section, component stylings, layout principles, responsive rules, motion philosophy, anti-patterns and AI tells, and the performance budget. No dimension is left descriptive-only.
- The eight-part DESIGN.md is drafted with precise values: Visual Theme and Atmosphere, Colour Palette and Roles (an absolute neutral base, one accent below 80 percent saturation with its hex, no purple/neon, no pure black, a full paired dark token set because both schemes ship), Typography Rules (Inter and generic serifs banned, a face chosen from the fintech/console register row with a stated reason and never defaulted to Geist, the fluid clamp() scale with per-tier line-height, weight, and tracking, tabular figures for dashboard numbers at this density), Component Stylings (register radius token, the data-visualization block because a dashboard is a target, the finishing details and the accessibility floor), Layout Principles, Motion and Interaction, Anti-Patterns, and Performance Budget.
- Every text/surface pair states its computed WCAG contrast ratio and passes the web-standards Color 2 floors, in BOTH schemes because both ship.
- Motion is encoded with the named easing family (hover and entrances use `--ease-out-quart` cubic-bezier(0.25, 1, 0.5, 1), the named `--spring-out` linear() spring, active-press 90ms ease-out), stagger 60ms capped at 600ms, max 2 live-state loops per viewport paused offscreen, transform and opacity only. No Material standard easing, no raw stiffness/damping constants.
- The anti-pattern / AI-tell check is run: Section 7 enumerates the full ban list and no banned signature leaked into the earlier sections.
- The assembled DESIGN.md holds the length budget (under 900 words / 120 lines).
- The build report begins with the exact line `STITCH OUTPUT`.
- The Design review gate is run: `crew-design-engineering` as the authoring cross-reference over Sections 4 and 6 (Before/After/Why fixes applied), then `crew-design-quality` (binding, its Motion and Interactive-states dimensions are the motion verdict), `crew-design-composition`, `crew-design-patterns`, and the register-conditional pack-13 style lens, which for this fintech console is `crew-design-minimalist`, NOT `crew-design-soft`. Pack-14 animation skills are named only as authoring cross-references, never gate reviewers. Criticals and Majors fixed; a fail blocks the handover to Stitch.
- No render is supplied this run, so the render compliance check (Workflow step 9) records "render unverified" and STATUS is DONE_WITH_GAPS, never a clean DONE; a clean DONE requires the render compliance check against Stitch's actual generated screens.
- No em dashes anywhere.
- The handoff is written to `~/.claude/crew-state/projects/ledger/crew-web-stitch-handoff.md`, opening with the `# crew-web-stitch handoff` title line, a `Date:` line, and a `STATUS:` line, and carrying "render unverified" forward as unfinished work.

## Case B: messy
INPUT:
Make me a Stitch DESIGN.md that looks like that famous designer everyone copies, really premium. I want it dark but also warm and friendly, a dense analytics dashboard but also an airy marketing landing page, and use a nice font. Brand already onboarded. Fast mode.
EXPECT:
- Step 0 reads `~/.claude/crew-state/brand-context.md`, the gate passes, the skill confirms the brand out loud, settles or confirms the active project, and reads only this skill's own prior record before drafting.
- The named-designer reference is NOT guessed from the name: the skill asks for one sentence of description or hands off to `crew-design-language` to decode real values, and invents no taste, palette, or reference on a guess.
- The contradictions are surfaced and resolved rather than averaged into mush: dark-and-warm is reconciled into one coherent scheme (a warm-hued near-black, not #000, with the contrast re-checked), and dense-dashboard-versus-airy-landing is split by target screen with the density dial stated per screen and each assumption flagged "Assumed" for the user to correct.
- Fast mode is abandoned and the run finishes in Careful because the reference is a name the user cannot describe and the register is contested; the surviving integrity checks never lighten under Fast: no-fabrication, the contrast floors on every text/surface pair, the anti-pattern ban sweep, the length budget, the Design review gate, and the render compliance check when output exists.
- A font is chosen from the register table with one stated sentence on why it fits, never defaulted to Geist; the fluid clamp() scale with per-tier tracking is used, not static sizes.
- One accent only, below 80 percent saturation, no purple/neon, no pure black; every text/surface pair states its computed contrast ratio and passes the Color 2 floors in the chosen scheme.
- The build report begins with the exact line `STITCH OUTPUT` and names the open assumptions.
- STATUS is DONE_WITH_GAPS (never a clean DONE) because assumptions stay open and no render was verified ("render unverified").
- No em dashes anywhere.
- The handoff is written to `~/.claude/crew-state/projects/<project>/crew-web-stitch-handoff.md`, carrying the open assumptions and "render unverified" forward as unfinished work.

## Case C: missing-input
INPUT:
Make me a DESIGN.md.
EXPECT:
- The Step 0 brand HARD GATE fires if `~/.claude/crew-state/brand-context.md` does not exist: the skill STOPS, says the business is not onboarded yet, and runs the eleven-question brand onboarding conversation inline, writing the file before going further.
- Loop 1, Missing Input fires. The skill does NOT invent a brand, does NOT pick a reference, and does NOT draft any taste, palette, dials, or eight-part contract on a guess.
- It asks once for the six-question brief: the brand or reference (a URL, a brand name, or an existing product), the audience and product type, the design intent / dials, the target screens, the scheme (light, dark, or both), and the mode.
- It does not analyze across the ten dimensions or start drafting the eight-part contract until the brand or reference, the audience, and the design intent arrive.
- No `STITCH OUTPUT` report is produced for a contract that was not drafted, and STATUS is NEEDS_CONTEXT or BLOCKED, never DONE.
- No em dashes anywhere.
- The handoff is written FIRST to `~/.claude/crew-state/projects/<project>/crew-web-stitch-handoff.md` (a Loop 1 pause counts as finishing for the Context Loop), with STATUS: BLOCKED and the missing inputs named, inventing no brand, reference, palette, or dials.
