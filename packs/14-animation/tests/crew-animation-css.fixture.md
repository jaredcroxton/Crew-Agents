# Fixture: crew-animation-css

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the output, and that the handoff file was written.

## Case A: clean
INPUT:
Spec the motion for a marketing card section (Careful mode). The card should lift and brighten on hover, the call-to-action below it should run a finite pulse-ring loop, and a toast notification should slide in under JavaScript control with its duration computed from the message length and a slide-out chained when it finishes. Framework: none, plain HTML and CSS with a little JS. Honor reduced-motion.
EXPECT:
- Output begins with "CSS ANIMATION SPEC" and includes a Brief line, a Trigger line, a Framework line (none, native platform), a Built date, and a Mode.
- A "Primitive:" block that picks a CSS transition for the hover lift (a two-state change), CSS keyframes for the finite pulse-ring loop (a self-running sequence), and WAAPI (element.animate()) for the JS-driven, data-driven toast.
- A "Motion:" block: the transition names exact properties (transform, opacity), a duration, a timing-function, and the hover state that fires it; the keyframes give the stops, the shorthand or longhands, animation-fill-mode, and a finite iteration-count; the WAAPI block gives the keyframe array, options with fill both, and the playback control surface including animation.finished to chain the slide-out.
- A "Performance and accessibility:" block confirming only transform and opacity animate, will-change applied narrowly and removed, the 60fps off-main-thread rationale, and a reduced-motion path.
- The reduced-motion path removes or reduces each of the three motions to a static or minimal state.
- No em dashes anywhere in the output.
- Handoff file `~/.claude/crew-state/animation/crew-animation-css-handoff.md` was written.

## Case B: wrong-tool
INPUT:
I want a scroll-driven hero where six panels pin in place and scrub through a coordinated, multi-element timeline as the user scrolls, with relative offsets between the elements. Should I build this with CSS keyframes and transitions?
EXPECT:
- The reviewer judges CSS is the wrong tool here: a pinned, scroll-scrubbed, coordinated multi-element timeline with relative offsets is orchestration the native primitives cannot express; CSS has no real timeline and no scroll-scrub engine, so it would become a pile of hand-managed delays.
- It routes the request to `crew-animation-gsap` (the scroll and pinned-scrub engine with a real timeline and relative offsets), and notes `crew-animation-scroll-reveal` for lighter scroll reveals, rather than speccing CSS keyframes for it.
- It explains the boundary: CSS keyframes and transitions are for declarative, state, and single-element loop motion, WAAPI adds JS control without a library, and an orchestrated, scroll-scrubbed timeline belongs in a library.
- It does not fabricate a CSS-only scroll-scrub pretending to coordinate the panels.
- Handoff file written, recording that CSS was not the right tool and where the request was routed.

## Case C: missing-input
INPUT:
"Add some CSS animation to my site." No brief on what should animate, why, or on what trigger.
EXPECT:
- The skill follows Loop 1 (Missing Input): it asks once what should animate, why it should move, and on what trigger (a state change, hover or focus, load, in-view, or a JS event), because a spec needs a motion brief.
- It does not invent a motion, fabricate a keyframe block, or assume a trigger.
- If it emits any partial output, the Brief and Primitive fields are marked "Not provided" rather than filled.
- Handoff file `~/.claude/crew-state/animation/crew-animation-css-handoff.md` written, recording the missing brief as the blocker the next run needs.
