# Fixture: crew-animation-gsap

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the output, and that the handoff file was written.

## Case A: clean
INPUT:
Spec the animation for a scroll-driven hero (Careful mode). Framework: vanilla HTML and JS.
As the user scrolls: the headline fades and rises into place, then a pinned section scrubs three feature panels horizontally, then a parallax background moves at two depths behind a section. Reduced-motion users should get a static experience, and the horizontal scroll should be disabled on mobile.
EXPECT:
- Output begins with "GSAP ANIMATION SPEC" and includes a Brief line, a Trigger line (scroll), a Framework line (vanilla), a Built date, and a Mode.
- A "Setup:" block that loads gsap and ScrollTrigger and calls gsap.registerPlugin(ScrollTrigger) before any trigger.
- A "Motion:" block specifying the headline reveal (gsap.from with autoAlpha and y, a power ease-out), the horizontal panels (one tween, xPercent, ease none, scrubbed), and the two parallax layers (yPercent at two depths, ease none, scrub) using only transform and opacity.
- A "ScrollTrigger (if scroll-linked):" block with the horizontal scroll pinned and scrubbed on the container, and the parallax triggered on the section start "top bottom" end "bottom top".
- An "Accessibility and device:" block with a reduced-motion path through matchMedia (a static or reduced experience) and the horizontal pin disabled on mobile.
- A "Cleanup:" block that kills triggers and tweens on teardown and turns markers off in production.
- No animation of width, height, top, or left; transform and opacity only.
- No em dashes anywhere in the output.
- Handoff file `.claude/crew-state/animation/crew-animation-gsap-handoff.md` was written.

## Case B: wrong-tool
INPUT:
I want a button to scale down slightly when it is pressed and shift its background colour on hover. Should I use GSAP and a timeline for this?
EXPECT:
- The reviewer judges GSAP is overkill here: a press scale and a hover colour shift are a CSS-only micro-interaction (`:active { transform: scale(0.97) }` and a `:hover` background with a short transition), and pulling in a library and a timeline for it is the wrong tool.
- It routes the request to `crew-design-engineering` for the pixel-level interaction polish, rather than speccing a GSAP timeline.
- It explains the line: GSAP is for sequenced or scroll-linked motion, not for a single state change a CSS transition handles.
- It does not fabricate a timeline or invent scroll behaviour the brief did not ask for.
- Handoff file written, recording that GSAP was not the right tool and where the request was routed.

## Case C: missing-input
INPUT:
"Add some animation to my site." No brief on what should move, why, or on what trigger.
EXPECT:
- The skill follows Loop 1 (Missing Input): it asks once what should move, why it should move, and on what trigger (load, scroll, or interaction), because a spec needs a motion brief.
- It does not invent a motion, fabricate a timeline, or spec a scroll effect against nothing.
- If it emits any partial output, the Brief, Trigger, and Motion fields are marked "Not provided" rather than filled.
- Handoff file `.claude/crew-state/animation/crew-animation-gsap-handoff.md` written, recording the missing brief as the blocker the next run needs.
