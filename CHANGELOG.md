# Changelog

All notable changes to the Crew skill packs.

## 1.19.1 (2026-08-06)

### Fixed
- crew-web-scrollytelling scrub engine: snap-on-big-gap is now a MANDATORY
  law before the lerped playhead. A lerp-only playhead breaks under a fast
  flick: the target jumps hundreds of frames, the lerp sweeps through every
  intermediate frame, each swept frame floods createImageBitmap with
  soon-stale decode requests and misses the cache on draw (a synchronous
  JPEG decode on the main thread, every tick). The result is a main-thread
  starvation storm; on weaker devices the tab locks up. The fix teleports
  the playhead to 8 frames short of the target whenever the gap exceeds 36
  frames and lerps the rest, so the film always keeps up and the sweep never
  happens. Proven in the field on a live production build and verified on 18
  deployed scroll-film sites (settle gap 0 on every abuse round, max rAF
  delta 86ms).
- The ensureBitmaps example is replaced with a decode-budget queue: at most
  6 decodes in flight, nearest-to-playhead first, stale requests dropped at
  dequeue time. The dev contract gains a NaN boot guard (a zero-height pane
  at boot yields 0/0 and freezes the playhead forever) and a resize-noise
  guard (iOS URL-bar collapse fires 1px resize storms that flicker the
  canvas).
- Two fast-scroll stress harnesses ship in scripts/: stress.js
  (contract-based, prints STRESS PASS or FAIL) and stress2.js
  (engine-agnostic, clean-top versus after-abuse screenshots compared by
  SSIM). The verify step now requires a STRESS PASS before ship.

## 1.19.0 (2026-07-31)

### Changed
- The fuel packs consolidate: 23 spec skills roll into 3 front doors. Pack 14
  Animation is now ONE skill, crew-animation, carrying all 12 engine specs
  (GSAP, Motion, Locomotive, Anime, Barba, Lottie, Rive, Spring, View
  Transitions, scroll reveal, components, CSS) as bundled reference files
  read on demand. Pack 13 Design Styles is ONE skill, crew-design-styles,
  carrying the 5 lenses (brutalist, minimalist, soft, redesign, blueprint).
  Pack 12 folds its 6 reference skills into crew-design-reference (the
  library, patterns, composition, language, authority, kit); the three
  verdict gates (crew-design-quality, crew-design-engineering,
  crew-design-documents) stay standalone. Every spec survived whole: laws,
  worked examples, all 20 palettes and 161 hexes of the kit, verified
  mechanically during conversion. The skill picker drops from 108 entries to
  88 while the catalogue keeps all 108 capabilities; the QA count guard now
  asserts capabilities (folders plus bundled specs minus containers), and
  all 562 consult references across the build skills were swept to the new
  names. Buyers see a picker that reads like a business team instead of an
  engineering wiki; nothing about the design gates changed.
- Onboarding now builds the workspace folder: crew-core-brand-context ends
  by settling a work root once (a Crew folder on the Desktop works well),
  creating the brand's folder inside it, and writing a CLAUDE.md pin that
  checks the filing cabinet at the start of every session there, so opening
  the brand's folder in the sidebar always lines up the right drawer.
  Never-overwrite and announce-what-was-done guardrails apply; the brand
  switch names the target's folder after every switch.

## 1.18.0 (2026-07-27)

### Fixed
- Four cabinet-layer bugs found by a four-lens expert review of the deployed
  harness, all in the two places prose performs filesystem surgery.
- Brand switch is now crash-safe: the switch procedure checks for a live
  session first, raises a SWITCHING sentinel, archives with the brand file
  LAST and restores it FIRST (the commit token, so a half-moved store always
  coherently names one brand), merges never overwrites (a same-named
  collision stops and reports instead of nesting directories and burying
  records), verifies the landed brand file and the active-project pointer,
  and only then lowers the sentinel. Both front-door skills now recognise a
  mid-switch cabinet and offer to complete or roll back instead of running
  fresh onboarding over another brand's projects.
