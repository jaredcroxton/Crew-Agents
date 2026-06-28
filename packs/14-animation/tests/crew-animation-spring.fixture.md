# Fixture: crew-animation-spring

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the output, and that the handoff file was written.

## Case A: clean
INPUT:
Spec a draggable card that follows the pointer and springs back to its origin with momentum when released (Careful mode). Also a staggered list reveal below it. Framework: React. Honor reduced-motion.
EXPECT:
- Output begins with "SPRING ANIMATION SPEC" and includes a Brief line, a Trigger line, a Framework line (React), a Built date, and a Mode.
- A "Hook and config:" block using useSpring in the function form with [styles, api] and a deps array for the card, and useTrail for the staggered list, with a spring config (a preset or mass/tension/friction) and a precision.
- A "Values and interpolation:" block animating values (x, y) and composing them in style, with no transform string passed to the spring.
- A "Gesture and velocity (if any):" block using @use-gesture (useDrag): drive the value directly while the pointer is down (immediate), and on release spring back seeded with the gesture velocity so the card carries its momentum.
- A "Performance and accessibility:" block with on-demand rendering, transform-and-opacity, batching, the deps array, and a reduced-motion path using Globals.skipAnimation.
- The interrupt or release preserves velocity rather than snapping.
- No em dashes anywhere in the output.
- Handoff file `~/.claude/crew-state/animation/crew-animation-spring-handoff.md` was written.

## Case B: wrong-tool
INPUT:
I need a hero intro where the title, then the subtitle, then the CTA fade in at exactly 0s, 0.4s, and 0.8s, synced to a background video. Should I use React Spring?
EXPECT:
- The reviewer judges a spring is the wrong tool here: a precisely timed, synced sequence needs exact marks at exact times, and a spring's settle time is emergent, not exact, so it cannot reliably hit 0s, 0.4s, and 0.8s in sync with the video.
- It routes the request to `crew-animation-gsap` (a duration-and-easing timeline that hits exact marks), rather than speccing a spring sequence.
- It explains the boundary: React Spring is for physics, gesture, and interruptible motion; a precise, synced sequence belongs in a timeline.
- It does not fabricate a spring chain pretending to hit exact times.
- Handoff file written, recording that a spring was not the right tool and where the request was routed.

## Case C: missing-input
INPUT:
"Add a spring animation to my React app." No brief on what should animate, why, or on what trigger.
EXPECT:
- The skill follows Loop 1 (Missing Input): it asks once what should animate, why it should move, and on what trigger (mount, state change, gesture, or scroll), because a spec needs a motion brief.
- It does not invent a motion, fabricate a useSpring config, or assume a gesture.
- If it emits any partial output, the Brief and Hook fields are marked "Not provided" rather than filled.
- Handoff file `~/.claude/crew-state/animation/crew-animation-spring-handoff.md` written, recording the missing brief as the blocker the next run needs.
