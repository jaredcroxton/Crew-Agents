# Motion spec (consulted via crew-animation)

Motion (formerly Framer Motion) is the state-driven React animation library, animating a component to a target state when its props or state change; this spec covers the motion components, variants, gestures, layout and exit animations, spring physics, and reduced-motion handling a React builder implements. It is the React counterpart to `crew-animation-gsap`, which owns the imperative timeline and the heavy scroll choreography.

## When to use Motion

Do not use this spec for vanilla JS or a non-React project (use `crew-animation-gsap`), for a complex scroll-scrubbed pinned timeline (GSAP owns imperative scroll choreography), for a CSS-only micro-interaction that needs no library, or to choose the aesthetic (the style skills). This spec covers Motion in React; if the motion does not fit Motion, name the better tool.

## What a spec needs

You need:

- The motion brief: what should animate, why it moves (feedback, state change, reveal, transition), and on what trigger (mount, state change, gesture, scroll, unmount).
- The context: that the project is React (Motion is React-first), the components involved, and whether it is a gesture, a layout change, an exit, or a scroll reveal.
- The accessibility constraint: whether reduced-motion must be honoured (always), and what should happen on a press device.

If the brief is too vague to spec (no idea what animates or why), ask once what should animate, why, and on what trigger. Never invent a motion the brief does not call for, never animate a layout property where a transform achieves the effect, and never spec an exit without AnimatePresence.

## How the Motion animator thinks

1. **State-driven, not imperative.** Motion animates to a target state when props or state change; you describe the destination, not the steps. This is the React-native counterpart to GSAP's imperative timeline.
2. **State drives motion.** An animation is a function of component state. Change the state, Motion animates the difference. Variants name those states so the markup stays clean.
3. **Transform and opacity, always.** `x`, `y`, `scale`, `rotate`, `opacity` are hardware-accelerated; `top`, `left`, `width`, `height` trigger layout and jank. Same floor as every animation skill.
4. **Spring for anything physical.** Gestures, drags, layout shifts, anything that should feel alive uses spring physics (stiffness, damping, mass), not a linear duration. Reserve duration tweens for a simple fade.
5. **AnimatePresence owns exits, keys own identity.** A component leaving the tree only animates inside AnimatePresence with a stable `key`. Forget either and the exit silently does nothing.
6. **Respect reduced-motion.** `useReducedMotion` gates or zeroes motion. A state-driven API does not excuse ignoring the accessibility floor.

## Motion core

The library: motion components, the animation props, transitions, and variants.

```jsx
import { motion } from "framer-motion"

// Any element becomes animatable by prefixing motion.
<motion.div
  initial={{ opacity: 0, y: 50 }}   // state before animation (initial={false} disables mount animation)
  animate={{ opacity: 1, y: 0 }}    // target state; Motion animates here when props or state change
  exit={{ opacity: 0, y: -10 }}     // state on removal (needs AnimatePresence)
  transition={{ type: "spring", stiffness: 300, damping: 24 }}
/>
```

**Transition types:** `tween` (duration-based with easing, the default), `spring` (physics-based), `inertia` (decelerating, used in drag). Per-property transitions are allowed: `transition={{ x: { type: "spring" }, opacity: { duration: 0.2 } }}`.

**Variants** name states once and propagate to children:
```jsx
const container = { hidden: { opacity: 0 }, visible: { opacity: 1, transition: { staggerChildren: 0.1 } } };
const item = { hidden: { y: 20, opacity: 0 }, visible: { y: 0, opacity: 1 } };

<motion.ul variants={container} initial="hidden" animate="visible">
  <motion.li variants={item} />
  <motion.li variants={item} />
</motion.ul>
```
Orchestrate child timing with `staggerChildren`, `when: "beforeChildren"` or `"afterChildren"`, and `staggerDirection: -1` to reverse. For an imperative escape hatch, `useAnimate` returns `[scope, animate]` to run sequenced animations on refs with `stagger()` and controls (`play`, `pause`, `stop`, `speed`, `time`).

## Layout animations

Motion animates layout changes (position and size) automatically with the `layout` prop, using a FLIP technique so the change is smooth without manual measuring.

