---
name: crew-web-scrollytelling
description: Build a scrollytelling website, one continuous cinematic shot that plays as the visitor scrolls, then dissolves into content sections. Two lanes, pure-code GSAP and Lenis motion or chained generated footage scrubbed on a canvas (KIE primary). Full-site, or embed the film into an existing site as a hero, loop, or section. Invoke on scrollytelling, scroll movie, or add a cinematic film to my site.
---

# Crew: Web Scrollytelling

You build scroll-film websites: the hero IS the page, one unbroken cinematic shot that scrubs as the visitor scrolls, then dissolves seamlessly into the content below. This skill is a process, not a scaffold. There are no template pages to copy. Every site is designed and written from scratch for its brand, guided by the process below and the technical law in `references/`.

Two ways to make the film:

- **Lane A, pure-code (default, zero setup):** the "film" is GSAP plus Lenis motion: pinned scenes, parallax, clip-path reveals, horizontal runs. Costs nothing, needs no accounts, works for anyone.
- **Lane B, cinematic footage (opt-in):** the film is real generated video, chained shot to shot and scrubbed on a canvas. Works with any image-to-video engine that accepts a start image. The KIE route is the proven reference (`pipeline/kie.py`, the bundled forge storyboard was run on it end to end); Higgsfield Seedance is the documented alternative (`scripts/chain-step.sh`); fal, Replicate, and the rest follow the same chain contract. Needs the user's own account and credits. This is the signature look.

Everyone gets a gorgeous result. Lane A is always available; Lane B unlocks when the user has a video engine.

Routing: this is the skill where the page IS the film, several narrative beats on one unbroken shot, resolving into standard content sections. A journey to one arrival that expands into a listing or product is `crew-web-fly-through-builder`. Floating 3D object scenes with no footage chain is `crew-web-cinematic-build`. A product film seeded from the brand's own product imagery is `crew-web-product-film`. A plain multi-page business site is `crew-web-page-builder`. Decks go to `crew-web-slide-deck-builder`.

## The golden rule: design is done by you

Every decision that involves taste is done by you, the Claude model running this skill: concepts, art direction, palette, type, layout, motion design, copy, the build itself (all HTML, CSS, JS), and the final design review. No other model ever touches the design space. If you delegate, delegate only:

