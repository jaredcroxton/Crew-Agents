# Locomotive Scroll spec (consulted via crew-animation)

Locomotive Scroll replaces native scroll with an inertia-lerped scroll that feels cinematic and premium, adding parallax by element speed, viewport detection, sticky elements, and a proxy that lets GSAP ScrollTrigger drive animation through the smoothed scroll position; this spec covers the container and data attributes, the init config, the parallax, the scroll events, the GSAP integration, the lifecycle, and the disable path. Smooth scroll is a trade, not a free win, so the spec always provides a reduced-motion and mobile fallback to native scroll and never traps the user.

## When to use Locomotive Scroll

Do not use this spec for a standard content or documentation site where native scroll is better (smooth scroll hijacks it for no gain), for a React-state or gesture animation (that is `crew-animation-motion`), for a scroll-scrubbed timeline that does not need smooth scroll (GSAP ScrollTrigger on native scroll is often the better and lighter choice), or when accessibility and scannability are paramount. Smooth scroll is the wrong call when the cost outweighs the cinematic gain; say so.

## What a spec needs

You need:

- The brief: what the smooth scroll is for (an immersive landing page, a narrative scroll site, a parallax hero), and the specific effects wanted (parallax, reveal-on-scroll, sticky, horizontal, GSAP-synced scrub).
- The context: the framework (vanilla or React), whether GSAP ScrollTrigger is also in play, and the content type (a marketing or story site, not a content or docs site).
- The accessibility and device constraints: that reduced-motion must fall back to native scroll (always), and what happens on mobile.

If the brief is too vague to spec, or it is unclear whether the cinematic feel is worth the trade-offs, ask once what is being built and whether smooth scroll is genuinely wanted. Never invent an effect the brief did not ask for, never spec smooth scroll for a content site where native scroll is better, and never omit the reduced-motion fallback.

## How the smooth-scroll animator thinks

1. **Smooth scroll is a trade, not a free win.** Locomotive replaces native scroll for a premium, cinematic feel, at the cost of native momentum, keyboard scroll, and accessibility. Use it when the feel is worth the cost, not by default.
2. **Enhance scroll, never trap it.** Even with smooth scroll the user controls the pace; never disable scrolling, never force a fixed step. A disable path is mandatory, not optional.
3. **Parallax is depth by speed.** `data-scroll-speed` moves an element slower (a background) or faster (a foreground) than the page. Small differences read as depth; large ones read as broken. Restraint and z-index discipline.
4. **Sections and limits keep it at 60fps.** `data-scroll-section` segments the page so only what is near the viewport recalculates; too many parallax elements thrash. Performance is a budget.
5. **The lifecycle is the bug surface.** Init once, update after DOM changes, destroy on route change. An un-destroyed instance leaks in a single-page app; a stale instance after dynamic content has the wrong positions.
6. **Disable on mobile and reduced-motion.** Smooth scroll feels wrong on touch and fails accessibility; gate it by device and by prefers-reduced-motion, with native scroll as the honest fallback.

## Locomotive core

The smooth-scroll container, the init, and the data attributes.

```html
<div data-scroll-container>
  <div data-scroll-section>          <!-- segments the page, improves performance -->
    <h1 data-scroll>Tracked element</h1>
    <div data-scroll data-scroll-speed="2">Parallax (faster than scroll)</div>
    <div data-scroll data-scroll-sticky data-scroll-target="#section">Sticky within a target</div>
    <div data-scroll data-scroll-id="hero">Tracked by id, progress readable in JS</div>
    <div data-scroll data-scroll-call="playVideo">Fires a named call on enter and exit</div>
  </div>
</div>
```

```javascript
import LocomotiveScroll from "locomotive-scroll";
import "locomotive-scroll/dist/locomotive-scroll.css";

const scroll = new LocomotiveScroll({
  el: document.querySelector("[data-scroll-container]"),
  smooth: true,
  lerp: 0.1,          // smoothness, 0 to 1, lower is smoother but laggier
  multiplier: 1,      // scroll speed multiplier
  class: "is-inview", // class added to a data-scroll element when it enters the viewport
  repeat: false,      // re-run the in-view detection each time
  direction: "vertical", // or "horizontal"
});
```

