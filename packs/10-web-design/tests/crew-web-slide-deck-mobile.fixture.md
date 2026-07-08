# Fixture: crew-web-slide-deck-mobile

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the behaviour and output, and that the record was written into the active project. All businesses are fictional.

## Case A: clean
INPUT:
Tidal Electrical, a fictional two-van electrician business, wants to send a quote as a link.
Brand context exists (navy ground, ivory ink, amber accent, Inter). Content, confirmed:
proposal for "Marina Cafe fit-out", problem: "your kitchen trips the moment the espresso
machine and the ovens run together", work: rewire the kitchen circuit, new switchboard,
safety certificate; price $4,850 including GST, includes parts, labour, certificate;
guarantee: "if it trips again in 12 months, we come back free"; action: Accept or call
0400 000 000. No media. Recipient opens it in iMessage.
EXPECT:
- Skill runs Step 0 Context Recovery and settles the project (new or continuing).
- A panel map is shown BEFORE the build (one idea per panel, 8 or fewer panels for this content) and the $4,850 price is confirmed verbatim.
- One self-contained HTML file: no CDN, no external requests, inline CSS and JS only.
- The Mobile Quote sequence: hook panel with the client's name, statement (problem), list or statements (the work), a panel-price with $4,850 as the largest type on any panel and the three inclusions, the guarantee statement, one panel-cta with a tel: link in thumb reach.
- The engine: vertical scroll-snap (scroll-snap-type y mandatory) on a fixed wrapper, every panel min-height 100dvh with a 100vh fallback line, viewport meta with viewport-fit=cover, safe-area insets respected, a top progress rail with one segment per panel sitting clear of the notch band.
- Animation per the motion budget: staggered entrance reveals fired synchronously with an IntersectionObserver backstop, a single signature count-up on the price panel (value on a non-overshooting curve, spring on the transform settle only), prefers-reduced-motion collapses reveals and renders the final price instantly.
- Desktop fallback: centred phone-width column on viewports wider than 520px, keyboard Up/Down advances.
- OG tags set (title reads like a message for the client), print block stacks panels one per page.
- No invented content: every number and inclusion traces to the input.
- Output begins with the literal line "MOBILE STORY DECK".
- The Design review gate runs with a binding verdict and Criticals/Majors are fixed.
- No em dashes anywhere in the output.
- The record was written to ~/.claude/crew-state/projects/<project>/crew-web-slide-deck-mobile-handoff.md with the frame intact.

## Case B: messy
INPUT:
Fern & Forage, a fictional florist, wants "our spring launch as one of those swipe
stories" from a pasted A4 flyer: twelve paragraphs of copy, six photos all landscape
16:9, no clear call to action, brand context exists (sage, cream, terracotta).
EXPECT:
- The skill re-cuts the flyer into the panel grammar and shows the map: one idea per panel, no panel carrying two headings, total panels capped near 14 with a proposed cut of the weakest content.
- The 16:9 photos are flagged: cropping to portrait will read as repurposed; the skill offers typographic panels or fresh vertical generation, and centre-safes any crop only if the user insists.
- The missing call to action triggers Loop 1: one plain question about what the reader should do; no CTA is invented.
- Media panels that do ship carry the scrim (.55 default, ~.72 flagged for bright frames) and dual-layer display shadows.
- The record notes the re-cut decisions and any panels marked "awaiting asset".
- STATUS is DONE_WITH_GAPS if the CTA answer or assets are still pending, with the gaps named.

## Case C: missing input
INPUT:
"Make me one of those phone decks."
EXPECT:
- No artifact is produced. The skill asks once, plainly, for the content and the job (what the deck is for, who receives it), per Loop 1.
- No panels, prices, claims, or media are invented while waiting.
- The record is still written into the active project first, STATUS: BLOCKED, naming the missing content as the blocker.
- The chat Completion status is NEEDS_CONTEXT or BLOCKED, never DONE.