- The sales audit-deck library moved from brands/<brand>/sales/library/ (a
  path that cannot exist for the active brand, silently emptying the
  matcher) to library/sales/ in the live store, where it rides every brand
  switch automatically.
- Final Step now writes into the project bound at Step 0 across all 105
  conventional skills; a re-read of the active-project pointer can warn that
  another session moved it but can never redirect the write. Closes the one
  true concurrent data-loss path (session B moving the pointer mid-run of
  session A).
- uninstall.sh --purge now purges the modern store layout (projects/,
  lessons/, brand-context.md, active-project, the sentinel) after the same
  tar backup, and --purge --all also removes archived brand drawers. A buyer
  clearing a machine now actually clears it.

## 1.17.0 (2026-07-23)

### Added
- Pack 15, Second Brain, and skill 108: crew-my-second-brain. The living,
  visual map of everything the owner's AI agents know, converted whole from
  the field-proven personal skill with the behaviour unchanged. One command
  in, one living map out: a cinematic Awakening on first load, a light-theme
  wheel with profile lenses (including a presenter-safe mode that hides file
  paths), a genesis growth replay, Ask-the-Brain with a lit citation trail,
  a voice mode with optional premium TTS, and live node births over SSE when
  new memories land. Ships the full working kit (viewer template, map
  assembler, server, default brand taxonomy) plus the workshop cold-start
  gate that seeds a day-one brain so nobody ever sees an empty map. Its own
  pack because the second brain is the spine the whole Crew hangs off. One
  deliberate rail difference: a missing brand file does not hard-stop this
  skill (the map can be built pre-onboarding and is the best advertisement
  for onboarding); privacy guardrails lock it to localhost with the
  presenter-safe profile for projection.

## 1.16.0 (2026-07-18)

### Added
- Skill 107: crew-marketing-carousel-campaign (Pack 03 Marketing, 7 to 8). The
  proven Meta carousel campaign pipeline, converted whole: one style reference
  in, a ready-to-post kit out. Six carousels of four slides (an animated hero
  plus three code-rendered slides each), built on the core principle that AI
  generates only the hero plates and code does everything else (copy, layout,
  animation of fragile assets). Ships the full working toolchain (plate
  extension, headless page export, Seedance animation with a code-built
  fallback, 4K upgrade, text surgeon, kit builder, review gallery), the style
  recipes, the failure-modes scar tissue, and an offer template with a fully
  fictional worked example. The mandatory human step is welded in as the
  spine: the skill delivers the prompt pack, then STOPS while the user
  generates the six hero plates in Google Flow and returns them; proceeding
  without real plates is named a defect. Converted craft-first per the house
  doctrine, rails at the tail, zero personal or brand data.

### Changed
- crew-marketing-campaign-plan now routes the produced paid-social visual
  system to crew-marketing-carousel-campaign (its builder roster is complete);
  crew-marketing-social-post-pack routes fully produced carousel systems the
  same way. The chain: plan the campaign, the carousel skill consumes the plan
  record from the project and asks only for the style reference, captions run
  through brand-voice-check, the kit through the quality checker.

## 1.15.1 (2026-07-18)

### Changed
- crew-web-scrollytelling rebuilt craft-first (55KB to 24KB). Field comparison
  against the original studio skill showed the conversion had preserved the
  reference files but diluted the build brief: the same craft wrapped in four
  times the governance, with the creative-authority framing buried. The skill
  now leads with the golden rule (design is done by the model running it),
  keeps the original's voice and order (interview, pitch, art-direct, lanes,
  delegation model, cost discipline), and compresses the Crew rails to the
  required blocks at the tail. The design review gate is now briefed with the
  cinema register: boldness judged as intent, the gate kills real defects
  (jank, illegible copy, broken reduced-motion, masked seams), it does not
  sand the art. Process spine unchanged: interview, pitch, pick, then build.

