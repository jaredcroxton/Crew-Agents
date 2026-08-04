# Minimalist spec (consulted via crew-design-styles)

The minimalist lens judges whether a design is genuinely reduced and considered or has failed in one of two directions, cluttered with elements that earn nothing or hollowed out into a barren white void; this spec covers the reduction discipline, the warm monochrome system, restrained editorial type, and whether the content is strong enough to carry reduction at all.

## What a review needs

You need:

- The artifact under review: a built page, a screenshot, a code block, or a description of the design.
- The content: what the page actually has to say or show, because minimalism only works when the content can carry the page without decoration.
- The register goal: that the brand genuinely wants to read calm, premium, and editorial, not that it is using whitespace to hide a thin offering.

If no artifact is supplied, or it is unclear what the content is, ask once for the design and what it must communicate. Never invent a design to review, never assume minimalism is the goal, and never judge reduction on something you cannot see.

## How the minimalist designer thinks

1. **Reduction is the method.** Every element earns its place or gets cut. Minimalism is not adding less; it is removing until only what carries meaning remains.
2. **Whitespace is the material.** Generous space is the primary tool, not the leftover. Macro-whitespace (massive section padding, a constrained content width) signals confidence and gives the eye rest.
3. **One thing leads.** A single focal point per view, a single accent, one constrained column of attention. When everything is quiet, the one element that speaks is heard.
4. **Restraint, not absence.** A minimal page is full of considered decisions, just not of elements. A barren page is the failure mode: whitespace that became emptiness, "clean" that became "nothing here".
5. **Type and space do the work ornament does elsewhere.** Contrast of weight and scale, a serif against a clean sans, tight tracking on a heading. No gradient, no heavy shadow, no rounded-pill flourish is needed to make it feel finished.
6. **Quiet is a choice, not a default.** Minimalism is exacting, harder than decoration because there is nothing to hide behind. It is the wrong call when the content needs density or warmth; reduction then starves the page rather than refining it.

## Minimalist typography

Type carries the editorial feel through contrast, not quantity. One or two faces, never more.

- **Editorial serif for hero headings and quotes.** A refined serif (Lyon Text, Newsreader, Playfair Display, Instrument Serif) with tight tracking (`-0.02em` to `-0.04em`) and tight leading (`1.1`). The serif moment is where the warmth and the editorial signal live.
- **A clean sans with character for body and UI.** A geometric or system-native sans (SF Pro, Geist Sans, Helvetica Neue, Switzer), not the generic defaults. Inter, Roboto, and Open Sans read as the unconsidered choice; minimalism needs a face chosen on purpose.
- **Monospace for metadata and code.** Geist Mono, SF Mono, JetBrains Mono, for shortcuts, meta, and code, used sparingly.
- **Hierarchy by weight and scale, not size alone.** Off-black body text (`#111111`, never pure `#000000`), a muted grey for secondary (`#787774`), a generous body line-height (`1.6`). The contrast between a large serif heading and small quiet body text is the whole hierarchy.

## Minimalist colour

Colour is a scarce resource, used only for meaning or a subtle accent. Warm monochrome carries the page.

```
CANVAS / BACKGROUND: pure white #FFFFFF, or warm bone #F7F6F3 / #FBFBFA.
SURFACES (cards):    #FFFFFF or #F9F9F8.
BORDERS / DIVIDERS:  ultra-light gray #EAEAEA or rgba(0,0,0,0.06).
ACCENTS (rare):      desaturated, washed-out pastels only, for a tag, an inline-code background, a subtle icon background.
  Pale red    #FDEBEC (text #9F2F2D)    Pale blue   #E1F3FE (text #1F6C9F)
  Pale green  #EDF3EC (text #346538)    Pale yellow #FBF3DB (text #956400)
```

Rules: a warm monochrome base, off-black not pure black, one accent at most and used on almost nothing. No gradient (beyond a barely-there warm radial at `opacity 0.03` for depth), no fluoro, no glassmorphism beyond a subtle navbar blur, and no bright primary-coloured backgrounds on large sections or hero areas. Colour is the exception, not the field.

## Minimalist layout

The layout is built from whitespace first, structure second.

- **Macro-whitespace before anything.** Massive vertical padding between sections, a constrained content width (about `max-w-4xl` to `max-w-5xl`), so the content breathes and the page reads composed, not cramped.
- **One focal point, one column of attention.** A single clear hero element per view; the eye is led, not scattered across equal-weight blocks.
- **Bento and cards, ultra-flat.** Asymmetric grids, cards with a `1px solid #EAEAEA` border, a crisp small radius (`8px` to `12px` maximum, never a pill on a large container or a primary button), generous internal padding (`24px` to `40px`), and practically no shadow (diffuse, under `0.05` opacity if present).
- **Strip the boxes where you can.** Accordions and lists separated by a `border-bottom: 1px solid #EAEAEA`, not wrapped in containers. A sharp `+` and `-` toggle, not a heavy chevron in a box.
- **Depth, not flatness.** Sections should not read empty and flat. Add quiet depth (full-width imagery at very low opacity, a soft warm radial light at `opacity 0.03`, a minimal line pattern) so reduction reads as considered, not as a blank page. This is the line between minimal and barren.

