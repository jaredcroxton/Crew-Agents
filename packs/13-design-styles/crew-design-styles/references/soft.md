# Soft spec (consulted via crew-design-styles)

The soft lens judges whether a design feels warm and human or has failed toward one of two poles, cold and hard-edged or so sweet it reads as a toy; this spec covers the warm rounded system (generous radii, diffused light, warm neutrals, spring motion, soft imagery) and whether soft is the right register for the brand at all.

## What a review needs

You need:

- The artifact under review: a built page, a screenshot, a code block, or a description of the design.
- The audience and category: who the brand is for and what it sells, because soft fits a human-centred register and fights an authoritative or urgent one.
- The register goal: that the brand genuinely wants to read warm, approachable, and human, not that it is using roundness to look friendly while underneath it is a serious or high-stakes product.

If no artifact is supplied, or the register goal is unclear, ask once what is being built and how it should feel. Never invent a design to review, never assume soft is the goal, and never judge warmth on something you cannot see.

## How the soft designer thinks

1. **Warmth is the goal.** Soft design makes an interface feel human and approachable, made by people for people, not a cold machine. Every choice softens an edge the default would leave sharp.
2. **Round the corners, diffuse the light.** Generous radii (squircles, not sharp ninety-degree corners), soft, highly diffused shadows (never a harsh dark drop), gentle warm gradients. The light feels ambient, like a room, not a spotlight.
3. **Warm neutrals, never pure.** No pure black and no pure white. A warm off-white and a soft charcoal, low-saturation pastels and muted warm tones. The palette feels like paper and skin, not screen.
4. **Motion has mass and spring.** Nothing snaps. Gentle spring physics, slow eases, a heavy fade-up. Soft motion settles like a held breath, never a hard click.
5. **Space is generous and unhurried.** Macro-whitespace, components that float and breathe, no cramped hard grid. The pace is calm and welcoming.
6. **Warm is not the same as sweet.** The failure mode is saccharine: too round, too pastel, too bouncy, infantilising. Soft must stay credible and grown-up; the fix for sweet is to mature the warmth, not remove it. And soft is the wrong register when a brand needs authority, urgency, or a raw edge.

## Soft typography

Type carries warmth through rounded forms, comfortable spacing, and a human voice.

- **Rounded, humanist faces.** A humanist or soft grotesque sans (Plus Jakarta Sans, Geist, a rounded grotesque), or a gently rounded display for headings. The forms have a little roundness and warmth, not the cold mechanical precision of a tight grotesque, and not the generic defaults (Inter, Roboto, Arial, Helvetica).
- **Generous line-height and comfortable tracking.** Body line-height around `1.6` or more, tracking neutral to slightly open, so the text feels relaxed, never cramped.
- **Medium weights, not extremes.** Soft avoids the heavy-black shout and the hairline whisper. Regular and medium weights read warm and steady.
- **A human voice in the casing.** Sentence case over aggressive all-uppercase. Uppercase, if used, is a tiny tracked eyebrow label, not a shouting headline.
- **Off-black text, never pure black.** A soft charcoal on a warm ground keeps even the type from feeling harsh.

## Soft colour

Colour is warm, low in saturation, and never pure. The palette should feel sun-warmed.

```
CANVAS / BACKGROUND: warm cream #FDFBF7, warm off-white, or a soft silver-grey. Never pure #FFFFFF.
TEXT:                soft charcoal (#2F2B28 to #3A3A38). Never pure #000000.
NEUTRALS:            warm greys, taupes, and bones; the warmth is in the neutral, not just the accent.
ACCENTS (muted):     low-saturation warm tones, used gently:
  Blush, terracotta, butter, sage, dusty blue, clay. Desaturated, never candy-bright or fluoro.
GRADIENTS:           soft, warm, low-contrast only (a gentle cream-to-blush wash), never a hard or fluoro gradient.
```

Rules: a warm neutral base, off-black not pure black, off-white not pure white. Pastels and muted warm tones, kept desaturated so they read calm rather than candy. One warm accent does most of the colour work. A gentle warm gradient is allowed (unlike the raw and minimal registers), but it stays soft and low-contrast. Bright, saturated, or fluoro colour breaks the warmth.

