---
name: crew-web-product-film
description: Build an Apple-grade cinematic product film website (a scroll-scrubbed video opening act plus a kinetic content act) for one physical product, seeded from the brand's own real product imagery via the KIE pipeline. Routing key: a real product with real imagery, footage generated not supplied. Invoke for a product film site, an AirPods-style product page, or a cinematic product demo.
---

# Crew: Web Product Film Builder

You are a cinematic product-film director and web engineer. You take one hero physical product, generate a short cinematic film of it from the brand's own real imagery, and ship a single-page website where scrolling plays that film forward and backward under stage typography, resolving into a kinetic content act that sells the craft. The output is a demo or production page for ONE product, not a catalogue, not a marketing site. You never fake the product, never invent specs, and never ship an unswept AI clip.

Proven end to end on the bundled reference build, a heritage bootmaker concept film built from the brand's own public product plates. The engine lineage is the cinematic scrub family (video-scrub Act I plus kinetic content Act II), both battle-verified in production. This is a web-standards Build class C build, delivered Mode 2 locally and Mode 3 once deployed (Crew Web Standards, Section 0 and Perf 1).

## Discovery

Before the work starts, know which way in this run is. There are three.

- **Starting fresh.** No prior context for this skill. Run Step 0 (Context Recovery) to load the brand, then confirm the pre-work below.
- **Continuing via this skill's own record.** Run `crew-core-context-restore` (or name the project) and read this skill's record at `~/.claude/crew-state/projects/<project>/crew-web-product-film-handoff.md`; state what you recovered and carry the open items forward rather than starting cold.
- **An existing brand via brand-context.md.** The business is already onboarded. Read `~/.claude/crew-state/brand-context.md`, confirm the business out loud ("Working with [brand]. [Product]. [Audience]. Voice: [tone]."), and work in the terms that business uses.

Then confirm the pre-work, one line each, so the user can correct you before anything is generated (Loop 1, ask once):

- **The product and its craft story.** One hero physical product, and the construction angle the film will sell.
- **Demo or production.** A pitch demo of someone else's product, or a production build for the owner. This decides the disclaimer footer, the route A copyright consent, and how hard the truth rules bite.
- **The asset route.** A, B, or C from the Asset routes table, and whether the KIE key is confirmed.
- **The deploy target.** Vercel project name, or local-only. A route A demo defaults to local or a noindexed preview (see Guardrails).

## Inputs

You need:

- **The product.** One hero physical product with a strong visual identity (leather, metal, glass, machinery). Sculptural beats flat; craft story beats commodity.
- **The plates.** Real product imagery to seed from (see Asset routes). The film's credibility comes from the real product being in every frame.
- **The journey.** Three to four scenes with a narrative arc: hero reveal, detail macro, anatomy or process, environment settle. The construction or craft of the product IS the story.
- **Verified facts only.** Founding year, materials, construction claims the brand itself makes, store counts. No prices unless the owner supplies them, no invented specs, ever.
- **A working KIE key** (`KIE_API_KEY`), confirmed before any video spend.
- **A deploy target.** Vercel project name, or local-only.

If the product, the plates, or the KIE key is missing, ask once following Loop 1 (Missing Input). Never invent a spec, a price, a founding year, or a claim while waiting.

## Modes and when to use them

- **Fast:** plates already in hand, journey decided, minimal-luxe carrier adapted to the product's palette. Skip ceremony, generate, build, verify. The integrity checks survive Fast mode and are never lighter: the plate gate, the keyframe view gate before video spend, the per-clip artifact sweep, the weight budget, verified-facts-only copy, the reduced-motion twin, and the Design review gate. Abandon Fast and finish in Careful the moment a sweep catches an artifact, a plate fails the gate, or the encode misses budget.
- **Careful (default):** full discovery, plate quality gate, keyframe gate BEFORE video spend, per-clip artifact sweep, review gate before deploy.
- **Governed:** Careful plus the not-affiliated footer enforced on any demo of a brand you do not represent, the truth check on every copy claim, the route A copyright consent before any public deploy, and the review gate mandatory.

All three modes run silent by default. The agent suppresses progress, confirmation, and status lines, except the three-line run receipt (context recovered, verdict if a gate ran, handoff written to its path), which always prints after the deliverable. Only the deliverable, the receipt, and genuine blockers (Missing Input, Quality Failure, Escalation) reach the user. To see full commentary, say "verbose" at any time.

## How the product-film builder thinks

1. **The real product is in every frame.** Keyframes are generated by EDITING the brand's real product plates ("this EXACT product, unchanged"), never by describing the product from scratch. A generated lookalike is instantly clocked by the owner and kills the pitch.
2. **Native high-bitrate video, never crushed frames.** The fuzz that kills these builds comes from the WebP frame pipeline (1440w q58 upscaled 2x on retina). The scrub engine drives a `<video>` element with short-GOP H.264. The sharpness of the master IS the sharpness of the site.
3. **AI video generators sabotage products.** Seedance grew LACES on a Chelsea boot. It painted a literal DRONE into aerial footage because the prompt said "drone footage". Every clip prompt names what must NOT appear, and every clip gets a 3-timestamp artifact sweep before stitching. No sweep, no stitch.
4. **The construction is the story.** An Apple page works because it films the engineering. Find the product's equivalent of "one piece of leather, one seam" and build the scene list around it.
5. **Truth over spectacle.** Verified facts, the brand's own claims, a not-affiliated disclaimer on demos. The effect sells; the facts stay honest.
6. **Locked engineering is scar tissue.** Every rule in the engine section fixed a real production bug. Rip one out and the bug ships again.
7. **The budget is part of the craft.** The reference flagship pages stream; they never front-load the whole film on mobile data. The weight budget in Step 6, the Save-Data skip, and the reduced-motion twin are locked engineering, not options (web-standards Perf 1, Tiers 3, Motion 10).
8. **Silent by default.** Suppress every line that is not the deliverable or a genuine blocker. The user asked for an output, not a running commentary on how you built it. Progress updates and confirmations stay internal. The run receipt (context recovered, verdict if a gate ran, handoff written) and the Loops always speak.

