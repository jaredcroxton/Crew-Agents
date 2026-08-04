# Design language spec (consulted via crew-design-reference)

A design language is the set of load-bearing choices (the type scale, the palette, the spacing rhythm, the depth system) applied the same way on every page, in every component, across every build, so the product feels like one thing rather than a pile of screens; this spec builds that system as named tokens on a clear ladder, sets the naming rules that keep it coherent, and audits a project for the drift that creeps in when values get hardcoded.

## When to use design language

Do not use this spec to score a single screen's quality (that is `crew-design-quality`), to polish pixels and motion (that is `crew-design-engineering`), to find reference sites (that is `crew-design-reference`), or to judge whether patterns are current (that is `crew-design-patterns`). This spec builds and maintains the token system itself.

## What a spec needs

You need:

- The brand basis: the accent, the neutral base, the typeface or type direction, and any colours, fonts, or values the brand already locks. A reference site or an extracted token set can seed this.
- The surfaces in scope: which pages, apps, or builds the language must cover (a marketing site, an app, a dashboard, a deck), because coherence is judged across them.
- An existing project to audit, if the job is drift detection rather than a fresh build.

If the brand basis is missing (no accent, no neutrals, no type direction), ask once, because a token system needs a source of truth. Never invent a brand colour, a font, or a value the project has not set. If a value is undecided, mark it a slot to fill, do not guess a hex.

## How the language designer thinks

1. **A design language is a system, not a stylesheet.** The same decisions, applied the same way, everywhere. Drift, the same idea expressed three slightly different ways, is the enemy.
2. **Token before pixel.** Every colour, size, space, and shadow is a named token, never a hardcoded value in a component. A raw hex in a selector is a future inconsistency waiting to happen.
3. **The ladder has three rungs.** Primitives (raw values), semantic (role and intent), component (scoped). Components reference semantic tokens, never primitives. The semantic layer is where the brand lives and where theming happens.
4. **Name by role, not by value.** `--color-accent`, not `--color-green`. When the brand swaps green for blue, the name still fits. A value-named token lies the moment the value changes.
5. **Constrain to a scale.** A spacing scale of eight steps beats infinite freedom. Constraint is what makes a system coherent and a page feel composed rather than improvised.
6. **The load-bearing choices are invisible.** An optical-size axis, a weight between the named steps, pixel line-heights. These are what make a language feel considered, and they are exactly what an AI build skips. Name them so they survive.

## Colour tokens

Colour is the clearest place to see the ladder, so build it here first and reuse the shape for every other family.

```
PRIMITIVES (raw values, no meaning, defined once):
  --blue-500: oklch(62% 0.18 250);   --zinc-50: oklch(98% 0 0);   --zinc-950: oklch(20% 0 0);

SEMANTIC (role and intent, references a primitive, the brand lives here):
  --color-accent:  var(--blue-500);
  --color-surface: var(--zinc-50);     /* page background */
  --color-raised:  white;              /* a card or panel above the surface */
  --color-text:    var(--zinc-950);
  --color-muted:   oklch(50% 0 0);     /* secondary text */
  --color-border:  oklch(90% 0 0);

COMPONENT (scoped, references semantic, never a primitive):
  --button-bg:   var(--color-accent);
  --card-border: var(--color-border);
```

Rules: one accent, defined once at the semantic layer, reused everywhere (this is what prevents two-greens drift). Neutrals on a single temperature, do not mix warm and cool greys. Define colour in OKLCH so lightness is consistent across hues. A component that needs the accent reads `var(--color-accent)`, never the raw primitive, so a rebrand touches one line.

## Typography tokens

A type system is a scale plus a set of roles, not a pile of one-off font sizes.

```
SCALE (fluid primitives):
  --text-sm:   clamp(0.875rem, 0.8rem + 0.3vw, 1rem);
  --text-base: clamp(1rem, 0.9rem + 0.5vw, 1.25rem);
  --text-2xl:  clamp(2rem, 1.6rem + 2vw, 3rem);
  --text-4xl:  clamp(3.5rem, 2.5rem + 5vw, 6rem);

ROLE TOKENS (semantic, one per text role):
  --type-display: { font: var(--font-heading); size: var(--text-4xl); weight: 450; line-height: 1.05; letter-spacing: -0.02em; }
  --type-heading: { ...; size: var(--text-2xl); weight: 550; line-height: 1.15; }
  --type-body:    { ...; size: var(--text-base); weight: 400; line-height: 1.6; measure: 65ch; }
```

The three load-bearing typographic choices, the ones a screenshot hides and an AI build skips:

- **Optical-size axis.** A variable font with an `opsz` axis draws differently at each size; set `font-variation-settings: "opsz" <px>` to match the rendered size, so display type and body type are tuned, not just scaled. Name it in the system so it is not lost.
- **A weight between the named steps.** Production type often sits at a weight like 450 or 550, between regular and medium, a variable-font luxury that reads more considered than 400 or 700. Record the exact weight per role.
- **Pixel or unitless line-heights chosen on purpose.** A unitless line-height (1.6) scales with size; a fixed value locks vertical rhythm. Pick deliberately per role and write it down, rather than letting it default.

