# Fixture: crew-web-scrollytelling

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the behaviour and output, and that the handoff file was written.

## Case A: clean
INPUT:
Brand: VESSEL, a fictional boutique fragrance house. Vibe: nocturnal, gilded, slow.
Journey: a moonlit flower field, dive into a single bloom, falling through gold embers, a drop of
liquid gold lands in a pool, pull back inside the bottle on black marble.
Lane: B, cinematic footage. Engine: KIE (KIE_API_KEY set). Chapters: 5. Credit ceiling: 200.
After the film: the collection, stockists, contact, CTA "Discover the collection".
Delivery context: presented on a screen, desktop-first. Deploy: Vercel project "vessel-film".
EXPECT:
- Skill runs Step 0 Context Recovery and states recovered context or "No prior record in this project for this skill."
- The interview answers are confirmed back in one line before any tool call.
- 2 to 3 named concepts are pitched BEFORE any generation, the recommended one marked "(Recommended)", each with a concrete what-you-see scroll walkthrough, lane, chapter count, and estimated credits; the build starts only after a concept is chosen.
- Cost is quoted against the 200-credit ceiling and accepted before any generation; the report carries a balance-delta receipt (spent credits measured, not assumed).
- The chain contract holds: the opening keyframe prompt ends with the full-bleed no-letterbox line, and every later clip is seeded from the ffmpeg-extracted literal last frame of the previous clip (uploaded, hosted url as image_url), never a lookalike keyframe.
- Every junction is SSIM-measured with a side-by-side; any seam under 0.88 is judged in motion, never masked with a dissolve or crossfade.
- FRAME_COUNT is set from the assemble.sh printed count, not asked of the user; the film is a canvas frame scrub, never a <video> element; the after-film background starts at the sampled seam hex.
- Output is a "SCROLL FILM BUILD" report with Concept, Lane, Journey, Chapters, Credits, Frames, Junctions, Verified, Gate, Review gate, Deploy checks.
- Verification adopts the web-standards Gate roster: the report carries a "web-standards Gate:" verdict line, and the reduced-motion twin and jank p95/max figures appear in Verified.
- No em dashes anywhere in the output.
- Handoff file `~/.claude/crew-state/projects/<project>/crew-web-scrollytelling-handoff.md` was written.

## Case B: messy
INPUT:
"Can our site feel like one of those pages where the whole thing is a movie while you scroll?
We are Driftline Coffee Roasters (a fictional roastery). I have no video tools and honestly
no budget for credits, is that a dealbreaker? At the end people should find our beans and a
subscribe button."
EXPECT:
- Skill restates the ask and resolves the lane to A (pure-code, zero setup, no credits) instead of treating the missing engine as a blocker.
- A journey arc is proposed from the brand (for example green cherry to roast to first pour) and 2 to 3 named concepts are pitched with the recommended one first; the user picks or defers with "you decide".
- No credits are spent and no engine key is requested for Lane A.
- The Lane A build honors the ordering law (pinned scenes created before ambient or background triggers) and gives any clip-path reveal its own threshold-0 observer with a negative bottom rootMargin.
- The film resolves into after-film sections carrying the beans and the subscribe CTA; reduced motion gets a designed static or instant-state twin, not a faster scrub.
- Handoff file written to `~/.claude/crew-state/projects/<project>/crew-web-scrollytelling-handoff.md`, noting the lane decision and any open items.

## Case C: missing-input
INPUT:
Brand: Granite Peak Outfitters (a fictional alpine gear label). Journey: a summit ridge at dawn
descending into a valley workshop. "I want the real footage film, not the code-animation version,
do not build that one. I do not have a KIE key, a Higgsfield account, or any AI video tool."
EXPECT:
- Skill follows Loop 1: it does NOT fabricate footage, does NOT fake the film with CSS against the user's explicit refusal, and does NOT spend or request credits on any account.
- Lane A is offered once as the zero-setup alternative and the refusal is respected.
- The keyframe prompt (ending with the full-bleed no-letterbox line) and the chapter prompts are handed over as paste-ready text with the chain instruction: seed each clip with the literal last frame of the previous clip, export MP4s, send them back.
- Skill pauses and states the build resumes at assembly when the clips land.
- No "SCROLL FILM BUILD" artifact is emitted.
- Handoff file written FIRST (STATUS: BLOCKED, the missing engine named as the blocker), recording that prompts were handed over and what resumes on return.

## Case D: embed mode
INPUT:
"We already have our site live, I do not want it redesigned. Can you add one of those cinematic
scroll films to it? The repo is in ./site. KIE key is ready, ceiling 300 credits."
EXPECT:
- The mode question resolves to Embed Mode: the skill states it is creating the film and embedding it, NOT designing a website, and that the existing design system rules.
- It reads the site first (palette, type, spacing, brand assets) before proposing anything, and proposes reusing the site's own imagery as keyframe seeds.
- Exactly three placements offered with one recommendation: scroll-scrub hero, autoplay loop background (5 to 8s, ends pinned identical, muted, poster still), or its own full-bleed section.
- Credits quoted against the 300 ceiling and a yes obtained before any generation; single-generation checked before chaining (a 10 to 15s take has no junctions).
- The embed touches only the placement: new markup, the scrub or loop runtime with the snap-on-big-gap guard, a poster fallback, a reduced-motion path. No restyling of the rest of the site; mobile gets the poster or a lighter loop, never a 25s scrub.
- The receipt lists exactly which files were touched and how to revert; a scroll-scrub hero gets the fast-scroll stress test before handover.
- Handoff written with the placement chosen, credits spent, and files touched.