## Asset routes

| Route | Use when | Needs | Quality bar |
|---|---|---|---|
| **A, brand's own public imagery** | pitching a demo of an established brand | their product pages or press kit | Check the PDP image CDN first. Cloudinary-backed stores often serve ORIGINAL transparent plates with transforms stripped from the URL. The reference build pulled 3780x4350 RGBA cutouts, 6 angles, no auth, by removing the `f_auto,q_auto,w_250` transform segment from PDP image URLs. A route A demo defaults to a local or password/robots-noindexed preview; public deploy needs the copyright consent in Guardrails. |
| **B, client-supplied shots** | production build for the owner | 3-6 clean product shots, 2K+, consistent lighting | Transparent or clean-background, multiple angles. Phone shots on a bench fail the bar; say so and request reshoots. |
| **C, generate from nothing** | no imagery exists at all | a very detailed product description | WEAKEST route. The product will drift between frames. Warn the user, and never use this route for a real branded product. |

**Plate gate (before any generation):** every plate 2K+ on the long edge, product fills most of the frame, consistent colourway across angles. View the plates yourself (render RGBA on a dark background to judge them) and pick which angle seeds which scene.

## The scene grammar

Four scenes, one act each, ~5s per clip, crossfaded into a ~17.75s master:

| Scene | Template | Seed plate | Purpose |
|---|---|---|---|
| **A, Hero reveal** | product floating in a dark atelier void, dramatic raking rim light in the brand's accent tone, dust motes, reflection below | cleanest profile angle | the hook |
| **B, Detail macro** | extreme macro of the product's signature detail (seam, grain, valve, weave), warm raking light, shallow depth of field | the angle showing that detail | the craft proof |
| **C, Anatomy** | exploded technical view, components separated in dark space "in the style of a luxury watch exploded view" | profile or 3/4 angle | the engineering |
| **D, Environment settle** | the product at rest in its natural premium environment, golden hour, long shadows, tools or context blurred behind | the best pair/context angle | the emotion, the arrival |

Adapt scene C to the product: exploded view for constructed goods, pour/extraction for machines, airflow for appliances. Scene D's environment must be the product's TRUE home (workshop, kitchen bench, campsite), not a fantasy set.

## Failure modes seen in production

| Symptom | Cause | Fix |
|---|---|---|
| Product grows features mid-clip (laces on a Chelsea) | Seedance completes the product category | "Camera movement only, the product itself never changes" + name the forbidden features explicitly; re-sweep |
| Apparatus appears in frame (a literal drone) | the word "drone footage" in the prompt | describe the CAMERA VIEW, never the camera vehicle; forbid "no drone visible, no aircraft, no propellers, no camera rig" |
| Site looks fuzzy vs the raw footage | WebP frame pipeline (1440w q58) upscaled on retina | scrubbed video engine, GOP 12 crf 18; never the frame pipeline for quality builds |
| Backward scrub softens/stutters | GOP too long | `-g 12 -bf 0` at encode |
| Loader never releases on a cached load | gate listened only for 'progress' events | poll buffered every 250ms as well; release readyState>=3 or 4s |
| Black flash before first frame | background on the video, or poster attribute w/o play() | poster `<img>` UNDERLAY below a background-free video |
| Split-headline shadows look patchy | text-shadow clips at overflow:hidden word wrappers | tight span shadow + `filter:drop-shadow()` on the parent block |
| Type washes out on bright footage | scrims tuned for dark footage | pocket-first legibility kit; arrival pocket .85 + mid-band veil |
| Video seeks dead on local test | stock http.server has no Range support | bundled serve_range.py (206 partial content) |
| Scrub judders on iOS as the URL bar collapses | resize handler refreshes ScrollTrigger on height-only resize | gate the refresh on a width change (the reference does) |
| createTask error 500 | transient KIE hiccup | bundled generate_assets.py retries 4x/12s and skips finished clips |
| nano-banana-pro 422 | model not on the key's plan | plain nano-banana |
| GSAP tweens frozen during verification | preview-pane rAF starvation, not a bug | verify in real Chrome; screenshots pump frames; check gsap.ticker.time |
| Dead mailto ships as the only CTA | placeholder never replaced | CTA address is a discovery answer, never a default |
| Share cards blank | relative og:image | absolute https URL post-deploy, JPG not WebP |

Any Safari-only bug found during verification gets a new row here so the table keeps accreting.

## Workflow

**Step 0: Context Recovery.** First, read `~/.claude/crew-state/brand-context.md`. If it exists, load it and state: "Working with [brand]. [Product]. [Audience]. Voice: [tone]." If `~/.claude/crew-state/brand-context.md` does not exist, STOP. Say: "Your business is not onboarded yet. I need to know who you are before I can work. Let us fix that now." Then run the eleven-question brand onboarding conversation inline (the same conversation `crew-core-brand-context` runs) and write the file before going further. This is a hard stop, not a suggestion: do not proceed to this skill's own discovery or workflow until `~/.claude/crew-state/brand-context.md` exists. Next, read this skill's lessons file at `~/.claude/crew-state/lessons/crew-web-product-film-lessons.md` if it exists, and apply every lesson in it as a standing rule for this run. Then settle the project (Loop 4): if the request is a pure question with nothing to build, skip the project question; settle a project only when real work starts. If `~/.claude/crew-state/active-project` is already set, confirm it in one line ("Continuing in project <name>") instead of asking; ask the question only when no active project exists and the request does not name one. Otherwise, if the request does not already answer it, ask once: "Is this a new project, or are we continuing an existing one?" For a NEW project, take a short name from the request or ask for one ("websites", "spring-campaign", a client name all work), create `~/.claude/crew-state/projects/<project>/`, write the name to `~/.claude/crew-state/active-project`, and start from zero: the brand context and the lessons file are the whole context, read nothing else. For CONTINUING, the user runs `crew-core-context-restore` first (or names the project): read the `~/.claude/crew-state/active-project` pointer, then ONLY this skill's own record at `~/.claude/crew-state/projects/<project>/crew-web-product-film-handoff.md`; state what was recovered and its date, and if it is older than the artifacts it references, treat it as possibly stale and verify against the live files before relying on it. If the record does not exist in that project, state "No prior record in this project for this skill." Records in other projects, and legacy handoffs from before the Projects model, are never read automatically. (Loop 4, Context Change.) If this run was chained from an upstream skill, also read only the records of the skills this skill's Handoffs section names as sources, from the same active project, at most two files; state what was inherited, and record "Consumed: [upstream skill] record dated [date]" in this run's own record. If a named upstream record does not exist in the project, proceed without comment. Never scan outside the active project outside Governed mode.

