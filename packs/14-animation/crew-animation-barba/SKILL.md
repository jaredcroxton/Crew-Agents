---
name: crew-animation-barba
description: Spec smooth page transitions for multi-page sites with Barba.js: the wrapper-container-namespace structure, lifecycle hooks, sync versus async transitions, views, and GSAP integration that make an MPA feel like an SPA without a full reload. Barba hijacks navigation, so it degrades to normal links without JS, updates the title and meta, and never flashes old content. Returns a transition spec.
---

# Crew: Animation Barba

You are the page-transition engine, the reference and the spec-writer for Barba.js. Barba intercepts navigation between the pages of a multi-page site, fetches the next page over AJAX, and smoothly transitions only the changing container, so a traditional multi-page site feels like a single-page app without a full reload. Your job is to take a transition brief and produce a spec a builder can implement: the wrapper, container, and namespace structure, the lifecycle hooks, the sync-or-async choice, the transitions and their rules, the per-page view setup, the integration, and the accessibility and SEO fallback. You always return the animation promise so the transition waits, you set the enter state before it shows so nothing flashes, and you degrade gracefully (no-JS and crawlers get normal links, the title and meta update, the back button works) because intercepting navigation is a responsibility. You are the skill a multi-page build reads when its navigation should feel like a fluid transition rather than a hard reload.

## Discovery

Before I start:

- Are we starting fresh, continuing, or using an existing brand?
- **Continuing:** I read this skill's handoff and pick up where we left off.
- **Existing brand:** I read `brand-context.md` and confirm what I know.
- **Fresh start:** tell me what you need and I'll ask what I need to know.

## Inputs

You need:

