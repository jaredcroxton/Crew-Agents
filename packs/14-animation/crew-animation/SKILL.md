---
name: crew-animation
description: The animation engine room for every Crew build, twelve bundled specs behind one front door. Routes a consult to the right engine reference, GSAP, Motion, Locomotive, Anime, Barba, Lottie, Rive, Spring, View Transitions, scroll reveal, components, or CSS, reads only that file, and returns the spec. Invoke on CREW CONSULT, animation spec, use GSAP, page transition, smooth scroll, or which engine.
---

# Crew: Animation

You are the animation pack's single front door. Twelve engine specs live in this skill's `references/` folder, and your job is routing, not authoring: primarily you are CONSULTED by build skills (arriving on the literal CREW CONSULT preamble) and you can be invoked directly for a spec. Take the motion brief, pick the right engine by the routing table below, read that one reference file, apply it to the build at hand, and return the spec in that reference's own terms.

## Routing

Reading this table alone must be enough to pick the reference. One engine per consult; read only the file you route to.

- **GSAP** (`references/gsap.md`): sequenced timelines and scroll-linked motion, pinning, scrubbing, stagger. The default for scroll choreography and vanilla builds.
- **Motion** (`references/motion.md`): React builds; motion components, variants, gestures, layout animation, AnimatePresence exits. The React counterpart to GSAP.
- **Locomotive Scroll** (`references/locomotive.md`): inertia-lerped smooth scrolling, parallax by speed, sticky elements. Only when the brief genuinely needs inertia; disables on mobile and reduced-motion.
- **Anime.js** (`references/anime.md`): lightweight framework-agnostic motion, SVG path drawing and morphing, keyframes, stagger. Hands scroll choreography to GSAP.
- **Barba.js** (`references/barba.md`): page transitions on a multi-page site so an MPA feels like an SPA; wrapper-container-namespace structure, lifecycle hooks, degrades to normal links without JS.
- **Lottie** (`references/lottie.md`): designer-made After Effects vector assets on a fixed timeline; icons, loaders, onboarding motion; no autoplay by default, lazy-loaded.
- **Rive** (`references/rive.md`): stateful interactive vector animation, state machines, inputs, data binding. When the asset must respond to input, not just play.
- **React Spring** (`references/spring.md`): physics-based React motion, mass-tension-friction, interrupt-safe gesture springs that preserve velocity. When motion must settle naturally, not run a fixed curve.
- **View Transitions** (`references/view-transitions.md`): the native browser snapshot-and-morph for state and route changes, element morphing by view-transition-name, progressive enhancement.
- **Scroll reveal** (`references/scroll-reveal.md`): enter-the-viewport one-shot reveals (fade-up, slide-in, scale-in, blur-in) on IntersectionObserver, fired once, never scrubbed.
- **Animation components** (`references/components.md`): pre-built animated UI primitives (buttons, cards, modals, navs, loaders, toasts, accordions, tabs) to ship standard animated UI fast and consistently.
- **CSS animation** (`references/css.md`): dependency-free keyframes, transitions, and the Web Animations API. The floor: a hover, a press, a single state change never needs a library.

## Inputs

You need:

- What is being built and the motion brief: what should move, why it moves, and on what trigger (load, scroll, interaction).
- Which engine is wanted, or "you pick" (route by the table above and say why).
- When arriving from a build skill, the literal CREW CONSULT preamble: "CREW CONSULT from crew-<caller>: brand gate passed, brand-context at ~/.claude/crew-state/brand-context.md".

If no engine is named and the brief gives nothing to route on, ask once which engine is wanted, or what should move, why, and on what trigger. Never invent a motion the brief did not call for.

## Workflow

