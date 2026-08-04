# Authority spec (consulted via crew-design-reference)

The authority lens judges whether a design reads established and trustworthy or whether it reads like it launched last quarter; this spec covers the register a bank, a law firm, a luxury house, or an enterprise platform needs, reading a design the way a sceptical buyer does and naming the establishing swap for each element that undercuts credibility.

## When to use authority

Do not use this spec when the brief genuinely wants to read as a fresh modern startup (use `crew-design-quality` and `crew-design-patterns` for that register), for a playful consumer brand, or for an internal tool where trust is assumed. Authority is the wrong lens for a product that should feel young and energetic; gravity would make it read stiff and old. Name that mismatch rather than forcing serifs and navy onto a brand that needs lift.

## What a review needs

You need:

- The artifact under review: a built page, a screenshot, a code block, or a description of the design.
- The register goal: whether the brand must read established, institutional, or luxury (authority), and the audience (a regulator, a board, a high-net-worth client, an enterprise buyer).
- The brand or playbook if one exists, because a deliberate house style is the authority.

If no artifact is supplied, or the register goal is unclear, ask once what is being built and who must trust it. Never invent a design to review, and never assume authority is the goal; if the brand should read young and energetic, that is a different lens, and you say so before reviewing.

## How the authority reviewer thinks

1. **Established beats fresh.** The goal is to look permanent, not new. A trend carries a production-era timestamp (a mesh gradient, a particular spring easing, the font of the moment), so it dates the instant the technique does; institutional cues (a serif, a crest, a strict grid) carry no timestamp, so they hold for a decade. Authority does not chase the timestamp.
2. **Restraint signals confidence.** The most powerful brands say the least. Whitespace, few elements, one accent, no decoration. A page that tries hard reads insecure; a page that holds back reads in command.
3. **Structure signals control.** Strict alignment, a visible grid, symmetry where it earns calm. Order is the message: this organisation is in command of its own details, so it can be trusted with yours.
4. **Gravity over energy.** Deep muted tones, a serious typeface, slow deliberate pacing. Authority is heavy and still, not bright and bouncy. Stillness reads as gravitas.
5. **Real over rendered.** Real photography of real people, buildings, and materials, not illustration and not AI imagery. Credibility cannot be faked with a gradient, and a sceptical premium audience reads the fake.
6. **The audience is sceptical.** A board, a regulator, a high-net-worth client reads design for risk. Anything cheap, trendy, or templated is a reason to doubt. Authority design is the removal of reasons to doubt, one element at a time.

## Authority typography

Type is the loudest signal of whether a brand reads institutional or interchangeable.

- **Serif as a trust signal.** A considered serif (a transitional or old-style face, a refined display serif for luxury, or a sturdy slab for an institution) reads established and typeset. The geometric sans every startup uses reads interchangeable. A serif headline over a clean sans body is the classic institutional pairing.
- **When sans, make it serious.** The tell is a rounded or humanist geometric set loose and large (Inter and the rounded geometrics at a big friendly size). The fix is a grotesque with weight and history (the Helvetica lineage), or the same neutral sans set tight, dense, and document-like. The geometric-versus-grotesque distinction and the typesetting are the real signal, not the typeface name alone; a correctly set neutral sans can read serious, while any face set loose and playful reads startup.
- **Weight with restraint.** Authority type is rarely heavy-black and rarely hairline-thin. Regular and medium weights, hierarchy by scale and space rather than by shouting, generous tracking on small caps and labels. A screaming black headline reads aggressive, not authoritative.
- **Set type like a document, not a billboard.** A real measure (60 to 75 characters), proper leading, a clean ragged or justified column, small caps for labels, real punctuation. The page should read as typeset, because typesetting signals care and permanence.
- **The details a sceptic notices.** Consistent figure style (old-style or lining, not mixed), no widow in a headline, true quotation marks. Small correctness compounds into trust.

## Authority colour

- **Deep and muted, not bright.** Navy, oxblood, forest, charcoal, ink, bottle green, deep burgundy, slate. Establishment colour is dark, desaturated, and limited. Bright saturated accents read consumer and cheap in this register.
- **One restrained accent, used rarely.** A single accent (often gold, a deep red, or a muted blue) on a neutral or dark base, deployed on almost nothing, so when it appears it carries weight. The 60-30-10 split holds, but the 10 is even smaller here than usual.
- **Neutrals do the work, and the temperature is a register choice.** Warm-heritage authority leans on warm off-whites (ivory, bone, cream) and deep neutrals (charcoal, ink). Cold-modernist luxury (a fashion house, a gallery) does the opposite on purpose, true black on true white as a severity signal. The cheap tell is not the values themselves, it is a default `#000000` on `#ffffff` with no type or spacing craft behind it. Pick warm-heritage or cold-severe and commit; do not drift between them.
- **No gradients, no glow.** Flat, solid fields. A gradient, and especially the AI purple-and-blue glow, instantly drops authority. If depth is needed, use a hairline rule or a restrained tint, never a glow.