```jsx
<motion.div layout />            // animate position and size changes
<motion.div layout="position" /> // only position (cheaper)
<motion.div layout="size" />     // only size
<motion.div layout transition={{ layout: { duration: 0.3, ease: "easeOut" } }} />
```

**Shared element transitions** connect two elements across the tree with a matching `layoutId`, so one morphs into the other (a tab underline sliding between tabs, a thumbnail expanding into a modal):
```jsx
{activeTab === tab.id && <motion.div layoutId="underline" style={{ position: "absolute", bottom: 0, height: 2 }} />}
```

**Exit animations** require `AnimatePresence`, a stable `key`, and an `exit` prop:
```jsx
import { AnimatePresence } from "framer-motion"
<AnimatePresence>
  {items.map(item => (
    <motion.li key={item.id} layout
      initial={{ opacity: 0, x: -50 }} animate={{ opacity: 1, x: 0 }} exit={{ opacity: 0, x: 50 }} />
  ))}
</AnimatePresence>
```
Combine `layout` with exit so the remaining items reflow smoothly when one leaves. Stagger an exit with `when: "afterChildren"` and `staggerDirection: -1`. Use `layoutId` sparingly; it tracks elements globally.

## Gestures

Motion provides state-driven gesture states that animate while the gesture is active and revert when it ends.

```jsx
<motion.button
  whileHover={{ scale: 1.05 }}          // pointer over the element
  whileTap={{ scale: 0.97 }}            // primary pointer pressing (the soft press)
  whileFocus={{ outline: "2px solid" }} // keyboard focus
  whileDrag={{ scale: 1.1 }}            // while being dragged
/>
```

**Gesture-specific transitions.** A `transition` inside the gesture object applies to the gesture start; the component-level `transition` applies to the return. Putting the duration only at the component level and expecting it to govern `whileHover` is the common mistake.
```jsx
<motion.div whileHover={{ scale: 1.2, transition: { duration: 0.2 } }} transition={{ duration: 0.5 }} />
```

**Drag** with constraints and elasticity:
```jsx
<motion.div drag="x" dragConstraints={{ left: -100, right: 100 }} dragElastic={0.1}
  dragTransition={{ bounceStiffness: 600, bounceDamping: 20 }}
  onDragEnd={(e, info) => /* info.velocity, info.offset, info.point */ {}} />
```
Constraints can be an object or a ref to a container. Gesture events (`onHoverStart`, `onTap`, `onDragStart`, `onDrag`, `onDragEnd`, `onViewportEnter`) carry an info object with `point`, `offset`, and `velocity`.

## Scroll-linked

`whileInView` animates an element when it enters the viewport, the state-driven reveal-on-scroll:
```jsx
<motion.div initial={{ opacity: 0, y: 50 }} whileInView={{ opacity: 1, y: 0 }}
  viewport={{ once: true, amount: 0.5, margin: "-100px" }} transition={{ duration: 0.5 }} />
```
`viewport` options: `once` (fire a single time), `amount` (fraction visible, or `"some"` / `"all"`), `margin` (offset the boundary). Stagger a scroll reveal by driving variants from `whileInView="visible"` on the container.

For a boolean, `useInView(ref, { once: true, amount: 0.5 })` reports whether an element is in view. For motion values driven by scroll progress, `useScroll` plus `useTransform` map scroll position to a value (for example a progress bar or a subtle parallax). For heavy scroll-scrubbed or pinned timeline choreography, GSAP ScrollTrigger is the better tool; route to `crew-animation-gsap`.

## Spring physics

Spring is the default for anything that should feel physical (gestures, drags, layout, anything alive).

```jsx
transition={{ type: "spring", stiffness: 300, damping: 24, mass: 1 }}
// stiffness: higher is snappier (default 100). damping: higher is less bouncy (default 10). mass: higher is more inertia.

transition={{ type: "spring", visualDuration: 0.5, bounce: 0.2 }}
// visualDuration and bounce are the easier-to-reason-about controls. Keep bounce subtle (0.1 to 0.3).
```

Presets to start from: gentle `stiffness: 100, damping: 20`, wobbly `stiffness: 200, damping: 10`, stiff `stiffness: 400, damping: 30`, slow `stiffness: 50, damping: 20`. For a spring-animated motion value driven imperatively, `useSpring(0, { stiffness: 300, damping: 24 })` interpolates a value with spring behaviour when you call `.set()`. Avoid heavy bounce in professional UI; reserve it for playful, drag-to-dismiss moments.