## Soft layout

The layout floats, breathes, and rounds every edge.

- **Generous radii everywhere.** Squircles and large corner radii on cards and containers (`1.5rem` to `2rem`), pills for buttons and tags. A sharp ninety-degree corner reads cold and breaks the register.
- **Concentric, tactile nesting.** A card can sit in a soft outer shell with its own hairline and a slightly larger radius, the inner core a mathematically smaller radius, so curves stay concentric and the element feels like a soft physical object, not a flat rectangle.
- **Soft, diffused shadows.** Large-blur, low-opacity ambient shadows that read like soft daylight, never a harsh dark drop (`rgba(0,0,0,0.3)` and `shadow-md`-style hard shadows are banned). Depth comes from soft light, not hard edges, and not a hard `1px solid gray` border.
- **Macro-whitespace and floating components.** Double the standard section padding; let components float with air around them rather than packing them into a rigid hard grid.
- **Organic structure over the Bootstrap grid.** Asymmetric bento, gentle overlaps, a slight rotation, varied card sizes. The structure feels arranged by a human hand, not stamped from a symmetrical three-column template. Mobile collapses gracefully to a single warm column.

## Soft motion

Motion is the warmth expressed in time. Nothing is abrupt.

- **Gentle spring and long eases.** Custom soft cubic-beziers (for example `cubic-bezier(0.32, 0.72, 0, 1)`) over slow durations (`500ms` to `800ms`). Default `linear` and `ease-in-out`, and instant state changes with no interpolation, are banned; they read mechanical.
- **Heavy fade-up on entry.** Elements enter with a gentle, weighted fade-up (a small translate, a touch of blur, resolving over `800ms`), never appearing statically and never snapping in. Use IntersectionObserver-style triggers, not a scroll listener.
- **Soft press and magnetic hover.** A press scales down slightly (`scale(0.98)`) like a soft physical button; hover moves with a little kinetic give, not a hard colour flip.
- **Stagger, do not dump.** Lists and grids cascade in with a gentle stagger, so the page assembles calmly.
- **The bounce ceiling.** Spring is warm; too much bounce is saccharine. Keep the overshoot subtle. A big cartoon bounce on every element tips soft into childish.

## Soft imagery

In a warm palette, imagery holds the warmth and the humanity.

- **Warm, soft-light photography.** Warm-graded images with gentle, diffused light and soft contrast. No harsh high-contrast, no hard clinical lighting, no deep black shadows. People, hands, natural light, real moments.
- **Organic shapes.** Soft blobs, rounded forms, gentle curves as background and framing. Rounded image corners, not hard rectangles. Organic, not geometric and sharp.
- **Warm texture.** A subtle warm grain or a paper feel at very low opacity to keep the surface from feeling cold and digital.
- **The cartoon ceiling.** Soft illustration is allowed, but rounded blob-people and bright cartoon mascots are the fast road to saccharine. Prefer real, warm photography; if illustration is used, keep it restrained and grown-up. No emoji.

## When to use soft

Soft earns its place when the category is cold or intimidating by default and warmth is the way to earn trust and approach.

- Health, wellness, mental health, and care, where a clinical default frightens people and warmth reassures them.
- Consumer and lifestyle brands, hospitality, food, and community, where approachable is the point.
- Education and family products, where welcoming and human builds comfort.
- Human-centred fintech and productivity, where softening a cold or stressful category is the differentiation.
- The warmth play: a brand in a category that everyone else makes feel sterile or stressful, where feeling human is the edge.

Do not use this spec for a brand that must read authoritative and serious (a bank, a law firm, route to `crew-design-authority`), for a product that needs urgency or a hard conversion edge, for a tough, raw, or technical brand (that is `crew-design-brutalist`), or to score broad visual quality regardless of style. Soft is wrong where the brand must read serious, fast, or tough; name the mismatch rather than rounding the corners on a register that needs edges.

## When NOT to use soft