## 1.15.0 (2026-07-18)

### Added
- Skill 106: crew-sales-audit-deck (Pack 02 Sales, 7 to 8). Turns discovery
  call notes into a branded ten-slide audit deck, matched against the
  operator's own library of past builds. Ported from a community n8n audit
  workflow, stripped to the reasoning that actually matters: the extraction
  discipline, the library match, and the cost of inaction, with blank beats
  invented held throughout (never invent a firmographic, a tool, or a dollar
  figure the client did not state; process steps the only inferred content,
  always labelled). The library is the moat: a per-brand cabinet drawer at
  crew-state/brands/<brand>/sales/library/, SHIPPED-only entries, grep-matched,
  seed six real builds. Renders by consulting crew-web-slide-deck-builder with
  the completed plan (its Fast mode renders, it keeps its own design gate), and
  writes a durable handoff either way. A three-tier product: Native on Claude,
  a portable bring-your-own-model kit, a managed done-for-you.
- Built through the full gold loop (author, three adversarial lenses, fixer).
  The senior-sales lens caught a real cost-of-inaction inflation (frequency
  times value with no capture rate reads 3 to 5x high and gets torn apart on
  the follow-up call); the method now applies a conservative capture-rate range
  labelled revenue at risk. Also added: a two-sided proof clause on the
  recommendations slide, roadmap months reconciled against each build's stated
  timeline, money slides stamped pending and the deck held at DONE_WITH_GAPS
  until priced, and a single primary call to action on the close slide.

## 1.14.0 (2026-07-18)

### Added
- Skill 105: crew-web-scrollytelling (Pack 10). Builds a scroll-film site where
  the whole page is one continuous cinematic shot that plays as the visitor
  scrolls, beats of copy riding on the film, resolving into standard content
  sections. Two lanes: pure-code motion by default (zero setup), chained
  generated footage as the opt-in signature lane (KIE primary route with the
  proven chain contract, Higgsfield documented alternative, any start-image
  engine on the same contract). Converted from a field-proven local studio
  build: the footage-first law, the chaining law with exact continuation
  language, the measured junction gate (SSIM thresholds plus the stochastic
  under-read allowances, side-by-side decides), billing verified by balance
  delta, the canvas scrub engine (never a video element), letterbox and
  bright-ending regeneration language, the clip-path IntersectionObserver
  deadlock law, and cost discipline with a user-approved credit ceiling.
  Ships references/ (playbook, engine recipes), scripts/ (kie.py chain
  runner, chain-step.sh, assemble.sh, verify.js), a worked reference
  storyboard, and a three-case fixture. Second-model consults from the
  source were stripped; taste stays on the one model and the binding
  verdict stays with the design review gate.
- README pack table reconciled against disk: Web Design 18, Infrastructure 1
  (rows had been stale since 1.11.0; the count guard checks only the badge
  total, which stays exact at 105).

## 1.13.0 (2026-07-18)

### Added
- Bundled third-party: the six HyperFrames agent skills (hyperframes,
  hyperframes-cli, hyperframes-media, hyperframes-registry,
  remotion-to-hyperframes, website-to-hyperframes) now ship under
  vendor/hyperframes/, redistributed verbatim from
  github.com/heygen-com/hyperframes under Apache-2.0, with the full licence
  text and a provenance README beside them. A fresh Crew install now includes
  rendered video: HTML compositions, synced captions, text-to-speech
  voiceover, audio-reactive motion, hand-drawn emphasis effects, shader
  transitions, and renders via npx hyperframes (Node 18+).
- install.sh installs the vendor skills under their own names with the same
  skip and force rules as the packs, and places the licence plus provenance
  note in the target. uninstall.sh --all removes exactly the six shipped
  names and nothing else.
