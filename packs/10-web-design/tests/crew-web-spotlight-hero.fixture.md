# Fixture: crew-web-spotlight-hero

Three cases that exercise the skill: a clean spotlight-hero build, a wrong-tool routing case, and a vague brief missing the two discovery answers. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the behaviour and output, and that the handoff file was written.

## Case A: clean

**Input.**

> Build me a spotlight hero for "Verdant", a landscape-design studio. Dark premium theme. The transformation is the spotlight reveal: the base image is an overgrown, bare, neglected yard (cold and dim, charcoal and slate), and the reveal underneath is the finished garden (warm golden-hour light, lush planting, alive). One subject, centered low, edges to black. Deploy to a Vercel preview. Careful mode.

**Expect.**

- Step 0 reads `.claude/crew-state/web-design/crew-web-spotlight-hero-handoff.md` and states what was recovered (or "No prior context, first run").
- The two discovery answers are captured and confirmed back in one line before any code: the website is Verdant, a landscape-design studio, and the before-and-after transformation is the overgrown yard becoming the finished garden. The theme is the user's, not invented.
- Two matched image prompts are written and shown: a base prompt (the overgrown yard, the before) and a reveal prompt (the finished garden, the after), sharing one composition, 16:9, edges falling to pure black.
- The image pair is generated via kie.ai nano banana, the base first into `public/hero-base.png`, then the reveal as an image-to-image edit off the base into `public/hero-reveal.png`, and the framing, contrast, and black edges are confirmed.
- The pair is wired into the locked template and referenced as the local files `/hero-base.png` and `/hero-reveal.png`.
- The canvas reveal mechanic is built: a viewport-sized mask canvas, a radial-gradient spotlight at the cursor, applied as `mask-image` with `maskSize: '100% 100%'`, cleared every frame, with the trailing cursor lerp.
- The mobile / no-pointer fallback is present: a coarse-pointer branch (`matchMedia('(pointer: coarse)')` or touch) auto-animates the spotlight along a path and a tap moves it, so the hero is not a dead screen on a phone.
- The reduced-motion path is present: `prefers-reduced-motion` holds the reveal static (the after image shows), no cursor chase, and the headline and CTA still read.
- The build report begins with the exact line `SPOTLIGHT HERO OUTPUT`.
- The Design review gate is run: `crew-design-quality` as the binding verdict (including the binding Motion dimension), `crew-design-composition` (the eye resolves to the single spotlight focal point), `crew-design-patterns`, a register-conditional pack-13 style lens (here `crew-design-soft` for the warm premium register), with `crew-animation-gsap` and `crew-animation-motion` consulted as authoring references only (they emit a STATUS, not a Pass or Fail), Criticals and Majors fixed, a fail blocking the ship.
- No em dashes anywhere in the output.
- Handoff file `.claude/crew-state/web-design/crew-web-spotlight-hero-handoff.md` was written.

## Case B: wrong-tool

**Input.**

> I want a full multi-scene immersive site that morphs through five different environments as I scroll, floating objects and atmosphere, the whole thing changing world by world as you go down the page.

**Expect.**

- The skill recognises this is a full immersive multi-scene cinematic site that morphs through environments on scroll, not a single-focal hero section with a cursor reveal.
- It routes to `crew-web-cinematic-build` (or to `crew-web-scroll-journey` if the five environments are framed as a gated, stage-by-stage narrative) and explains the boundary: Spotlight Hero builds one hero section where the cursor reveals a before-and-after image through a circular mask, while a five-environment scroll-morph site with floating objects is exactly what Cinematic Build is for.
- It does NOT scaffold a spotlight-hero project, does NOT write the two matched image prompts, and does NOT generate an image pair.
- It explains it builds a single hero section, not a full site.
- No `SPOTLIGHT HERO OUTPUT` report is produced for a hero that was not built.
- No em dashes anywhere.
- Handoff file written, recording that the request was routed to the cinematic or scroll-journey builder and why.

## Case C: missing-input

**Input.**

> Make me a cool hero.

**Expect.**

- Loop 1, Missing Input. The skill does NOT invent a website purpose, does NOT pick a theme, does NOT invent a before-and-after transformation, and does NOT scaffold.
- It asks once for the two BLOCKING discovery questions: what is the website (brand, what it sells, the wordmark), and what look and theme are we going for (the subject, the mood, the palette, and the spotlight transformation, the before state and the after state).
- It invents no theme and no transformation; it does not generate an image pair on a guess.
- It states it will draft the two matched prompts and confirm them once the brief is answered.
- Handoff file `.claude/crew-state/web-design/crew-web-spotlight-hero-handoff.md` written, recording the missing discovery answers as the blocker the next run needs, with no theme assumed.
