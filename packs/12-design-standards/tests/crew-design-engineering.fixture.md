# Fixture: crew-design-engineering

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the output, and that the handoff file was written.

## Case A: clean
INPUT:
Review this button component (Careful mode). It is a primary button used a few times per screen.
```css
.button {
  background: #4f46e5;
  transition: all 0.2s;
}
.button:hover {
  background: #4338ca;
}
```
There is no `:active` state, and the only hover change is the background colour.
EXPECT:
- Output begins with a fenced summary whose first line is "DESIGN ENGINEERING REVIEW", with a Component line, a Reviewed date, a Mode, and a Verdict line (Polish or Rework) plus a Highest-impact fix.
- The review body is a markdown table with "Before", "After", and "Why" columns (a real table with the | --- | --- | --- | separator row), NOT a list with "Before:" and "After:" on separate lines.
- A row flags `transition: all 0.2s` and replaces it with an exact property (for example `transition: transform 160ms ease-out` or `transition: background-color ...`), with the reason that exact properties beat `all`.
- A row flags the missing `:active` state and adds `transform: scale(0.97)` on `:active`, with the reason that a button must feel responsive to press.
- A row flags the thin hover (background only) and adds a more considered hover, gated behind `@media (hover: hover) and (pointer: fine)` where motion is involved.
- No em dashes anywhere in the output.
- Handoff file `~/.claude/crew-state/design-standards/crew-design-engineering-handoff.md` was written.

## Case B: animation decision
INPUT:
Review these two components. A modal and a popover, both animating with `transition: all 0.3s ease`. The modal scales in from `transform-origin: center`. The popover also scales in from `transform-origin: center`.
EXPECT:
- The reviewer keeps the table format (Before, After, Why).
- It replaces `transition: all 0.3s ease` on both with explicit properties (for example `transition: transform 200ms ease-out, opacity 200ms ease-out`), not `all`.
- It corrects the modal away from a pure scale-from-center toward a fade plus translate (or keeps the modal centered but with explicit properties), and explicitly keeps `transform-origin: center` for the modal because a modal is not anchored to a trigger.
- It corrects the popover to scale from its trigger via `transform-origin: var(--radix-popover-content-transform-origin)` (or the Base UI variable), not from center, because a popover should scale from where it is anchored.
- The distinction is made clear: modals stay centered, popovers are origin-aware. No easing or duration is invented beyond standard craft values.
- Handoff file written, recording the modal and popover decisions.

## Case C: missing-input
INPUT:
"Review this UI." No component, no code, no screenshot, no URL is provided.
EXPECT:
- The skill follows Loop 1 (Missing Input): it asks once, plainly, for the component or interaction to review (the code, a snippet, or a concrete interaction), because craft review is specific to real code.
- It does not invent a component, fabricate an easing or duration, or produce a Before/After table against code it cannot see.
- If it emits any partial output, the Component and verdict fields are marked "Not provided" rather than filled.
- Handoff file `~/.claude/crew-state/design-standards/crew-design-engineering-handoff.md` written, recording the missing artifact as the blocker the next run needs.
