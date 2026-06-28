# Fixture: crew-design-patterns

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the output, and that the handoff file was written.

## Case A: clean
INPUT:
Review this landing page for whether the patterns look current (Careful mode). Page type: SaaS marketing. No brand playbook.
It has a centered hero with a big H1 in Inter over a gradient, a full-width auto-rotating carousel of testimonials, a feature row of three equal pastel-gradient cards each with a hard black drop shadow, glassmorphism applied to every card, and a custom mouse-trail cursor that follows the pointer across the whole page.
EXPECT:
- Output begins with "DESIGN PATTERN REVIEW" and includes an Artifact line, a Page type line, a Reviewed date, a Mode, and a "Verdict:" (Refresh or Dated) with a "Highest-impact swap:".
- A "Pattern reads:" block marking Layout, Cards, Typography, and Colour as Tired (with a one-line reason), and any current patterns as Current.
- A "Dated patterns flagged (with the current swap):" block that names each dated pattern against the watchlist with a year and a concrete swap: the centered hero plus three equal cards (split or bento hero), the testimonial carousel (static grid or bento of quotes), heavy glass on every card (restrained glass plus soft tinted elevation), the hard black drop shadows (soft tinted elevation), and the mouse-trail cursor (drop it, use the native cursor).
- The Inter screaming H1 is flagged with a swap to a distinct face and hierarchy by weight.
- No invented pattern; only patterns actually described are flagged.
- No em dashes anywhere in the output.
- Handoff file `~/.claude/crew-state/design-standards/crew-design-patterns-handoff.md` was written.

## Case B: pattern decision
INPUT:
For a feature section on a 2026 product marketing page, should I use a bento grid or a z-pattern (or a zig-zag)? Which is current?
EXPECT:
- The reviewer compares the patterns rather than naming one blindly: bento grid is current and fresh for a feature or showcase section (asymmetric tiles sized by priority), the zig-zag is timeless for a sequence of alternating features, and the z-pattern is timeless for a simple single landing section, not a multi-feature grid.
- It gives a when-to-use for each, tied to the content (a set of unequal features suits bento; a narrative sequence suits zig-zag).
- It does not fabricate a pattern or claim a trend it cannot defend as current, and it may produce a short decision brief because the call is genuinely contested.
- A recommendation with a primary choice and the tradeoff is stated.
- Handoff file written, recording the pattern decision.

## Case C: missing-input
INPUT:
"Is my site modern?" No page, screenshot, code, or pattern description is provided.
EXPECT:
- The skill follows Loop 1 (Missing Input): it asks once for the design or the page to review (a screenshot, the code, or a description of the patterns in use), because pattern currency cannot be judged without the patterns.
- It does not invent a design, fabricate a pattern read, or run the watchlist against nothing.
- If it emits any partial output, the Artifact and Verdict fields are marked "Not provided" rather than filled.
- Handoff file `~/.claude/crew-state/design-standards/crew-design-patterns-handoff.md` written, recording the missing artifact as the blocker the next run needs.
