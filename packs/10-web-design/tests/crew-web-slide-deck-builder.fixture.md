# Fixture: crew-web-slide-deck-builder

The canonical trio is clean (Case A), messy (Case B), and missing-input (Case C); Case D is an extra dense-deck stress case for the overflow behaviour. The smoke test feeds Case A (and Case C with `--cases AC`) to the skill and asserts the EXPECT markers appear in the behaviour and output, and that the handoff file was written into the active project. All businesses are fictional.

## Case A: clean brief, preset theme
INPUT:
I need a 5-slide pitch deck for a fintech startup called Ledger. Use the Slate + Ink + Lime preset.
Slide 1: Title, "Ledger: Real-time business banking"
Slide 2: Content, three feature cards: Live cashflow, Auto reconciliation, Multi-currency accounts
Slide 3: Code, show a 4-line JavaScript snippet that calls ledger.balance()
Slide 4: Content, one quote from a beta customer saying "Ledger cut our close time from 4 days to 4 hours"
Slide 5: CTA, "Join the waitlist" button
EXPECT:
- A single self-contained HTML file written to disk (no external links, no CDN, under 500KB with the size printed).
- A :root block built from the Slate + Ink + Lime values, with a CSS comment naming the preset.
- Fonts embedded as base64 subset WOFF2 (or a declared system stack); no @import and no network font request.
- 5 slides with the correct types (title, content, code, content, cta).
- All five navigation controls: arrows, dots, counter, keyboard, touch; arrows and dots are real <button> elements.
- Inactive slides carry inert and aria-hidden; a #slide-N hash (and ?slide=N param) deep-links.
- The code slide uses inline highlighting with .kw, .fn, .num spans (no library).
- The CTA slide has a styled button.
- A wordmark logo reading "Ledger" in the heading font (Inter).
- The deck is delivered as a file path plus the SLIDE DECK OUTPUT block, no trailing warnings or disclaimers.
- No em dashes anywhere, and no invented company or product names or copy beyond the brief.
- Handoff file `~/.claude/crew-state/projects/<project>/crew-web-slide-deck-builder-handoff.md` was written.

## Case B: messy brief, custom brand, missing font
INPUT:
Here are my brand colours: primary is navy #1E3A5F, accent is a kind of orange #FF6B35.
Background should be dark. Fonts I do not know yet. Build me a training deck for new hires.
3 slides. First slide: title "Welcome to the Team". Second: three values. Third: next steps.
EXPECT:
- The skill asks once for the two missing font names before building, and does not invent fonts.
- If the user says "use safe defaults", it falls back to a system font stack rather than guessing brand fonts.
- If the user names an unembeddable font (Calibri, Helvetica Neue, SF Pro), the skill says so and offers the closest embeddable match; it never lets it silently fall back.
- The :root block is built from the two provided hex colours with a sensible dark background gradient. No third colour is invented (accent reused or a tint derived with color-mix and labelled).
- 3 slides with the correct types, all single-file security standards met.
- Step 0 Context Recovery message appears, and the handoff file is written after delivery.

## Case C: missing-input brief
INPUT:
Make me a slide deck. It is for a product launch. I will send you the content later.
EXPECT:
- The skill asks the branding discovery question first (preset or custom), then asks for the missing slide brief.
- It does not build a single slide until the inputs are complete (Loop 1, Missing Input fires).
- It does not invent a company name, a product name, a colour, or any slide content.
- Handoff file written at `~/.claude/crew-state/projects/<project>/crew-web-slide-deck-builder-handoff.md`, recording the deck as not started and the inputs still needed.

## Case D: messy stress, dense deck on a short viewport
INPUT:
Build me a 10-slide internal strategy deck. Every content slide is dense: 6 bullet points plus a 3-column stat row plus a footnote. Use the Slate + Ink + Lime preset. I present on a laptop projector at 1180x640.
EXPECT:
- 10+ slides built, every content slide carrying its full dense content (no silent trimming).
- The `.slide` uses `justify-content: flex-start` with `padding-top: max(8vh, 80px)`, not `justify-content: center`, so content starts below the fixed logo.
- Stat values set in font-variant-numeric: tabular-nums; slide height 100dvh with a 100vh fallback line.
- No content overflow or clip at any of 1920x1080, 1366x768, 1180x640, or 375x812, verified by per-slide screenshots via the ?slide=N harness; a slide too tall for the viewport scrolls within its own bounds rather than centre-clipping under the logo.
- All single-file security standards met, no em dashes, handoff written into the active project.
