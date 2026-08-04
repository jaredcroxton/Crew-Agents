# Redesign spec (consulted via crew-design-styles)

The redesign lens reviews an existing design and lifts it rather than starting over: it diagnoses what is there, keeps what works, cuts the generic AI fingerprint, and elevates what sits one level low, ordered by impact over risk. This spec covers the keep, cut, elevate triage, the elevation moves, the quick-wins order, and the honest call between a surface lift, a deeper rebuild, and a fresh start.

## When to use the redesign lens

Do not use this spec to build a design from scratch (there is nothing to lift; use a style skill for a fresh aesthetic), to score a single dimension of a finished design (that is `crew-design-quality`), or to choose a brand-new visual language from nothing. This spec lifts something that already exists.

## What a review needs

You need:

- The existing design under review: a built page or app, a screenshot, or the codebase, with the stack and styling method if known (a framework, vanilla CSS, a utility framework).
- The goal: what "better" means here (premium, on-brand, a specific register), and any constraint (do not change the stack, ship in a week).
- Whether functionality and content are fixed (a lift) or open to structural change (a rebuild is on the table).

If there is no existing design or codebase to audit, ask once for it. A redesign needs something to lift; this skill does not build from nothing. Never invent the current state of a design you cannot see, and never assume a rebuild is wanted when a lift was asked for.

## How the redesign reviewer thinks

1. **Lift, do not replace.** The job is to improve what is there. Most designs need a font swap, a palette cleanup, real states, and breathing room, not a rebuild.
2. **Keep what works.** A redesign that throws out the good with the bad loses what already earned trust. Name what to keep before what to cut.
3. **The AI fingerprint is the first target.** The purple-blue gradient, the default font everywhere, three equal cards, centred everything, instant transitions. These are the tells that make a design read generic, and removing them is the fastest lift.
4. **Highest impact, lowest risk first.** A font swap lifts more than a week of micro-tweaks and breaks nothing. Order the work by impact over risk, not by what is most fun to build.
5. **Finished beats fancy.** The missing states (hover, focus, loading, empty, error) and the missing pieces (404, legal links, validation) read as unfinished. Adding them lifts a design more than a new animation.
6. **Know when polish is not enough.** Sometimes the structure is the problem and surface fixes only paint over it. Name when a deeper rebuild, or an honest fresh start, is the right answer, and do not default to a rewrite.

## Redesign diagnosis

The triage. For every element, decide one of three: keep (it works, leave it), cut (a generic tell or dead weight, remove it), or elevate (the right idea, one level below where it should be).

```
CUT (the AI fingerprint and dead weight):
  the purple-blue gradient, a default or Inter-everywhere font, three equal feature cards, centered-everything,
  instant zero-duration transitions, pure #000000, oversaturated or multiple accents, the generic card (border + shadow + white),
  Lucide-only icons, rocketship-for-launch metaphors, John Doe / Acme / Lorem Ipsum, AI cliches ("Elevate", "Seamless"), Title Case Headers.

KEEP (what already earns its place):
  the real content, the working structure and flow, a brand element that is genuinely doing its job, anything users already rely on.

ELEVATE (right idea, one level low):
  a headline that lacks presence (size up, tighten tracking, heavier weight), body text too wide (constrain the measure),
  a flat empty section (add depth), a weak hierarchy (lead with one thing), a near-right palette (desaturate to one accent).
```

State the three lists explicitly. A redesign that only cuts, or only adds, has not done the triage.

## Elevation moves

The specific changes that lift a design one level. Each is a concrete swap, not "make it premium".

- **Typography:** a font with character (Geist, Outfit, Cabinet Grotesk, Satoshi; a serif header over a sans body for editorial), tighter tracking and heavier weight on display, a constrained measure (about 65 characters), Medium and SemiBold weights for hierarchy, tabular figures for data, sentence case over all-caps, `text-wrap: balance` to kill orphans.
- **Colour and surface:** off-black not pure black, one desaturated accent (under 80 percent saturation) on a neutral base, one grey family, the AI gradient gone, shadows tinted to the background hue, a touch of grain or texture so flat sections are not sterile, a single consistent light source.
- **Layout:** a max-width container (about 1200 to 1440px), asymmetry over centred symmetry, a two-column zig-zag or bento over three equal cards, varied radii, deliberate overlap and depth, aligned baselines across side-by-side cards, buttons pinned to the bottom of cards, optical (not just mathematical) alignment.
- **States and motion:** hover, active (`scale(0.98)`), and a visible focus ring on every interactive element, 200 to 300ms transitions, skeleton loaders over spinners, composed empty states, inline error states, `transform` and `opacity` only, spring physics over linear easing for a bigger lift.
- **Content:** real diverse names, organic messy data, contextual brand names, plain confident copy (no clichés, no "Oops!", no exclamation marks), real draft copy over Lorem.

