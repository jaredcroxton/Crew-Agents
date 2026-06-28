# Fixture: crew-animation-anime

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the output, and that the handoff file was written.

## Case A: clean
INPUT:
Spec the animation for an SVG logo intro (Careful mode). Context: vanilla HTML and JS.
The logo strokes draw on as a line-dash reveal, then one shape morphs into another, then the wordmark letters stagger in from the center, all sequenced as a single timeline that plays on load. Reduced-motion users should see the final settled state instantly.
EXPECT:
- Output begins with "ANIME ANIMATION SPEC" and includes a Brief line, a Trigger line (load), a Context line (SVG, vanilla), a Built date, and a Mode.
- A "Setup:" block importing anime from animejs and noting the stroke-dasharray set by anime.setDashoffset.
- A "Motion:" block built as an anime.timeline with relative offsets (+= or -=), covering the line draw, the morph, and the letter stagger, using individual transform properties and opacity.
- An "SVG (if any):" block specifying the line drawing via strokeDashoffset [anime.setDashoffset, 0], and a morph whose two d values keep the same number of points.
- The letter reveal uses anime.stagger with from "center".
- An "Integration and accessibility:" block with a reduced-motion path that applies the final state instantly, and cleanup (pause on teardown).
- No transform string and no layout properties (left, top, width, height); individual transforms and opacity only.
- No em dashes anywhere in the output.
- Handoff file `~/.claude/crew-state/animation/crew-animation-anime-handoff.md` was written.

## Case B: wrong-tool
INPUT:
I want a pinned section that scrubs an animation tied to scroll progress as the user scrolls down. Should I use Anime.js, driving seek from the scroll position?
EXPECT:
- The reviewer judges Anime.js is the wrong tool here: it has no scroll engine, and driving seek from a raw scroll-event listener thrashes the main thread, while a pinned, scroll-scrubbed timeline is exactly what GSAP ScrollTrigger is built for.
- It routes the request to `crew-animation-gsap` rather than speccing an Anime.js scroll hack.
- It explains the boundary: Anime.js is for SVG and framework-agnostic choreographed sequences; for in-view play it would use an IntersectionObserver, but a pinned scrub belongs to GSAP.
- It does not fabricate an Anime.js scroll spec or invent a raw scroll listener.
- Handoff file written, recording that Anime.js was not the right tool and where the request was routed.

## Case C: missing-input
INPUT:
"Animate this." No brief on what should animate, why, or on what trigger.
EXPECT:
- The skill follows Loop 1 (Missing Input): it asks once what should animate, why it should move, and on what trigger (load, interaction, or in-view), because a spec needs a motion brief.
- It does not invent a motion, fabricate a timeline, or spec SVG or stagger against nothing.
- If it emits any partial output, the Brief, Trigger, and Motion fields are marked "Not provided" rather than filled.
- Handoff file `~/.claude/crew-state/animation/crew-animation-anime-handoff.md` written, recording the missing brief as the blocker the next run needs.
