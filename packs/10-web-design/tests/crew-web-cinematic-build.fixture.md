# Fixture: crew-web-cinematic-build

Three cases that exercise the skill: a clean cinematic build, a messy brief with partial and defective assets, and a vague brief missing the purpose-first input.

## Case A: clean

INPUT:

> Build me a cinematic site for a luxury fragrance launch, "Noir Veil". Museum-drift aesthetic: a dim marble gallery, smoky black with deep violet and silver, the hero is a black faceted perfume bottle that glows from within. The visitor should walk away wanting to pre-order. Audience is high-end fragrance buyers. I have generated all nine assets in nano banana (s1_bg.mp4 loop with its still, s1_hero, s2_bg, s2_hero, s2_cards, s3_bg composite, s4_hero, s5_bg, s5_hero), they are in an assets folder. Deploy to a Vercel preview. Careful mode.

EXPECT:

- Step 0 reads `~/.claude/crew-state/brand-context.md` (hard stop if absent), settles the project, and reads this skill's record at `~/.claude/crew-state/projects/<project>/crew-web-cinematic-build-handoff.md`, stating what was recovered (or "No prior record in this project for this skill").
- The purpose is captured first: a fragrance pre-order launch, museum-drift aesthetic, the glowing black bottle as the recurring hero, smoky-black + violet + silver palette, high-end buyers as audience, confirmed back one line each.
- The nine-photo manifest is handed over (or confirmed already satisfied), with 2 to 3 cohesion anchors locked and "pure black background" on every hero object slot (s1_hero, s2_hero, s4_hero, s5_hero).
- The assets are run through `pipeline/compress-assets.sh` (webp conversion, dimension caps, byte sum against the 8MB desktop / 4MB mobile budget) before wiring.
- Assets are wired one scene at a time, hero objects as additive planes on pure black floated with a vertical sine float (never a full spin), backdrops as crossfaded planes, s2_cards keyed before wiring.
- The build starts from `cinematic-reference.html` (adapted, not rewritten from scratch): one HTML file plus a sibling assets folder (Mode 2), CDN imports via importmap, no build step, no extra source files.
- The s1_bg.mp4 slot carries muted + playsinline + loop + autoplay + preload="auto", a `.catch()` swap to the still poster, and a canplaythrough count into the preloader.
- The preloader fade is gated on `Promise.all([managerDone, fontsDone, videoDone])` and scroll is gated with `lenis.stop()` / `lenis.start()`.
- Scroll / scene morph present: entrance, reveal, contrast (the high-meets-modern moment), product moment, close, each gap a named transition.
- Atmosphere present: FogExp2, UnrealBloomPass, drifting particles, ACES tone mapping plus sRGB output, all layered at ~60 percent, plus the finishing pass (grain under 0.08 opacity, vignette, styled ::selection, scrollbar-color, visibilitychange pause).
- The head block is present: title, meta description, OG/Twitter tags (og:image from the Scene 3 composite once deployed), SVG favicon, theme-color matched to Scene 1.
- A mobile cut present as its own film: portrait backdrops at the 1280px cap, hero upper third, type lower third, scroll-velocity parallax, DOF off, particles cut, 100svh scenes, safe-area insets, Lenis off on touch.
- The render is verified per the web-standards Verification Gate: served over HTTP, Scenes 1/3/5 screenshot at 1280px and 375px, console read (zero errors), all assets 200, FPS median >= 50 on the heaviest scene, reduced-motion twin forced and screenshot, weight and head audited, keyboard walk, contrast math.
- The build report begins with the exact line `CINEMATIC WEBSITE OUTPUT`.
- The Design review gate is run per the Gate roster in `crew-design-quality` (binding), with `crew-design-reference` (composition lens), `crew-design-reference` (patterns lens), `crew-design-engineering` (advisory), and the register-conditional pack-13 style lens (here `crew-design-styles` (soft lens), warm premium luxury register), Criticals and Majors fixed, a fail blocking the ship.
- A real reduced-motion path is confirmed in code: scrubbed camera moves disabled, scenes snapped to designed states, copy and CTA read from the DOM, runtime change listener present.
- No em dashes anywhere.
- The handoff is written to `~/.claude/crew-state/projects/<project>/crew-web-cinematic-build-handoff.md` with the frame (title, Date, STATUS).

## Case B: messy

INPUT:

> Cinematic launch site for our studio's new espresso machine, "Meridian One". Dark marble workshop world, brass and smoke palette, the machine is the hero. Six of the nine assets are done: s1_bg, s1_hero, s2_bg, s3_bg, s5_bg, s5_hero. The s2_hero came out on a dark grey background, close enough, right? We never made s2_cards or s4_hero. For the words, just write whatever sounds premium, and say it is "the world's quietest espresso machine, from $1,899" so it feels real.

EXPECT:

- The skill flags the s2_hero defect instead of wiring it: dark grey is not pure black, an additive plane will show an ugly box; it asks for a regeneration with "pure black background" in the prompt (or offers Path A for that slot meanwhile).
- The two missing slots (s2_cards, s4_hero) fall back to Path A procedural geometry so the site is never broken, and both are named as pending in the report and the handoff.
- It refuses to fabricate: "the world's quietest espresso machine" is a superlative and "$1,899" is a price the user asserted for effect, so both are treated per Loop 3, "Escalated: [needs the user's confirmation these are real, published claims]", not silently written into scene copy. Voice-true copy is generated from the brief; anything beyond it carries a REPLACE or "(placeholder, swap for real copy)" label.
- The compress pass still runs on the six delivered assets, with the byte sum reported against the budget.
- Fast mode is abandoned if it was in play: an asset failed its sanity check, so the run finishes in Careful.
- The report's "Nine assets" line honestly splits used / pending, and STATUS is DONE_WITH_GAPS (never a clean DONE) while slots and claims remain open.
- The handoff at `~/.claude/crew-state/projects/<project>/crew-web-cinematic-build-handoff.md` records the pending slots, the escalated claims, and the regeneration ask.
- No em dashes anywhere.

## Case C: missing-input

INPUT:

> Make me something epic and cinematic.

EXPECT:

- Loop 1, Missing Input. The skill asks once for the purpose-first brief (what the site is for, the outcome, the audience, the world/theme, the hero object, the palette, the content source, the deploy target).
- It notes that the user must generate the nine assets in nano banana first (the nine-photo manifest), with the cohesion anchors locked and pure black on every hero object, before any HTML is wired.
- It invents no theme, no hero object, no palette, and no copy; it does not start writing the site on a guess.
- It records the blocker in the handoff at `~/.claude/crew-state/projects/<project>/crew-web-cinematic-build-handoff.md` (STATUS: BLOCKED, written before the ask per Loop 4) and pauses rather than fabricating a brief.
- The chat Completion block is STATUS: NEEDS_CONTEXT or BLOCKED, never DONE.
- No em dashes anywhere.