## Spacing and layout tokens

```
SPACING SCALE (one scale, eight steps, everything snaps to it):
  --space-1: 0.25rem;  --space-2: 0.5rem;  --space-3: 0.75rem;  --space-4: 1rem;
  --space-6: 1.5rem;   --space-8: 2rem;    --space-12: 3rem;    --space-16: 4rem;

LAYOUT (semantic):
  --container:      min(100% - 2rem, 1200px);   /* page max width with gutter */
  --container-prose: 65ch;                       /* reading measure */
  --section-gap:    var(--space-16);
  --grid-gutter:    var(--space-6);
```

Rules: every margin and padding is a step on the scale, never an arbitrary `13px`. Vertical rhythm comes from a small set of section and block gaps, not from per-element guesses. One container width owns the page edge so nothing drifts wider or narrower than the system allows. Prefer fluid spacing with `clamp()` to reduce hard breakpoints.

## Elevation and shadow tokens

Depth is a system, not a per-card guess. Define a small ladder and use each level for a fixed meaning.

```
--elevation-0: none;                                  /* flat on the surface */
--elevation-1: 0 1px 3px rgba(0,0,0,0.06);            /* a resting card */
--elevation-2: 0 8px 24px -8px rgba(0,0,0,0.10);      /* a raised panel, a dropdown */
--elevation-3: 0 16px 40px -12px rgba(0,0,0,0.16);    /* a modal, a popover */
```

Rules: each level maps to a meaning (resting, raised, floating), and a component picks a level by meaning, not by taste. Shadows are soft, wide, and tinted to the background hue, never a hard black drop on every card. Use elevation only where it communicates hierarchy; at high density, prefer borders and negative space over boxes. More than four levels is a sign the depth system has lost its meaning.

## Border, radius, and surface tokens

```
RADIUS (one scale):
  --radius-sm: 0.375rem;  --radius-md: 0.625rem;  --radius-lg: 1rem;  --radius-full: 9999px;

BORDER AND SURFACE (semantic):
  --border-hairline: 1px solid var(--color-border);
  --surface-base:    var(--color-surface);
  --surface-raised:  var(--color-raised);
  --focus-ring:      0 0 0 3px color-mix(in oklch, var(--color-accent) 40%, transparent);
```

Rules: one radius scale, used consistently (a system mixing a 4px and a 16px radius at random reads broken). A single hairline border token so dividers and card edges match. A named focus-ring token so accessibility is part of the language, not an afterthought. Surfaces are named by role (base, raised) so a dark theme swaps the semantic layer and the whole system follows.

## Naming conventions

The rules that keep the system readable and stop it rotting.

```
PRIMITIVE: <family>-<value>        --blue-500, --space-4, --text-2xl      (raw, value-named, defined once)
SEMANTIC:  <category>-<role>       --color-accent, --type-heading, --section-gap  (role-named, references a primitive)
COMPONENT: <component>-<property>  --button-bg, --card-padding, --input-border    (scoped, references a semantic)
```

- **Name semantics by role, primitives by value.** A primitive may be value-named (`--blue-500`) because it is raw. A semantic token must be role-named (`--color-accent`), because its value will change and its name must not lie.
- **One direction of reference.** Component references semantic, semantic references primitive. Never the reverse, and never a component reaching past semantic to a primitive.
- **No synonyms.** One name per concept. If `--color-accent` exists, there is no `--color-brand` and no `--color-primary-1` meaning the same thing. Synonyms are drift with a name.
- **Utility classes map to tokens, not values.** A utility like `.p-4` resolves to `--space-4`, never to a hardcoded `1rem`, so the utility layer and the token layer cannot disagree.

## Coherence rules

How to audit a project for language drift, the slow divergence that makes a product feel assembled by strangers.

```
[ ] One source per concept: every accent on the page resolves to a single --color-accent, not two near-identical hexes.
[ ] No hardcoded values: no raw hex, px, or rem sitting in a component where a token should be.
[ ] One unit system: spacing in one scale, type in one scale, no mix of rem here and px there for the same role.
[ ] Roles, not one-offs: text uses the role tokens (display, heading, body), not bespoke font sizes per section.
[ ] Depth has meaning: every shadow maps to an elevation level; no per-card custom shadows.
[ ] One radius and one border token family; no random mix of corner sizes.
[ ] Theming swaps the semantic layer only: a dark theme redefines semantic tokens, it does not touch components.
[ ] No synonyms: one name per concept across the whole project.
```

A drift audit reports each violation with the duplicate or hardcoded value it found and the single token that should replace it.

## Application rules

How a build skill consumes the language. The token system is the contract every build writes against.

```
[ ] Pull the semantic token set; reference --color-*, --type-*, --space-*, never a raw value.
[ ] A new component declares its own --component-* tokens that reference semantics, it does not hardcode.
[ ] A rebrand or a theme is a change to the semantic (and primitive) layer only; components are untouched.
[ ] Any value the brand has not set is a named slot to fill, not a guessed default that hardens into drift.
[ ] Before a multi-page build ships, run the Coherence rules audit; one source per concept, no hardcoded values.
```

