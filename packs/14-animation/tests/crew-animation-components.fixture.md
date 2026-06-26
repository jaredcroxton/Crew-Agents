# Fixture: crew-animation-components

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the output, and that the handoff file was written.

## Case A: clean
INPUT:
Spec the animated UI for a settings panel (Careful mode). It needs a modal dialog that opens from a button, success toasts that appear after a save, and a tabbed body inside the dialog. Framework: React with an existing shadcn/ui and Tailwind setup. Honor reduced-motion.
EXPECT:
- Output begins with "ANIMATION COMPONENT SPEC" and includes a Brief line, a Trigger line, a Framework line (React+Motion), a Built date, and a Mode.
- A "Primitive:" block naming the catalogue primitives chosen (modal/dialog, toast, tabs) and confirming they are pre-built, not a brand signature.
- A "Motion primitives and composition:" block decomposing each component: the modal as overlay-fade plus panel-scale plus focus-trap plus Escape, the toast as slide-in plus auto-dismiss plus exit, the tabs as a sliding indicator plus a short panel transition, with a shared spring preset named.
- A "Framework mapping:" block naming React with Motion plus a headless layer (Radix UI or React Aria) that owns focus, keyboard, and ARIA, and naming the library precisely.
- A "Pre-built vs custom and dependency cost:" block justifying pre-built (consistency, correctness, speed) and not pulling a heavy library for a single primitive.
- A "Performance and accessibility:" block with transform-and-opacity only (the accordion height exception noted where relevant), the focus trap, focus restore, and Escape on the overlay, and a reduced-motion path that drops decorative motion and keeps the fade.
- No em dashes anywhere in the output.
- Handoff file `.claude/crew-state/animation/crew-animation-components-handoff.md` was written.

## Case B: wrong-tool
INPUT:
I want a signature hero where the product name extrudes in 3D, a custom liquid-blob cursor that follows the mouse with momentum and bounces off the edges, and a one-of-a-kind page-load reveal nobody else has. What pre-built component should I drop in?
EXPECT:
- The skill judges this is the wrong tool: a brand-signature 3D extrude, a momentum-driven custom cursor, and a one-of-a-kind reveal are not standard primitives in any catalogue, so a pre-built component does not fit.
- It routes the work to the right siblings: the physics-and-momentum cursor to `crew-animation-spring` (interruptible, velocity-preserving motion), the bespoke page-load reveal timeline to `crew-animation-gsap` or a one-off `crew-animation-motion` piece, and the 3D extrude to a 3D path, rather than naming a component-library primitive.
- It explains the boundary: the components catalogue is for standard, solved patterns (modals, toasts, tabs) where consistency and correctness matter; a brand signature is exactly the custom case, and pulling a component library buys nothing here.
- It does not fabricate a pre-built primitive that does not exist or pretend a catalogue ships a custom-cursor component.
- Handoff file written, recording that a pre-built primitive was not the right tool and where the request was routed.

## Case C: missing-input
INPUT:
"Add some animated components to my app." No brief on which UI element should animate, why, or on what trigger.
EXPECT:
- The skill follows Loop 1 (Missing Input): it asks once which UI element should animate (a button, card, modal, nav, loader, toast, accordion, or tabset), why it should move, and on what trigger (hover, click, mount, open, dismiss, or in-view), because a spec needs a component brief.
- It does not invent a component, fabricate a primitive choice, or assume a framework or library.
- If it emits any partial output, the Brief and Primitive fields are marked "Not provided" rather than filled.
- Handoff file `.claude/crew-state/animation/crew-animation-components-handoff.md` written, recording the missing brief as the blocker the next run needs.