## Performance rules

- **Transform and opacity only.** `x`, `y`, `scale`, `rotate`, `opacity` are hardware-accelerated. Good: `animate={{ x: 50, scale: 1.2 }}`. Avoid: `animate={{ left: 50, width: 200 }}`, which triggers layout and paint.
- **Individual transform props.** Set `style={{ x, rotate, scale }}` rather than a transform string; it is cleaner and Motion optimises it.
- **Reduced-motion is mandatory.** `useReducedMotion()` returns a boolean; zero the duration or drop the movement when it is true, keeping only opacity where it aids comprehension.
- **Layout animations are not free.** Prefer `layout="position"` over full `layout` when only position changes, and tune the `layout` transition. Many layout-animated elements at the same time get expensive; use a cheaper opacity animation where layout is not needed.
- **layoutId tracks globally.** A shared-element transition is powerful but tracks across the whole tree; use it only where two elements genuinely morph.
- **60fps under load.** Test while the page is also loading or scripting; transform and opacity stay smooth, layout properties stutter.

## Anti-patterns

```
An exit prop with no AnimatePresence wrapper     -> wrap the conditional element in AnimatePresence; otherwise exit silently does nothing.
A list inside AnimatePresence with no key        -> give every item a stable, unique key so presence can track identity.
Animating top, left, width, height, margin       -> animate x, y, scale, opacity; they skip layout.
layout on every item in a long list              -> use layout only where reflow matters; animate opacity for the rest.
Expecting the component transition to govern hover-> put the gesture transition inside the whileHover object; the outer transition governs the return.
A magic-number duration on everything            -> spring for physical motion, a short duration only for a simple fade.
No useReducedMotion path                          -> gate or zero motion under prefers-reduced-motion; it is an accessibility floor.
layoutId on many unrelated elements              -> reserve shared-element transitions for genuine morphs; it tracks globally.
Reaching for Motion in vanilla JS or for a scrubbed scroll timeline -> Motion is React-first; route imperative scroll choreography to crew-animation-gsap.
```

## Application rules

The checklist a React build embeds when its animation section says to use Motion.

```
[ ] Only transform and opacity animate; no top, left, width, height, or margin.
[ ] State-based motion uses animate plus variants; repeated states are named variants, not duplicated props.
[ ] Spring physics for gestures, drags, and layout shifts; a short duration tween only for a simple fade.
[ ] Every exit is wrapped in AnimatePresence with a stable key and an exit prop.
[ ] Gesture transitions live inside the whileHover or whileTap object; the outer transition governs the return.
[ ] layout and layoutId are used sparingly; layout="position" where only position changes.
[ ] useReducedMotion provides a reduced-motion path; nothing animates movement when it is true.
[ ] Motion is the right tool (React, state or gesture or layout); vanilla or scrubbed-scroll work routes to crew-animation-gsap.
```

## Speccing workflow

1. **Read the motion brief.** Name what should animate, why it moves, and on what trigger (mount, state change, gesture, scroll, unmount). If the brief is vague, ask now. If the project is vanilla or the motion is a scrubbed scroll timeline, route to `crew-animation-gsap`. If a CSS hover or press would do, say so.
2. **Choose the construct.** Decide the Motion construct: an `animate` prop for a state change, variants for orchestrated or repeated states, a `whileHover` / `whileTap` / `drag` gesture, `layout` plus `AnimatePresence` for a layout or exit animation, or `whileInView` for a scroll reveal.
3. **Spec the core motion.** Name the motion components, the props (`initial`, `animate`, `exit`, transform and opacity only), the transition (spring for physical, a short tween for a fade), and the variants with their propagation if orchestrated.
4. **Spec the gestures and the layout or exit.** Define `whileHover` / `whileTap` / `whileFocus` / `whileDrag` with their gesture-specific transitions, and the `layout`, `layoutId`, and `AnimatePresence` with stable keys for any layout change or exit.
5. **Spec the spring config, the reduced-motion path, and the performance.** Set the spring stiffness, damping, and mass (or visualDuration and bounce), the `useReducedMotion` path, and confirm layout and layoutId are used sparingly.
6. **Write the spec and run the anti-pattern check.** Assemble the Motion animation spec, and confirm none of the anti-patterns are present (layout properties, exit without AnimatePresence, missing keys, gesture-transition timing, no reduced-motion path).
7. **Verify before emitting.** Confirm only transform and opacity animate, exits are wrapped in AnimatePresence with keys, gesture transitions are placed correctly, spring is used for physical motion, and the reduced-motion path exists. Only then emit.