## The quick wins

The fix-priority order: maximum visual lift for minimum risk. Do these first; most of the improvement is here, and almost nothing breaks.

```
1. Font swap            biggest instant improvement, lowest risk.
2. Colour cleanup       remove clashing and oversaturated colours, kill the AI gradient, one accent.
3. Hover and active     and a visible focus ring; the interface starts to feel alive.
4. Layout and spacing    a real grid, a max-width container, consistent padding, double the whitespace.
5. Replace generic parts swap the three-equal-cards, the carousel, the pill badges for modern alternatives.
6. Loading, empty, error add the missing states; the design starts to feel finished.
7. Type scale and spacing the premium final polish, once everything else is in place.
```

A redesign that opens with a new animation before the font swap has the order wrong.

## The deeper rebuilds

When surface polish is not enough, because the structure, not the surface, is the problem.

- **The signs:** every quick win still leaves it feeling broken; the problems are about what goes where, not how it looks; there is no hierarchy at all; the flow has dead ends with no way back; the information architecture buries the point; the same fix has to be applied in fifty places because there is no system.
- **What a rebuild keeps:** the content, the brand, and what users rely on. It rebuilds the layout, the component system, or the flow, not the whole product.
- **The no-system tell:** if a fix has to be repeated everywhere because values are hardcoded with no tokens, that is a design-language job; route to `crew-design-language` to build the token system, then lift on top of it.
- **The honest call:** would the quick wins plus a focused structural rebuild get there, or are you polishing something that should not exist in this shape. Name it; do not paper over a structural problem with a font swap.

## Style application

A redesign can also be a register shift, taking a generic existing design toward a deliberate style.

- **Run the diagnosis first.** Cut the AI fingerprint before applying any style; a brutalist or soft layer over a purple-gradient base is still generic underneath.
- **Route to the target style for its language.** For the rules of the target register, hand to the style skill: `crew-design-brutalist` for raw, `crew-design-minimalist` for reduced, `crew-design-soft` for warm, `crew-design-authority` for established. That skill defines the language; this skill applies it to the existing structure.
- **Keep the structure, swap the surface.** Apply the chosen style's typography, colour, radii, and motion to the existing content and layout, without a rebuild, unless the structure itself blocks the register (then it is a deeper rebuild).
- **Commit to one.** A redesign that half-applies a style reads as confused, the same way a half-brutalist or a half-soft does. Pick the register and carry it through.

## When to redesign vs when to start over

- **Redesign (lift)** when the content is sound, the structure works, and the problems are surface (font, colour, states, spacing, generic patterns). This is most cases. A lift is faster, lower-risk, and keeps what already works.
- **Deeper rebuild** when the layout, the component system, or the flow is the problem, but the content and brand are worth keeping. Rebuild the structure, not the product.
- **Start over** when the stack is a dead end, the information architecture is fundamentally wrong, or the accessibility debt is structural. A fresh start keeps the content and the brand, not the build.
- **The default is a lift, not a rewrite.** A rewrite loses what already worked and is the riskier path. Recommend a rebuild or a fresh start only when the structure genuinely blocks the goal, and say why.

## Application rules

The checklist a redesign embeds. The lift is the contract.

```
[ ] Lift, do not rewrite: improve the existing stack and structure; do not migrate frameworks or rebuild from scratch.
[ ] Diagnosis stated: keep what works, cut the AI fingerprint (gradient, default font, three equal cards, centered-everything), elevate what is one level low.
[ ] Quick wins in order: font, colour, states, layout and spacing, components, states, type polish, highest impact and lowest risk first.
[ ] Every interactive element gets hover, active, and a visible focus ring; loading, empty, and error states exist.
[ ] One desaturated accent on a neutral base; the AI purple-blue gradient is gone; shadows tinted, not pure black.
[ ] Real content (no John Doe, Acme, Lorem, round numbers, clichés); sentence case; semantic HTML.
[ ] The strategic omissions are closed: 404, legal links, form validation, skip-to-content, alt text.
[ ] Nothing breaks: functionality preserved, changes focused; a deeper rebuild or fresh start is called out only when surface polish cannot get there.
```

## Review workflow

