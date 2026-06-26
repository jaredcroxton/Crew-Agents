# Fixture: crew-animation-locomotive

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the output, and that the handoff file was written.

## Case A: clean
INPUT:
Spec smooth scroll for an immersive landing page (Careful mode). Framework: vanilla HTML and JS, GSAP ScrollTrigger also in use.
Smooth inertia scrolling, a hero with a slow parallax background and a faster parallax foreground, sections that reveal as they enter the viewport, and a sticky chapter label that pins within its section. Sync with GSAP ScrollTrigger for a scrubbed reveal. Disable on mobile and for reduced-motion users.
EXPECT:
- Output begins with "LOCOMOTIVE ANIMATION SPEC" and includes a Brief line, a Framework line, a GSAP synced line (yes), a Built date, and a Mode.
- An "HTML structure:" block with a data-scroll-container, data-scroll-section segments, and data-scroll elements (the parallax layers, the reveal sections, the sticky label with its target).
- An "Init config:" block with new LocomotiveScroll, smooth true, a lerp value, direction, the in-view class, and smartphone smooth false.
- A "Parallax and scroll events:" block with the background at a slow data-scroll-speed and the foreground faster, explicit z-index on the layers, an on("scroll") or on("call") handler, and the sticky label via data-scroll-sticky.
- A "GSAP integration (if synced):" block with the scrollerProxy, every ScrollTrigger using scroller: "[data-scroll-container]", locoScroll.on("scroll", ScrollTrigger.update), and refresh wired to update.
- A "Lifecycle and accessibility:" block with update on resize and DOM change, destroy on unmount, a reduced-motion fallback to native scroll, and mobile disabled.
- Native scroll is preserved; nothing traps the user.
- No em dashes anywhere in the output.
- Handoff file `.claude/crew-state/animation/crew-animation-locomotive-handoff.md` was written.

## Case B: wrong-tool
INPUT:
I am building a content-heavy documentation site and I want to add Locomotive smooth scroll to make it feel more premium. Should I?
EXPECT:
- The reviewer judges smooth scroll is the wrong call here: a documentation or content site depends on native scroll, keyboard navigation, find-in-page, and scannability, and hijacking the scroll for a premium feel hurts all of those and the accessibility floor.
- It recommends native scroll, and points to restrained motion polish (crew-design-engineering) instead of a scroll-hijacking library.
- It frames smooth scroll as a trade: the cinematic feel is worth it for an immersive or narrative site, not for docs where the cost outweighs the gain.
- It does not spec a Locomotive container or invent parallax the brief did not describe.
- Handoff file written, recording that smooth scroll was not the right call and the native-scroll recommendation.

## Case C: missing-input
INPUT:
"Make my scroll smooth." No context on what is being built or whether the cinematic feel is worth the trade-offs.
EXPECT:
- The skill follows Loop 1 (Missing Input): it asks once what is being built and whether the cinematic smooth-scroll feel is worth its trade-offs (native momentum, keyboard scroll, accessibility), because smooth scroll is a trade, not a default.
- It does not invent a smooth-scroll spec, fabricate parallax, or assume the cinematic feel is wanted.
- If it emits any partial output, the Brief and HTML structure fields are marked "Not provided" rather than filled.
- Handoff file `.claude/crew-state/animation/crew-animation-locomotive-handoff.md` written, recording the missing brief as the blocker the next run needs.