- README gains a Bundled extra section; CREDITS.md now separates the
  Crew-authored guarantee (packs/) from the clearly labelled vendor
  redistribution.

### Changed
- qa-check.sh deliberately exempts vendor/ from the em-dash and ban-list
  scans: third-party text redistributed under its own licence is not
  Crew-authored and the white-label rules do not apply to it. The Crew
  catalogue count remains 104; vendor skills are additive.

## 1.12.0 (2026-07-14)

### Changed
- crew-web-app-builder is restored to Pack 10 and is a permanent core skill: it
  is the Express / Antigravity automation builder (the five-phase Blueprint,
  Link, Architect, Stylize, Trigger protocol on the A.N.T. three-layer
  architecture), the daily driver for scaffolding deterministic automation. It
  keeps its deliberate QA carve-out from the Step 0 / Final Step frame because
  it is the BLAST-protocol mirror, not a context-loop skill. Do not delete it.

### Removed
- crew-project-builder (Pack 11) and its fixture retired: it was the neutralised
  duplicate of the automation protocol; crew-web-app-builder is the one that
  ships. The four crew-web-learning-experience references were repointed back to
  crew-web-app-builder, and the QA carve-outs were re-added to qa-check.sh and
  the two sweep scripts. Pack 11 now holds crew-voice-receptionist only.
- Net catalogue count unchanged at 104 (one skill in, one out). This reverses
  the app-builder removal shipped in 1.11.0.

## 1.11.0 (2026-07-14)

### Added
- shared/web-standards.md (441 lines): the single web-build standard every
  Pack 10 skill now cites. Covers the type system, performance budgets, the
  motion law, iOS reality, head hygiene, the accessibility floor, the anti-slop
  register, the Verification Gate roster, and an Apple scroll-pattern appendix.
  Wired into install.sh so it lands with the pack.
- Two new web skills, built to the standard (SKILL, compliant reference HTML,
  and fixture each): crew-web-landing-page-builder and
  crew-web-booking-site-builder.

### Changed
- Pack 10 (Web Design) closed to gold: 44 critical, 98 major, and 73 minor
  holes fixed across 14 existing skills, each reworked and then re-verified on
  disk under the three-lens loop (craft, gold, consistency), not by self-report.
  Confirmed fixes include the two-part favicon, 44px touch targets, oklch
  light-theme contrast, the two-tag theme-color, font-cap reconciliation, and
  the preload contradictions.

### Removed
- crew-web-app-builder deleted: it was the Express automation protocol misfiled
  in the web pack, a duplicate of crew-project-builder (Pack 11). The four
  crew-web-learning-experience references were repointed to crew-project-builder,
  and its QA carve-outs were stripped from qa-check.sh and the two sweep scripts
  so no shipped skill dodges the frame check. Catalogue count 105 to 104.

## 1.10.0 (2026-07-13)