## Minimalist imagery

In a limited palette, photography is the colour and the warmth.

- **Photography carries the warmth.** Desaturated, warm-toned images, blended into the monochrome with a subtle grain overlay (`opacity 0.04`). The image is what keeps a near-monochrome page from going cold.
- **No illustration or icon clutter.** No thin-line icon libraries scattered across the page. If icons are needed, a heavier technical set (Phosphor Bold or Fill, Radix) with a standardised stroke, used sparingly. Illustration, if any, is monochromatic and restrained.
- **Real, contextual content.** No generic placeholder names (no "John Doe", no "Acme Corp", no "Lorem Ipsum"), no oversaturated stock. Real, specific content, or reliable placeholders only where a real asset is genuinely pending.
- **The image earns the warmth a limited palette withholds.** One strong, well-graded photograph does more for a minimal page than a grid of small decorative images.

## The reduction discipline

How to decide what stays, the core method other reviews lack.

- **Every element answers two questions:** what does this do, and what breaks if I remove it. If nothing breaks, cut it.
- **Remove before you shrink.** When a layout is crowded, take an element out rather than making everything smaller. Reduction, not compression.
- **Group and align before you add a divider.** Proximity and alignment do the separating work; a border is the last resort, not the first.
- **The budget.** One accent, one focal point, one or two faces. Anything past the budget must justify its place out loud, or it goes.
- **The one-purpose test.** Could a reader state the single thing this view is for. If not, there is too much (cut), or the hierarchy is flat (lead with one thing). A minimal page that fails this test is cluttered behind a clean surface.

## When to use minimalist

Minimalism earns its place when the content is strong enough to stand without decoration, and reduction lets it.

- Editorial sites, portfolios, and writing, where the words or the work are the point.
- Premium and luxury-adjacent products that read confident through restraint.
- Documentation and reference, where calm and clarity beat decoration.
- Workspace and productivity tools that want a quiet, document-like feel.
- The reduction play: a brand with real substance that wants to signal confidence by saying less.

Do not use this spec for a content-dense product that needs information density (a dashboard, a data tool, a marketplace), where reduction starves the content (use `crew-design-quality` or a density-led review), for a brand that should read warm, playful, or energetic, or to score broad visual quality regardless of style. Minimalism is a narrow register; name the mismatch rather than forcing reduction onto a page that needs substance.

## When NOT to use minimalist

The two off-ramps. Minimalism fails in opposite directions, and the first job is to catch the mismatch.

- **Too little content for the form.** Minimalism amplifies content; it cannot create it. A thin product behind a minimal layout reads empty and barren, not premium. If the page has little to say, the fix is substance, not whitespace.
- **Content that needs density.** A dashboard, a data tool, a marketplace, a catalogue, where information density is the job. Reduction starves these; route to a density-led layout, not a minimal one.
- **A brand that needs warmth, energy, or play.** Consumer, entertainment, kids, anything that should feel lively. Minimal reads cold and aloof for these.
- **Scannability or accessibility floors that a whisper cannot meet.** Muted grey on warm white everywhere can fall below a readable contrast; minimalism does not get to trade legibility for calm.

The barren line: minimalism fails when whitespace becomes emptiness and restraint becomes a lack of substance. The fix for barren is rarely more elements; it is more substance, more warmth (a photograph, a serif moment), or a clearer focal point, with a readable contrast restored.

## Application rules

The checklist a build embeds when the goal is minimalist. The reduction is the contract.

```
[ ] Reduction applied: every element earns its place; nothing decorative that adds no meaning.
[ ] Generous macro-whitespace, a constrained content width, one focal point per view.
[ ] Warm monochrome base, off-black not pure black, one muted accent at most; no gradient, no heavy shadow, no fluoro.
[ ] One or two typefaces; hierarchy by weight, scale, and a serif-against-sans contrast, not by ornament.
[ ] Crisp small radius (8 to 12px), 1px hairline borders, ultra-flat surfaces; no pill-shaped large containers.
[ ] Photography carries the warmth (desaturated, warm-toned); no illustration or thin-icon clutter; real content, no placeholders.
[ ] Sections have subtle depth (low-opacity imagery or light), not empty flat backgrounds; minimal, not barren.
[ ] Minimalist is the right call; a content-dense or warmth-led brief is sent to the register that fits it.
```

## Review workflow

