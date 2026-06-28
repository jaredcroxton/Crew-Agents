# Fixture: crew-web-slide-deck-builder

Four cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear, and that the handoff file was written.

## Case A: clean brief, preset theme
INPUT:
I need a 5-slide pitch deck for a fintech startup called Ledger. Use the Slate + Ink + Lime preset.
Slide 1: Title, "Ledger: Real-time business banking"
Slide 2: Content, three feature cards: Live cashflow, Auto reconciliation, Multi-currency accounts
Slide 3: Code, show a 4-line JavaScript snippet that calls ledger.balance()
Slide 4: Content, one quote from a beta customer saying "Ledger cut our close time from 4 days to 4 hours"
Slide 5: CTA, "Join the waitlist" button
EXPECT:
- A single self-contained HTML file (no external links, no CDN, under 500KB).
- A :root block built from the Slate + Ink + Lime values, with a CSS comment naming the preset.
- 5 slides with the correct types (title, content, code, content, cta).
- All five navigation controls: arrows, dots, counter, keyboard, touch.
- The code slide uses inline highlighting with .kw, .fn, .num spans (no library).
- The CTA slide has a styled button.
- A wordmark logo reading "Ledger" in the heading font (Inter).
- The deck is delivered as a single fenced HTML block followed by one short open-it sentence, no trailing warnings or disclaimers.
- No em dashes anywhere, no extracted product names.
- Handoff file `~/.claude/crew-state/web-design/crew-web-slide-deck-builder-handoff.md` was written.

## Case B: messy brief, custom brand, missing font
INPUT:
Here are my brand colours: primary is navy #1E3A5F, accent is a kind of orange #FF6B35.
Background should be dark. Fonts I do not know yet. Build me a training deck for new hires.
3 slides. First slide: title "Welcome to the Team". Second: three values. Third: next steps.
EXPECT:
- The skill asks once for the two missing font names before building, and does not invent fonts.
- If the user says "use safe defaults", it falls back to a system font stack rather than guessing brand fonts.
- The :root block is built from the two provided hex colours with a sensible dark background gradient. No third colour is invented (accent reused or a tint derived and labelled).
- 3 slides with the correct types, all single-file security standards met.
- Step 0 Context Recovery message appears, and the handoff file is written after delivery.

## Case C: missing-input brief
INPUT:
Make me a slide deck. It is for a product launch. I will send you the content later.
EXPECT:
- The skill asks the branding discovery question first (preset or custom), then asks for the missing slide brief.
- It does not build a single slide until the inputs are complete (Loop 1, Missing Input fires).
- It does not invent a company name, a product name, a colour, or any slide content.
- Handoff file written, recording the deck as not started and the inputs still needed.

## Case D: dense deck, short-viewport overflow
INPUT:
Build me a 10-slide internal strategy deck. Every content slide is dense: 6 bullet points plus a 3-column stat row plus a footnote. Use the Slate + Ink + Lime preset. I present on a laptop projector at 1180x640.
EXPECT:
- 10+ slides built, every content slide carrying its full dense content (no silent trimming).
- The `.slide` uses `justify-content: flex-start` with `padding-top: max(8vh, 80px)`, not `justify-content: center`, so content starts below the fixed logo.
- No content overflow or clip at any of 1920x1080, 1366x768, 1180x640, or 375x812; a slide too tall for the viewport scrolls within its own bounds rather than centre-clipping under the logo.
- All single-file security standards met, no em dashes, handoff written.