### Changed
- HR pack (05) upgraded to gold standard: all five skills expert-reviewed and
  rewritten under the ultracode campaign loop (author, three-lens review, fix,
  verified gate per skill).
  - Pack-wide: every fixture now asserts the Projects-model handoff path
    (crew-state/projects/<project>/), replacing the stale crew-state/hr/ paths
    that failed compliant runs; every Decision briefs section gained the
    structured brief template (Decision / At stake if wrong / Recommendation /
    A / B / Net); every escalation now lands somewhere real (the named HR
    contact or external employment adviser from brand context, else the
    business owner, with a once-only nudge to name an adviser).
  - crew-hr-employee-communication-draft: departure and individual-circumstance
    announcements carry neutral facts only (stating or implying a reason is
    refused and escalated); redundancy and restructure comms gain a
    consultation-status gate (proposal framing until consultation is confirmed
    complete); formal employment instruments (termination letters, warnings,
    redundancy notices) added to the NOT-list; sequencing now covers staff on
    leave, off-shift casuals, deskless workers, and union or elected
    representatives; hard news must name real support and sane timing.
  - crew-hr-interview-guide: solo-interviewer degraded mode for the buyer who
    interviews alone; right-to-work uniform-question carve-out; volunteered
    protected-information rule; sexual orientation, gender identity, and union
    membership added to every protected-characteristic list; recording and
    AI-in-hiring disclosure rules; remote-interview parity; the broken offer
    handoff fixed (offer letter is the business's instrument, welcome
    announcement stays with communication-draft).
  - crew-hr-performance-conversation-prep: discovery now asks whether the issue
    was raised before and the person's employment context (probation, casual,
    contractor); protected-timing trigger in the escalation gate (conversation
    near a complaint, disclosure, adjustment request, or protected leave);
    "if the conversation turns" playbook (health disclosure, counter-allegation,
    support person, distress); 24-hour contemporaneous file-note template;
    logistics block (privacy, notice, time, remote handling).
  - crew-hr-policy-summary: Consequence rules now land in the employee guide
    ("what happens if") and manager checklist; never-cut rubric (consequences,
    deadlines, procedural rights always survive summarisation); document-
    completeness gate before summarising; worker-type and overriding-instrument
    scope checks; delta path and guardrail-pressure fixture cases.
  - crew-hr-role-profile-builder: employment basis and working pattern now
    asked, carried, emitted, and verified; contractor-vs-employee decision
    brief (classification escalated, never made); collective-instrument
    guardrail; probation-aware 30/60/90 ramp; inherent-requirements and
    reasonable-adjustments lines; supplied pay figures carried verbatim as
    Evidence; orphaned anatomy parts (career path, decision rights,
    comparables) wired through output and verification.

## 1.9.0 (2026-07-12)

### Added
- crew-web-product-film: the Apple-grade cinematic product film site.
  Graduated from a shipped concept build into the catalogue: a scroll-scrubbed
  video opening act plus a kinetic content act, seeded from the brand's own
  real product plates (including the CDN-transform-stripping route that pulls
  original transparent cutouts from Cloudinary-backed stores). Ships the
  locked reference build (fictional branding), the full pipeline (asset
  generation with skip-existing and retry patches, stitcher, Range-capable
  dev server, a real production clip manifest), the camera-only prompt lock
  with named forbidden-features lists, the mandatory three-timestamp artifact
  sweep with back-half emphasis, the GOP 12 crf 18 scrub encode pair, and a
  fourteen-row failure-modes table from five production builds.