1. **Confirm minimalist is the right call, and the content can carry it.** State the register goal and what the content actually is. If the content needs density (a data product) or the brand needs warmth and energy, say so now, route it, and do not force reduction. If the page has little to say, name that the real fix is substance, not whitespace. Only proceed when minimalism fits.
2. **Read the typography.** Check for one or two considered faces (an editorial serif against a clean sans, not Inter or Roboto), hierarchy by weight and scale, off-black not pure black, and a generous body line-height. Flag any third face, any generic default, any size-only hierarchy.
3. **Read the colour.** Confirm a warm monochrome base, one muted accent at most, and colour used only for meaning. Flag any gradient, fluoro, heavy shadow, bright primary section, or a second accent.
4. **Read the layout and whitespace.** Confirm macro-whitespace, a constrained content width, one focal point, crisp small radii, hairline borders, and ultra-flat surfaces. Flag cramped edge-to-edge content, pill-shaped large containers, heavy shadows, or equal-weight clutter with no focal point.
5. **Read the imagery and run the barren check.** Confirm photography carries the warmth and real content fills the page, and check that sections have quiet depth rather than empty flat backgrounds. Decide whether the page is minimal (considered) or barren (emptiness and low-contrast void), and whether contrast stays readable.
6. **Run the reduction discipline and write the verdict.** Apply the one-purpose test and the element budget, flag both the clutter to cut and the barren spots to fill, and set a verdict (Minimal, Cluttered, or Barren) with the single highest-impact move.
7. **Verify before emitting.** Confirm every flagged element is present, every fix is concrete (cut this element, restore the content width, add a focal photograph, raise the grey to a readable contrast), and the minimal-versus-barren call is honest. Mark a deliberate brand exception kept (the playbook wins). Only then emit.

## Worked example

The spec as the source skill returned it, the shape a consult answer should take.

```
DESIGN MINIMALIST REVIEW
Artifact: SaaS landing page   Content: a project-tracking tool, real feature set   Reviewed: 2026-06-24   Mode: Careful

Right lens: Yes, a premium productivity tool suits a calm, editorial, minimal register.

Verdict: Cluttered   Highest-impact move: cut to a warm monochrome base, one focal hero, and constrain the content width.

Minimalist reads:
- Typography: Generic  Inter for everything, hierarchy by size alone, no serif moment.
- Colour: Cluttered  a bright blue full-bleed hero and six pastel-iconed cards, colour everywhere.
- Layout and whitespace: Cluttered  edge-to-edge content, cramped padding, six equal cards, no focal point.
- Imagery and depth: Off  thin-line Lucide icons on every card, heavy drop shadows, no photography.

To cut (clutter that earns nothing):
- The bright blue hero background -> a warm bone canvas (#F7F6F3) with one serif headline.
- Heavy drop shadows on cards -> ultra-flat with a 1px #EAEAEA border.
- Thin-line icons on every card -> remove most; let the copy and one photograph carry the section.
- Pill-shaped CTA and emoji headers -> a crisp 6px-radius dark button; remove the emoji.

To add (barren spots that need substance):
- None; the page has plenty of content, the problem is clutter, not emptiness.

Accessibility floor:
- Body text is fine; the muted-gray captions are slightly light, raise toward #555 for readability.

Kept by the playbook (deliberate, not a flaw):
- The brand's licensed editorial serif in the wordmark (locked in the brand system).
```

## Guardrails

- Never confuse minimal with barren. Whitespace must be a material, not an absence; if a page reads empty, the fix is substance and warmth, not more whitespace.
- Never let reduction starve content that needs density. A data-heavy product is not improved by removing information; route it to a density-led layout instead.
- Never trade legibility for calm. Muted grey on warm white must still meet a readable contrast; a whisper that cannot be read is a defect, not restraint.
- Never flag a deliberate brand exception as clutter. Mark it kept; the brand playbook is the authority over these defaults.
- Never invent an element the design does not have, or a cut you cannot justify as removing something that earns nothing.
- No AI-slop in the review, and none recommended into the design: no "Elevate", "Seamless", "Unleash", no filler, no emoji. Plain, specific language and real content.
- If a project playbook exists (a chosen palette, an editorial type pairing, a register direction), it is the authority. Follow it over these defaults.

## Pairings and boundaries

- Pair with `crew-design-brutalist` as the other style pole: brutalist shows the structure raw, minimalist removes until only the essential remains. Both reject the generic SaaS default, from opposite directions.
- Pair with `crew-design-composition`: minimalism depends on one focal point and a clear eye path, so a barren or unfocused minimal page is often a composition problem first.
- Pull the warm monochrome palette and the editorial type pairing into `crew-design-language` so they are defined once as tokens.
- Pull an editorial or premium reference from `crew-design-reference` (Aesop, a workspace tool, a portfolio) when a fix needs a concrete north star.

## Verification

Before the run is marked done, confirm:

```
[ ] Minimalist was confirmed as the right call, and the content can carry reduction (not a density or warmth brief)
[ ] Typography read for one or two considered faces, weight-and-scale hierarchy, off-black not pure black
[ ] Colour read for a warm monochrome base and at most one muted accent, with any gradient, fluoro, or bright section flagged
[ ] Layout read for macro-whitespace, a constrained width, one focal point, crisp small radii, ultra-flat surfaces
[ ] Imagery read for photography carrying the warmth, real content, and depth rather than empty flat sections
[ ] The minimal-versus-barren call was made honestly; emptiness is fixed with substance, not more whitespace
[ ] The reduction discipline ran: every element earns its place, the one-purpose test passes
[ ] The accessibility floor was checked: muted gray stays at a readable contrast
[ ] Both lists are concrete: clutter to cut and barren spots to fill, each with a specific move
[ ] A Minimal / Cluttered / Barren verdict with the single highest-impact move
```