## Speccing workflow

1. **Establish the brand source and the surfaces.** State the accent, the neutral base, the type direction, and any locked brand values, and list the surfaces the language must cover. If the brand basis is missing, ask now. Do not invent a colour or a font.
2. **Define the primitives.** Lay down the raw value families (the palette in OKLCH, the type scale in clamp, the spacing scale, the radius scale) once. Value-named, no meaning yet.
3. **Map the semantic tokens.** For each role (accent, surface, raised, text, muted, border, the type roles, the section gaps, the elevation levels), point a role-named token at a primitive. This layer carries the brand.
4. **Scope the component tokens.** Where a component needs its own values, declare `--component-property` tokens that reference semantics, never primitives.
5. **Set and check the naming conventions.** Confirm primitives are value-named, semantics role-named, components scoped, references flow one direction, and there are no synonyms.
6. **Run the coherence audit.** Walk the Coherence rules across the surfaces (or the existing project, if auditing). Flag every hardcoded value, every duplicate concept, every off-scale value, and name the single token that resolves each.
7. **Verify before emitting.** Confirm every token references the layer below it (component to semantic to primitive), no component reaches a primitive directly, every brand value traces to the source or is marked a slot, and the load-bearing choices (optical size, exact weight, line-heights) are named. Where a value needs the owner to decide, mark it Escalated. Only then emit.

## Worked example

The spec as the source skill returned it, the shape a consult answer should take.

```
DESIGN LANGUAGE BRIEF
Project: a developer-tool SaaS   Surfaces: marketing site + app dashboard   Built: 2026-06-24   Mode: Careful

Primitives (raw values, defined once):
--teal-500: oklch(70% 0.12 190);  --zinc-50: oklch(98% 0 0);  --zinc-950: oklch(20% 0 0);
--text-base: clamp(1rem, 0.9rem + 0.5vw, 1.25rem);  --space-4: 1rem;  --radius-md: 0.625rem;

Semantic tokens (role to primitive, the brand lives here):
--color-accent: var(--teal-500);  --color-surface: var(--zinc-950);  --color-text: var(--zinc-50);
--type-heading: weight 550, line-height 1.15;  --section-gap: var(--space-16);  --elevation-2: 0 8px 24px -8px rgba(0,0,0,0.4);

Component tokens (scoped, reference semantics):
--button-bg: var(--color-accent);  --card-bg: var(--color-raised);  --card-padding: var(--space-6);

Load-bearing choices (the invisible craft, named so it survives):
- Headings at weight 550 (between medium and semibold), display at opsz matched to size, body line-height 1.6 unitless.

Naming convention: primitive value-named, semantic role-named, component scoped, references flow component to semantic to primitive only.

Coherence notes / drift found:
- None on the fresh system. Dark-first, so semantic surface and text invert for the marketing light sections via the semantic layer only.

Slots to fill / Escalated:
- The marketing light-theme neutrals are a slot, awaiting the brand owner's confirmation.
```

## Guardrails

- Never hardcode a value in a component where a token belongs. A raw hex, px, or rem in a selector is drift waiting to happen.
- Never name a semantic token by its value (`--color-green`). Name by role (`--color-accent`), so the name does not lie when the value changes.
- Never let a component reference a primitive directly, or reference flow backward. Component to semantic to primitive, one direction only.
- Never invent a brand colour, font, or value the project has not set. An undecided value is a named slot, not a guessed default.
- Never allow two names for one concept. One accent, one source, one name. Synonyms are drift.
- No AI-slop in the brief: no filler, no emoji. Named tokens, real values or explicit slots.
- If a project brand playbook exists (a locked palette, type, or scale), it is the authority and the source of the primitives. Follow it over these defaults.

## Pairings and boundaries

- This is the glue: feed the semantic token set to every build skill (`crew-web-slide-deck-builder`, `crew-web-fly-through-builder`, `crew-web-lead-dashboard-builder`) so they write against one language, not a fresh palette each time.
- Pair with `crew-design-quality` (it scores whether a screen hit the standard) and `crew-design-patterns` (it checks the patterns are current); this spec supplies the tokens both judge against.
- Pull a north-star reference from `crew-design-reference` to seed the brand direction before defining primitives.

## Verification

Before the run is marked done, confirm:

```
[ ] The brand source and the surfaces were established; no colour, font, or value was invented
[ ] Primitives defined once (palette in OKLCH, type and spacing scales), value-named
[ ] Semantic tokens map every role to a primitive and are role-named, not value-named
[ ] Component tokens reference semantics, never primitives; references flow one direction
[ ] The load-bearing choices (optical size, exact weight, line-heights) are named, not left to default
[ ] The naming conventions hold: primitive value-named, semantic role-named, component scoped, no synonyms
[ ] The coherence audit ran: one source per concept, no hardcoded values, one unit system, depth has meaning
[ ] Every undecided value is a named slot, not a guess; anything the owner must set is Escalated
[ ] The brand playbook, if any, was the source of the primitives and won over the defaults
```
