# Fixture: crew-design-minimalist

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the output, and that the handoff file was written.

## Case A: clean
INPUT:
Review this landing page for minimalist execution (Careful mode). Content: a real project-tracking SaaS with a full feature set. Register goal: calm, premium, editorial.
The page has a colourful hero with a bright blue full-bleed background, six feature cards each with a thin-line Lucide icon and a heavy drop shadow, the Inter typeface for everything with hierarchy by size alone, pill-shaped large CTA buttons, emoji in the section headers, and the content spans edge to edge with cramped padding.
EXPECT:
- Output begins with "DESIGN MINIMALIST REVIEW" and includes an Artifact line, a Content line, a Reviewed date, and a Mode.
- A "Right lens:" line confirming minimalist fits a premium productivity tool.
- A "Verdict:" of "Cluttered" with a "Highest-impact move:".
- A "Minimalist reads:" block marking Typography, Colour, Layout and whitespace, and Imagery as Cluttered, Generic, or Off, each with a one-line reason.
- A "To cut (clutter that earns nothing):" block naming each excess and its fix: the bright blue full-bleed hero (a warm monochrome canvas), the heavy drop shadows (ultra-flat with a 1px border), the thin-line icons on every card (remove most), the Inter-for-everything (a clean sans with character plus an editorial serif), the pill-shaped large buttons (a crisp small radius), the emoji (remove), and the edge-to-edge cramped content (constrain the width, add macro-whitespace).
- A "To add" line and an "Accessibility floor" note are present (here, the page is cluttered not barren, so "To add" may read none).
- No invented element; only what is described is flagged.
- No em dashes anywhere in the output.
- Handoff file `.claude/crew-state/design-styles/crew-design-minimalist-handoff.md` was written.

## Case B: barren
INPUT:
Review this page. It is a pure white page with a single line of light-gray text centered in the middle, enormous empty margins on all sides, no imagery, no secondary content, no focal hierarchy beyond that one line, and that is the entire page.
EXPECT:
- The reviewer judges the page Barren, not Minimal: restraint has become emptiness, the whitespace is now a void rather than a material, and there is nothing for the reduction to amplify.
- It flags that the single line of light-gray text likely fails a readable contrast, an accessibility-floor defect, not a style choice.
- The "To add" guidance is substance-led, not element-led: the fix is more substance, warmth (a photograph, a serif moment), and a clear focal point, NOT simply adding decorative elements or filling the whitespace.
- It distinguishes minimal from empty explicitly, and notes that minimalism amplifies content but cannot create content that is not there.
- It invents no content and does not pretend the page is fine because it is "clean".
- Handoff file written, recording the barren verdict and the substance to add.

## Case C: missing-input
INPUT:
"Make it minimalist." No artifact, no content, and no description of the design is provided.
EXPECT:
- The skill follows Loop 1 (Missing Input): it asks once for the design to review and what the content must communicate, because minimalism cannot be judged without seeing the design and knowing whether the content can carry reduction.
- It does not invent a design, fabricate a minimalist read, or flag clutter or barrenness against nothing.
- If it emits any partial output, the Artifact, Content, and Verdict fields are marked "Not provided" rather than filled.
- Handoff file `.claude/crew-state/design-styles/crew-design-minimalist-handoff.md` written, recording the missing artifact and content as the blocker the next run needs.