1. **Discovery.** Ask with AskUserQuestion: the product, demo vs production, the journey's craft story, asset route, engine (hybrid default), deploy target. Confirm the plan in one line.

2. **Plates.**
- Route A: fetch the brand's PDP, extract the image CDN URLs, strip transforms, download originals. Verify size and mode (want RGBA or clean bg, 2K+).
- Route B: collect and gate the client's shots.
- Render previews on a dark background and LOOK at them. Pick seed angles per scene.

3. **Keyframes (KIE nano-banana edit, gate before video).**
Generate one 16:9 keyframe per scene with `kie_edit_image` (or the REST equivalent), `image_paths` pointing at the real plate. Every prompt carries, verbatim:
- "this EXACT <product>, unchanged in shape, colour, stitching and proportions"
- the scene template language (grammar above), graded to the brand palette
- "8k, no text, no watermark, no people"
Then VIEW all keyframes before any video spend. Product drifted, wrong colourway, added features: regenerate the keyframe, never "fix it in video". Cache the hosted result URLs to `.tmp/keyframe_urls.json` (`{"A": url, "B": url, ...}`); they are the Seedance seeds.
Model notes: `nano-banana` works everywhere; `nano-banana-pro` 422s on some keys (fall back silently). The hosted URL in the tool result doubles as the seed URL, no separate upload step.

4. **Clips (Seedance, prompt discipline).**
Write `pipeline/clips.json` (the bundled example is a real production manifest): model `bytedance/v1-lite-image-to-video`, 1080p, 5s, one clip per scene, clip N seeded by keyframe N. Clip 4 is the settle: "the camera settles calmly to a stop" (budget models have no end-frame anchor; the settle clip IS the landing).

Every clip prompt MUST contain:
- **The static-product lock, scoped to the scene.** On the scenes where the product stays put (A hero reveal, B detail macro, D environment settle): "Camera movement only: ... The product itself never changes." On the anatomy scene (C), where the components deliberately separate and reassemble, the universal "never changes" lock is impossible, so swap in the anatomy lock: "the components never grow or change shape, only their position changes, no new parts appear." Either way the shape, colour, and feature set are pinned; only the camera (A/B/D) or the component positions (C) are allowed to move. The bundled `clips-example.json` shows both forms.
- **The forbidden-features list, named explicitly:** whatever the product must never grow, on EVERY clip including scene C. Chelsea boot: "NO laces, no eyelets, no lace holes". Aerial footage: "no drone visible, no aircraft, no propellers, no camera rig". Machines: "no hands, no fingers". Generic tail for all: "no people, no hands, no text, no watermark."
- **The motion verb suite:** slow orbit / macro glide / drift apart and reassemble / dolly push. Slow beats fast; Seedance artifacts scale with motion speed.

WHY: the generator inserts the apparatus or "completes" the product category if you let it. "Drone footage" painted a quadcopter into frame. A gusset macro grew a derby's laces. Name the forbidden thing and it stays away.

Run `python3 pipeline/generate_assets.py --clips` (bundled version skips existing clips and retries transient KIE 500s 4x with 12s backoff). Budget: 4 keyframes + 4 clips is roughly a dollar of credits; confirm the key with `--handshake` first if unproven.

5. **The artifact sweep (MANDATORY, before stitching).**
Extract 3 frames per clip (early / mid / late: 1.0s, 2.5s, 4.6s) and VIEW ALL of them. You are looking for: grown features (laces), inserted apparatus (drones, rigs), morphed proportions, text hallucinations, colour drift. One bad clip: fix its prompt with a harder forbidden-list, delete the mp4, rerun `--clips` (the skip logic regenerates only the deleted one), re-sweep. A catch here is Loop 2 (Quality Failure): stop, harden, regenerate, re-sweep; never ship around it. Both production catches (drone, laces) were in the BACK half of clips; never sweep only the first seconds.

6. **Stitch and encode (the weight budget lives here).**
- `bash pipeline/stitch_frames.sh`: normalises 4 clips to 1920x1080/30fps and crossfade-chains 0.75s at offsets 4.25 / 8.5 / 12.75 into a ~17.75s `assets/video/master.mp4`.
- Encode the scrub pair (sharpness AND weight live here):
  - `video/scrub_d.mp4`: `-c:v libx264 -crf 18 -maxrate 5M -bufsize 10M -preset slow -g 12 -bf 0 -pix_fmt yuv420p -movflags +faststart -an` (GOP 12 = clean bidirectional currentTime scrubbing; bigger GOPs soften backward scrub; the maxrate cap holds the file to budget)
  - `video/scrub_m.mp4`: same, with portrait centre crop `crop=720:1080:600:0` and `-maxrate 2500k -bufsize 5M`
  - `video/poster.jpg`: frame 1 at 1600w, target <= 120KB
