# Brutalist spec (consulted via crew-design-styles)

The brutalist lens judges whether a design is genuinely raw and committed or a soft commercial layout wearing a few hard edges; this spec covers the two committed modes (Swiss industrial print and tactical telemetry), the commercial defaults that leak back in, and whether brutalist is the right call at all.

## What a review needs

You need:

- The artifact under review: a built page, a screenshot, a code block, or a description of the design.
- The intended mode if known: Swiss industrial print (light, heavy sans, red accent) or tactical telemetry (dark, monospace, CRT). If not stated, the reviewer infers it and confirms.
- The register goal: that the brand genuinely wants to read raw, honest, and deliberately uncommercial, not just edgy on top of a commercial product.

If no artifact is supplied, or it is unclear whether brutalist is even the goal, ask once what is being built and what feeling it must carry. Never invent a design to review, never assume brutalist is the goal, and never trace a critique on something you cannot see.

## How the brutalist designer thinks

1. **Honesty over polish.** Brutalism shows the structure instead of hiding it. Visible borders, raw states, system fonts. The seams are the design, not a flaw to smooth.
2. **Pick one mode and commit.** Swiss industrial print (light, heavy sans, hazard red) OR tactical telemetry (dark, monospace, CRT). Never mix the two in one interface; mixing reads as confused, not raw.
3. **Type is the architecture.** Typography is the structure and the decoration; imagery is secondary. The signature is extreme scale contrast, viewport-bleeding uppercase headers against tiny monospace metadata.
4. **Subtract the commercial defaults.** No gradient, no soft shadow, no rounded corner, no easing curve. Each removal is deliberate; brutalism is defined by what it refuses.
5. **The grid is visible and rigid.** Ninety-degree corners, hairline dividers, explicit compartments. Mathematically engineered, anchored to grid tracks, never floating.
6. **Raw is a choice, not an excuse.** A real brutalist site is more controlled than a polished one, not less. And it is the wrong choice for most commercial work, so the first judgment is always whether it earns its place at all.

## Brutalist typography

Type carries the structure. The system demands extreme variance in scale, weight, and spacing.

- **Macro type (structural headers).** A heavy grotesque or black-weight sans (Archivo Black, Monument Extended, a black-weight grotesque, a heavy Roboto Flex). Massive fluid scale (`clamp(4rem, 10vw, 15rem)`), tight or negative tracking (`-0.03em` to `-0.06em`) so glyphs form solid blocks, compressed leading (`0.85` to `0.95`), exclusively uppercase.
- **Micro type (data and metadata).** Monospace (JetBrains Mono, IBM Plex Mono, Space Mono). Small and fixed (`0.7rem` to `0.875rem`), generous tracking (`0.05em` to `0.1em`) to read like a terminal matrix, uppercase for all metadata, nav, IDs, and coordinates.
- **System fonts are on-brand.** A raw system stack (the default sans or a monospace) fits the honesty of the style; a brutalist site does not need a designer typeface to be correct.
- **Textural serif, used exceedingly sparingly.** A high-contrast serif (Playfair Display, EB Garamond, Times New Roman) only as disruption, and degraded (halftone or 1-bit dither) so it reads as texture against the clean sans, never as a soft elegant flourish.
- **No friendly type.** The rounded geometric sans that signals consumer-tech is the opposite of brutalist. If the body face reads warm and approachable, the design is not committed.

## Brutalist colour

The colour architecture is uncompromising. Gradients, soft drop shadows, and translucency are prohibited. Pick one substrate per project and never mix light and dark in one interface.

```
SWISS INDUSTRIAL PRINT (light):
  Background: #F4F4F0 or #EAE8E3 (matte unbleached paper)
  Foreground: #050505 to #111111 (carbon ink)
  Accent:     #E61919 or #FF2A2A (hazard red), the ONLY accent, for strikes, structural dividers, vital data.

TACTICAL TELEMETRY (dark):
  Background: #0A0A0A or #121212 (deactivated CRT, never pure #000000)
  Foreground: #EAEAEA (white phosphor), the primary text colour
  Accent:     #E61919 or #FF2A2A (hazard red), same rules
  Terminal green #4AF626: optional, for ONE specific element (a single status readout), never as general text. Omit if it serves no purpose.
```

Rules: one substrate, one ink, one accent. The red is structural, not decorative, used on almost nothing so it carries weight. No gradient, no glow, no soft shadow, no frosted glass. Depth, if any, comes from a hard border or a flat fill, never a blur.

## Brutalist layout

The layout must look mathematically engineered. It rejects soft web padding in favour of visible compartmentalisation.

