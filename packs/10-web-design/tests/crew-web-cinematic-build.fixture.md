# Fixture: crew-web-cinematic-build

Three cases that exercise the skill: a clean cinematic build, a wrong-tool routing case, and a vague brief missing the purpose-first input.

## Case A: clean

**Input.**

> Build me a single-file cinematic site for a luxury fragrance launch, "Noir Veil". Museum-drift aesthetic: a dim marble gallery, smoky black with deep violet and silver, the hero is a black faceted perfume bottle that glows from within. The visitor should walk away wanting to pre-order. Audience is high-end fragrance buyers. I have generated all nine assets in nano banana (s1_bg.mp4 loop, s1_hero, s2_bg, s2_hero, s2_cards, s3_bg composite, s4_hero, s5_bg, s5_hero), they are in an assets folder. Deploy to a Vercel preview. Careful mode.

**Expect.**

- Step 0 reads `.claude/crew-state/web-design/crew-web-cinematic-build-handoff.md` and states what was recovered (or "No prior context, first run").
- The purpose is captured first: a fragrance pre-order launch, museum-drift aesthetic, the glowing black bottle as the recurring hero, smoky-black + violet + silver palette, high-end buyers as audience.
- The nine-photo manifest is handed over (or confirmed already satisfied), with 2 to 3 cohesion anchors locked and "pure black background" on every hero object slot (s1_hero, s2_hero, s4_hero, s5_hero).
- Assets are wired one scene at a time, hero objects as additive planes on pure black floated with a vertical sine float (never a full spin), backdrops as crossfaded planes, s2_cards keyed before wiring.
- The build is a single self-contained HTML file, CDN imports via importmap, no build step, no extra source files.
- Scroll / scene morph present: entrance, reveal, contrast (the high-meets-modern moment), product moment, close, each gap a named transition.
- Atmosphere present: FogExp2, UnrealBloomPass, drifting particles, ACES tone mapping plus sRGB output, all layered at ~60 percent so the type survives.
- A mobile cut present as its own film: portrait backdrops, hero upper third, type lower third, scroll-velocity parallax, DOF off, particles cut.
- The render is verified, including the rAF-suspended-in-a-background-tab check (logic confirmed even when automation cannot paint a live frame).
- The build report begins with the exact line `CINEMATIC WEBSITE OUTPUT`.
- The Design review gate is run against `crew-design-quality`, `crew-design-composition`, `crew-design-patterns`, `crew-design-soft`, `crew-animation-gsap`, `crew-animation-locomotive`, and `crew-animation-scroll-reveal`, Criticals and Majors fixed, a fail blocking the ship.
- A real reduced-motion path is confirmed: scrubbed camera moves disabled, scenes hold static, copy and CTA read.
- No em dashes anywhere.
- The handoff is written to `.claude/crew-state/web-design/crew-web-cinematic-build-handoff.md`.

## Case B: wrong-tool

**Input.**

> I want a 6-stage onboarding journey that teaches new hires our company values as they scroll. Each stage is a lesson they complete before moving to the next, themed like a mountain climb.

**Expect.**

- The skill recognises this is a multi-stage L&D narrative where each stage teaches a lesson and a gate paces the story, not a single-file cinematic museum-drift site.
- It routes to `crew-web-scroll-journey` and explains the boundary: Cinematic Build is for an immersive Three.js drift where floating objects morph on scroll like a fashion film, while a gated, stage-by-stage onboarding that teaches values is exactly what Scroll Journey is for (a two-state gate, an arrival hero per stage, a persistent themed motif).
- It does NOT scaffold a cinematic single-file site, hand over the nine-photo manifest, or start writing the Three.js HTML.
- No em dashes anywhere.

## Case C: missing-input

**Input.**

> Make me something epic and cinematic.

**Expect.**

- Loop 1, Missing Input. The skill asks once for the purpose-first brief (what the site is for, the outcome, the audience, the world/theme, the hero object, the palette, the content source, the deploy target).
- It notes that the user must generate the nine assets in nano banana first (the nine-photo manifest), with the cohesion anchors locked and pure black on every hero object, before any HTML is wired.
- It invents no theme, no hero object, and no palette; it does not start writing the single-file site on a guess.
- It records the blocker in the handoff at `.claude/crew-state/web-design/crew-web-cinematic-build-handoff.md` and pauses rather than fabricating a brief.
- No em dashes anywhere.