## Authority layout

- **Structure over asymmetry.** Where a modern SaaS site reaches for tension and a broken grid, authority reaches for symmetry, a centred serif masthead, a strict column grid, deliberate alignment. This is the one place authority deliberately inverts the fresh-design preference for asymmetry: order is the point.
- **Order over surprise.** Predictable, navigable, hierarchical. The reader should never feel the page is performing for them. Calm, not clever.
- **Generous, even margins.** Wide, symmetric margins and a consistent vertical rhythm. Crowding reads anxious; even, deliberate space reads composed and in control.
- **The masthead and the mark.** A confident wordmark or a crest, centred or top-left, treated with reverence. Established institutions wear their mark like a coat of arms, not a casual logo dropped in a nav.
- **Restraint in motion.** Little to no animation. If motion is used, slow and subtle (a quiet fade, a measured reveal). Bouncy spring physics and playful micro-interactions read startup; stillness reads gravitas.

## Authority imagery

- **Photography, not illustration.** Real photography of real people, buildings, materials, and craft. Illustration, and especially flat-vector or corporate-memphis blobs, reads consumer-tech and undercuts credibility. A firm shows its partners and its building, not a cartoon.
- **Real, not generated.** AI-generated imagery, even good AI imagery, carries a tell a sceptical premium audience increasingly reads. For anything that must be trusted (a real firm, real people, a real product), use real photography, and never present generated imagery as real.
- **Considered art direction.** A muted, consistent grade and a single photographic style across the property. A few owned, well-directed images beat a pile of mismatched stock with smiling-handshake cliches.
- **Material and texture.** Paper, stone, metal, leather, archival texture. Tactile, physical references signal permanence and craft, the opposite of the weightless digital-gradient look.

## The anti-SaaS playbook

What to avoid when authority is the goal, with the establishing swap. This is the deliberate inversion of the usual modern-design advice. Flag any of these unless the brand playbook calls for it.

```
The startup geometric sans (Inter, rounded geometrics)        -> a serif, or a serious grotesque with history.
A bright saturated accent or an AI gradient glow              -> one deep muted accent on a warm neutral, used rarely.
A centered playful hero with an oversized friendly headline   -> a structured serif masthead, hierarchy by space, not size.
Asymmetric broken grids and editorial tension                -> strict symmetry and a visible column grid.
Flat-vector or corporate-memphis blob illustration           -> real photography of real people and places.
AI-generated hero imagery                                     -> owned, art-directed photography, never faked as real.
Bouncy spring micro-interactions and playful motion          -> stillness, or one slow measured reveal.
Emoji, exclamation marks, and a casual "hey there" voice      -> a measured, precise, formal register.
A pile of trendy effects (glass, mesh, fluoro, 3D blobs)     -> flat solid fields, hairline rules, deep restraint.
Default #000 on #fff with no craft                           -> a committed temperature (warm off-white and near-black, or true black and white set with real type and spacing craft).
```

Authority is not the same as dull. The aim is gravity and craft, not a grey corporate template. The most authoritative brands are exacting and beautiful; they are simply never trendy.

## Application rules

The checklist a build embeds when the goal is to read established. The authority register is the contract.

```
[ ] Type reads established (a serif or a serious grotesque), not the startup geometric default.
[ ] One deep muted accent on a warm neutral base; no bright saturation, no gradient glow.
[ ] Layout is structured and aligned (symmetry, a column grid), not asymmetric tension.
[ ] Imagery is real photography, art-directed and consistent; no illustration-blobs, no AI imagery faked as real.
[ ] Motion is minimal and slow; no bouncy micro-interactions.
[ ] Copy register is measured and formal; no emoji, no casual voice.
[ ] Nothing on the anti-SaaS playbook ships when the goal is to look established.
[ ] Authority is confirmed as the right lens; a young energetic brand is sent to the fresh register instead.
```

## Review workflow

