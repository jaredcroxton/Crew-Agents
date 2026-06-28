# Fixture: crew-animation-barba

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the output, and that the handoff file was written.

## Case A: clean
INPUT:
Spec page transitions for a multi-page agency site (Careful mode). GSAP is in use.
A smooth fade between most pages, a slide crossfade between project-detail pages, and a loader during the page fetch. The header and footer should persist. After each transition, re-init the per-page scripts, reset scroll to the top, and update the document title and meta. The site must still work without JavaScript.
EXPECT:
- Output begins with "BARBA TRANSITION SPEC" and includes a Brief line, a Site line (multi-page), a GSAP line (yes), a Built date, and a Mode.
- A "DOM structure:" block with a data-barba wrapper, the persistent header and footer outside the container, a data-barba container on every page, and a data-barba-namespace per page type.
- An "Init (barba.init):" block with the transitions (the fade as async, the project slide as sync with from and to namespace and absolutely positioned containers, and a default fallback transition last) and per-namespace views.
- Every transition returns its animation promise (or is async/await); the spec does not skip the return.
- A "Hooks:" block with beforeEnter setting the enter initial state and resetting scroll, afterEnter re-initing scripts and lazy images, and after updating the title and meta and analytics.
- An "Accessibility and SEO fallback:" block stating the site degrades to normal links without JS, external links pass through, and focus moves to the new page.
- The new page does not flash before the enter animation; the loader is shown during fetch.
- No em dashes anywhere in the output.
- Handoff file `~/.claude/crew-state/animation/crew-animation-barba-handoff.md` was written.

## Case B: wrong-tool
INPUT:
I am building a React single-page app with React Router, and I want animated transitions between routes. Should I use Barba.js for this?
EXPECT:
- The reviewer judges Barba is the wrong tool here: Barba is for multi-page sites where it intercepts real navigation and AJAX-swaps a server-rendered container, whereas a React single-page app already owns its routing and its DOM, so Barba would fight React's render.
- It routes the request to the framework's own route transitions, or to `crew-animation-motion` (AnimatePresence) for React route animation, rather than speccing a Barba setup.
- It explains the boundary: Barba is for an MPA feeling like an SPA; an actual SPA uses its router and a React-native animation library.
- It does not fabricate a Barba init or invent a data-barba structure for a React app.
- Handoff file written, recording that Barba was not the right tool and where the request was routed.

## Case C: missing-input
INPUT:
"Add page transitions to my site." No context on whether the site is multi-page or a single-page app, or what the transition should feel like.
EXPECT:
- The skill follows Loop 1 (Missing Input): it asks once what kind of site it is (a multi-page site versus a single-page app) and what the transition should feel like, because Barba is for multi-page sites and the tool choice depends on that.
- It does not invent a transition spec, fabricate a DOM structure, or assume the site is multi-page.
- If it emits any partial output, the Brief and DOM structure fields are marked "Not provided" rather than filled.
- Handoff file `~/.claude/crew-state/animation/crew-animation-barba-handoff.md` written, recording the missing context as the blocker the next run needs.
