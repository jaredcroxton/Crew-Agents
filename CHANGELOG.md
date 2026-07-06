# Changelog

All notable changes to the Crew skill packs.

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
