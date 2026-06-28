# Fixture: crew-animation-view-transitions

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the output, and that the handoff file was written.

## Case A: clean
INPUT:
Spec a photo grid where tapping a thumbnail morphs it into the detail hero, and the list-to-detail route change slides forward (Careful mode). Framework: React. Same-document SPA swap. Honor reduced-motion.
EXPECT:
- Output begins with "VIEW TRANSITIONS SPEC" and includes a Brief line, a Trigger line, a Framework line (React), a Built date, and a Mode.
- A "Shape and trigger:" block describing a same-document SPA swap via document.startViewTransition, with the React state update wrapped in flushSync so the new view is committed before the new snapshot is captured.
- A "Shared elements (morphs):" block giving the thumbnail and the detail hero the same view-transition-name, templated per item (for example photo-${id}) so each name is unique, with a stated fallback for paths where no matching pair forms.
- A "Transition CSS:" block styling the ::view-transition-old / new / group pseudo-elements: a directional slide for the hierarchical list-to-detail change and a size-and-position morph for the named image, animating transform and opacity over a short duration.
- A "Performance:" block bounding the named set (only the photo and the page root named, not the grid container), sizing and containing the captures, and avoiding layout shift by loading the detail image before the swap.
- An "Accessibility and fallback:" block with a progressive-enhancement path (feature-detect document.startViewTransition, unsupported browsers swap instantly) and a reduced-motion path that disables the named animations under prefers-reduced-motion.
- No em dashes anywhere in the output.
- Handoff file `~/.claude/crew-state/animation/crew-animation-view-transitions-handoff.md` was written.

## Case B: wrong-tool
INPUT:
I need a list where, during the page navigation, each of the twelve cards staggers out one after another at 40ms intervals, with precise per-item timing. Should I use View Transitions?
EXPECT:
- The reviewer judges View Transitions is the wrong tool for per-item staggered control during a navigation: when a parent view transition runs, nested named elements do not fire their own staggered enter or exit, so a single view transition cannot stagger the twelve cards independently during the page change.
- It routes the request to `crew-animation-motion` (declarative React variants with staggerChildren give per-item control), or notes `crew-animation-gsap` for an exact-timed imperative timeline, rather than speccing a view transition that cannot deliver the stagger.
- It explains the boundary: View Transitions is a native snapshot-and-morph for a whole state or route change; per-element staggered choreography belongs in a library.
- It does not fabricate a view-transition spec pretending to stagger per item.
- Handoff file written, recording that a view transition was not the right tool and where the request was routed.

## Case C: missing-input
INPUT:
"Add view transitions to my app." No brief on what changes, why it should morph, on what trigger, or whether it is same-document or cross-document.
EXPECT:
- The skill follows Loop 1 (Missing Input): it asks once what changes, why it should morph, and on what trigger (a click, a navigation, a state update), because a spec needs a brief and the same-document versus cross-document shape.
- It does not invent a transition, fabricate a view-transition-name, or assume the framework path.
- If it emits any partial output, the Brief and Shared-elements fields are marked "Not provided" rather than filled.
- Handoff file `~/.claude/crew-state/animation/crew-animation-view-transitions-handoff.md` written, recording the missing brief as the blocker the next run needs.