- crew-voice-receptionist (Pack 11 Infrastructure): a no-code AI phone
  receptionist build for small businesses. Answers missed calls on the
  existing number via carrier call divert, sounds human (an AU voice through
  the user's own voice platform), answers FAQs from a knowledge base, books
  into the user's calendar, takes structured messages, and delivers a
  transcript plus customer SMS after every call. Ships a reference kit in
  assets/: five SOPs (divert, voice agent, booking, post-call, compliance),
  locked data schemas, system prompt, tool JSON schemas, divert-code card,
  webhook field map, knowledge-base template, and a send-ready client
  playbook. The catalogue reaches 103 skills; Web Design grows to 15,
  Infrastructure to 2.

### Changed
- crew-marketing-seo-page-builder: the Technical pre-flight. When the page
  will ship on a site that already exists, the skill grounds the draft in
  five read-only fetches instead of assumptions: robots.txt (is the target
  path crawlable), sitemap.xml (live cannibalization evidence), the served
  HTML (SSR vs CSR), llms.txt (AI-search readiness), and the PageSpeed API
  mobile score. Wired end to end through discovery, workflow, output format,
  Fast mode, and the handoff; every field is a fetched fact, "Not checked
  (unreachable)", or "skipped, no domain supplied".
- 24 adversarial-review findings fixed across the three additions before
  landing, including a Critical personal-email leak in the product-film
  reference and full retargeting of its spliced ceremony and design gate.

## 1.8.0 (2026-07-08)

### Added
- crew-docs-research-notebooklm: skill 101, deep research and multimodal
  briefings over your own sources through NotebookLM. A bridge skill: it drives
  the community notebooklm-py CLI that the user installs and logs in to once
  (the invoke-once, connect step), one NotebookLM notebook bound to each Crew
  project via a local notebooklm.json, every artifact (the audio overview, the
  video, the report, the deck, quizzes, mind maps) downloaded into the project
  folder. Grounded, cited answers only; the notebook is the authority and an
  ungrounded question gets "the sources do not cover this", never a training
  guess. Honest about the dependency by design: the undocumented-API risk is
  stated up front with a Crew-native fallback, the data boundary (sources go to
  Google, the one Crew skill where work leaves the machine) is stated before
  the first source and re-flagged for sensitive material, and the skill never
  touches the Google password or runs the login itself. 10 adversarial-review
  findings fixed before landing, including a CLI-correctness pass against the
  real command surface and an auth-safety Critical. The catalogue reaches 101
  skills; the Docs pack grows to 8.

## 1.7.0 (2026-07-08)

### Added
- crew-web-slide-deck-mobile: skill 100, the vertical story deck for the phone
  in the hand. Full-screen 9:16 panels advanced by the thumb's downward flick
  (scroll-snap on a fixed wrapper, so browser chrome never shifts the snap
  points and pull-to-refresh cannot kill the deck), one idea per panel, a
  stories-style progress rail, and the Mobile Quote template for sending a
  priced proposal as a link in a text: hook, problem, the work, the price
  huge, guarantee, one thumb-reach action. Media is generated vertical at the
  source (1080x1920), never cropped down from widescreen. The animation layer
  ships staggered entrance reveals fired synchronously with an observer
  backstop, one signature count-up with a spring settle, and full
  reduced-motion collapse. Sent-link engineering is honest: OG preview
  requires a hosted absolute image, so the workflow carries a deploy step and
  a real-scraper preview check; the file itself stays self-contained with
  sibling media. Safe areas are real (viewport-fit=cover mandated, dvh
  everywhere, nothing in the notch or home-bar bands). 18 adversarial-review
  findings fixed before landing, including three Criticals from the mobile
  lens. The horizontal sibling and the mobile deck now route to each other.
  The catalogue reaches 100 skills.

## 1.6.1 (2026-07-08)

### Fixed
- Four field-proven lessons promoted from live-build records into the shipped
  skills. crew-design-documents: footers are set in flow, never via @page
  margin boxes (headless Chrome, the pipeline's own renderer, silently ignores
  the @bottom-* boxes; the proven pattern is a flex-column .page with an
  explicit min-height and a margin-top auto footer). crew-web-fly-through-
  builder: the budget video route gains the settle clip (the budget model has
  no end-frame anchor, so the arrival needs a fourth clip seeded from the
  arrival keyframe; the prompts handed out on the no-key route include it),
  and the arrival scrim rule (alpha .55 holds only on dark footage, raise to
  about .72 on a bright arrival frame). crew-web-slide-deck-builder: entrance
  reveals fire synchronously in the navigation function with the
  IntersectionObserver kept as backstop only (a transformed slide track
  reports the observer late and embedded contexts throttle it, leaving slides
  invisible). Two failure-modes rows added to the fly-through table.

## 1.6.0 (2026-07-07)

### Changed
- PROJECTS: the memory model. Inside the brand's state root, every piece of
  work now lives in a named project folder (`~/.claude/crew-state/projects/
  <name>/`) and each skill keeps one record per project: ten websites from one
  skill are ten projects, all kept, all restorable, never overwritten by each
  other. A session starts light, brand context plus the skill's lessons file
  and nothing else; continuing earlier work goes through
  `crew-core-context-restore` (the front door: lists projects, loads the
  chosen one, sets the active-project pointer), and chained skills read their
  upstream records from the same project. The record file name and frame are
  unchanged (`<skill>-handoff.md`, `# <skill> handoff`), so every record ever
  written still parses. Records from before this model are listed by restore
  as legacy and can be moved into a project on request; nothing is deleted.
- THE LESSON OFFER (Loop 5): when a run captures a durable way-of-working
  correction, the skill offers once, "Want me to save this lesson so it never
  happens again?" On yes it is appended to that skill's local lessons file,
  read at every future start, survives every product update, and never leaves
  the machine.
- All 96 work skills swept to the new Step 0 / Final Step (four verified
  passes, zero old-path references remain); the four cabinet-level core
  skills (brand-context, context-save, context-restore, using-crew)
  hand-rewritten for their roles; template updated and its section order made
  to match the shipped shape.
- Harness: structural QA asserts the project record path (mutant-verified),
  the smoke seam seeds and asserts a project, and the loop-regression suite
  grows to nine scenarios including project creation, the first scripted
  multi-hop chain test (upstream record consumed from the same project), and
  the lessons-file read. 33 adversarial-review findings fixed before landing.

## 1.5.2 (2026-07-06)

### Fixed
- crew-web-fly-through-builder: the arrival ENTER panel was hidden by opacity
  alone, but its child button keeps pointer-events auto, so an invisible,
  Tab-focusable ENTER button rode the whole descent and a mid-flight click
  smooth-scrolled past the journey. The base #enter now carries
  visibility:hidden and overlays() toggles it visible only at the arrival
  (p greater than .90). On the continuous-flow arrival that inline
  visibility:visible outlives the arrival, so the .covering #enter and
  .past-cine #enter rules use visibility:hidden!important (a non-important
  class rule loses to the inline, which would leave the button clickable over
  the whole proof section). Fix verified by computed-style resolution and
  documented in the failure-modes table.