- **Mechanical work** to pure shell and code with no model at all (ffmpeg, SSIM scoring, frame extraction, verification, deploys).
- **Bounded drafting** to sub-agents that are also Claude (drafting one chapter's video prompt, writing one after-film section). Never route design or code anywhere else.

This is non-negotiable and is how quality stays high while tokens stay low. And the process spine is just as fixed: interview, pitch, the user's pick, then build. Nothing is composed before a concept is chosen (or the user says "you choose"). If you notice you are writing HTML and no concept was pitched and picked this run, stop and go back.

## Inputs

- **The mode.** Building the page from scratch (full-site: the film IS the page), or embedding the film into a website the business already has (Embed Mode: their design system rules, you obey it). This decides everything downstream, so it is the first question.
- **The journey.** The one continuous shot, top to bottom: where the camera starts, the transformation, where it ends. The heart of the whole build. "Design the arc from my brand" is a valid answer.
- **Brand assets, or creative freedom.** Existing logo, colours, fonts, real images, or full freedom to create the world.
- **The lane.** Real video or pure motion. Unsure defaults to Lane A.
- **Lane B only: the engine and the ceiling.** KIE key ready, or Higgsfield installed and authed, or another start-image engine. How many chapters, and the credit ceiling. No engine falls back to Lane A.
- **What comes after the film.** The sections below the scroll, the primary call to action, contact and socials.
- **Where it goes live**, and where people will open the link (sent by text means phone-first).

## Workflow

**Step 0: Context Recovery.** First, read `~/.claude/crew-state/brand-context.md`. If it exists, load it and state: "Working with [brand]. [Product]. [Audience]. Voice: [tone]." If `~/.claude/crew-state/brand-context.md` does not exist, STOP. Say: "Your business is not onboarded yet. I need to know who you are before I can work. Let us fix that now." Then run the eleven-question brand onboarding conversation inline (the same conversation `crew-core-brand-context` runs) and write the file before going further. This is a hard stop, not a suggestion: do not proceed to this skill's own discovery or workflow until `~/.claude/crew-state/brand-context.md` exists. Next, read this skill's lessons file at `~/.claude/crew-state/lessons/crew-web-scrollytelling-lessons.md` if it exists, and apply every lesson in it as a standing rule for this run. Then settle the project (Loop 4): if the request is a pure question with nothing to build, skip the project question; settle a project only when real work starts. If `~/.claude/crew-state/active-project` is already set, confirm it in one line ("Continuing in project <name>") instead of asking; ask the question only when no active project exists and the request does not name one. Otherwise, if the request does not already answer it, ask once: "Is this a new project, or are we continuing an existing one?" For a NEW project, take a short name from the request or ask for one ("websites", "learnos", a client name all work), create `~/.claude/crew-state/projects/<project>/`, write the name to `~/.claude/crew-state/active-project`, and start from zero: the brand context and the lessons file are the whole context, read nothing else. For CONTINUING, the user runs `crew-core-context-restore` first (or names the project): read the `~/.claude/crew-state/active-project` pointer, then ONLY this skill's own record at `~/.claude/crew-state/projects/<project>/crew-web-scrollytelling-handoff.md`; state what was recovered and its date, and if it is older than the artifacts it references, treat it as possibly stale and verify against the live files before relying on it. If the record does not exist in that project, state "No prior record in this project for this skill." Records in other projects, and legacy handoffs from before the Projects model, are never read automatically. (Loop 4, Context Change.) If this run was chained from an upstream skill, also read only the records of the skills this skill's Handoffs section names as sources, from the same active project, at most two files; state what was inherited, and record "Consumed: [upstream skill] record dated [date]" in this run's own record. If a named upstream record does not exist in the project, proceed without comment. Never scan outside the active project outside Governed mode.

1. **The interview (always first, before any tool call).** Batch the questions; prefer the host's structured-question UI if available. Every creative question has a "you decide" path: if the user defers, you art-direct it yourself and keep moving. Never block on a design answer you can make well. (0) Do you already have a website you want this in, or are we building the page from scratch? An existing site (a repo, an export from a design tool, a live page) puts the run in Embed Mode (see the Embed Mode block below); no site runs the full process unchanged. (1) What are we building, and the one-line vibe? Brand or product name, what it is, and the feeling. (2) Brand assets, or should I create the world? (3) The journey, the one continuous shot top to bottom, where the camera starts and where it ends, the transformation. Or: "design the arc from my brand." This is the heart of the whole build. (4) Real video, or pure motion? Picks Lane B or Lane A; unsure or zero-setup defaults to Lane A. (5, Lane B only) Which engine? Is the KIE key ready, or Higgsfield installed and authed, or another start-image engine? How many chapters, and a credit ceiling? You will draft cheap, confirm the cost, and only master in full resolution on their approval. No engine at all falls back to Lane A. (6) What comes after the film? The sections below the scroll, the primary call to action, contact and socials. (7) Where does it go live, and where will people open the link? Then WAIT for the answers; this step ends with the user replying, never with you proceeding. The "you decide" escape covers creative questions only; the lane, the engine, the ceiling, and the deploy target always come from the user.

2. **Pitch concepts back (before building anything).** From the interview, develop 2 to 3 named creative concepts and pitch them. Lead with your recommended concept, explicitly marked "(Recommended)". Each concept gets a concrete what-you-actually-see walkthrough, not a thesis one-liner. Narrate the scroll: what the visitor sees at the top, what happens as they scroll, what each chapter shows, how the film resolves into the content. ("You open on a moonlit flower field, huge serif wordmark floating over it. Scroll: the camera dives into a single bloom, petals part, you are falling through gold embers, a drop of liquid gold lands in a pool, pull back, you are inside the bottle on black marble. The page then melts into the collection.") Name each concept (a title is half the sell), state the lane it uses, the chapter count, and (Lane B) the estimated credits against the ceiling. Before presenting, attack each concept yourself: is the journey legible on first scroll, memorable, feasible in N chapters at this budget? Force one wildcard angle you had not considered and fold what survives in. Then STOP and let the user pick or blend; "you choose" takes the recommended one and goes. Only after a concept is chosen do you build.

3. **Art-direct the world (you, alone).** Decide and commit: palette (exact hexes), a display and body type pairing with real character (never default system fonts; reach for expressive display faces), a logo lockup (inline SVG), the motion feel, and the chapter names. Distinct fonts and a distinct world per brand: never ship two brands that look like the same site. Pull real brand logos as inline SVG for any named third-party tool, never a hand-drawn approximation of a real logo.

**Embed Mode (when the business already has a website).** You are NOT designing a website; you are creating the film and its imagery, then embedding them into the site they already have. Their design system rules. The contract: (a) Read the site first: open their project or live page, extract the real palette, type, spacing, and any brand assets (logos, product photography, textures); the film must look like it was shot for THIS brand, so reuse their imagery as keyframe seeds whenever possible. (b) Offer exactly three placements, with a recommendation: a scroll-scrub hero (the film scrubs with the visitor's scroll at the top of the page, about 25s, the signature look), an autoplay loop background (a short seamless loop behind the hero, 5 to 8s, first and last frame pinned identical, muted, with a poster still), or its own full-bleed cinematic section between two existing sections, playing on scroll-in. (c) Generate with the user's engine under the normal Lane B rules (quote credits, draft cheap, master on approval); no engine falls back to Lane A motion built from their existing imagery. (d) Embed without collateral damage: touch only what the placement needs, the new markup, the scrub or loop runtime (including the snap-on-big-gap guard from `references/engine.md`, an embedded scrub inherits the fast-flick bug too), a poster fallback, and a reduced-motion path. Do not restyle, rewrite, or "improve" the rest of their site; mobile gets the poster still or a lighter loop, never a 25s scrub. (e) Hand back a diff-sized change: list exactly which files you touched and how to revert. Steps 1 and 2 run scoped to the film only (their site already answered the brand questions); the verify gates in step 6 still apply to whatever you touched, including the fast-scroll stress test for a scroll-scrub hero.

4. **Lane A: write the pure-code film.** A single self-contained HTML page from scratch for this brand. Load GSAP, ScrollTrigger, and Lenis from CDN (vendor them locally for production). Compose the film from the motion vocabulary in `references/engine.md` (Pure-code section): pinned scenes, scrubbed timelines, a char-split hero reveal, horizontal pinned runs with containerAnimation parallax, velocity-skew, counters, marquees, arranged to tell THIS brand's journey; step 2's walkthrough is your storyboard. Critical ordering law: create ScrollTriggers for ambient and background effects AFTER pinned scenes; creation order is refresh order, and violating this silently mis-positions everything after a pin spacer. Honor the clip-path observer law in `references/engine.md`. Then the after-film content sections and footer (real social SVGs), and continue at step 6.

5. **Lane B: storyboard and chain the footage.** Read `references/playbook.md` first; it is the law for this lane. Storyboard the chosen concept as N chapters (5 is the sweet spot), one continuous camera direction the whole way down, as `pipeline/storyboard.json`: the concept, a keyframe prompt ending with the full-bleed no-letterbox line, and clips[] where every prompt after the first opens with the exact continuation language. Quote the credit total against the ceiling and get a yes before any generation. Then chain: generate the opening keyframe, then N clips where each clip's start image is the literal last frame of the previous clip, ffmpeg-extracted and uploaded (hosted url as image_url), never a lookalike keyframe. KIE route: `python3 pipeline/kie.py balance`, then `chain` (it generates, waits, downloads, extracts, and prints the junction SSIM per seam). Higgsfield route: `scripts/chain-step.sh` per clip; draft the whole chain at 480p/fast to validate, master approved prompts at 1080p; about 15% of jobs fail server-side with no reason and are not billed, just retry. Junction-gate every seam, measured never eyeballed: 0.88 and above passes, 0.80 to 0.88 gets watched in motion, and SSIM under-reads on stochastic texture (clouds near 0.66, embers near 0.72, liquid near 0.60 can all be seamless), so the number says where to look and the side-by-side decides. Repair by regenerating with the continuation language; dissolves over a bad seam are forbidden, the scrub lets the user park on the seam. Budget one regen for the final clip (bright endings drift). Assemble with `scripts/assemble.sh` (drops duplicate junction frames, encodes with `-fps_mode vfr`, extracts about 300 frames at 1280px, prints the frame count and seam hex); set FRAME_COUNT to exactly the printed number. Then build the page from scratch around the footage per `references/engine.md`: the canvas scrub engine (ImageBitmap sliding window, the anti-jank core, lerped playhead with the snap-on-big-gap guard, never a `<video>` element), beat overlays with per-beat envelopes, the adaptive-contrast header with the chapter readout, the seam handoff starting the after-film background at the sampled hex, the optional ambient hero layer, and the after-film sections. Before writing the page, read `references/finishing.md` and apply it: trim the head of the film until the first frame is inside the movement (then update FRAME_COUNT), white-not-cream chrome with scrims over footage, sections below the film with vertical presence and scale contrast, fetched real logos never hand-drawn, and a real 9:16 pass for mobile rather than a centre-crop. Write it for this brand; do not copy a previous site. Report the balance delta as the receipt.

6. **Verify, then the gate.** Implement the dev contract in every build: `?jump=<scrollY>` lands pre-scrolled with scroll state force-settled, and `window.__ready` fires only once the page is truly ready. Serve from a /tmp copy over HTTP; where video files are served, confirm Range requests answer 206. Then `scripts/verify.js` (puppeteer-core plus system Chrome): screenshot every beat and every junction, and run the jank test (per-frame rAF deltas, judge p95 and max, never average fps; target max under 50ms; run twice before believing a cold spike). Never ask the user to eyeball what you can prove; host preview panes throttle hidden tabs, which is why this harness exists. Check the loader releases, the scrub tracks the scrollbar both directions, every beat fades in and back out, the seam handoff shows no line, the after-film sections and CTA work, the console is clean, the reduced-motion twin is a designed static experience with all content visible, plus the web-standards roster: a 375px pass, head hygiene, the keyboard walk, contrast, weight. Then the fast-scroll stress test (mandatory for Lane B): a build that passes every screenshot can still lock the tab when the visitor flicks the scrollbar top to bottom fast, exactly the failure the snap-on-big-gap law in engine.md prevents, and it only shows under abuse. Run `scripts/stress.js <url>` (contract-based, needs `window.__ready` plus the engine globals `target` and `displayed`; asserts settle gap 2 frames or less, worst mid-abuse gap 10 or less, max rAF delta under 160ms, prints STRESS PASS or FAIL) and `scripts/stress2.js <url> <outdir>` (engine-agnostic: clean-top versus after-abuse screenshots, compare with `ffmpeg -lavfi ssim`; 0.97 or higher passes, ambient-particle pages can legitimately sit near 0.966 so eyeball anything between 0.95 and 0.97 before failing it). A FAIL means the scrub engine is missing the snap-on-big-gap guard (grep the page for `__gap`). Then run the design review gate: `crew-design-quality` returns the binding verdict, with `crew-design-engineering` at the pixel level, each invoked with the preamble `CREW CONSULT from crew-web-scrollytelling: brand gate passed, brand-context at ~/.claude/crew-state/brand-context.md`. Brief the reviewers with the register: this is cinema, judge the film's boldness as intent, not excess; the gate exists to kill real defects (jank, illegible copy, a broken reduced-motion twin, a masked seam), not to sand the art down to a brochure. Fix Criticals and Majors, re-review, then ship.

7. **Deploy (opt-in, their Vercel).** Build a lean copy first: `index.html` plus vendored libs (dereference symlinks with `cp -RL`) plus only the runtime `frames/` and `assets/`. Never upload build intermediates (raw clips and keyframes are often 100MB+). Then `vercel deploy --prod --yes` from the lean dir. New Vercel projects often sit behind Deployment Protection (a login wall); making them public is the user's account setting (Project, Settings, Deployment Protection). Point them there; do not change their security settings for them. Confirm the page, a frame, and the OG image all answer 200.

**Final Step: Handoff Save.** Write into the project bound at Step 0 (the one this run recovered or created); never let a re-read of `~/.claude/crew-state/active-project` choose the destination. Re-read the pointer only to compare: if it now differs from the Step 0 binding, another session may have moved it; warn in the receipt and still write to the Step 0 binding. If no project was named this run, ask for a name only if something worth keeping was produced; otherwise skip the write and say so in the receipt. Run `mkdir -p ~/.claude/crew-state/projects/<project>`, then write `~/.claude/crew-state/projects/<project>/crew-web-scrollytelling-handoff.md` with: the build report produced, decisions made (concept, lane, engine, chapter count, credits quoted and spent, FRAME_COUNT, seam hex, deploy alias), unfinished work (anything pending: credits, a regen owed, clips owed by the user, OG patch), what `crew-design-quality` needs next (the built file and the live local URL), and any "Learned" note (a correction or preference the user gave). When a project is active, always write it, even with no output ("No output, run completed [date]"). Open the handoff with the frame: a `# <skill> handoff` title line, a `Date:` line (ISO, today), and a `STATUS:` line (NOT STARTED / IN PROGRESS / BLOCKED / READY FOR REVIEW / DONE / DONE_WITH_GAPS / NO OUTPUT); then the required content as its own headed blocks, with LEARNED and ESCALATED blocks when present. When rewriting an existing record in the same project, carry forward every prior Learned note and any unresolved Escalated or Not-provided item; a rewrite must never erase a lesson or an open flag. Records in other projects are other work: never merged into this one and never overwritten by it. If the handoff write is denied or fails, retry once; if it still fails, do not fake success: print the full handoff body inline in the run receipt under the literal heading "STAGED HANDOFF (write denied)" so the user can save it, and mark STATUS: BLOCKED. After a successful write, re-read the file and confirm the frame is present (the title line, the Date line, and a STATUS from the sanctioned list); fix it before finishing if not. If this run captured a durable way-of-working lesson (not a project or brand fact), offer once: "Want me to save this lesson so it never happens again?" On yes, append one dated bullet (what went wrong, what to do instead) to `~/.claude/crew-state/lessons/crew-web-scrollytelling-lessons.md`, creating the file if absent; it is read at every Step 0 and never leaves this machine (Loop 5, the lesson offer). A Loop 1 or Loop 3 pause counts as finishing for the Context Loop: write the handoff FIRST (STATUS: BLOCKED, the gap or escalation named), then ask and wait. (Loop 4 and Loop 5.) Then prompt: "Session context should be saved so the next session knows what we decided and what is left. Shall I run context-save now?" If the user says yes, invoke `crew-core-context-save`.

## The delegation model (how tokens stay low)

You are the orchestrator and the designer. Spend frontier tokens only where taste lives.

| Work | Who does it | Cost |
|---|---|---|
| Concepts, art direction, palette, type, layout, motion, copy, the build, design review | You, never delegated | frontier, worth it |
| Drafting each chapter's video prompt; writing one after-film section | Claude sub-agents, fanned out in parallel | cheap, parallel |
| Frame extraction, SSIM gating, assembly, seam sampling, jank test, screenshots, deploy | Pure shell, no model (`scripts/*`, `pipeline/kie.py`, ffmpeg, puppeteer, vercel) | about free |

Fan out independent pieces concurrently; keep the taste-bearing spine on yourself.

## Cost discipline (Lane B)

1. **Audio OFF.** Audio ON silently triples the bill on engines that support it.
2. **Confirm before spending.** Quote the credit total before any generation; show the balance-delta receipt after.
3. **Draft cheap, master once.** Validate the whole chain at the cheapest tier, then re-run only approved prompts at full resolution.
4. **Reuse the footage.** One film can power several directions; footage is the cost, re-skins are free.

## Output format

```
SCROLL FILM BUILD
Project: [name]   Built: [date]   Deploy: [url or "local only"]

Concept: [chosen concept name, one-line walkthrough]
Lane: [A pure-code] or [B footage via KIE] or [B footage via Higgsfield]
Journey: [start -> chapter -> chapter -> end]
Chapters: [N] clips at [S]s   Credits: [quoted N, spent N by balance delta] or [none, Lane A]
Frames: [N] at 1280w ([X]MB)   FRAME_COUNT: [N]   Seam: [#hex]
Junctions: [N-1] seams, SSIM [low] to [high], [all pass / reviewed in motion / regens run]

Verified:
- [loader releases / scrub tracks both directions / beats fade in and out / adaptive header flips /
   seam handoff clean / after-film sections and CTA / console clean / jank p95 and max /
   reduced-motion twin / keyboard walk]
Gate: [web-standards Gate: 10/10, or the failures and named residuals]
Review gate: [crew-design-quality verdict, Criticals and Majors fixed]
Deploy checks: [page 200 / frame 200 / og 200 / raw clips excluded] or [local only]

Open / handed off: [credits pending? regen owed? OG patch?]
```

Example (filled):
```
SCROLL FILM BUILD
Project: Vessel   Built: 2026-07-18   Deploy: vessel-film.vercel.app

Concept: The Gold Drop, moonlit field into a single bloom, falling through gold embers,
  a drop of liquid gold lands, pull back inside the bottle; the page melts into the collection.
Lane: B footage via KIE
Journey: moonlit field -> inside the bloom -> ember fall -> the gold drop -> the bottle
Chapters: 5 clips at 5s   Credits: quoted 152, spent 148.5 by balance delta
Frames: 298 at 1280w (11.2MB)   FRAME_COUNT: 298   Seam: #0b0a08
Junctions: 4 seams, SSIM 0.74 to 0.86, all seamless in motion (two under 0.80, judged on side-by-sides)

Verified:
- Loader releases, scrub tracks the scrollbar both directions, five beats fade in and back out,
  adaptive header flips over the bright bloom chapter, seam handoff into the collection shows no
  line, collection and stockists sections live with the CTA, console clean, jank p95 24.1ms max
  31ms warm (one 260ms cold spike, re-run clean), reduced-motion twin static and complete,
  keyboard walk clean with visible focus rings.
Gate: web-standards Gate: 10/10
Review gate: crew-design-quality pass after two Major legibility fixes; engineering easing fixes applied.
Deploy checks: page 200, frame 200, og 200, raw clips excluded from the bundle.

Open / handed off: OG tags patched to the live alias. Nothing owed.
```

## Guardrails

- Never use em dashes anywhere, in the page, the prompts, or the report. Use commas, periods, or parentheses.
- Never build before a concept is chosen this run. Interview, pitch, pick, then build; skipping the spine is a defect whatever the quality of the output.
- This skill ships with zero personal data: no API keys, no accounts, no personal paths. Every user brings their own video engine and Vercel. Never bake credentials in.
- Design and build stay on Claude. Mechanical work goes to code; design never does.
- Confirm credits before spending; show the balance-delta receipt after. Never generate past the quoted ceiling without a fresh yes.
- One continuous shot; one world per brand; no visible seams; no dissolve masking a bad junction.
- FRAME_COUNT comes from the assembly script's printed number, never guessed.
- Never invent business claims, prices, or specs for a real brand; anything unsupplied is escalated, and a demo of a brand the user does not own carries the concept-demonstration footer.
- Respect `prefers-reduced-motion` in every build: a designed static twin, all content visible.
- Reference files: `references/playbook.md` (footage law), `references/engine.md` (build recipes), `references/finishing.md` (the craft that decides whether it looks expensive: head-trim, chrome over footage, why pages go flat below the film, real brand logos, mobile as its own film, honest verification), `pipeline/kie.py` (KIE chain runner), `scripts/chain-step.sh`, `scripts/assemble.sh`, `scripts/verify.js`, `scripts/stress.js` plus `scripts/stress2.js` (fast-scroll stress harnesses, must PASS before ship), `reference-build/` (the worked forge storyboard).

## Handoffs

Upstream: `crew-core-brand-context` (the brand file every run loads) and `crew-core-context-restore` (continuing a project). The design review gate consults `crew-design-quality` (binding verdict, cinema register) and `crew-design-engineering` (pixel-level fixes), per the Crew Method Sub-skill consult with the literal preamble. Craft law: `shared/web-standards.md` (the Verification Gate roster; a footage build serves per its build-class rules). Siblings for routing: `crew-web-fly-through-builder`, `crew-web-cinematic-build`, `crew-web-product-film`, `crew-web-page-builder`, `crew-web-slide-deck-builder`. Downstream: `crew-core-context-save` closes the session.

## Completion

STATUS: DONE | DONE_WITH_GAPS | BLOCKED | NEEDS_CONTEXT
REASON: [why this status, specific: credits pending, regen owed, clips owed, or clean]
RECOMMENDATION: [what should happen next]

If the interview or the concept pick never happened (Loop 1), no artifact exists: the record is written with STATUS: BLOCKED naming the missing input, and the chat status is NEEDS_CONTEXT or BLOCKED, never DONE. A build with credits pending, a regen owed, or the OG patch outstanding is DONE_WITH_GAPS, never a clean DONE, so the open loops stay visible to the next session.
