# Fixture: crew-design-soft

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the output, and that the handoff file was written.

## Case A: clean
INPUT:
Review this wellness app landing page for soft execution (Careful mode). Audience: people managing stress and sleep. Register goal: warm and reassuring.
The page has sharp ninety-degree corners on every card, harsh dark drop shadows (rgba(0,0,0,0.3)), pure black text on a pure white background, a condensed bold uppercase headline, instant snap hover states with no interpolation, and high-contrast clinical photography with hard shadows.
EXPECT:
- Output begins with "DESIGN SOFT REVIEW" and includes an Artifact line, an Audience line, a Reviewed date, and a Mode.
- A "Right lens:" line confirming soft fits a wellness product (it should feel warm, not clinical).
- A "Verdict:" of "Cold" with a "Highest-impact move:".
- A "Soft reads:" block marking Typography, Colour, Layout, and Motion and imagery as Cold, each with a one-line reason.
- A "Hard or cold spots (to soften):" block naming each hard element and its warming fix: the sharp ninety-degree corners (generous squircle radii), the harsh dark drop shadows (soft diffused ambient shadows), the pure black on pure white (soft charcoal on a warm cream), the condensed uppercase headline (a rounded humanist sans in sentence case), the snap hover (a gentle spring), and the clinical photography (warm soft-light imagery).
- A "Saccharine excess (to mature)" line and an "Accessibility floor" note are present (here the page is cold, not sweet, so the saccharine list may read none).
- No invented element; only what is described is flagged.
- No em dashes anywhere in the output.
- Handoff file `~/.claude/crew-state/design-styles/crew-design-soft-handoff.md` was written.

## Case B: saccharine
INPUT:
Review this design. It is a personal finance app for adults that uses a comic-rounded bubble font, bright candy pastels on every surface, big bouncy spring animations that overshoot on every element, cartoon blob-people illustrations, and emoji throughout the headings.
EXPECT:
- The reviewer judges the design Saccharine, not Warm: the roundness, candy pastels, and big bounce have tipped soft into childish and twee, and an adult financial product that reads like a kids app loses the credibility it needs to be trusted with money.
- The fixes mature the warmth rather than removing it: calm the overshoot to a subtle spring, desaturate the candy pastels to muted warm tones, replace the cartoon blob illustrations with warm real photography, swap the comic bubble font for a grown-up rounded humanist sans, and remove the emoji.
- It explicitly distinguishes warm from sweet, and names the trust risk for a money product.
- It does not recommend stripping the warmth out entirely or making the app cold; the goal is warm and credible.
- It invents nothing.
- Handoff file written, recording the saccharine verdict and the maturing fixes.

## Case C: missing-input
INPUT:
"Make it soft." No artifact, no audience, and no description of the design is provided.
EXPECT:
- The skill follows Loop 1 (Missing Input): it asks once for the design to review and how it should feel (the audience and register), because warmth cannot be judged without seeing the design.
- It does not invent a design, fabricate a soft read, or flag cold or saccharine elements against nothing.
- If it emits any partial output, the Artifact, Audience, and Verdict fields are marked "Not provided" rather than filled.
- Handoff file `~/.claude/crew-state/design-styles/crew-design-soft-handoff.md` written, recording the missing artifact as the blocker the next run needs.
