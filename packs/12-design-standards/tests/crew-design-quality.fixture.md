# Fixture: crew-design-quality

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the output, and that the handoff file was written.

## Case A: clean
INPUT:
Review this design (Careful mode). Type: SaaS dashboard. Audience: ops managers. No brand playbook, use the baseline dials.
Artifact: the hero is a centered H1 in the Inter font at text-7xl, centered over the fold. The primary button has a purple-to-blue gradient glow. Below it is a feature row of three equal cards. The hero section uses h-screen. The team section shows avatars labelled "John Doe" and "Jane Doe" with stats reading "99.99%" and "50%".
EXPECT:
- Output begins with "DESIGN QUALITY REVIEW" and includes an Artifact line, a Type line, a Reviewed date, a Mode, and a Dials line (variance 8 / motion 6 / density 4 from the baseline).
- A "Verdict:" line set to Revise or Fail, with a "One change to raise the grade:" note.
- A "Dimension scores:" block scoring at least Typography, Colour, Layout, and Execution as Slop or Mixed, each with a one-line reason tied to a real element on screen.
- An "AI tells caught:" block that names each tell specifically, not generically: the Inter font, the centered H1 hero, the three equal-weight cards, the AI-purple gradient glow, the h-screen trap, and the John Doe generic names with the round 99.99% / 50% numbers.
- A "Ranked fixes (highest impact first):" block with specific changes (for example swap Inter for Geist, replace the centered hero with a split or left-aligned hero, drop the purple glow for one desaturated accent, use min-h-[100dvh]), not "make it pop".
- No em dashes anywhere in the output.
- Handoff file `.claude/crew-state/design-standards/crew-design-quality-handoff.md` was written.

## Case B: messy
INPUT:
Review this landing page. The brand playbook (supplied) explicitly locks a centered hero and a purple accent as the brand signature, and specifies the Inter font as the brand typeface. The page also uses h-screen on the hero and shows three equal feature cards. Audience and density are not stated.
EXPECT:
- The reviewer respects the playbook over the defaults: the centered hero, the purple accent, and Inter are marked "Brand-lock, not a tell" and are NOT red-flagged, because the playbook is the authority.
- It still flags the genuine quality issues that the playbook does not bless: the h-screen hero (an execution bug, mark min-h-[100dvh]) and the three-equal-cards row, separating a real tell from a deliberate brand choice.
- Where context is missing (audience, the density dial), it marks "Assumed" or "Not provided" and states the assumption rather than inventing a target.
- It does not redesign the brand or overrule the locked choices; the verdict focuses on what is genuinely off-standard.
- Handoff file written, recording the Brand-lock items and the real issues separately.

## Case C: missing-input
INPUT:
"Can you review my design?" No artifact, screenshot, code, or URL is provided.
EXPECT:
- The skill follows Loop 1 (Missing Input): it asks once, plainly, for the artifact (a screenshot, a code block, or a URL), because there is nothing to review without it.
- It does not invent a design, fabricate dimension scores, or name AI tells against an artifact it cannot see.
- If it emits any partial output, the Artifact, dimension scores, and verdict fields are marked "Not provided" rather than filled.
- Handoff file `.claude/crew-state/design-standards/crew-design-quality-handoff.md` written, recording the missing artifact as the blocker the next run needs.
