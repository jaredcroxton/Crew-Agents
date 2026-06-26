# Fixture: crew-design-language

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the output, and that the handoff file was written.

## Case A: clean
INPUT:
Stand up the design language for a new developer-tool SaaS (Careful mode). Brand: one accent (teal), a neutral zinc base, dark-first, a distinct variable sans for headings. Surfaces: a marketing site and an app dashboard. No values locked beyond the teal accent and the zinc neutrals.
EXPECT:
- Output begins with "DESIGN LANGUAGE BRIEF" and includes a Project line, a Surfaces line, a Built date, and a Mode.
- A "Primitives" block with raw value-named tokens (a teal and zinc palette in OKLCH, a fluid type scale, a spacing scale, a radius scale), defined once.
- A "Semantic tokens" block mapping roles to primitives and role-named (for example --color-accent referencing the teal primitive, --color-surface, --color-text, --type-heading, --section-gap, an elevation level).
- A "Component tokens" block where component tokens (for example --button-bg, --card-padding) reference semantic tokens, never the raw primitives.
- A "Load-bearing choices" note naming at least one of the invisible craft decisions (optical-size axis, an exact weight between the named steps, or deliberate line-heights).
- A "Naming convention" line stating primitives value-named, semantics role-named, components scoped, references one direction.
- Any undecided value (the marketing light-theme neutrals) is marked a slot to fill, not a guessed hex.
- No em dashes anywhere in the output.
- Handoff file `.claude/crew-state/design-standards/crew-design-language-handoff.md` was written.

## Case B: drift audit
INPUT:
Audit this project for language drift. Page 1 buttons use #14b8a6; page 2 buttons use #0d9488 (a slightly different teal). Headings are 2rem on the marketing page and 32px in the app. There are three different card paddings (12px, 16px, 20px). The dark theme was done by overriding colours inside the button and card components directly.
EXPECT:
- The audit identifies the two near-identical teals as a single-source violation: both should resolve to one --color-accent semantic token, and it names that fix.
- It flags the mixed units (2rem versus 32px for the same heading role) and recommends one type scale and a --type-heading role token.
- It flags the three off-scale card paddings and recommends snapping them to one spacing-scale token.
- It flags that theming was done inside components, and states the rule: a theme swaps the semantic layer only, components are untouched.
- It does not invent new brand values; it unifies the existing ones onto tokens, reporting each duplicate or hardcoded value with the single token that replaces it.
- Handoff file written, recording the drift found and the unifying tokens.

## Case C: missing-input
INPUT:
"Make me a design system." No accent, no neutrals, no type direction, and no surfaces are given.
EXPECT:
- The skill follows Loop 1 (Missing Input): it asks once for the brand basis (the accent, the neutral base, the type direction) and the surfaces in scope, because a token system needs a source of truth.
- It does not invent a palette, a font, or a scale, and it does not emit a full token ladder against an unknown brand.
- If it emits any partial output, the Primitives and Semantic fields are marked "Not provided" or left as slots rather than filled with guesses.
- Handoff file `.claude/crew-state/design-standards/crew-design-language-handoff.md` written, recording the missing brand basis as the blocker the next run needs.
