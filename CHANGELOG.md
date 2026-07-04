# Changelog

All notable changes to the Crew skill packs.

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