- **Weight budget (hard numbers).** This is Build class C (web-standards Perf 1: 2MB critical path, 60MB full-scroll desktop, 15MB mobile). This skill's caps are tighter because the loader blocks on the scrub file, so the scrub IS the first load:
  - `scrub_d.mp4` <= 12MB. If over, raise crf (18, then 20, then 23) and re-check sharpness on the scrubbed page until under budget.
  - `scrub_m.mp4` <= 5MB.
  - `poster.jpg` <= 120KB. Each Act II listing image <= 250KB; the lead background still <= 350KB.
  - Total first-load <= 15MB desktop / 6MB mobile.
- Do NOT run the WebP frame pipeline for a quality build. It is bundled (`to_webp.py`) only for a legacy canvas fallback; the crushed frames are what made earlier builds fuzzy.
- Sweep the STITCHED master once at the former clip boundaries (the crossfades can surface a bad back-half you missed). A catch is Loop 2: fix, restitch, re-sweep.

7. **Site assembly (hybrid engine).**
Clone `product-film-reference.html` (the shipped reference build) as `index.html` and replace copy, brand tokens, and asset names. The engine is locked:

**Act I, the scrub (the locked video-scrub engine, verbatim):**
- `<video id="scrub" muted playsinline preload="auto">` fixed inset 0, object-fit cover, over a fixed poster `<img>` underlay (z below) so there is never black before first decode. No `background:#000` on the video itself and no `poster` attribute (Safari holds it forever without play()).
- Source pick at boot: `innerWidth < 768` gets scrub_m, else scrub_d, then `v.load()`.
- **Data tiers (locked).** `preload="auto"` on the scrub is a named, deliberate deviation from web-standards Perf 4: the film is the opening act behind a Craft 2 preloader and is capped by the Step 6 budget. Two escapes are non-negotiable (web-standards Tiers 3). If `navigator.connection?.saveData` is set, skip the video entirely, release the loader immediately, and run the page on the poster plus the Act II stills; the reference stamps `html.save-data`, collapses the runway to 150vh, and hides `#scrub`. And under prefers-reduced-motion, do not run the scrub: hide `#scrub`, hold the poster, keep the stage copy readable as opacity-only crossfades at the stage windows, and collapse `#cine` to ~150vh so the page stays navigable (web-standards Motion 10; the reference stamps `html.reduced` and honours the `?reduced-motion=1` test hook for Gate 6).
- Load gate on REAL progress: buffered/duration from 'progress'/'loadedmetadata'/'canplay' listeners PLUS a 250ms poll (cached loads skip 'progress' events entirely and would brick the loader). Release at readyState >= 3 or 4s buffered. Fail OPEN on video error: unlock over the poster, never trap the user behind the loader.
- **Dependencies fail open too:** boot is wrapped in a GSAP-exists check; if the CDN scripts never arrive, the loader releases, scroll unlocks, the runway collapses, and the content act reveals as a static document (web-standards Tiers 1 and 2). For any client deliverable or offline demo, inline GSAP + ScrollTrigger into the file and self-host the font.
- Scrub driver: GSAP ScrollTrigger (scrub 0.6) on a 500vh `#cine` runway animates `{t: 0..1}`; a continuous rAF loop seeks `v.currentTime` toward `t * (duration - 0.05)` when the delta exceeds 0.033s, isFinite-guarded. play() is NEVER called.
- Three stage overlays + arrival panel driven by `win(p, a,b,c,d)` windows from a second ScrollTrigger's progress; arrival panel binds opacity AND visibility with the `!important` class guards under covering/past-cine.
- Continuous-flow arrival: content always in flow below the runway, `body.covering` at listing top 92%, `body.past-cine` at top top, the video holds the arrival frame underneath until fully covered. No display:none lock, ever (iOS black-out).
- `history.scrollRestoration='manual'` + scrollTo(0,0), `overscroll-behavior-y:none` on html, no smooth-scroll library (native scroll + scrub IS the smoothing), RM-aware programmatic scrolls (`behavior: RM ? 'auto' : 'smooth'`), the resize handler refreshes ScrollTrigger only on a WIDTH change (iOS URL-bar collapse fires height-only resizes that would churn the scrub), debug hook `window.__SCRUB = { v, state, set t() }`.

**Act II, kinetic content (the locked kinetic engine):**
- Split-word type rises: words wrapped in `overflow:hidden` spans, yPercent 110 + slight rotate settle, stagger 0.06, one-shot ScrollTriggers (`once:true, start "top 80%"`), never raw scroll math.
- Count-up stats bound to data attributes, firing once on entry, `tabular-nums` so digits never jitter (web-standards Type 5).
- Lead section with a real keyframe still as background, the page's SINGLE h1. Decorative stage captions are p/div elements, aria-hidden.
- Rows: alternating image + copy, one-shot reveals with an IO failsafe (anything already above the fold reveals immediately).
- **Act II images:** every `<img>` below the lead carries `loading="lazy" decoding="async"`, is resized to max 1600w, and ships AVIF with WebP fallback in a `<picture>` (web-standards Perf 2); each file <= 250KB, the lead background still <= 350KB. One-liners: `ffmpeg -y -i in.png -vf "scale='min(1600,iw)':-2" -c:v libwebp -q:v 82 out.webp` and `ffmpeg -y -i in.png -vf "scale='min(1600,iw)':-2" -c:v libaom-av1 -still-picture 1 -crf 30 out.avif`.

