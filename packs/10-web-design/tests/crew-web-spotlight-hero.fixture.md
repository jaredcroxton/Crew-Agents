# Fixture: crew-web-spotlight-hero

Three cases: a clean spotlight-hero build, a messy and self-contradictory brief the skill has to cope with, and a vague brief missing the two blocking discovery answers. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the behaviour and output, and that the handoff file was written.

## Case A: clean
INPUT:
Build a spotlight hero for "Verdant", a landscape-design studio, wordmark "Verdant".
Dark premium theme, soft register. The before-and-after transformation is the whole build:
the base image is an overgrown, bare, neglected yard (cold and dim, charcoal and slate), and
the reveal underneath is the finished garden (warm golden-hour light, lush planting, alive).
One subject, centered low, edges falling to pure black. CTA "Book a consult" to /contact.
Deploy to a Vercel preview "verdant-hero". Careful mode.
EXPECT:
- Step 0 Context Recovery runs and states recovered context or "No prior record in this project for this skill."
- The two blocking discovery answers are captured and confirmed back in one line before any code: the website is Verdant, a landscape-design studio, and the transformation is the overgrown yard becoming the finished garden. The theme is the user's, not invented.
- The register lens is chosen at Workflow step 2 (here `crew-design-soft`, warm/premium) and steers the image prompts, the palette, and the type from that step forward, not as a surprise at review time.
- Two matched image prompts are written and shown: a base prompt (the overgrown yard, the before) and a reveal prompt (the finished garden, the after), sharing one composition, 16:9, subject centered low, edges falling to pure black `#000000`.
- The pair is generated via kie.ai nano banana: the base first into `public/hero-base.png`, then the reveal as an image-to-image edit off the saved base, and the framing, contrast, and black edges are confirmed.
- The mandatory optimize step runs: both images to WebP (or AVIF), 300KB cap each, wired as `BG_IMAGE_1`/`BG_IMAGE_2` at `/hero-base.webp` and `/hero-reveal.webp`, both preloaded (`fetchpriority="high"` on the base), `og.jpg` generated, the raw PNGs deleted from `public/`.
- The portrait crop is managed: a matched 4:5 pair swapped on an orientation `matchMedia` check, or `BG_POSITION` locked to the subject, verified so the subject and the before-and-after delta hold in frame at 375x812.
- The reveal mechanic is the locked CSS `radial-gradient` mask: centre driven by `--mx` / `--my` (viewport px) and radius by `--r`, the mask string set once, the single rAF loop writing only the variables on the stage element (never a canvas `toDataURL` encode, never React setState per frame), with the additive glow layer riding the same variables and a trailing cursor lerp.
- The reduced-motion floor is present: `prefers-reduced-motion` pins a fixed off-centre spotlight (a static partial reveal, the after inside the circle and the before around it), no cursor chase, and the headline and CTA still read, with a live `matchMedia('change')` listener.
- The coarse-pointer fallback is present: `matchMedia('(pointer: coarse)')` or touch auto-animates the spotlight along a 2D path and a tap moves it, so the hero is not a dead screen on a phone.
- Head hygiene ships: lang, the title pattern, meta description, the inline SVG favicon, OG and Twitter tags, `theme-color`, and `viewport-fit=cover`; the scene wrapper carries `role="img"` with the one-sentence ARIA_SCENE description; the skip link is first and every control has a visible focus-visible ring; every nav link resolves and the CTA navigates to `/contact` (no dead controls, no hamburger).
- The build report begins with the exact line `SPOTLIGHT HERO OUTPUT` and carries a `web-standards Gate:` verdict line.
- The Design review gate is run with the `CREW CONSULT from crew-web-spotlight-hero:` preamble: `crew-design-quality` (binding, including the binding Motion dimension), `crew-design-engineering` (binding, the pixel-and-easing leg), `crew-design-composition`, `crew-design-patterns`, and the register-conditional pack-13 lens (`crew-design-soft` here), with `crew-animation-css`, `crew-animation-motion`, and `crew-animation-spring` consulted as authoring references only (a STATUS and a spec, not a Pass or Fail); Criticals and Majors fixed, a fail blocking the ship.
- No em dashes anywhere in the output.
- Handoff file `~/.claude/crew-state/projects/<project>/crew-web-spotlight-hero-handoff.md` was written.

## Case B: messy
INPUT:
"Spotlight hero for Apex Detailing, we detail cars in Sydney. Make the before shot really bright
and colourful so it pops, then the reveal is a dark moody mirror-polish finish. Chuck a testimonial
carousel and three buttons across the bottom, and put 'The best detailer in Sydney' as the big headline.
Not sure what the nav should say. Just build it."
EXPECT:
- The two blocking answers are settled from what was given (the website is Apex Detailing, a car-detailing studio; the transformation is a dull scratched car becoming a mirror-polished finish), and the theme is worked from the brief, not invented.
- The contradictions are flagged, not silently obeyed: a bright colourful before fights the dark stage and the black edges that hide the mask rim, so the before is the muted/dim state and the after is the vivid one (the delta is kept, the polarity corrected and stated as an assumption); the testimonial carousel and the three buttons are declined because one hero is a single focal point (Application and Guardrails), and the reason is given.
- The superlative "The best detailer in Sydney" is Escalated (Loop 3), not written on the skill's authority: the neutral headline ships until the owner supplies a substantiated claim; who decides is named.
- The missing nav labels are not a blocker: the skill drafts them from the brand and confirms in the summary, and any unresolved `#` href is flagged as owed in the handoff rather than shipped silently on a deployed hero.
- The portrait crop is still managed and the reduced-motion floor and coarse-pointer fallback still ship as real code; the optimize step and the 300KB cap still run (the integrity checks survive a messy brief and Fast mode).
- The mechanic invariants are not "simplified" away for a rushed brief: the CSS radial-gradient mask, the `--mx` / `--my` writes on the stage, no canvas encode, no cursor-through-React-state, and the identical `background-size`/`background-position` on both layers all hold.
- Handoff file `~/.claude/crew-state/projects/<project>/crew-web-spotlight-hero-handoff.md` was written, recording the corrected before/after polarity, the declined carousel and extra CTAs, the escalated superlative, and the drafted nav labels as items to confirm.

## Case C: missing-input
INPUT:
"Make me a cool hero."
EXPECT:
- Loop 1, Missing Input. The skill does NOT invent a website purpose, does NOT pick a theme, does NOT invent a before-and-after transformation, and does NOT scaffold or generate an image pair on a guess.
- It asks once for the two BLOCKING discovery questions: what is the website (brand, what it sells, the wordmark), and what look and theme (the subject, the mood, the palette, and the spotlight transformation, the before state and the after state).
- It states it will draft the two matched prompts and confirm them once the brief is answered.
- No `SPOTLIGHT HERO OUTPUT` report is produced for a hero that was not built.
- No em dashes anywhere.
- Handoff file `~/.claude/crew-state/projects/<project>/crew-web-spotlight-hero-handoff.md` written FIRST (STATUS: BLOCKED), recording the two missing discovery answers as the blocker the next run needs, with no theme and no transformation assumed.