## 1.5.1 (2026-07-06)

### Fixed
- crew-web-fly-through-builder: the arrival was a desktop-only lock that
  black-outs on iOS. The reference template now ships the continuous-flow
  arrival proven live on two builds: the listing sits in flow below the runway
  with no display:none gate, two ScrollTriggers stage the hand-off (covering at
  top 92 percent fades only the ENTER panel and hint, past-cine at top top
  retires the canvas) so the arrival frame is held underneath until the section
  fully covers and there is no black in either direction, ENTER and HOME are
  native smooth-scroll glides, and html carries overscroll-behavior-y none to
  kill the iOS rubber-band black at the page edges. The SKILL prose, failure
  modes, and verification battery were rewritten to teach the continuous-flow
  arrival and to document the old display:none lock as a superseded scar (do
  not restore it). The locked scrub, loader, and frame engine are unchanged.

## 1.5.0 (2026-07-05)

### Changed
- crew-web-learning-experience v3.1, rebuilt to the field-proven master
  specification distilled from a complete live pilot (three build generations,
  every feature verified in a running room). The engine is one monolithic
  index.html (no framework, no build step, no animation libraries). Plain
  typographic module openers are now the locked default with the cinematic
  scrub demoted to an explicit opt-in when footage exists and the theme allows.
  The block union grows to eight types (poll joins with live tally bars). Four
  roles: solo, presenter, audience, and a phone remote over an SSE relay
  (serve.py, stdlib only, mandatory no-cache headers) with authority never
  leaving the presenter tab. One nextAction() path drives all five inputs
  (drawer, edge chevrons, keyboard, swipe, remote) under the same gate. The
  presenter drawer gains live plan-vs-actual clocks with an auto-surfacing cut
  line and a draggable width grip. Edit mode is complete: click-to-edit on
  canvas, add-a-tile, remove chips on the tile wrapper, a collapsible sidebar
  with the canvas reflowing beside it, and settled-commit broadcast semantics.
  Themes ship as four CSS-var token presets. Timing intelligence lands
  (per-step timelog, rehearsal mode with a plan-vs-actual report, a styled
  recap export), plus a print handout and an offline single-file bundler.
  Eighteen numbered engineering scars and the full pre-ship verification
  battery are encoded in the skill. The crew-state ceremony (Step 0, handoff
  frame, loops, receipts) is preserved verbatim from v2.