The data attributes: `data-scroll` (enable detection), `data-scroll-speed` (parallax speed), `data-scroll-direction` (parallax axis), `data-scroll-sticky` with `data-scroll-target` (sticky boundary), `data-scroll-offset` (trigger offset), `data-scroll-repeat`, `data-scroll-call` (named event), `data-scroll-id` (track by id), `data-scroll-class` (custom in-view class). Load via npm or the CDN (the script and its CSS).

## Parallax

Depth is created by moving elements at different speeds than the page.

```html
<div data-scroll data-scroll-speed="0.5">Slow, a background layer</div>
<div data-scroll data-scroll-speed="3">Fast, a foreground layer</div>
<div data-scroll data-scroll-speed="-2">Reverse direction</div>
<div data-scroll data-scroll-speed="2" data-scroll-direction="horizontal">Horizontal parallax</div>
```

Rules: keep the speed deltas modest (a background at `0.5`, a foreground at `1.5` to `3`); a large delta reads as a glitch, not depth. Give parallax layers explicit z-index so they do not fight as they move at different speeds. Limit the number of parallax elements; each one is recalculated on scroll, and too many drop frames.

```css
[data-scroll-speed] { position: relative; z-index: var(--layer-depth); }
```

## Scroll events

Locomotive emits scroll progress and named calls for syncing animation.

```javascript
scroll.on("scroll", (args) => {
  args.scroll.y;       // current scroll position
  args.speed;          // scroll speed
  args.direction;      // scroll direction
  if (args.currentElements["hero"]) {
    const progress = args.currentElements["hero"].progress; // 0 to 1 through the element
  }
});

scroll.on("call", (value, way, obj) => {
  // value is the data-scroll-call attribute, way is "enter" or "exit", obj is { id, el }
});
```

Viewport detection is automatic: a `data-scroll` element gains the in-view class (`is-inview` by default) when it enters the viewport, which is the reveal mechanism (animate from the class in CSS, or react to the `call` event). Track a specific element with `data-scroll-id` and read its `progress`. Pin an element with `data-scroll-sticky` and a `data-scroll-target` boundary. Scroll programmatically with `scroll.scrollTo(target, { offset, duration, easing, callback })`.

## Performance rules

- **Segment with `data-scroll-section`.** Wrap each major block so only the near-viewport sections recalculate. On a long page this is the single biggest performance lever.
- **Limit parallax elements.** Each `data-scroll-speed` element is recomputed on scroll; a handful is fine, dozens is not.
- **Disable smooth on mobile.** Set `smartphone: { smooth: false }` (and a tablet breakpoint as needed); smooth scroll feels wrong on touch and costs the most on the weakest devices.
- **Update after DOM changes and on resize.** Call `scroll.update()` after adding or removing content and on resize, or positions go stale and triggers misfire.
- **Destroy when gone.** Call `scroll.destroy()` on unmount or route change; an un-destroyed instance leaks.
- **Tune lerp deliberately.** A lower lerp is smoother but lags behind the input; match it to the feel, and do not chase a value so low the page feels disconnected from the wheel.

## Integration

The lifecycle and the wiring, including the GSAP ScrollTrigger proxy.

```javascript
// Lifecycle
scroll.init(); scroll.update(); scroll.destroy(); scroll.start(); scroll.stop();
```

**GSAP ScrollTrigger** drives animation through the smoothed scroll position via a scroller proxy:
```javascript
import { gsap } from "gsap";
import { ScrollTrigger } from "gsap/ScrollTrigger";
gsap.registerPlugin(ScrollTrigger);

const locoScroll = new LocomotiveScroll({ el: document.querySelector("[data-scroll-container]"), smooth: true });
locoScroll.on("scroll", ScrollTrigger.update);

ScrollTrigger.scrollerProxy("[data-scroll-container]", {
  scrollTop(value) {
    return arguments.length ? locoScroll.scrollTo(value, 0, 0) : locoScroll.scroll.instance.scroll.y;
  },
  getBoundingClientRect() { return { top: 0, left: 0, width: window.innerWidth, height: window.innerHeight }; },
  pinType: document.querySelector("[data-scroll-container]").style.transform ? "transform" : "fixed",
});

gsap.to(".fade-in", { opacity: 1, y: 0, scrollTrigger: { trigger: ".fade-in", scroller: "[data-scroll-container]", start: "top bottom", end: "top center", scrub: true } });

ScrollTrigger.addEventListener("refresh", () => locoScroll.update());
ScrollTrigger.refresh();
```
Every ScrollTrigger that runs through the smooth scroll needs `scroller: "[data-scroll-container]"`. In React, create the instance in a `useEffect` and return `() => scroll.destroy()` for cleanup. Fixed elements break inside the container; place a fixed nav outside the container, or use `data-scroll-sticky`.

