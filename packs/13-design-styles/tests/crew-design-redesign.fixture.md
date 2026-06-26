# Fixture: crew-design-redesign

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the output, and that the handoff file was written.

## Case A: clean
INPUT:
Redesign this existing marketing page (Careful mode). Goal: lift a generic page to premium. Constraint: keep the existing stack, do not break functionality.
It is a working Next.js and Tailwind site, but generic: Inter everywhere, a purple-to-blue gradient hero, three equal feature cards each with border plus shadow plus white background, everything centered and symmetrical, instant hover transitions with no focus rings, no loading or empty states, John Doe testimonials, Title Case headers, and no 404 page or legal links.
EXPECT:
- Output begins with "DESIGN REDESIGN REVIEW" and includes an Artifact line, a Stack line (Next.js + Tailwind), a Goal line, a Reviewed date, and a Mode.
- A "Verdict:" of "Lift" (not Rebuild or Start over) with a "Highest-impact move:".
- A "Keep (works, leave it):" block naming the working stack and structure (do not migrate or rebuild) and the real content.
- A "Cut (the AI fingerprint and dead weight):" block naming each tell with its replacement: the purple-to-blue gradient (a neutral base, one desaturated accent), Inter everywhere (a font with character), the three equal cards (a zig-zag or bento), John Doe (real names), Title Case headers (sentence case).
- An "Elevate (right idea, one level low):" block (for example the headline lacking presence, flat sections needing depth).
- A "Quick wins (in order, highest impact and lowest risk first):" block starting with the font swap and colour cleanup, not a new animation.
- A "Deeper rebuild needed:" line set to No (the structure and stack are sound).
- A "Strategic omissions / accessibility floor:" line flagging the missing focus rings, 404, legal links, and form validation.
- No invented current state; only what is described is diagnosed.
- No em dashes anywhere in the output.
- Handoff file `.claude/crew-state/design-styles/crew-design-redesign-handoff.md` was written.

## Case B: start-over
INPUT:
Redesign this site. It is a single long page that is a wall of equal-weight text with no hierarchy at all, the navigation is a dead end with no way back from any sub-page, the information architecture buries the actual product three scrolls down, and it is built on a deprecated stack with inline styles scattered through the markup.
EXPECT:
- The reviewer judges this needs a deeper rebuild or a start-over, NOT a surface lift: the problems are structural (no hierarchy, broken flow with dead ends, wrong information architecture, a dead-end stack), and a font swap or palette cleanup would only paint over them.
- It distinguishes a redesign from a rewrite: a start-over keeps the content and the brand but not the build, and a deeper rebuild rebuilds the structure, the flow, or the component system rather than the whole product.
- It is honest that the quick wins alone will not get there, and explains why surface polish is not enough for a structural problem.
- It still names what to keep (the content, the brand) so the rebuild does not throw out what works.
- It invents nothing.
- Handoff file written, recording the rebuild-or-start-over call and what is structural.

## Case C: missing-input
INPUT:
"Make my site better." No existing design, screenshot, or codebase is provided.
EXPECT:
- The skill follows Loop 1 (Missing Input): it asks once for the existing design or codebase to audit (a screenshot, the live page, or the code), because a redesign needs something to lift and this skill does not build from nothing.
- It does not invent the current state of a site, fabricate a diagnosis, or produce a keep, cut, elevate triage against nothing.
- If it emits any partial output, the Artifact, Stack, and Verdict fields are marked "Not provided" rather than filled.
- Handoff file `.claude/crew-state/design-styles/crew-design-redesign-handoff.md` written, recording the missing design as the blocker the next run needs.