## 1.4.0 (2026-07-03)

### Changed
- crew-web-learning-experience v2, from live pilot feedback: the learning is
  the hero. Calm editorial content steps (keynote-slide test, one accent, 10
  percent imagery ceiling) with the cinematic treatment demoted to five-second
  module openers only. The manifest becomes a block spine (steps of typed
  blocks: heading, text, script, whiteboard, discussion, media, split) borrowed
  as structure only from block-based course tools, still no LMS. Edit mode is a
  first-class contract: sidebar sequence editor, inline edits, pasted media
  URLs, course.json as the live read-and-write data file, presenter-side only,
  with a COURSE message replicating settled edits to the wall in dual mode.
  Whiteboard captures export as rendered session notes (held to
  crew-design-documents). Full-guide coverage is a hard rule: every run-of-show
  segment becomes a step, a coverage table proves it, any gap is a build
  failure. Engine: DOM-slide steps with a block renderer, rAF canvas scrub at
  openers only, deck-style one-shot reveals.

## 1.3.0 (2026-07-03)

### Added
- crew-design-documents: the delivery standard for every file handed to a
  human. Styled PDFs via the HTML-to-headless-Chrome pipeline, formatted
  workbooks, page geometry and type-scale numbers, overflow discipline (no
  clipped text, no orphan headings, no mid-row table splits), and the render
  verification loop: no document ships unseen; pages are imaged and inspected
  before handover, and the receipt names the method used.
- Delivery-format guardrail swept into the document-producing packs (hr,
  finance, docs, training, learning-experience): files for humans are rendered,
  never raw markdown.

## 1.2.0 (2026-07-03)

### Added
- crew-web-learning-experience: the PowerPoint killer for trainers. Activates a
  finished training programme (module outline + facilitator guide + workbook)
  into a cinematic facilitator-presented journey: audience view + presenter view,
  the two-state gate as the facilitator's clicker (solo and dual-screen modes),
  a course manifest contract, per-stage media slots with a stills route, built
  on the immersive-narrative engine. Not an LMS by design: no logins, no
  tracking, no backend.

## 1.1.0 (2026-07-02)

### Added
- Silent mode on 92 of 94 skills
- crew-web-page-builder (clean premium websites)
- crew-web-website-architect (design extraction)
- crew-web-app-builder (deterministic automation)
- crew-design-kit (21 palettes and font pairings)
- Animation injection via crew-design-quality gate
- Brand hard-gate on all skills
- ~/.claude/crew-state/ path resolution
- Page-builder real-copy fix
- Switch-brand mode (one active brand, archived drawers, round-trip verified)
- Context-loop chain: handoff frame, copy-forward, upstream read, consumed record, staleness check
- Run receipts under silent mode (context recovered, verdict, handoff written)
- Sub-skill consult preamble (a consulted skill never re-runs onboarding)
- DONE_WITH_GAPS as an official handoff status
- Optional Visual identity in the brand context file
- Three worked example brand files under examples/brand-context/
- QA harness: cross-reference integrity, path anchoring, honest smoke seam with a negative brand-gate case

### Fixed
- 10 fresh-install issues
- Webcam startCamera deadlock
- Immersive-narrative rename
- Fly-through Route D for still images
- Dark-theme arrow visibility
- App-builder discovery display
- Full bundle no longer ships the git store or generated trees

## 1.0.0 (2026-06-26)

- Initial catalogue: 14 packs, gold-standard skills, QA harness, installer, per-pack zips.