## Anti-patterns

```
Smooth scroll with no disable option              -> always provide a reduced-motion and mobile fallback to native scroll.
No reduced-motion path                            -> matchMedia prefers-reduced-motion disables smooth; never hijack for those users.
position: fixed inside the container              -> place fixed elements outside the container, or use data-scroll-sticky.
No destroy on route change (SPA)                  -> always scroll.destroy() on unmount; otherwise the instance leaks.
No update after dynamic content                   -> call scroll.update() after the DOM changes, or positions go stale.
Too many data-scroll-speed elements               -> limit parallax; segment with data-scroll-section.
Smooth scroll on mobile                           -> smartphone { smooth: false }; it feels wrong on touch and costs the most.
A GSAP trigger without scroller: container        -> every ScrollTrigger over smooth scroll needs the scroller option and the proxy.
Parallax layers with no z-index                   -> set explicit z-index so layers at different speeds do not fight.
Smooth scroll on a content or docs site           -> use native scroll; the premium feel is not worth the accessibility cost there.
```

## Application rules

The checklist a build embeds when it uses Locomotive smooth scroll.

```
[ ] Smooth scroll is justified (an immersive or narrative site), not bolted onto a content or docs site.
[ ] A data-scroll-container wraps the page, with data-scroll-section segments for performance.
[ ] Parallax uses modest speed deltas and explicit z-index; the number of parallax elements is limited.
[ ] A reduced-motion path falls back to native scroll; smooth is disabled on mobile (smartphone smooth false).
[ ] The lifecycle is handled: init once, update after DOM changes and on resize, destroy on unmount or route change.
[ ] Fixed elements sit outside the container or use data-scroll-sticky; the user is never trapped.
[ ] Any GSAP ScrollTrigger uses the scrollerProxy and the scroller option, with refresh wired to update.
[ ] Native scroll behaviour (the user setting the pace) is preserved; nothing forces a step or blocks scrolling.
```

## Speccing workflow

1. **Confirm smooth scroll is the right call.** State what is being built. If it is a content or docs site, or accessibility and scannability are paramount, say so now, recommend native scroll (and `crew-design-engineering` for restrained motion polish), and do not hijack scroll for no gain. Only proceed when the cinematic feel is worth the trade.
2. **Spec the HTML structure.** Define the `data-scroll-container`, the `data-scroll-section` segments, and the `data-scroll` tracked elements with their attributes (id, call, sticky, target).
3. **Spec the init config.** Set `smooth`, `lerp`, `multiplier`, `direction`, the in-view class, and the mobile breakpoints (`smartphone: { smooth: false }`).
4. **Spec the parallax, the scroll events, and the sticky.** Name the parallax elements with their speeds and directions and z-index, the `on("scroll")` and `on("call")` handlers and what they drive, and any `data-scroll-sticky` with its target.
5. **Spec the GSAP integration, the lifecycle, and the disable path.** If GSAP ScrollTrigger is in play, spec the scrollerProxy, the scroller option, and the refresh wiring. Spec the lifecycle (update on resize and DOM change, destroy on unmount) and the reduced-motion fallback to native scroll.
6. **Write the spec and run the anti-pattern check.** Assemble the Locomotive animation spec, and confirm none of the anti-patterns are present (no disable path, fixed inside the container, no destroy, no update, smooth on mobile, a trigger without the scroller).
7. **Verify before emitting.** Confirm the container and sections are set, parallax is restrained and z-indexed, the reduced-motion and mobile fallbacks exist, the lifecycle is handled, any GSAP trigger uses the proxy, and native scroll is preserved. Only then emit.