- **The blueprint grid.** Strict CSS Grid. Elements anchor to tracks and intersections; they do not float in centred cards.
- **Visible compartmentalisation.** Solid borders (`1px` or `2px solid`) delineate zones; full-width horizontal rules segregate units. The structure is shown, not implied.
- **The hairline divider trick.** `display: grid; gap: 1px;` with contrasting parent and child backgrounds produces razor-thin perfect dividers without border rules.
- **Bimodal density.** Oscillate between extreme density (tight monospace metadata clusters) and vast calculated negative space framing the macro type. The contrast is the composition.
- **Ninety degrees, always.** Absolute rejection of `border-radius`. Every corner is exactly square to enforce mechanical rigidity. One rounded corner breaks the whole register.
- **Semantic rigidity.** Build with precise technical tags (`<data>`, `<samp>`, `<kbd>`, `<output>`, `<dl>`) so the DOM reflects the telemetry nature.

Optional analogue texture: halftone and 1-bit dither on imagery and large serifs, CRT scanlines via a `repeating-linear-gradient` for terminal mode, a low-opacity SVG noise filter on the root for a unified physical grain. Texture, not decoration; it must serve the raw read, not prettify it.

## Brutalist interactions

Motion is as honest as the rest. Brutalist interaction is instant and hard, never smooth.

- **No easing, no fade.** Transitions and easing curves are commercial polish. A brutalist hover changes state instantly (an invert, a block fill, a hard underline appearing), not a 300ms colour fade.
- **Hard hover states.** Hover inverts foreground and background, fills the cell with the accent, or snaps a thick underline into place. The change is binary, on or off.
- **Instant active feedback.** A press is an immediate hard state, no spring, no scale-bounce. The interface acknowledges the click without animating it.
- **Texture motion only.** If anything moves on its own, it is a scanline sweep or a flicker as texture, not a decorative micro-interaction.
- **Focus must survive the rawness.** A visible hard focus outline is mandatory. Brutalist removes the soft, but it does not get to remove keyboard accessibility; a missing or invisible focus state is a defect, not a style.

## When to use brutalist

Brutalist earns its place when the polish of everyone else is the problem and raw is the differentiation.

- Portfolios, agencies, and studios that need to stand out and signal craft and confidence.
- Editorial, zines, and culture or music brands that want an anti-corporate, raw voice.
- Technical and data-heavy dashboards where the tactical-telemetry mode genuinely fits the content (real density, real readouts).
- Counterculture, fashion, and product brands deliberately rejecting the consumer-SaaS look.
- The honesty play: a brand that wants to read raw, direct, and uncommercial, and can afford to trade mass-market safety for a strong point of view.

Do not use this spec for a commercial product that must read trustworthy and safe (use `crew-design-authority`), to score broad visual quality regardless of style (that is `crew-design-quality`), to build the token system (that is `crew-design-language`), or for a brand that should read warm, friendly, or accessibility-first. Brutalist is a deliberate, narrow register; name the mismatch rather than forcing it.

## When NOT to use brutalist

This is the off-ramp. Brutalist is the wrong tool for most commercial work, and the first job is to catch the mismatch.

- Anything that must signal trust and safety: banking, finance, healthcare, legal, insurance. These need the established register; route to `crew-design-authority`.
- Enterprise SaaS selling to risk-averse buyers, where raw reads as unfinished or unstable.
- Accessibility-first or government work, where the high-contrast-but-careless brutalist habit (thin focus, hard-to-scan density, red-only signalling) fails real accessibility floors.
- E-commerce conversion funnels, where rawness adds friction and hurts the clarity and trust a purchase needs.
- A broad mainstream consumer audience that reads raw as broken rather than deliberate.

If the brief needs to feel safe, trustworthy, frictionless, or universally accessible, brutalist is the wrong lens. Say so, name the better register, and do not soften brutalist into a half-measure that satisfies no one.

## Application rules

The checklist a build embeds when the goal is brutalist. The aesthetic is the contract.

```
[ ] One mode committed (Swiss industrial print OR tactical telemetry), never mixed in one interface.
[ ] One substrate, one ink, one accent (hazard red); no gradient, no soft shadow, no translucency.
[ ] Ninety-degree corners everywhere; no border-radius anywhere.
[ ] Type carries the structure: massive uppercase macro type against tiny monospace metadata, extreme scale contrast.
[ ] Visible structure: solid borders or the gap:1px divider trick, an explicit grid, compartments, not floating cards.
[ ] Interactions are instant and hard (invert, fill, hard underline); no easing, no fade.
[ ] A visible hard focus outline survives; the raw look does not break keyboard accessibility.
[ ] Brutalist is confirmed as the right call; a trust-critical or accessibility-first brief is sent to the right register instead.
```

## Review workflow

