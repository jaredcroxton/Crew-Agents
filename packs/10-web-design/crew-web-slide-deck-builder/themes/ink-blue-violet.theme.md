# Ink + Blue + Violet

Background: #0A0A0A
Card surfaces: #111111
Primary text: #F0F0F5
Accent / CTAs: #3B82F6 (blue) - the ONE carried accent. Build hover, border, and tint states from it with color-mix; do not introduce a separate soft-blue hue.
Secondary: #8B5CF6 (violet) - a single sparing emphasis pop only, at most one violet element per slide (one highlighted stat, or the one contrast series a two-series chart genuinely needs). Never a co-equal second accent.
Data viz: derive series from the blue accent via color-mix tints; use violet only when a second series is unavoidable. No separate cyan hue.
Buttons: pill (border-radius: 999px)
Nav arrows: visible by default, never blended into the background. At rest: background rgba(0,0,0,0.7), 1px border in the primary, chevron glyph in the primary, opacity 0.45. On hover: opacity 1, background fills with the primary, glyph flips to the background colour.
Type stack: Inter (headings and body), JetBrains Mono (code). All faces embeddable as subset WOFF2; never Calibri or another unembeddable licensed font.
Subvert the tell: a blue accent on a near-black ground is the strongest generic-AI tell of this cycle (web-standards Color 5, Slop 1). This preset must NOT read as a dark-glow SaaS clone. No radial glows, no frosted-glass card system, no gradient blobs. Carry the one blue accent ruthlessly with color-mix states, ground the surface with a real texture (a faint 1px grid or fine mono rule lines, never a glow), and let confident, data-dense type do the work. Violet stays a rare single pop, so the palette holds to roughly two colours, not a rainbow.
Gate note: the Color 5 / Slop 1 pass (crew-design-reference (patterns lens) at plan time, crew-design-quality at the gate) must scrutinise this preset specifically. If the rendered deck reads as generic blue-on-black dark SaaS, revise before ship.
Voice: Direct, data-first, no fluff
Do NOT use: light backgrounds, serif fonts, pastel colours, radial glows, frosted glass, gradient blobs, a rainbow of accents (more than the one blue plus a single sparing violet pop)