The two off-ramps. Soft fails by being too hard (cold) or too sweet (saccharine), and it is the wrong register entirely for some brands.

- **Saccharine: too much sugar.** When the roundness, pastels, and bounce tip into childish or twee, an adult product reads like a toy and loses credibility. A serious financial, medical, or professional product cannot afford to look like a kids app. The fix is to mature the warmth (less bounce, desaturated tones, more weight, real photography over cartoon blobs), not to strip it out.
- **Wrong register.** A brand that must read authoritative, established, or high-stakes (banking, law, enterprise security) needs gravity, not roundness; route to `crew-design-authority`. A product that needs urgency or a hard conversion edge, or a tough, raw, technical brand, is fighting soft, not served by it.
- **Accessibility floor.** Soft low-contrast pastels and thin warm greys can fall below a readable contrast. Warmth is no excuse for an unreadable interface; the contrast floor holds.

The saccharine line: soft fails when warmth becomes sweetness and approachable becomes infantile. The fix is almost never to remove the warmth; it is to mature it, keep the soft language but add weight, restraint, and real substance so it reads warm and credible, not sweet.

## Application rules

The checklist a build embeds when the goal is soft. The warmth is the contract.

```
[ ] Warmth without sugar: rounded and warm, but credible and grown-up, not childish or twee.
[ ] Warm neutral base, no pure black or pure white; low-saturation pastels and muted warm tones, one warm accent.
[ ] Generous radii (squircles, pills), soft highly-diffused shadows; no harsh dark drops, no hard 1px gray borders.
[ ] Rounded humanist or soft grotesque type, generous line-height, medium weights, sentence case over aggressive uppercase.
[ ] Gentle spring motion, soft long eases, a heavy fade-up; nothing linear, instant, or snappy, and no big cartoon bounce.
[ ] Warm, soft-light photography and organic shapes; no harsh high-contrast or clinical imagery; no emoji.
[ ] Macro-whitespace and floating components; organic spacing, not a rigid hard grid.
[ ] Soft is the right call; an authority, urgency, or raw-edge brief is sent to the register that fits it.
[ ] Pastels and warm greys still meet a readable contrast floor.
```

## Review workflow

1. **Confirm soft is the right call.** State the register goal and the audience. If the brand must read authoritative, urgent, or tough, say so now, route it (`crew-design-authority` for gravity), and do not soften a register that needs edges. If soft fits, proceed.
2. **Read the typography.** Check for rounded humanist or soft grotesque faces, generous line-height, medium weights, sentence case, and off-black text. Flag any cold tight grotesque, condensed face, aggressive uppercase, or pure-black text, and flag any childish bubble font on the saccharine side.
3. **Read the colour.** Confirm a warm neutral base, no pure black or white, and desaturated pastels or muted warm tones. Flag any harsh pure black or white, any fluoro or candy-bright colour, and any hard gradient. On the saccharine side, flag oversweet candy pastels.
4. **Read the layout.** Confirm generous radii, soft diffused shadows, macro-whitespace, and organic floating structure. Flag sharp ninety-degree corners, harsh dark drop shadows, hard 1px grey borders, and rigid cramped grids.
5. **Read the motion, imagery, and the saccharine and contrast floors.** Confirm gentle spring motion, warm soft-light imagery, and organic shapes. Flag any linear or instant motion and any harsh clinical imagery on the cold side, and any big cartoon bounce or blob-mascot imagery on the saccharine side. Check that pastels and greys still meet a readable contrast.
6. **Run both leak lists and write the verdict.** Flag the hard or cold elements to soften and the saccharine excess to mature, and set a verdict (Warm, Cold, or Saccharine) with the single highest-impact move.
7. **Verify before emitting.** Confirm every flagged element is present, every fix is concrete (round this corner, diffuse this shadow, desaturate this pastel, calm this bounce), and the warm-versus-cold-versus-saccharine call is honest. Mark a deliberate brand exception kept (the playbook wins). Only then emit.

## Worked example

The spec as the source skill returned it, the shape a consult answer should take.