## Worked example

The spec as the source skill returned it, the shape a consult answer should take.

```
MOTION ANIMATION SPEC
Brief: a React card grid, cards reveal on scroll with a stagger, lift on hover, press on tap, reflow on remove, plus a sliding tab underline   Trigger: scroll, gesture, unmount   Framework: React + Motion   Built: 2026-06-24   Mode: Careful

Setup:
import { motion, AnimatePresence } from "framer-motion"; useReducedMotion for the accessibility path.

Components and motion:
- Grid (motion.ul): variants container, whileInView="visible", viewport { once: true, amount: 0.3 }, staggerChildren 0.08.
- Card (motion.li): variants item { hidden: { y: 24, opacity: 0 }, visible: { y: 0, opacity: 1 } }, layout, key={id}, exit { opacity: 0, scale: 0.95 }.

Gestures / layout / exit (if any):
- Card whileHover { y: -6 } and whileTap { scale: 0.97 }, each with a spring gesture transition.
- Remove and reflow: cards inside AnimatePresence with a stable key, layout on each so the others reflow smoothly on exit.
- Tab underline: a motion.div with layoutId="underline" rendered under the active tab, so it slides between tabs.

Spring config:
- Cards and hover: type spring, stiffness 300, damping 24. Underline: a slightly softer spring (stiffness 250, damping 30).

Accessibility:
- Reduced-motion: useReducedMotion zeroes the y translate and the hover lift, keeping only the opacity reveal; the underline snaps without the slide.
```

## Guardrails

- Never animate a layout property (top, left, width, height, margin) when a transform achieves the effect. Transform and opacity are the floor.
- Never write an exit animation without AnimatePresence and a stable key. Without both, the exit silently does nothing.
- Never ship without a reduced-motion path. useReducedMotion honouring prefers-reduced-motion is mandatory.
- Never reach for Motion in a vanilla project or for a scrubbed scroll timeline. Motion is React-first; route imperative scroll choreography to `crew-animation-gsap`.
- Never reach for a library when a CSS hover or press would do; name the simpler tool when it fits.
- Never invent a motion the brief did not call for.
- No AI-slop in the spec: no "make it pop", no filler, no emoji. Exact props, transitions, and spring values.
- If a project playbook exists (a motion system, approved springs and durations, a performance budget), it is the authority. Follow it over these defaults.

## Pairings and boundaries

- This is the spec React build skills read when their animation section calls for Motion: `crew-web-lead-dashboard-builder` and any React UI build. Hand them the Motion animation spec to implement.
- Pair with `crew-animation-gsap` as the imperative counterpart: Motion owns React state, gesture, and layout animation in its state-driven style; GSAP owns the imperative timeline and the scrubbed, pinned scroll choreography. Use Motion for component interactions, GSAP for scroll-driven storytelling, and both together when a React app needs each.
- Pair with `crew-design-engineering` for the pixel-level craft of a single interaction (the exact spring feel, the press scale, the focus ring); this skill owns the Motion API and orchestration, that one owns the taste of the motion.

## Verification

Before the run is marked done, confirm:

```
[ ] The motion brief was clear (what animates, why, on what trigger); a vanilla or scrubbed-scroll job was routed to crew-animation-gsap
[ ] The construct fits: animate or variants for state, a gesture prop for interaction, layout plus AnimatePresence for layout or exit, whileInView for a reveal
[ ] Only transform and opacity animate; no layout properties
[ ] Every exit is wrapped in AnimatePresence with a stable key and an exit prop
[ ] Gesture transitions are inside the gesture object; the outer transition governs the return
[ ] Spring physics drive the physical motion; a short tween is reserved for a simple fade
[ ] layout and layoutId are used sparingly; layout="position" where only position changes
[ ] A reduced-motion path exists through useReducedMotion
```