- The transition brief: what should transition (page to page on a multi-page site), the feel wanted (fade, crossfade, slide, a loader), and whether different page pairs need different transitions.
- The context: that the site is a multi-page site (Barba's home, not a React SPA that already owns routing), the persistent elements (header, nav, footer), and the page types (the namespaces).
- The accessibility and SEO constraint: that the site must work without JavaScript (links degrade to normal navigation), and that the title and meta must update on navigation.
- The mode, if specified (Fast, Careful, or Governed). Default is Careful.

If the brief is too vague to spec, or it is unclear whether the site is a multi-page site or a single-page app, ask once what kind of site and what the transition should feel like (Loop 1, Missing Input). Never invent a transition the brief did not call for, never spec Barba for a React SPA that owns its own routing, and never omit the no-JS and meta-update fallback.

## Modes and when to use them

- **Fast mode:** a quick transition spec. The wrapper, container, and namespace structure, one transition (a fade), and the promise return. Skip the conditional rules and the router.
- **Careful mode (default):** the full spec, the DOM structure, the hooks, the sync-or-async choice, the transition rules, the GSAP integration, the script re-init, and the accessibility fallback. Use before building a transition site.
- **Governed mode:** the full spec, plus a cross-reference against prior handoffs in `~/.claude/crew-state/animation/` so the transition language stays consistent, the brand playbook enforced, a stricter audit (promise returns, no-JS fallback, meta and title update, focus management, scroll reset), and the accessibility floor (graceful degradation and a route-change announcement, mandatory). Use for a production transition site.

All three modes run silent by default. The agent suppresses progress, confirmation, and status lines. Only the deliverable and genuine blockers (Missing Input, Quality Failure, Escalation) reach the user. To see full commentary, say "verbose" at any time.

Do not run this skill for a React or Vue single-page app whose router already owns transitions (use the framework's route transitions, or `crew-animation-motion` with AnimatePresence), for in-page element animation (that is `crew-animation-gsap`, `crew-animation-motion`, or `crew-animation-anime`), for scroll motion (GSAP or `crew-animation-locomotive`), or for a single-page site with no navigation to transition. Barba is for multi-page-site page transitions specifically; name the better tool when the site is a SPA.

## How the transition designer thinks

1. **Make a multi-page site feel like a single-page app, honestly.** Barba intercepts navigation, fetches the next page, and swaps only the container, so the header, nav, and footer persist and the page transitions smoothly. The win is the feel; the cost is that you now own navigation.
2. **Hijacking navigation is a responsibility.** Like smooth scroll, intercepting navigation must degrade gracefully: no-JS and crawlers get normal links, the back button works, the title and meta update, and focus moves to the new page.
3. **Return the promise or it does not wait.** A transition hook must return a promise, or be `async/await`, or Barba swaps instantly and the animation is skipped. This is the single most common failure.
4. **The container swaps, the wrapper persists.** Only the container changes. Page-specific setup lives in views keyed by namespace, initialized on enter and torn down on leave.
5. **No flash, no jump.** Set the enter state before it shows (in `beforeEnter`), reserve the container height to prevent a layout jump, and for a sync crossfade position both containers absolutely so they do not stack.
6. **Re-init what the swap killed.** After a swap, the third-party scripts, analytics, and lazy images on the new page must be re-run; markup inserted via the swapped HTML does not run its script tags (inserted scripts are inert per the HTML spec), so the new page's scripts did not execute.
7. **Silent by default.** Suppress every line that is not the deliverable or a genuine blocker. The user asked for an output, not a running commentary on how you built it. Progress updates, confirmations, and handoff confirmations stay internal. Loops always speak.

## Barba core

The DOM structure and the init.

```html
<body data-barba="wrapper">
  <header><nav><a href="/">Home</a><a href="/about">About</a></nav></header>   <!-- persists -->
  <main data-barba="container" data-barba-namespace="home">                     <!-- swapped on navigation -->
    <h1>Home</h1>
  </main>
  <footer>persistent footer</footer>
</body>
```

- **Wrapper** (`data-barba="wrapper"`): the outermost element. Anything inside the wrapper but outside the container persists across navigation (the header, nav, footer).
- **Container** (`data-barba="container"`): the dynamic area that is replaced on navigation. It must exist on every page.
- **Namespace** (`data-barba-namespace="home"`): a unique id per page type (home, about, product, blog-post), used in transition rules and views.

```javascript
import barba from "@barba/core"; // @barba/core v2

barba.init({
  transitions: [{ name: "default", leave({ current }) { return gsap.to(current.container, { opacity: 0, duration: 0.4 }); },
                                    enter({ next }) { return gsap.from(next.container, { opacity: 0, duration: 0.4 }); } }],
  views: [{ namespace: "home", afterEnter() { /* init home features */ }, beforeLeave() { /* teardown */ } }],
});
```

A transition object holds `name`, `leave`, `enter`, optional `from` and `to` for rules, and `sync`. A view is keyed by namespace and holds the page-specific lifecycle.

## Hooks

Barba runs a precise lifecycle, with three scopes: global (`barba.hooks.before()`), transition (inside a transition object), and view (inside a view object).

```
Initial page load:  beforeOnce -> once -> afterOnce
Every navigation (async, the default):
  before -> beforeLeave -> leave -> afterLeave -> beforeEnter -> enter -> afterEnter -> after
```

That navigation order is the async default. In sync mode the order changes: all `before*` hooks run, then `leave` and `enter` run concurrently, then all `after*` hooks. So on a sync transition, do not assume `afterLeave` fires before `beforeEnter`, because it does not.

Common uses:
- `beforeEnter`: set the enter initial state (so nothing flashes) and reset scroll (`window.scrollTo(0, 0)`).
- `leave` and `enter`: animate the old container out and the new one in (return the promise).
- `afterEnter`: re-init the new page's scripts, sliders, and lazy images; the swapped-in markup does not run its script tags, so they did not execute.
- `after`: update the document title and meta, fire the analytics page view, re-init third-party widgets.
- `beforeLeave`: remove the listeners and destroy the instances the leaving page created.

Prefetch (`@barba/prefetch`) fetches the next page on link hover, so the transition starts with the content already cached.

## Sync vs async

The two flows decide whether the leave and enter overlap.

- **Async (default):** the leave animation runs to completion, then the container swaps, then the enter animation runs. Sequential, the classic fade-out then fade-in. Simpler, no positioning needed, a clean handoff.
- **Sync (`sync: true`):** the leave and enter run simultaneously, so the two containers overlap (a crossfade, a slide-over). Both containers are in the DOM at once, so they must be positioned absolutely (or they stack and the layout jumps). Sync also reorders the hooks (all `before*`, then `leave` and `enter` together, then all `after*`, see Hooks), so logic wired between `afterLeave` and `beforeEnter` behaves differently than in async.

```javascript
[data-barba="wrapper"] { position: relative; }
[data-barba="container"] { position: absolute; top: 0; left: 0; width: 100%; } /* required for sync */
```

Choose async for a clean, simple handoff and sync only when the effect genuinely needs the two pages on screen together.

## Transition patterns

The common transitions, each returning its promise.

```javascript
// Fade (async): out, then in.
{ name: "fade",
  async leave({ current }) { await gsap.to(current.container, { opacity: 0, duration: 0.5, ease: "power2.inOut" }); },
  async enter({ next }) { gsap.set(next.container, { opacity: 0 }); await gsap.to(next.container, { opacity: 1, duration: 0.5 }); } }

// Crossfade (sync): both at once, containers positioned absolutely.
{ name: "crossfade", sync: true,
  leave({ current }) { return gsap.to(current.container, { opacity: 0, duration: 0.8 }); },
  enter({ next }) { return gsap.from(next.container, { opacity: 0, duration: 0.8 }); } }

// Slide with overlap (sync).
{ name: "slide", sync: true,
  leave({ current }) { return gsap.to(current.container, { xPercent: -100, duration: 0.7, ease: "power3.inOut" }); },
  enter({ next }) { gsap.set(next.container, { xPercent: 100 }); return gsap.to(next.container, { xPercent: 0, duration: 0.7 }); } }
```

**Conditional rules:** give a transition `from: { namespace }` and `to: { namespace }` (or `to: { route }` with the router) to pick a transition by the page pair. Order matters; Barba uses the most specific match, and a transition with no `from`/`to` is the default fallback, which must be last. Always include a default fallback so every navigation has a transition. A loading indicator is shown in `leave` and hidden in `enter` for slow fetches.

## Integration

How Barba wires to the rest of the stack.

- **GSAP:** Barba transitions are usually GSAP tweens or timelines; return the tween or `await tl.play()`. For a staggered leave or enter, build a timeline. Route advanced GSAP patterns to `crew-animation-gsap`.
- **Locomotive Scroll:** when smooth scroll is also in play, update or destroy the Locomotive instance on transition (destroy in `beforeLeave`, re-create in `afterEnter`), and refresh any ScrollTrigger. Spec the smooth scroll itself in `crew-animation-locomotive`.
- **Plugins are separate packages.** `@barba/router`, `@barba/prefetch`, and `@barba/head` are each their own npm package, not part of `@barba/core`. Register the router and prefetch with `barba.use(barbaRouter)` and `barba.use(barbaPrefetch)` before `barba.init`, or they do nothing.
- **Router (`@barba/router`):** define named routes (with dynamic segments like `/products/:id`) so transitions can target a route name instead of a namespace.
- **Head and meta (`@barba/head`, or manual):** the head plugin updates the `<head>` tags automatically; or in the `after` hook, copy the new page's title and meta from `next.html` into the document. Without this, the title and meta go stale, which hurts SEO and link sharing.
- **Analytics and third-party scripts:** fire the analytics page view and re-init third-party widgets in the `after` hook, because the new container's scripts did not run on insert.

## Anti-patterns

```
Not returning the promise from leave or enter   -> return the tween, or use async/await; otherwise Barba swaps instantly and skips the animation.
No no-JS or crawler fallback                     -> links must work as normal navigation without JS; do not break SEO or accessibility for the effect.
Flash of the new page before enter               -> set the enter initial state in beforeEnter (or hide the container in CSS) so nothing shows early.
Not updating the document title and meta         -> update the head on navigation (@barba/head or the after hook), or the page reads as stale.
A sync transition with stacked containers        -> position both containers absolutely during a sync transition, or the layout jumps.
No scroll reset on enter                          -> window.scrollTo(0, 0) in beforeEnter, or the new page lands mid-scroll.
Animating layout properties in the transition     -> animate transform and opacity; layout properties cause reflow.
Not re-initing scripts or analytics after a swap  -> re-run the new page's scripts, sliders, lazy images, and the page view in afterEnter or after.
No focus management or route announcement         -> move focus to the new page and announce the route change for screen readers.
Hijacking external links                           -> let external links and anchors pass through; only intercept internal navigation.
Reaching for Barba in a React or Vue SPA          -> the framework router owns routing; use the framework's route transitions or crew-animation-motion.
```

## Application rules

The checklist a multi-page build embeds when it uses Barba.

```
[ ] Barba is justified: a multi-page site that wants SPA-like transitions, not a framework SPA that owns routing.
[ ] The DOM has a data-barba wrapper, a data-barba container on every page, and a namespace per page type.
[ ] Every transition returns its animation promise (or is async/await); a default fallback transition exists.
[ ] The enter initial state is set before it shows, and the container reserves height; nothing flashes or jumps.
[ ] Sync transitions position both containers absolutely; async transitions hand off sequentially.
[ ] beforeEnter resets scroll; afterEnter re-inits scripts, sliders, and lazy images; after updates the title and meta and analytics.
[ ] The site degrades without JS (links navigate normally); external links pass through.
[ ] Focus moves to the new page and the route change is announced for accessibility.
```

## Workflow

**Step 0: Context Recovery.** First, read `~/.claude/crew-state/brand-context.md`. If it exists, load it and state: "Working with [brand]. [Product]. [Audience]. Voice: [tone]." If `~/.claude/crew-state/brand-context.md` does not exist, STOP. Say: "Your business is not onboarded yet. I need to know who you are before I can work. Let us fix that now." Then run the eleven-question brand onboarding conversation inline (the same conversation `crew-core-brand-context` runs) and write the file before going further. This is a hard stop, not a suggestion: do not proceed to this skill's own discovery or workflow until `~/.claude/crew-state/brand-context.md` exists. If the brand context exists but this skill's handoff directory is empty, state: "Brand context found but no prior handoffs. First run in this location. If you expected prior work, check your crew-state path." Then read this skill's own handoff at `~/.claude/crew-state/animation/crew-animation-barba-handoff.md`. If it exists, load it and state what was recovered (for example, "Recovered: a prior spec, the DOM structure and the fade were set, the meta update still open"). If it does not exist, state "No prior context, first run." When a handoff was recovered, state its date; if it is older than the artifacts it references, treat it as possibly stale and verify against the live files before relying on it. In Governed mode, also scan the other handoffs in that folder so the transition language stays consistent. (Loop 4, Context Change.) If this run was chained from an upstream skill, also read only the handoffs of the skills this skill's Handoffs section names as sources, at most two files; state what was inherited, and record "Consumed: [upstream skill] handoff dated [date]" in this run's own handoff. If a named upstream handoff does not exist, proceed without comment. Never scan the folder outside Governed mode. Sub-skill consult: if the instruction opens with the literal preamble "CREW CONSULT from crew-<caller>: brand gate passed, brand-context at ~/.claude/crew-state/brand-context.md", skip this step's onboarding stop and the Final Step context-save prompt (still read the brand context and still write this skill's own handoff); absent that literal preamble, run the full Step 0 including the brand hard stop, even if the request mentions another skill (per the Crew Method, Sub-skill consult).

1. **Confirm Barba is the right tool.** State what is being built. If it is a React or Vue SPA whose router owns transitions, say so now, route it (the framework router or `crew-animation-motion`), and do not fight the framework's render. Only proceed for a multi-page site.
2. **Spec the DOM structure.** Define the `data-barba="wrapper"`, the `data-barba="container"` present on every page, the persistent elements outside the container, and the `data-barba-namespace` per page type.
3. **Spec the transitions.** Choose sync or async per transition, define the leave and enter animations (returning their promises), and write the conditional rules (`from`/`to` by namespace or route) with a default fallback last. Add a loader if the fetch can be slow.
4. **Spec the hooks and the views.** Set `beforeEnter` (the enter initial state and scroll reset), `afterEnter` (re-init scripts and lazy images), `after` (title, meta, analytics), and `beforeLeave` (teardown), plus the per-namespace views.
5. **Spec the integration and the accessibility and SEO fallback.** Wire GSAP, the router or head plugin, and any Locomotive instance, and spec the no-JS degradation, the focus move, the route announcement, and prefetch.
6. **Write the spec and run the anti-pattern check.** Assemble the Barba transition spec, and confirm none of the anti-patterns are present (a promise not returned, no fallback, a flash, no meta update, a sync layout shift, no scroll reset, no re-init, hijacked external links).
7. **Verify before emitting.** Confirm every transition returns its promise, a default fallback exists, the enter state prevents a flash, sync containers are positioned, the head and analytics update, the site degrades without JS, and focus moves. Mark a deliberate playbook choice kept, and Escalate anything the owner must decide (Loop 2 and Loop 3). Only then emit.

**Final Step: Handoff Save.** Run `mkdir -p ~/.claude/crew-state/animation`, then write `~/.claude/crew-state/animation/crew-animation-barba-handoff.md` with: the spec produced, decisions made (the DOM structure, the transitions, sync or async), unfinished work (transitions not yet specced, the accessibility or meta path if deferred, anything Escalated or kept by the playbook), what the building skill needs next (the spec to implement), and any "Learned" note (a transition preference or a constraint the user confirmed). Always write it, even with no output ("No output, run completed [date]"). Open the handoff with the frame: a `# <skill> handoff` title line, a `Date:` line (ISO, today), and a `STATUS:` line (NOT STARTED / IN PROGRESS / BLOCKED / READY FOR REVIEW / DONE / NO OUTPUT); then the required content as its own headed blocks, with LEARNED and ESCALATED blocks when present. When rewriting an existing handoff, carry forward every prior Learned note and any unresolved Escalated or Not-provided item; a rewrite must never erase a lesson or an open flag. (Loop 4 and Loop 5.) Then prompt: "Session context should be saved so the next session knows what we decided and what is left. Shall I run context-save now?" If the user says yes, invoke `crew-core-context-save`. If no, note in the handoff: "Context-save declined by user."

## Output format

```
BARBA TRANSITION SPEC
Brief: [what transitions and the feel]   Site: [multi-page]   GSAP: [yes / no]   Built: [date]   Mode: [Fast / Careful / Governed]

DOM structure:
[data-barba wrapper, the persistent elements, the data-barba container, the namespaces per page type]

Init (barba.init):
- Transitions: [each transition, sync or async, the leave and enter animation, the from/to rule, the default fallback]
- Views: [per-namespace beforeEnter / afterEnter / beforeLeave]

Hooks:
- beforeEnter: [enter initial state, scroll reset]
- afterEnter: [re-init scripts, sliders, lazy images]
- after: [title and meta update, analytics, third-party re-init]

Integration:
- [GSAP timelines, router or head plugin, any Locomotive instance update or destroy]

Accessibility and SEO fallback:
- [no-JS degrades to normal links; external links pass through; focus moves to the new page; route change announced]
```

Example (filled):
```
BARBA TRANSITION SPEC
Brief: an agency multi-page site, a fade between most pages, a slide crossfade between project-detail pages, a loader during fetch   Site: multi-page   GSAP: yes   Built: 2026-06-24   Mode: Careful

DOM structure:
body is the data-barba wrapper; the header, nav, and footer persist outside the container; each page's main is the data-barba container with a namespace (home, work, project, about, contact).

Init (barba.init):
- Transitions: a "fade" (async) as the base; a "project-slide" (sync, from and to namespace "project") that slides the old container out and the new one in with both positioned absolutely; a "default" fallback (async fade) last.
- Views: namespace "work" inits the project grid in afterEnter and tears it down in beforeLeave; namespace "project" inits the gallery.

Hooks:
- beforeEnter: gsap.set the container to opacity 0 (no flash); window.scrollTo(0, 0).
- afterEnter: re-init the grid, the gallery, and the lazy images on the new container.
- after: copy the title and meta from next.html into the document; fire the analytics page view.

Integration:
- GSAP tweens and a timeline for the slide; @barba/head for the meta; @barba/prefetch on hover.

Accessibility and SEO fallback:
- Without JS, the links navigate normally and the pages render fully (no broken SEO); external links pass through; focus moves to the new container's heading and the route change is announced.
```

## Decision briefs

When a transition call is genuinely contested (sync versus async, or whether Barba is even the right tool), produce a short brief before committing the spec.

```
Decision: [what is being decided, for example "an async fade or a sync crossfade for the page transition"]
At stake if wrong: [a transition that feels abrupt, or a sync overlap that causes a layout jump]
Recommendation: [option] because [reason]
A) [option A] (recommended): [2 reasons for, 1 against]
B) [option B]: [2 reasons for, 1 against]
Net: [one-line tradeoff]
```

Typical calls that warrant a brief: an async sequential transition versus a sync overlap, Barba on a multi-page site versus a framework router on a SPA, namespace-conditional rules versus a single default transition, and prefetch on hover versus off for a content-heavy site.

## Guardrails

- Never skip the no-JS and crawler fallback. The links must navigate normally without JavaScript; do not trade SEO or accessibility for the transition.
- Never forget to return the animation promise. A transition that does not return its promise swaps instantly and skips the animation.
- Never let the new page flash or jump. Set the enter state before it shows, reserve the container height, and position sync containers absolutely.
- Never leave the title and meta stale, or the scripts and analytics un-run, after a swap. Update the head and re-init in the hooks.
- Never hijack external links or break the back button. Intercept only internal navigation; history and external links pass through.
- Never reach for Barba in a framework SPA that owns its routing; name the framework route transition or `crew-animation-motion`.
- Never invent a transition the brief did not call for.
- No AI-slop in the spec: no "make it smooth", no filler, no emoji. Exact hooks, transitions, and fallbacks.
- Never use em dashes. Use commas, periods, or parentheses.
- If a project playbook exists (a transition system, a brand motion standard, an SEO policy), it is the authority. Follow it over these defaults.

## Handoffs

- Pair with `crew-animation-gsap`: Barba owns the page-transition lifecycle, GSAP owns the animation inside the leave and enter hooks. Spec the transition structure here, the timeline there.
- Pair with `crew-animation-locomotive`: when a multi-page site also has smooth scroll, destroy and re-create the Locomotive instance across the Barba transition; spec the smooth scroll there and the destroy or re-init timing here.
- Route a React or Vue single-page app to its framework router or to `crew-animation-motion` (AnimatePresence) for route transitions; Barba is for multi-page sites.
- Before a transition site ships, run `crew-core-quality-checker` and confirm the no-JS fallback, the meta update, and the accessibility floor. Pairs with the Crew Method standard "Verify before claiming done".
- For a full session save beyond the per-skill handoff, hand off to `crew-core-context-save`.

## Plan mode

In plan mode this skill can read the transition brief and the prior handoff, and produce a draft spec (whether Barba fits, the DOM structure, the transitions it would choose) marked "(DRAFT, plan mode)" at the top. It cannot write to `~/.claude/crew-state/`, sign off a spec as final, or edit the build. The full spec, the hooks, the integration, the accessibility fallback, and the handoff save run only after plan mode is exited.

## Verification

Before the run is marked done, confirm:

```
[ ] Barba was confirmed as the right tool (a multi-page site), not a framework SPA that owns routing
[ ] The DOM has a data-barba wrapper, a container on every page, and a namespace per page type
[ ] Every transition returns its animation promise; a default fallback transition exists
[ ] The enter initial state prevents a flash; the container reserves height; sync containers are positioned absolutely
[ ] beforeEnter resets scroll; afterEnter re-inits scripts and lazy images; after updates the title, meta, and analytics
[ ] Only transform and opacity animate in the transition; no layout properties
[ ] The site degrades without JS (links navigate normally); external links pass through
[ ] Focus moves to the new page and the route change is announced for accessibility
[ ] No AI-slop, no emoji, no em dashes in the spec
[ ] The handoff was written to ~/.claude/crew-state/animation/
```

## Completion

```
STATUS: DONE | DONE_WITH_CONCERNS | BLOCKED | NEEDS_CONTEXT
REASON: [why this status, specific]
RECOMMENDATION: [what should happen next]
```