```
DESIGN SOFT REVIEW
Artifact: wellness app landing page   Audience: people managing stress and sleep   Reviewed: 2026-06-24   Mode: Careful

Right lens: Yes, a wellness product should feel warm and reassuring, not clinical.

Verdict: Cold   Highest-impact move: round the corners, diffuse the shadows, and warm the neutrals so the page stops reading clinical.

Soft reads:
- Typography: Cold  a condensed bold uppercase headline on pure-black body text, mechanical and shouty.
- Colour: Cold  pure black on pure white, no warmth in the neutrals.
- Layout: Cold  sharp ninety-degree cards with harsh dark drop shadows.
- Motion and imagery: Cold  instant snap hover states and high-contrast clinical photography.

Hard or cold spots (to soften):
- Sharp ninety-degree card corners -> generous squircle radii (1.5rem to 2rem).
- Harsh dark drop shadows -> soft, large-blur, low-opacity ambient shadows.
- Pure black on pure white -> soft charcoal on a warm cream (#FDFBF7).
- Condensed bold uppercase headline -> a rounded humanist sans in sentence case, medium weight.
- Instant snap hover -> a gentle spring with a slow ease and a soft press.
- High-contrast clinical photography -> warm-graded, soft-light images of real, calm moments.

Saccharine excess (to mature):
- None; the page is cold, not sweet. Add warmth without tipping into candy or cartoon.

Accessibility floor:
- Contrast is currently fine; keep the warmed neutrals above a readable ratio when softening.

Kept by the playbook (deliberate, not a flaw):
- The brand's warm coral accent (locked in the brand system).
```

## Guardrails

- Never let warmth tip into sugar. If a design reads childish or twee, mature the warmth (less bounce, desaturated tones, more weight, real photography), do not strip it out.
- Never soften a register that needs edges. A brand that must read authoritative, urgent, or tough is not served by rounded corners and pastels; name the mismatch and route it.
- Never trade legibility for warmth. Soft pastels and warm greys must still meet a readable contrast; warmth is no excuse for an unreadable interface.
- Never flag a deliberate brand exception as cold or saccharine. Mark it kept; the brand playbook is the authority over these defaults.
- Never invent an element the design does not have, or a fix you cannot justify as genuinely warming or maturing.
- No AI-slop in the review, and no emoji recommended into the design: no filler, plain specific language, real warm photography over cartoon clutter.
- If a project playbook exists (a chosen warm palette, a rounded type system, a register direction), it is the authority. Follow it over these defaults.

## Pairings and boundaries

- Pair with `crew-design-brutalist` and `crew-design-minimalist` as the three style poles: brutalist is raw, minimalist is reduced, soft is warm. Each rejects the generic SaaS default in its own direction.
- Pair with `crew-design-authority` as the opposite pull: when the right-lens check fails for soft because the brand needs gravity, route to authority, and when an authority brand reads too stiff for a human audience, soft is the warmer answer.
- Pull the warm palette and the rounded type system into `crew-design-language` so they are defined once as tokens.
- Pull a warm or consumer reference from `crew-design-reference` when a fix needs a concrete north star.

## Verification

Before the run is marked done, confirm:

```
[ ] Soft was confirmed as the right call; an authority, urgency, or raw-edge brief was routed elsewhere
[ ] Typography read for rounded humanist or soft grotesque faces, generous line-height, sentence case, off-black text
[ ] Colour read for a warm neutral base, no pure black or white, desaturated pastels, with fluoro or candy flagged
[ ] Layout read for generous radii, soft diffused shadows, macro-whitespace, with sharp corners and harsh shadows flagged
[ ] Motion read for gentle spring and long eases, with linear, instant, or big cartoon bounce flagged
[ ] Imagery read for warm soft-light photography and organic shapes, with clinical or cartoon imagery flagged
[ ] Both lists are concrete: cold spots to soften and saccharine excess to mature, each with a specific move
[ ] The accessibility floor was checked: pastels and warm greys stay readable
[ ] A Warm / Cold / Saccharine verdict with the single highest-impact move
[ ] A deliberate brand exception is marked kept; the playbook won over the defaults
```
