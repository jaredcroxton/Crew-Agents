# Fixture: crew-design-composition

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the output, and that the handoff file was written.

## Case A: clean
INPUT:
Review the composition of this landing page (Careful mode). Intended priority: the headline first, then the CTA, then the features. No brand playbook.
Layout: the hero headline, subhead, and CTA are all stacked centered at near-equal weight. Below the hero is a row of three equal-width cards of equal visual weight. Every section uses the same padding and the same density. Nothing is off-center. The empty areas are just the gaps between the centered blocks.
EXPECT:
- Output begins with "DESIGN COMPOSITION REVIEW" and includes an Artifact line, an Intended priority line, a Reviewed date, and a Mode.
- An "Eye path" section that traces where the eye actually lands (and notes there is no clear first landing point because the hero is centered and one weight), and a "Matches intended priority:" line set to No.
- A "Verdict:" of "Flat" (or "Arranged") with a "Highest-impact move:".
- A "Composition reads:" block marking Hierarchy, Rhythm, Negative space, and Tension, each with a one-line observation.
- A "Composition sins flagged (with the fix):" block that names the sins present and a concrete move for each: equal weight everywhere (establish one focal point), everything centered (move the focal point off-center, switch to alignment), uniform density (vary the density), and the three equal cards (size by priority, a bento).
- The fixes are concrete compositional moves, not "make it pop".
- No invented element or eye path; only what is described is judged.
- No em dashes anywhere in the output.
- Handoff file `~/.claude/crew-state/design-standards/crew-design-composition-handoff.md` was written.

## Case B: composition decision
INPUT:
For the hero of a premium consumer product, should it be centered and symmetric, or off-center and asymmetric? Which composes better?
EXPECT:
- The reviewer compares the two rather than picking blindly: centered symmetry reads calm, formal, and still (and it points to the authority or luxury register where that is right), while an off-center asymmetric hero (focal point near a thirds line) reads dynamic and modern and creates tension that holds attention.
- It ties the choice to the register and the intended feel, not to a default, and notes that a default-centered hero is the most common flat composition.
- It does not fabricate a layout; it reasons about the tradeoff and may produce a short decision brief because the call is genuinely contested.
- A recommendation with a primary choice and the tradeoff is given.
- Handoff file written, recording the composition decision.

## Case C: missing-input
INPUT:
"Is my layout good?" No page, screenshot, wireframe, or description of where the elements sit is provided.
EXPECT:
- The skill follows Loop 1 (Missing Input): it asks once for the layout to review (a screenshot, a wireframe, or a description of where the elements sit), because composition cannot be judged without seeing the arrangement.
- It does not invent a layout, trace an eye path on nothing, or run the composition sins against an unknown design.
- If it emits any partial output, the Artifact and Verdict fields are marked "Not provided" rather than filled.
- Handoff file `~/.claude/crew-state/design-standards/crew-design-composition-handoff.md` written, recording the missing artifact as the blocker the next run needs.