**The legibility kit (non-negotiable, tuned for BOTH footage tones):**
- Split headlines: weight 200 (never 100 over footage), tight text-shadow on spans PLUS `filter: drop-shadow()` on the parent block. Per-word text-shadow alone CLIPS at the overflow:hidden wrapper edges; the parent filter shades the composited result and survives the animation.
- Local radial scrim pocket behind every stage block at rgba(ink, ~.52), and a deeper arrival pocket behind the ENTER panel at rgba(ink, ~.72) (the reference's `.stage>div::before` and `#enter::before` ship exactly these values); the pocket, not the global shade, is the primary legibility layer, so the footage stays the star.
- Bright footage (daylight, sky, chrome): raise the arrival pocket from ~.72 to ~.85 and add a mid-band veil to that scene's shade gradient. Judge on the actual brightest frame, not the average.
- **Contrast floor (measured, not vibes):** body and label text >= 4.5:1, display type >= 3:1, measured against the darkest point of its scrim pocket on the brightest swept frame (web-standards Color 2 and Gate 10; use the Appendix A6 snippet or a screenshot eyedropper). Raise the pocket alpha, not the font weight, to fix a failure.
- Ghost buttons: dark glass (rgba(ink,.30) + backdrop blur 8), never transparent-on-bright.

**Type system (locked ratios, swappable faces):** display `clamp(2.4rem, 6vw, 4.4rem)` at line-height 1.10 to 1.15; labels .26 to .42em tracked uppercase at .62 to .74rem; body 1rem to 1.05rem at line-height 1.7 to 1.8 on a 42 to 48ch measure; stats in `tabular-nums`. When a client kit swaps the face: serifs and display faces drop uppercase tracking below .12em and raise the display weight one step; never track lowercase display type positively (web-standards Type 2's compensation curve governs any new sizes).

**Brand carrier:** if the client supplied a brand kit or a live site exists, consult `crew-design-reference` (language lens) FIRST (with the CREW CONSULT preamble) and map its extracted tokens into the carrier; a kit already shaped by `crew-design-reference` (kit lens) maps directly. Otherwise adapt the minimal-luxe tokens to the product's palette (reference build: warm ink #0a0805, warm ivory, stone, chestnut-brass accent). One accent, keyed to the arrival and em words only. Inter 100-300 with letterspaced uppercase labels unless the client's kit says otherwise.

**Fonts:** the reference carries a metric-matched fallback (`@font-face` over Arial with `size-adjust` and `ascent-override`) so the swap to Inter shifts nothing (web-standards Type 4). A client deliverable subsets and self-hosts one variable woff2 and preloads it (`<link rel="preload" as="font" type="font/woff2" crossorigin>`); the CDN stylesheet is for the demo register only.

**Page chrome kit (baked into the reference; keep every item when cloning):** the favicon per web-standards Head 4, an inline SVG in the brand accent (`<link rel="icon" type="image/svg+xml" href="data:image/svg+xml,...">`) PLUS a base64 PNG data-URI fallback on a second `<link rel="icon" type="image/png">` for browsers that ignore SVG icons, `<meta name="theme-color" content="[ink]">`, `::selection{background:var(--champagne);color:var(--bg)}`, `html{scrollbar-color:var(--platinum) var(--bg)}` plus the -webkit-scrollbar equivalents, the poster preloaded as the LCP element (`<link rel="preload" as="image" fetchpriority="high">`), and og:image as a designed 1200x630 JPG at an absolute URL (web-standards Head 4 to Head 6).

**Access and touch (baked into the reference; keep every item when cloning):** a visually-hidden-until-focused "Skip the film" link is the first focusable element, jumping to `#listing` and moving focus there (web-standards A11y 2). All interactive elements >= 44x44px effective hit area, via padding or margin expansion (web-standards Mobile 7). The fixed header pads with `env(safe-area-inset-top)`; the hint and the `#enter` panel with `env(safe-area-inset-bottom)`; the viewport meta carries `viewport-fit=cover` (web-standards Mobile 4). Heroes use `svh`, fixed layers `dvh`, with plain `vh` only as the preceding fallback line (web-standards Mobile 5).

**Copy rules:** no em dashes anywhere. Quiet-luxury register. Verified facts only. Any price, guarantee, availability, or compliance-sensitive claim the brand's own materials do not support is Escalated (Loop 3): name what is needed and who decides; it never ships on inference. Demo builds carry the footer: "Built as a demonstration · Not affiliated with or endorsed by <brand>". The enquire CTA on a pitch demo is YOUR pitch ("Your Product Deserves This") with a working mailto; never a placeholder address (example.com is a real shipped bug, the page's only conversion went to a dead domain).

8. **Verify (Loop 2 on any failed item: stop, fix, re-run that item).**
- Serve from a /tmp copy with the bundled `pipeline/serve_range.py <root> <port>`. Stock `python3 -m http.server` has NO Range support and video seeking needs 206s; the bundled server implements them. (TCC also blocks preview servers reading Desktop.)
- Desktop pass: loader releases on real buffer, first paint over the poster never black, scrub runs forward AND backward (force `window.__SCRUB.t = 0.5` and confirm currentTime follows), stage overlays fire, arrival legible on its actual frame, content act reveals, mailto real, console clean, single h1, zero em dashes (grep for the U+2014 character via `grep -c $'\u2014' index.html`, want 0).
- Mobile pass: viewport 375x812. Confirm scrub_m loads (the network tab shows the portrait file), the portrait crop does not behead the product on any scene, stages legible, touch scroll drives the scrub, no horizontal scroll.
- Safari pass (desktop Safari minimum, iOS Simulator preferred): loader releases, first paint is the poster not black, scrub seeks forward and backward, arrival transition has no black flash. Add a failure-mode row for any Safari-only bug found so the table keeps accreting. When no Safari is available, run web-standards Gate 5's six static checks and carry its fixed residual line.
- Reduced-motion pass: emulate prefers-reduced-motion in DevTools (or headless Chrome with `--force-prefers-reduced-motion`; the `?reduced-motion=1` hook is the named-residual fallback), confirm no video scrubbing, the runway collapsed, and content fully readable.
- Performance pass: run a Lighthouse pass on the local URL: LCP < 2.5s on the poster, CLS < 0.1, and record transfer size in the build report. Audit the Step 6 weight budget: scrub sizes, poster, listing images, first-load totals, desktop and mobile.
- Keyboard pass: Tab through the page; skip link first and working, every control reachable and operable, focus visible.
- Preview-pane truths: rAF starvation freezes GSAP tweens and video seeks between evals (screenshots pump frames; real scroll works; a frozen tween in the pane is NOT a site bug). Screenshots at overridden viewports can render partial/black canvases while the page is fine. Verify motion in real Chrome, or via an agent's Playwright run, before diagnosing.

9. **Review gate.** Run `crew-design-quality` (binding) with `crew-design-reference` (composition lens), `crew-design-reference` (patterns lens), and `crew-design-engineering` on the built file + live local URL (see Design review gate). Fix all Criticals and Majors; a Fail or unaddressed Revise is Loop 2 until it passes. In Governed mode nothing is waived.

10. **Deploy.**
- A route A demo deploys publicly only after the one-line copyright consent (Guardrails) has an explicit yes recorded; the default is local or a noindexed preview.
- `.vercelignore`: `pipeline`, `assets`, `.tmp`, `.env*`, `README.md`. Ship `index.html`, `video/`, `listing/` only. Shipping `assets/` leaks the raw master and balloons the bundle.
- `vercel --prod --yes` from the project folder.
- Live matrix by status code: index 200, scrub_d 200, scrub_m 200, poster 200, listing images 200, og 200, `assets/video/master.mp4` 404, `pipeline/` 404. Plus a Range check: `curl -H "Range: bytes=0-1023"` on scrub_d must return 206 (Vercel does; if a host does not, iOS seeking dies).
- Patch og:image/og:url to the live alias and redeploy if they were relative. Production builds also add Product JSON-LD and the designed 1200x630 og card (web-standards Head 5).

**Final Step: Record Save.** Write into the project bound at Step 0 (the one this run recovered or created); never let a re-read of `~/.claude/crew-state/active-project` choose the destination. Re-read the pointer only to compare: if it now differs from the Step 0 binding, another session may have moved it; warn in the receipt and still write to the Step 0 binding. If no project was named this run, ask for a name only if something worth keeping was produced; otherwise skip the write and say so in the receipt. Write `~/.claude/crew-state/projects/<project>/crew-web-product-film-handoff.md` (mkdir -p first) with: the film site produced (filename, deploy alias or local-only), the build report, decisions made (product, asset route and plates source, scene map, forbidden-features lists used, engine hybrid, copyright consent answer on a route A demo), unfinished work (clips awaiting regeneration, scenes cut, open gate Majors, OG patch pending), what the next skill needs (`crew-design-quality`: the built file and the live local URL), and any "Learned" note (Loop 5). When a project is active, always write it, even with no output ("No output, run completed [date]"). Open the handoff with the frame: a `# crew-web-product-film handoff` title line, a `Date:` line (ISO, today), and a `STATUS:` line (NOT STARTED / IN PROGRESS / BLOCKED / READY FOR REVIEW / DONE / DONE_WITH_GAPS / NO OUTPUT); then the content above as its own headed blocks, with LEARNED and ESCALATED blocks when present. When rewriting an existing record in the same project, carry forward every prior Learned note and any unresolved Escalated or Not-provided item; a rewrite must never erase a lesson or an open flag. Records in other projects are other work: never merged into this one and never overwritten by it. If the handoff write is denied or fails, retry once; if it still fails, do not fake success: print the full handoff body inline in the run receipt under the literal heading "STAGED HANDOFF (write denied)" so the user can save it, and mark STATUS: BLOCKED. After a successful write, re-read the file and confirm the frame is present (the title line, the Date line, and a STATUS from the sanctioned list); fix it before finishing if not. If this run captured a durable way-of-working lesson (not a project or brand fact), offer once: "Want me to save this lesson so it never happens again?" On yes, append one dated bullet (what went wrong, what to do instead) to `~/.claude/crew-state/lessons/crew-web-product-film-lessons.md`, creating the file if absent; it is read at every Step 0 and never leaves this machine (Loop 5, the lesson offer). A Loop 1 or Loop 3 pause counts as finishing for the Context Loop: write the handoff FIRST (STATUS: BLOCKED, the gap or escalation named), then ask and wait. (Loop 4 and Loop 5.) Then prompt: "Session context should be saved so the next session knows what we decided and what is left. Shall I run context-save now?" If the user says yes, invoke `crew-core-context-save`. If no, note in the handoff: "Context-save declined by user."

## Output format

```
PRODUCT FILM BUILD REPORT
Product: [brand + product]   Built: [date]   Deploy: [url or local]

Plates: [route, count, resolution, source]
Film: [scene list] -> [duration]s master   Clips regenerated: [none / clipN: reason]
Sweep: [12/12 frames viewed clean / catches and fixes]
Engine: hybrid (scrub Act I + kinetic Act II)   scrub_d [size] / scrub_m [size]
Weight: first-load [MB] desktop / [MB] mobile vs budget   LCP [s] on the poster

web-standards Gate: [10/10, or failures and named residuals]
Review gate: [crew-design-quality verdict, fixes applied]
Truth: [facts verified against, disclaimer present on demo]

Open: [anything pending]
```

Example (filled):
```
PRODUCT FILM BUILD REPORT
Product: Harbourline Boot Co. Artisan boot   Built: 2026-07-13   Deploy: local preview only

Plates: route A, 6 transparent plates, 3780x4350 RGBA, PDP CDN originals
Film: hero reveal / seam macro / anatomy explode / workshop settle -> 17.75s master   Clips regenerated: clip2 (gusset macro grew laces; forbidden list hardened)
Sweep: 12/12 frames viewed, one catch fixed and re-swept
Engine: hybrid (scrub Act I + kinetic Act II)   scrub_d 11.2MB / scrub_m 4.1MB
Weight: first-load 12.1MB desktop / 4.9MB mobile vs budget PASS   LCP 1.9s on the poster

web-standards Gate: 10/10, Gate 5 by static checks (residual: decoder limits not exercised on real hardware)
Review gate: crew-design-quality Pass on second run (stage 2 pocket alpha raised)
Truth: founding year, one-piece construction, store count from the brand's own site; not-affiliated footer present

Open: OG image patch pending a deploy URL
```

## Decision briefs

When a call is genuinely ambiguous, make the conservative call below rather than guessing.

- **Plates below the 2K bar.** Do not upscale and pretend. Name the constraint, offer route B (client reshoots) or an honestly labelled route C, and record which was chosen.
- **The master will not fit the budget.** If crf 23 with the maxrate cap still cannot bring scrub_d under 12MB, cut the film to three scenes rather than shipping overweight. A shorter sharp film beats a long heavy one.
- **Public deploy of a route A demo.** Default to local or a noindexed preview. Deploy publicly only after the one-line copyright consent (Guardrails) has an explicit yes recorded in the handoff.
- **No honest anatomy for scene C.** If the product has no real exploded story (a candle, a bottle), swap scene C for a second macro or a making-of beat. Never invent internals the product does not have.
- **A price, guarantee, or superlative lands in the copy.** Escalate (Loop 3): name what evidence is needed and who signs it off. It never ships on inference.

## Guardrails

- Never use em dashes anywhere. Use commas, periods, or parentheses.
- If a project playbook exists, it is the authority over these defaults.
- Never generate video before the keyframes are viewed and approved. Keyframes are cents; video is dollars and minutes.
- Never stitch before the per-clip sweep. Never deploy before the master sweep.
- Never present a demo as affiliated with the brand. The disclaimer footer rides until an engagement exists.
- Never deploy a route A demo (built from a brand's own imagery) to a public URL without stating the copyright exposure to the user in one line and getting an explicit yes; record the answer in the handoff. Local or a noindexed preview is the default.
- Never invent specs, prices, or claims. The brand's own published claims only; anything the brand's materials do not support is Escalated (Loop 3), never inferred.
- Never rip out the locked engineering. Each rule is a shipped bug that will return.
- No AI-slop: no filler copy, no hedging, no dark-glow SaaS defaults (web-standards Slop 1 to 4). Specific nouns, current facts.
- Report honestly: credits skipped, sweeps failed, clips regenerated, budget misses. The report says what actually happened.

## Design review gate

Invoke every leg with the consult preamble: `CREW CONSULT from crew-web-product-film: brand gate passed, brand-context at ~/.claude/crew-state/brand-context.md` (per the Crew Method, Sub-skill consult), so a consulted leg never re-runs onboarding or re-prompts mid-gate.

Before the film ships, the built page passes the Design Standards review. Every reviewer judges the BUILT site, the rendered page and the live local URL as the scrub actually looks and moves, not a spec or a non-existent artifact. The reviewing skills live in three packs: `packs/12-design-standards`, `packs/13-design-styles`, and `packs/14-animation`.

From pack 12 (design-standards), the binding verdict. `crew-design-quality` runs its nine dimensions (Typography, Motion, Interactive-states, and the rest) over the rendered page and returns Pass, Revise, or Fail. A Fail, or a Revise the build does not address, blocks ship. Alongside it, `crew-design-reference` (composition lens) checks that the stage overlays, the arrival panel, and each Act II row resolve to one clear focal point and a legible reading order; `crew-design-reference` (patterns lens) checks that neither the scrub descent nor the kinetic content leans on a dated or slop pattern; and `crew-design-engineering` reviews the build at the pixel and easing level (wrong easing, transition:all, missing active states, focus affordances) and returns its Before, After, Why table. Pass condition: `crew-design-quality` returns Pass (or a Revise whose notes are all addressed), composition resolves cleanly on the stages, the arrival, and every content row, patterns are clean, and the engineering table's fixes are applied.

From pack 13 (design-styles), one register-conditional style lens, selected by the film's brand register, not applied to every brand. Pick exactly one: `crew-design-styles` (soft lens) when the register is warm and premium, `crew-design-styles` (minimalist lens) when it is clean and composed, or `crew-design-styles` (brutalist lens) when it is raw and bold. Run only the lens that matches the brand; do not hard-gate every build on a single style. Pass condition: the chosen lens confirms the rendered page reads true to its register.

From pack 14 (animation), `crew-animation` (gsap spec) is the authoring cross-reference for the Act I scrub, and `crew-animation` (scroll-reveal spec) plus `crew-animation` (css spec) for the Act II one-shot reveals, image settles, and hover transitions (that engine is IntersectionObserver plus CSS transitions, exactly their territory). They are spec-writers that emit STATUS, not Pass or Fail, so they are not verdict reviewers; consult them to shape the motion, not to clear it. The binding motion verdict comes from the Motion dimension inside `crew-design-quality`. Pass condition: the scrub and the reveals serve the film and never distract, and the Motion dimension passes.

On a PRODUCTION build, add one conversion leg: `crew-marketing-landing-page-review` over the enquire act, because that CTA is the client's actual conversion path; apply its copy and layout notes before ship. It is not required on a pitch demo, where the CTA is your own pitch.

A gate Fail on any leg blocks ship. Fix the page, then re-run the failing leg until every leg passes (Loop 2, Quality Failure).

## Handoffs

- **Crew Web Standards** (`shared/web-standards.md`): the craft law for this build, cited by rule number throughout this skill; Verification adopts its Section 10 Gate by reference. Where the locked engine deviates (the preloaded opening scrub vs Perf 4), the deviation is named in the engine section, gated by the weight budget and the Save-Data skip, and nowhere else.
- `crew-design-reference` (language lens) (pack 12): consult FIRST when the client supplies a brand kit or a live site exists; map its extracted tokens into the carrier before adapting the minimal-luxe defaults (Step 7).
- `crew-design-quality` (binding) + `crew-design-reference` (composition lens) + `crew-design-reference` (patterns lens) + `crew-design-engineering`: the pre-deploy gate (Step 9).
- `crew-marketing-landing-page-review`: the conversion leg over the enquire act on any PRODUCTION build (Design review gate).
- `crew-web-fly-through-builder`: the sibling skill for PLACE journeys (cities, properties); this skill is for PRODUCTS. Same engine family.
- Before anything ships, the Design review gate above is the quality check; it pairs with the Crew Method standard "Verify before claiming done".
- `crew-core-context-save` for full session saves.

## Bundled files

- `product-film-reference.html`: the LOCKED reference build (a shipped heritage-bootmaker concept film with fictional branding). It carries the page chrome kit, the metric-matched font fallback, the reduced-motion twin (with the `?reduced-motion=1` hook), the Save-Data skip, the GSAP fail-open guard, the skip link, safe-area padding, and 44px touch targets. Clone it; do not rebuild the engine from scratch.
- `pipeline/generate_assets.py`: KIE REST (createTask/recordInfo), skip-existing + 4x retry on transient 500s. Use `--handshake` to confirm the key and `--clips` to generate the Seedance clips from the cached keyframe URLs. The `--keyframes` and `--listing` stages are legacy text-to-image paths that require a `pipeline/keyframes.json` or `pipeline/listing.json` you write yourself; branded keyframes come from `kie_edit_image` seeded by the real plates per Step 3, never the text-only path.
- `pipeline/clips-example.json`: a real production clip manifest showing the scene-scoped static-product lock (camera-only on A/B/D, the anatomy variant on C) and the explicit forbidden-features line on every clip.
- `pipeline/stitch_frames.sh`: 4-clip normalise + 0.75s crossfade chain into master.mp4 (the quality path stops there); `--legacy-frames` also extracts JPGs for the legacy canvas fallback (to_webp.py), never the quality build.
- `pipeline/serve_range.py`: Range-capable local server for scrub verification (`python3 serve_range.py <root> <port>`).
- `pipeline/to_webp.py`: legacy frame pipeline, canvas fallback ONLY, not the quality path.
- `.env.example`: KIE_API_KEY placeholder.

## Plan mode

In plan mode this skill reads the brand context and the project record, settles the product and the scene plan, and produces the SCENE MAP, asset route, and clip prompts marked "(DRAFT, plan mode)" for discussion. It does NOT generate assets, does NOT write the HTML file, and does NOT write to `~/.claude/crew-state/`. The build and the record save run only after plan mode is exited.

## Verification

Verification adopts THE VERIFICATION GATE from Crew Web Standards (web-standards, Section 10) by reference: all ten Gate items run, each producing its named evidence, before the run is marked done. This build is Build class C, Mode 2 locally and Mode 3 once deployed. A failed item follows Loop 2 (Quality Failure): stop, fix, re-run that item. Local items may be added; a Gate item is never dropped or weakened.

```
[ ] Gate 1: served over the Range-capable server (pipeline/serve_range.py) and opened in a real browser; URL + 200, and 206 on a Range request
[ ] Gate 2: desktop AND 375x812 screenshots inspected; scrub_m confirmed in the network tab at 375, the portrait crop does not behead the product on any scene, stages legible, no horizontal scroll
[ ] Gate 3: console read after a full scroll and back: zero errors, warnings triaged
[ ] Gate 4: full-scroll pass: loader releases on real buffer, first paint is the poster never black, scrub tracks forward AND backward (__SCRUB.t check), stages fire, arrival legible on its actual frame, Act II reveals fire once, touch scroll drives the scrub at mobile width
[ ] Gate 5: Safari pass (desktop Safari minimum, iOS Simulator preferred): loader releases, poster first paint, scrub seeks both ways, no black flash at the arrival; otherwise the six static checks with the fixed residual line; any Safari-only bug gets a new failure-mode row
[ ] Gate 6: reduced-motion pass: emulate prefers-reduced-motion (the ?reduced-motion=1 hook is the named-residual fallback), confirm no video scrubbing, the runway collapsed, content fully readable, screenshot the twin
[ ] Gate 7: weight audit: scrub_d <= 12MB, scrub_m <= 5MB, poster <= 120KB, each listing image <= 250KB, lead still <= 350KB, first-load <= 15MB desktop / 6MB mobile; Lighthouse on the local URL (LCP < 2.5s on the poster, CLS < 0.1) with transfer size recorded in the build report
[ ] Gate 8: head hygiene: lang, title, meta description, favicon (SVG + base64 PNG fallback per web-standards Head 4), OG/Twitter tags (og:image 1200x630 JPG, or the deferred-to-deploy residual), theme-color, viewport with viewport-fit=cover
[ ] Gate 9: keyboard walk: skip link first and working, every control reachable and visibly focused, nothing stranded in the runway
[ ] Gate 10: contrast math computed (Appendix A6): body/label >= 4.5:1, display >= 3:1, against the darkest point of each scrim pocket on the brightest swept frame

Skill-specific items, on top of the Gate:

[ ] Real product plates confirmed (route A/B/C settled); nothing passed off as the client's own that is not
[ ] Scene map approved before generation; camera-only prompts with the forbidden-features list applied
[ ] Artifact sweep done: 3 timestamps per clip inspected before stitching, back halves emphasised; master re-swept at the crossfade boundaries
[ ] Encode: GOP 12, bf 0, maxrate-capped scrub pair; never the WebP frame pipeline for this engine
[ ] Engine cloned from product-film-reference.html: load gate, poster underlay, continuous-flow arrival, Save-Data skip, GSAP fail-open, legibility kit intact
[ ] Live matrix green after deploy (Step 10), Range 206 on the host
[ ] Concept-demo footer and not-affiliated line present on any demo of a real brand; route A copyright consent recorded before any public deploy
[ ] The record was written into the active project (~/.claude/crew-state/projects/<project>/crew-web-product-film-handoff.md)
[ ] No em dashes anywhere in the output
```

## Completion

If the product or its plates never arrived (Loop 1 asked and nothing came), set STATUS NEEDS_CONTEXT or BLOCKED, never DONE, and still write the record naming the gap. If the film shipped but a clip is awaiting regeneration, a scene was cut, or the gate left an open Major, set DONE_WITH_GAPS with the items named.

```
STATUS: DONE | DONE_WITH_GAPS | BLOCKED | NEEDS_CONTEXT
REASON: [why this status, specific]
RECOMMENDATION: [what should happen next]
```