## Worked example

The spec as the source skill returned it, the shape a consult answer should take.

```
LOCOMOTIVE ANIMATION SPEC
Brief: an immersive landing page, smooth inertia scroll, a parallax hero, reveal-on-scroll sections, a sticky chapter label, a GSAP-scrubbed reveal   Framework: vanilla   GSAP synced: yes   Built: 2026-06-24   Mode: Careful

HTML structure:
A data-scroll-container wraps the page; each block is a data-scroll-section. The hero background and foreground carry data-scroll-speed; sections carry data-scroll for the in-view reveal; the chapter label carries data-scroll-sticky with its section as the target.

Init config:
new LocomotiveScroll({ el, smooth: true, lerp: 0.08, direction: "vertical", class: "is-inview", smartphone: { smooth: false } }).

Parallax and scroll events:
- .hero-bg: data-scroll-speed 0.5, z-index 1 (slow background).   .hero-fg: data-scroll-speed 2, z-index 2 (fast foreground).
- on("scroll"): read currentElements["hero"].progress to drive a subtle hero opacity fade.
- Sticky: the chapter label sticks within its data-scroll-section via data-scroll-sticky.

GSAP integration (if synced):
- scrollerProxy on [data-scroll-container], every ScrollTrigger uses scroller: "[data-scroll-container]", locoScroll.on("scroll", ScrollTrigger.update), ScrollTrigger refresh wired to locoScroll.update().

Lifecycle and accessibility:
- scroll.update() on resize and after any dynamic content; scroll.destroy() on teardown.
- Reduced-motion: prefers-reduced-motion disables smooth and falls back to native scroll. Mobile: smartphone smooth false; parallax simplified.
```

## Guardrails

- Never ship smooth scroll without a disable path. A reduced-motion fallback to native scroll and a mobile disable are mandatory, not optional.
- Never trap the user. The user always controls the pace; never block scrolling or force a fixed step. Smooth scroll enhances scroll, it does not seize it.
- Never hijack scroll on a content or docs site where native scroll, keyboard navigation, and find-in-page matter more than the feel. Name the mismatch and recommend native scroll.
- Never leave the instance un-destroyed on a route change, or un-updated after dynamic content. The lifecycle is part of the spec.
- Never put a fixed element inside the container or a GSAP trigger over smooth scroll without the scroller proxy. Place fixed elements outside, or use data-scroll-sticky.
- Never invent an effect the brief did not call for.
- No AI-slop in the spec: no "make it premium", no filler, no emoji. Exact attributes, init values, and lifecycle calls.
- If a project playbook exists (a scroll-feel standard, a performance budget, an accessibility policy), it is the authority. Follow it over these defaults.

## Pairings and boundaries

- This is the spec the `crew-web-fly-through-builder` and a scroll-journey build read when they need native-feeling smooth scroll; the fly-through builder uses this exact scrollerProxy to drive its frame-sequence descent through smoothed scroll.
- Pair with `crew-animation-gsap`: Locomotive provides the smooth scroll surface, GSAP ScrollTrigger drives the animation over it through the proxy. Spec the smooth scroll here, the scroll-linked motion there.
- Pair with `crew-design-patterns` and `crew-design-engineering` on the honest question of whether to smooth-scroll at all; both warn that hijacking native scroll is a dated and risky move outside a genuinely immersive context.

## Verification

Before the run is marked done, confirm:

```
[ ] Smooth scroll was confirmed as the right call; a content or docs site was routed to native scroll
[ ] A data-scroll-container and data-scroll-section segments are specified
[ ] Parallax uses modest speed deltas and explicit z-index, and the count is limited
[ ] A reduced-motion fallback to native scroll exists, and smooth is disabled on mobile
[ ] The lifecycle is handled: init once, update on resize and DOM change, destroy on unmount
[ ] Fixed elements sit outside the container or use data-scroll-sticky; the user is never trapped
[ ] Any GSAP ScrollTrigger uses the scrollerProxy and the scroller option, with refresh wired to update
[ ] Native scroll behaviour is preserved; nothing forces a step or blocks scrolling
```
