# Fixture: crew-animation

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the output, and that the handoff file was written.

## Case A: clean
INPUT:
CREW CONSULT from crew-web-scrollytelling: brand gate passed, brand-context at ~/.claude/crew-state/brand-context.md. Building the homepage for Tallowwood Timber Co, a custom furniture workshop. Engine wanted: GSAP. Spec the animation: as the user scrolls, the headline fades and rises into place, then a pinned section scrubs three workbench panels horizontally. Reduced-motion users get a static experience; the horizontal scroll is disabled on mobile.
EXPECT:
- The skill routes to `references/gsap.md` and reads ONLY that reference file; no other file under `references/` is read.
- The brand onboarding hard stop is NOT re-run: the literal CREW CONSULT preamble plus the present brand-context file carve straight through Step 0.
- Output begins with "ANIMATION SPEC" and includes an Engine line naming GSAP, a Reference line naming references/gsap.md, a Brief line, a Trigger line (scroll), a Built date, and a Fit line saying why GSAP is right here.
- The Spec block speaks in the reference's own terms: gsap.registerPlugin(ScrollTrigger) in the setup, the headline as a gsap.from with autoAlpha and y, the panels as one scrubbed xPercent tween with ease none, a pinned trigger on the container, a matchMedia reduced-motion path, the pin disabled on mobile, and cleanup that kills triggers.
- Only transform and opacity animate; no width, height, top, or left.
- STATUS: DONE on the spec, and no em dashes anywhere in the output.
- Handoff file `~/.claude/crew-state/projects/<project>/crew-animation-handoff.md` was written, recording the engine chosen and the reference consulted.

## Case B: wrong-engine
INPUT:
CREW CONSULT from crew-web-landing-page-builder: brand gate passed, brand-context at ~/.claude/crew-state/brand-context.md. Building the booking page for Moreton Bay Paddle Hire. Engine wanted: GSAP with a timeline. The brief: the Book Now button should scale down slightly when pressed and shift its background colour on hover.
EXPECT:
- The skill says GSAP is the wrong engine for this job: a press scale and a hover colour shift are a CSS-only micro-interaction, and a library plus a timeline for one state change is overkill.
- It routes to the right reference instead, `references/css.md`, reads it, and returns the spec from that reference's terms (a :active transform scale, a :hover background with a short transition, transition on transform and background-color, a prefers-reduced-motion guard).
- The output's Fit line records the reroute and why; the Engine line names CSS animation, not GSAP.
- It does not fabricate a GSAP timeline or invent scroll behaviour the brief did not ask for.
- Handoff file `~/.claude/crew-state/projects/<project>/crew-animation-handoff.md` written, recording that GSAP was asked for, why it was refused, and which reference answered instead.

## Case C: missing-input
INPUT:
"Add some animation to my site." No engine named, no brief on what should move, why, or on what trigger, and no build context to infer any of it from.
EXPECT:
- The skill asks once: which engine is wanted, or what should move, why, and on what trigger (load, scroll, or interaction), because routing and speccing both need a motion brief.
- It does not pick an engine arbitrarily, does not read a reference file on a guess, and does not invent a motion or fabricate a spec against nothing.
- If it emits any partial output, the Engine, Brief, and Trigger fields are marked "Not provided" rather than filled.
- The handoff records STATUS: BLOCKED with the missing brief named as the blocker; the chat status is NEEDS_CONTEXT or BLOCKED, never DONE.
- Handoff file `~/.claude/crew-state/projects/<project>/crew-animation-handoff.md` written, recording the missing brief as what the next run needs.
