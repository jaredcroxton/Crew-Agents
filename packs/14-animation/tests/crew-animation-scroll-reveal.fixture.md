# Fixture: crew-animation-scroll-reveal

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the output, and that the handoff file was written.

## Case A: clean
INPUT:
Spec the scroll reveals for a marketing landing page (Careful mode). The hero headline and subcopy should fade up on load, a three-up feature grid should cascade in as it enters the viewport, and alternating content sections should slide in from the left and right. Framework: vanilla single-file. Honor reduced-motion.
EXPECT:
- Output begins with "SCROLL REVEAL SPEC" and includes a Brief line, a Trigger line (element enters the viewport), a Framework line (vanilla), a Built date, and a Mode.
- A "Library:" block choosing plain IntersectionObserver (with a reason it beats a library here), not a scroll-event listener.
- A "Reveal patterns:" block naming fade-up for the hero and grid and slide-in for the sections, with small distances (16 to 32px translate), durations in the 400 to 800ms range, and an ease-out, and stating the resting state is the default so content survives without JS.
- A "Stagger and cascade (if a group):" block for the feature grid with a stagger of 60 to 120ms and a sensible cascade direction.
- An "Observer:" block with a threshold (around 0.15 to 0.25), a rootMargin, root null (viewport), and unobserve after the first fire.
- A "Performance and accessibility:" block: transform and opacity only, fire once, a reduced-motion path that collapses to an instant appearance under prefers-reduced-motion, and a no-JS fallback keeping content readable.
- The reveals fire once on entry (not re-trigger on every scroll past).
- No em dashes anywhere in the output.
- Handoff file `~/.claude/crew-state/animation/crew-animation-scroll-reveal-handoff.md` was written.

## Case B: wrong-tool
INPUT:
I want a cinematic hero where a city background scrolls slower than the foreground the entire time you scroll the section, plus the section pins while an image sequence scrubs frame-by-frame to the scrollbar. Should I use a scroll-reveal observer?
EXPECT:
- The reviewer judges this is the wrong tool: the motion scrubs continuously with scroll position (a continuous parallax, a pin, and an image-sequence frame scrub), not a one-shot reveal that fires once on entry.
- It explains that IntersectionObserver only knows entry and exit, not the position in between, so it cannot drive a continuous parallax or a frame scrub.
- It routes the request to `crew-animation-gsap` (ScrollTrigger with scrub, pin, and ease "none") and notes `crew-animation-locomotive` for the smooth-scroll plus parallax layer.
- It explains the boundary: a scroll reveal is lightweight, IntersectionObserver-first, and one-shot; anything that tracks the scrollbar frame-by-frame is a scrub.
- It does not fabricate an observer-based parallax or pretend an observer can scrub.
- Handoff file written, recording that a reveal was not the right tool and where the request was routed.

## Case C: missing-input
INPUT:
"Add some scroll animations to my site." No brief on what should reveal, why, or whether elements reveal as a group or one at a time.
EXPECT:
- The skill follows Loop 1 (Missing Input): it asks once what should reveal, why it should reveal, and whether elements reveal as a group or one at a time, because a spec needs a motion brief.
- It does not invent a reveal, fabricate a pattern set, or assume a grid cascade.
- If it emits any partial output, the Brief and Reveal-patterns fields are marked "Not provided" rather than filled.
- Handoff file `~/.claude/crew-state/animation/crew-animation-scroll-reveal-handoff.md` written, recording the missing brief as the blocker the next run needs.