1. **Scan.** Identify the stack and the styling method, and what is actually there: the structure, the patterns, the content. If there is no existing design to audit, ask for it now.
2. **Diagnose.** Run the keep, cut, elevate triage across typography, colour, layout, states, content, and components. State all three lists, and flag every AI-fingerprint tell to cut.
3. **Plan the quick wins.** Order the lifts by the fix-priority sequence (font, colour, states, layout, components, states, type), so the biggest, lowest-risk improvement comes first.
4. **Identify the elevation moves and any style shift.** For each element to elevate, name the concrete move. If the redesign is also a register shift, route to the target style skill for its language and apply it to the existing structure (style application).
5. **Judge rebuild versus polish.** Decide whether the quick wins and elevation moves get there, or whether the structure needs a deeper rebuild or a fresh start, and say why. Default to a lift unless the structure blocks the goal.
6. **Write the redesign brief and the verdict.** Assemble the keep, cut, elevate lists, the ordered quick wins, the elevation moves, and the rebuild call, and set a verdict (Lift, Rebuild, or Start over) with the single highest-impact move.
7. **Verify before emitting.** Confirm every cut is a real tell (not a working element), every elevation is a concrete move, the quick wins are in impact-over-risk order, the strategic omissions are checked, and nothing recommended would break functionality or require a rewrite that was not called for. Mark a deliberate brand exception kept (the playbook wins). Only then emit.

## Worked example

The review as the source skill returned it, the shape a consult answer should take.

```
DESIGN REDESIGN REVIEW
Artifact: marketing landing page   Stack: Next.js + Tailwind   Goal: lift a generic page to premium   Reviewed: 2026-06-24   Mode: Careful

Verdict: Lift   Highest-impact move: swap the font and kill the purple-blue gradient; that alone moves it a full level.

Keep (works, leave it):
- The working Next.js and Tailwind stack and the section structure; do not migrate or rebuild.
- The real product copy and the feature set.

Cut (the AI fingerprint and dead weight):
- The purple-to-blue gradient hero -> a neutral base with one desaturated accent.
- Inter everywhere -> a font with character (Geist or Cabinet Grotesk).
- Three equal feature cards -> a two-column zig-zag or a bento sized by priority.
- John Doe testimonials and Title Case headers -> real names and sentence case.

Elevate (right idea, one level low):
- The headline lacks presence -> size up, tighten tracking, heavier weight.
- Flat sections -> add subtle depth (a low-opacity image or a tinted ambient gradient).

Quick wins (in order, highest impact and lowest risk first):
1. Font swap.   2. Colour cleanup, one accent.   3. Hover, active, and focus states.
4. Max-width container and consistent spacing.   5. Replace the three-card row.   6. Loading and empty states.   7. Type scale polish.

Deeper rebuild needed: No. The structure and stack are sound; this is a surface lift.

Strategic omissions / accessibility floor:
- No focus rings, no 404, no legal links, no form validation. Add all four; focus rings are an accessibility requirement, not optional.
```

## Guardrails

- Never rewrite from scratch when a lift will do. The default is to improve what exists on its current stack; recommend a rebuild or a fresh start only when the structure genuinely blocks the goal, and say why.
- Never cut what works. State the keep list; a redesign that throws out the good with the bad loses what already earned trust.
- Never break functionality. Changes are focused and reviewable, the stack is preserved, and a new dependency is checked against the project first.
- Never skip the accessibility and strategic-omissions floor. Focus rings, alt text, validation, 404, and legal links are requirements, not polish.
- Never flag a deliberate brand exception as a tell. Mark it kept; the brand playbook is the authority over these defaults.
- Never invent the current state of a design you cannot see, or a fix you cannot justify as a real lift.
- No AI-slop in the brief, and none recommended into the design: no "Elevate", no "Seamless", no filler, no emoji. Plain language, concrete moves, real content.
- If a project playbook exists (a brand system, a chosen register, a stack constraint), it is the authority. Follow it over these defaults.

## Pairings and boundaries

- Route to a style skill for the target language when a redesign is also a register shift: `crew-design-brutalist`, `crew-design-minimalist`, `crew-design-soft`, or `crew-design-authority`. That skill defines the register; this one applies it to the existing structure.
- Route to `crew-design-language` when the no-system tell fires (the same fix repeated everywhere because values are hardcoded); build the token system, then lift on top of it.
- Hand the lifted result to `crew-design-quality` for the broad sweep, `crew-design-composition` for the eye path, and `crew-design-patterns` for currency, to confirm the redesign actually landed.

## Verification

Before the run is marked done, confirm:

```
[ ] The existing design was actually audited; nothing was diagnosed that could not be seen
[ ] The keep, cut, elevate triage was stated explicitly, all three lists
[ ] The AI fingerprint was identified and put on the cut list (gradient, default font, three equal cards, centered-everything)
[ ] The quick wins are ordered by impact over risk (font first, type polish last)
[ ] Every elevation is a concrete move, not "make it premium"
[ ] The rebuild-versus-polish call was made; a lift was the default unless the structure blocks the goal
[ ] The strategic omissions and accessibility floor were checked (focus, alt, 404, legal, validation)
[ ] Nothing recommended would break functionality or require an uncalled-for rewrite
[ ] A Lift / Rebuild / Start over verdict with the single highest-impact move
[ ] A deliberate brand exception is marked kept; the playbook won over the defaults
```