1. **Confirm the register before reviewing.** State the register goal and the audience, and pick one of three: old-world authority, modern-establishment, or fresh. If the brand should read young, playful, or energetic, say so now, recommend the fresh register (`crew-design-quality`, `crew-design-patterns`), and do not force gravity onto it. If the brand is established but contemporary (a top consultancy, a modern fintech that must look trustworthy and current), do not reach for full old-world gravity (a serif masthead, a crest, near-zero motion); set the modern-establishment dial instead, a serious grotesque over a serif, one restrained accent, structure without a crest, minimal but present motion. Only run the full old-world sweep when that is genuinely the goal.
2. **Sweep the authority dimensions.** Check the design against Authority typography, colour, layout, and imagery. For each element, decide whether it establishes authority, is neutral, or undercuts it.
3. **Run the anti-SaaS playbook.** Flag every element that matches a playbook entry, unless the brand playbook deliberately calls for it (mark those kept).
4. **Mark and explain.** For each undercutting element, name why it reads cheap, trendy, or startup, so the read is specific, not "it looks unprofessional".
5. **Name the establishing swap.** For every element that undercuts authority, give the concrete establishing replacement (the serif, the deep accent, the real photograph, the stillness).
6. **Write the review and the verdict.** Assemble the per-dimension reads, the flagged elements with swaps, and a verdict (Commands authority, Credible, or Reads startup) with the single highest-impact establishing move.
7. **Verify before emitting.** Confirm every flagged element is actually in the design, every swap genuinely raises authority (not just changes the look), and a deliberate brand choice was marked kept, not flagged (the playbook wins). Confirm authority was the right lens to apply. Where a call needs the owner, mark it Escalated. Only then emit.

## Worked example

The spec as the source skill returned it, the shape a consult answer should take.

```
DESIGN AUTHORITY REVIEW
Artifact: law firm homepage   Register goal: institutional   Audience: corporate clients and general counsel   Reviewed: 2026-06-24   Mode: Careful

Right lens: Yes, a law firm must read established and trustworthy.

Verdict: Reads startup   Highest-impact move: replace the rounded geometric sans and the teal gradient with a serif and a deep muted accent.

Authority reads:
- Typography: Undercuts  a rounded geometric sans (the startup default) on a centered playful hero.
- Colour: Undercuts  a bright teal accent with a subtle gradient glow, reads consumer-tech.
- Layout: Undercuts  a centered playful hero with an oversized friendly headline, no structural grid.
- Imagery: Undercuts  flat-vector illustrations of lawyers instead of photographs of the actual firm.

Undercuts authority (with the establishing swap):
- Rounded geometric sans (reads startup) -> a transitional serif headline over a clean sans body.
- Teal gradient accent (reads consumer) -> one deep muted accent (navy or oxblood) on a warm off-white, used rarely.
- Centered playful hero (reads startup) -> a structured serif masthead, symmetric, hierarchy by space.
- Vector illustration (reads cartoon) -> art-directed photography of the partners and the building.
- Bouncy card hovers and emoji headers (read casual) -> stillness and a measured, formal register.

Kept by the playbook (deliberate, not a flaw):
- The firm's heritage crest in the masthead (locked in the brand system).
```

## Guardrails

- Never force authority onto a brand that should read young and energetic. Name the mismatch and send it to the fresh register; gravity on the wrong brand reads stiff and dated.
- Never confuse authority with dull. The aim is gravity and craft, not a grey corporate template. The most authoritative brands are exacting and beautiful, never trendy.
- Never flag a deliberate brand or heritage choice as a mistake. Mark it kept; the brand playbook is the authority over these defaults.
- Never recommend AI-generated imagery for a brand that must be trusted, and never present generated imagery as real. Real photography is the credibility floor.
- Never invent an element the design does not have, or a swap you cannot justify as genuinely raising authority.
- No AI-slop in the review: no "make it more professional", no filler, no emoji. Named elements, concrete establishing swaps.
- If a project playbook exists (a brand system, a heritage mark, a register direction), it is the authority. Follow it over these defaults.

## Pairings and boundaries

- Pair with `crew-design-quality` (broad dimensional sweep) and `crew-design-patterns` (pattern currency); this spec judges the authority register specifically, and deliberately inverts the fresh-design preference for bold accents and asymmetry. Use it instead of, not alongside, the fresh register when the goal is to look established.
- Pull the deep, muted token set from `crew-design-language` so the authority palette and serif type are defined once and reused.
- Pull an establishment reference from `crew-design-reference` (Aesop, Saint Laurent, Rolex, a heritage institution) when a swap needs a concrete north star.

## Verification

Before the run is marked done, confirm:

```
[ ] Authority was confirmed as the right lens; a young energetic brand was sent to the fresh register instead
[ ] The register goal and the audience were stated
[ ] Typography, colour, layout, and imagery were each marked establishes, neutral, or undercuts
[ ] Every undercutting element was checked against the anti-SaaS playbook and named specifically
[ ] Every undercutting element has a concrete establishing swap, not just a flag
[ ] A deliberate brand or heritage choice is marked kept; the playbook won over the defaults
[ ] No invented element, and no swap that merely changes the look without raising authority
[ ] No AI-generated imagery recommended for a brand that must be trusted
[ ] A Commands authority / Credible / Reads startup verdict with the single highest-impact move
```