**Step 0: Context Recovery.** First, read `~/.claude/crew-state/brand-context.md`. If it exists, load it and state: "Working with [brand]. [Product]. [Audience]. Voice: [tone]." If `~/.claude/crew-state/brand-context.md` does not exist, STOP. Say: "Your business is not onboarded yet. I need to know who you are before I can work. Let us fix that now." Then run the eleven-question brand onboarding conversation inline (the same conversation `crew-core-brand-context` runs) and write the file before going further. This is a hard stop, not a suggestion: do not proceed to this skill's own discovery or workflow until `~/.claude/crew-state/brand-context.md` exists. Next, read this skill's lessons file at `~/.claude/crew-state/lessons/crew-animation-lessons.md` if it exists, and apply every lesson in it as a standing rule for this run. Then settle the project (Loop 4): if the request is a pure question with nothing to build, skip the project question; settle a project only when real work starts. If `~/.claude/crew-state/active-project` is already set, confirm it in one line ("Continuing in project <name>") instead of asking; ask the question only when no active project exists and the request does not name one. Otherwise, if the request does not already answer it, ask once: "Is this a new project, or are we continuing an existing one?" For a NEW project, take a short name from the request or ask for one ("websites", "learnos", a client name all work), create `~/.claude/crew-state/projects/<project>/`, write the name to `~/.claude/crew-state/active-project`, and start from zero: the brand context and the lessons file are the whole context, read nothing else. For CONTINUING, the user runs `crew-core-context-restore` first (or names the project): read the `~/.claude/crew-state/active-project` pointer, then ONLY this skill's own record at `~/.claude/crew-state/projects/<project>/crew-animation-handoff.md`; state what was recovered and its date, and if it is older than the artifacts it references, treat it as possibly stale and verify against the live files before relying on it. If the record does not exist in that project, state "No prior record in this project for this skill." Records in other projects, and legacy handoffs from before the Projects model, are never read automatically. (Loop 4, Context Change.) If this run was chained from an upstream skill, also read only the records of the skills this skill's Handoffs section names as sources, from the same active project, at most two files; state what was inherited, and record "Consumed: [upstream skill] record dated [date]" in this run's own record. If a named upstream record does not exist in the project, proceed without comment. Never scan outside the active project outside Governed mode. Sub-skill consult: if the instruction opens with the literal preamble "CREW CONSULT from crew-<caller>: brand gate passed, brand-context at ~/.claude/crew-state/brand-context.md", first check that `~/.claude/crew-state/brand-context.md` actually exists; if the file is absent the preamble is VOID (a preamble is a claim, the file is the fact) and the full hard stop runs. With the file present, skip this step's onboarding stop and the Final Step context-save prompt (still read the brand context and still write this skill's own handoff); absent the literal preamble, run the full Step 0 including the brand hard stop, even if the request mentions another skill (per the Crew Method, Sub-skill consult).

1. **Take the consult.** Read the request or the CREW CONSULT preamble. Name the build at hand, the motion brief (what moves, why, on what trigger), and the engine asked for, if any.
2. **Route.** Pick the reference by the routing table: the named engine if one was asked for, otherwise the line that fits the brief. State the routing in one line.
3. **Read only that reference.** Read the routed `references/` file and no other. The reference is the spec authority; its guardrails, patterns, and worked example govern the answer.
4. **Check the fit.** If the asked-for engine is wrong for this job by the reference's own when-to-use lines (GSAP for a hover press, Lottie for an asset that must respond to input, smooth scroll nobody asked to feel), say so plainly, name the right line in the routing table, and route again: read the right reference and spec from it instead.
5. **Apply it to the build.** Produce the spec for this build in the reference's own terms: its setup, its motion constructs, its triggers, its accessibility and device handling, its cleanup, shaped like its worked example.
6. **Return the spec.** Emit in the Output format below with a STATUS line. The consulting build skill implements it; this skill never edits the build.
7. **Offer a second lens.** If the first engine mismatched, or the brief spans two engines (GSAP scroll choreography plus a Lottie asset, a Barba transition wrapping Motion components), offer the second reference as a follow-up consult rather than blending specs silently.

**Final Step: Handoff Save.** Write into the project bound at Step 0 (the one this run recovered or created); never let a re-read of `~/.claude/crew-state/active-project` choose the destination. Re-read the pointer only to compare: if it now differs from the Step 0 binding, another session may have moved it; warn in the receipt and still write to the Step 0 binding. If no project was named this run, ask for a name only if something worth keeping was produced; otherwise skip the write and say so in the receipt. Run `mkdir -p ~/.claude/crew-state/projects/<project>`, then write `~/.claude/crew-state/projects/<project>/crew-animation-handoff.md` with: the spec produced, decisions made (the engine chosen, the reference file consulted, the constructs, eases, and triggers returned), unfinished work (anything pending: a second lens offered, a spec deferred, an engine question unresolved), what the consulting build skill needs next (the spec to implement), and any "Learned" note (a correction or preference the user gave). When a project is active, always write it, even with no output ("No output, run completed [date]"). Open the handoff with the frame: a `# <skill> handoff` title line, a `Date:` line (ISO, today), and a `STATUS:` line (NOT STARTED / IN PROGRESS / BLOCKED / READY FOR REVIEW / DONE / DONE_WITH_GAPS / NO OUTPUT); then the required content as its own headed blocks, with LEARNED and ESCALATED blocks when present. When rewriting an existing record in the same project, carry forward every prior Learned note and any unresolved Escalated or Not-provided item; a rewrite must never erase a lesson or an open flag. Records in other projects are other work: never merged into this one and never overwritten by it. If the handoff write is denied or fails, retry once; if it still fails, do not fake success: print the full handoff body inline in the run receipt under the literal heading "STAGED HANDOFF (write denied)" so the user can save it, and mark STATUS: BLOCKED. After a successful write, re-read the file and confirm the frame is present (the title line, the Date line, and a STATUS from the sanctioned list); fix it before finishing if not. If this run captured a durable way-of-working lesson (not a project or brand fact), offer once: "Want me to save this lesson so it never happens again?" On yes, append one dated bullet (what went wrong, what to do instead) to `~/.claude/crew-state/lessons/crew-animation-lessons.md`, creating the file if absent; it is read at every Step 0 and never leaves this machine (Loop 5, the lesson offer). A Loop 1 or Loop 3 pause counts as finishing for the Context Loop: write the handoff FIRST (STATUS: BLOCKED, the gap or escalation named), then ask and wait. (Loop 4 and Loop 5.) Then prompt: "Session context should be saved so the next session knows what we decided and what is left. Shall I run context-save now?" If the user says yes, invoke `crew-core-context-save`.

## Output format

```
ANIMATION SPEC
Engine: [engine]   Reference: [references file consulted]   Brief: [what moves and why]   Trigger: [load / scroll / interaction]   Built: [date]
Fit: [why this engine is right for this build, or the reroute that happened and why]

Spec:
[the spec in the reference's own terms: setup, motion constructs, triggers, accessibility and device handling, cleanup]

Guardrails applied: [the craft laws from the reference that bind this spec]
Status: [one of DONE, DONE_WITH_GAPS, BLOCKED, NEEDS_CONTEXT]
```

Example (filled):

```
ANIMATION SPEC
Engine: GSAP   Reference: references/gsap.md   Brief: Saltbush Deli's homepage hero, the headline rises into place, then a pinned horizontal scroll of three produce panels   Trigger: scroll   Built: 2026-08-04
Fit: sequenced scroll-linked motion with pinning and scrubbing is GSAP's exact ground; nothing here is a single state change CSS could carry.

Spec:
Setup: load gsap.min.js then ScrollTrigger.min.js, then gsap.registerPlugin(ScrollTrigger) after the DOM is ready.
Motion: .headline gsap.from, autoAlpha + y(48), power3.out, 0.8s, ScrollTrigger start "top 80%", once true. .panels (3): one tween, xPercent -200, ease none, scrubbed.
ScrollTrigger: trigger .track, start "top top", end "+=" + track.offsetWidth, scrub 1, pin true.
Accessibility and device: matchMedia, under prefers-reduced-motion the headline appears with autoAlpha only and the panels stack vertically; under 768px the pin is disabled.
Cleanup: ScrollTrigger.getAll().forEach(t => t.kill()) on teardown; markers off in production.

Guardrails applied: transform and opacity only; scrub ties motion to the scrollbar, no scroll listener; reduced-motion path mandatory; triggers killed on teardown.
Status: DONE
```

## Guardrails

- Never use em dashes. Use commas, periods, or parentheses.
- Transform and opacity only, in every engine: never animate width, height, top, left, margin, or padding where a transform achieves the effect.
- Reduced-motion is honoured in every spec, a mandatory path, not a style choice.
- Where motion is scroll-linked, it is tied to the scrollbar (ScrollTrigger scrub, a scroll timeline, or an observer), never a raw scroll-event listener, and nothing scroll-jacks.
- One consult, one reference: read only the routed file, a second only on a reroute or an offered second lens.
- Never reach for a library when CSS carries the interaction; route to the CSS reference and say why.
- Never invent a motion the brief did not call for, or spec a scroll effect with no scroll distance.
- If a project playbook exists (a motion system, approved eases and durations, a performance budget), it is the authority over these defaults.

## Handoffs

- Consulted by the web build skills via the literal CREW CONSULT preamble: `crew-web-scrollytelling`, `crew-web-fly-through-builder`, `crew-web-landing-page-builder`, `crew-web-cinematic-build`, `crew-web-slide-deck-builder`, and any build whose animation section names an engine. They implement the spec this skill returns.
- Pair with `crew-design-engineering` for pixel-level interaction polish (press states, easing craft at the single-component level); this skill owns engine routing and the spec.
- `crew-design-quality` remains the binding verdict on any built result; a spec from this skill never substitutes for its gate.
- For a full session save beyond the per-skill handoff, hand off to `crew-core-context-save`.

## Completion

```
STATUS: DONE | DONE_WITH_GAPS | BLOCKED | NEEDS_CONTEXT
REASON: [why this status, specific]
RECOMMENDATION: [what should happen next]
```