1. **Confirm brutalist is the right call, and the mode.** State the register goal and the audience. If the brand must read trustworthy, safe, or accessibility-first, say so now, route it (`crew-design-authority` for trust), and do not force raw onto it. If brutalist fits, confirm the mode, Swiss industrial print or tactical telemetry, and check it is committed, not mixed.
2. **Read the typography.** Check the macro type (heavy uppercase grotesque, massive scale, tight tracking, compressed leading) against the micro type (small uppercase monospace, generous tracking). Flag any friendly geometric body face or any soft, smoothed treatment.
3. **Read the colour and substrate.** Confirm one committed substrate, one ink, and the single hazard-red accent used structurally. Flag any gradient, soft shadow, glow, or translucency, and any mixing of light and dark substrates.
4. **Read the layout and structure.** Confirm a visible grid, solid borders or the gap:1px dividers, bimodal density, and ninety-degree corners. Flag any `border-radius`, any floating centred card, any soft web padding hiding the structure.
5. **Read the interactions and the accessibility floor.** Confirm instant hard states and no easing. Flag any eased fade or spring. Confirm a visible hard focus outline and a readable contrast; a missing focus state or an unreadable density is a defect, not a style choice.
6. **Run the commercial-default leaks and write the verdict.** Assemble the per-dimension reads, flag every commercial default that crept in with its raw fix, and set a verdict (Brutal, Diluted, or Wrong lens) with the single highest-impact move.
7. **Verify before emitting.** Confirm every flagged leak is actually present, every fix is a concrete raw move (square the corner, remove the shadow, snap the hover), the mode is judged as committed or mixed, and brutalist was confirmed as the right call. Mark a deliberate brand exception kept (the playbook wins). Only then emit.

## Worked example

The spec as the source skill returned it, the shape a consult answer should take.

```
DESIGN BRUTALIST REVIEW
Artifact: design studio portfolio   Mode: Tactical telemetry (intended), not committed   Audience: prospective clients   Reviewed: 2026-06-24   Run mode: Careful

Right lens: Yes, a studio portfolio can carry a raw, confident, anti-corporate voice.

Verdict: Diluted   Highest-impact move: strip the gradient, shadows, and rounded corners; commit to one dark substrate with square compartments.

Brutalist reads:
- Typography: Diluted  a friendly geometric body sans undercuts the heavy uppercase headers.
- Colour and substrate: Diluted  a purple-to-blue gradient hero and a mid-page light section break the single-substrate rule.
- Layout and structure: Off  rounded cards with soft drop shadows, floating and centered, no visible grid.
- Interactions and accessibility: Diluted  buttons fade on hover over 300ms; focus outline is present but faint.

Commercial defaults leaking in (with the raw fix):
- Rounded corners on cards -> square every corner, no border-radius.
- Soft drop shadows -> remove; delineate with 1px solid borders or gap:1px dividers.
- Purple-to-blue gradient hero -> a flat dark substrate (#0A0A0A) with hazard-red structural accents.
- 300ms hover fade -> instant invert or block fill on hover, no transition.
- Friendly geometric body sans -> uppercase monospace for metadata, a heavy grotesque for headers.
- Mixed light section -> commit to the dark tactical substrate throughout.

Accessibility floor:
- Focus is present but faint; replace with a hard 2px red outline. Contrast on the dark substrate is acceptable.

Kept by the playbook (deliberate, not a leak):
- The studio wordmark set in the brand's licensed grotesque (locked in the brand system).
```

## Guardrails

- Never force brutalist onto a brand that needs trust, safety, or universal accessibility. Name the mismatch and route it; a bank in brutalist reads unstable, not bold.
- Never confuse brutalist with broken or lazy. A real brutalist site is exacting and controlled; the rawness is deliberate, every refusal chosen on purpose.
- Never let the raw look break the accessibility floor. A visible hard focus state and readable contrast are mandatory; rawness is no excuse for a keyboard trap.
- Never flag a deliberate brand exception as a leak. Mark it kept; the brand playbook is the authority over these defaults.
- Never invent an element the design does not have, or a fix you cannot justify as genuinely raw.
- No AI-slop in the review: no "make it edgier", no filler, no emoji. Named defaults, concrete raw fixes.
- If a project playbook exists (a chosen mode, a brand exception, a register direction), it is the authority. Follow it over these defaults.

## Pairings and boundaries

- Pair with `crew-design-authority` as the opposite pole: authority is for brands that must read established and trusted, brutalist is for brands that must read raw and uncommercial. When the right-lens check fails for brutalist, route to authority, and vice versa.
- Pull the committed substrate, ink, and accent into `crew-design-language` so the brutalist palette and the monospace and grotesque type are defined once as tokens.
- Pull a brutalist or editorial reference from `crew-design-reference` when a fix needs a concrete north star.

## Verification

Before the run is marked done, confirm:

```
[ ] Brutalist was confirmed as the right call; a trust-critical or accessibility-first brief was routed elsewhere
[ ] The mode (Swiss industrial print or tactical telemetry) was identified and judged committed or mixed
[ ] Typography read for the heavy uppercase macro and small uppercase monospace, with any friendly face flagged
[ ] Colour read for one substrate, one ink, one accent, with any gradient, shadow, glow, or translucency flagged
[ ] Layout read for the visible grid, solid or gap:1px dividers, and ninety-degree corners, with any radius flagged
[ ] Interactions read for instant hard states, with any easing or fade flagged
[ ] The accessibility floor was checked: a visible hard focus state and readable contrast
[ ] Every commercial-default leak has a concrete raw fix, not "make it edgier"
[ ] A deliberate brand exception is marked kept; the playbook won over the defaults
[ ] A Brutal / Diluted / Wrong lens verdict with the single highest-impact move
```
