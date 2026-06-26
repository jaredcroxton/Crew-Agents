# Fixture: crew-animation-motion

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the output, and that the handoff file was written.

## Case A: clean
INPUT:
Spec the animation for a React card grid (Careful mode). Framework: React with Motion.
The cards reveal on scroll into view with a stagger, lift on hover, scale down slightly on tap, and when an item is removed it animates out while the remaining cards smoothly reflow. There is also a tab bar with an animated underline that slides between the active tabs. Reduced-motion users should get a reduced experience.
EXPECT:
- Output begins with "MOTION ANIMATION SPEC" and includes a Brief line, a Trigger line, a Framework line (React + Motion), a Built date, and a Mode.
- A "Setup:" block importing from framer-motion (motion, AnimatePresence) and useReducedMotion for the accessibility path.
- A "Components and motion:" block speccing the staggered scroll reveal via variants (a container with staggerChildren and whileInView, item variants, viewport once), using transform and opacity only.
- A "Gestures / layout / exit (if any):" block with whileHover lift and whileTap scale (each with a gesture transition), AnimatePresence with a stable key and an exit prop plus layout for the remove-and-reflow, and a layoutId shared-element underline that slides between tabs.
- A "Spring config:" block with spring stiffness and damping values.
- An "Accessibility:" block with a useReducedMotion path that zeroes or reduces the movement.
- No animation of top, left, width, or height; transform and opacity only.
- No em dashes anywhere in the output.
- Handoff file `.claude/crew-state/animation/crew-animation-motion-handoff.md` was written.

## Case B: wrong-tool
INPUT:
I am building a vanilla HTML and JS scroll site with a pinned section that scrubs through an image frame sequence as the user scrolls. Should I use Motion for this?
EXPECT:
- The reviewer judges Motion is the wrong tool here on two counts: the project is vanilla (not React, and Motion is React-first), and a pinned, scroll-scrubbed frame sequence is imperative scroll choreography that GSAP ScrollTrigger owns.
- It routes the request to `crew-animation-gsap` rather than speccing Motion components.
- It explains the boundary: Motion is for declarative React state, gesture, and layout animation; GSAP is for imperative timelines and scrubbed, pinned scroll.
- It does not fabricate a Motion spec or invent React structure the brief did not describe.
- Handoff file written, recording that Motion was not the right tool and where the request was routed.

## Case C: missing-input
INPUT:
"Add some animation to my React app." No brief on what should animate, why, or on what trigger.
EXPECT:
- The skill follows Loop 1 (Missing Input): it asks once what should animate, why it should move, and on what trigger (mount, state change, gesture, scroll, or unmount), because a spec needs a motion brief.
- It does not invent a motion, fabricate components, or spec variants against nothing.
- If it emits any partial output, the Brief, Trigger, and Components fields are marked "Not provided" rather than filled.
- Handoff file `.claude/crew-state/animation/crew-animation-motion-handoff.md` written, recording the missing brief as the blocker the next run needs.
