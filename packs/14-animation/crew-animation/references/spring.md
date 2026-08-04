# React Spring spec (consulted via crew-animation)

React Spring is the spring-physics animation engine for React: instead of running a fixed curve for a fixed time, it animates a value from its current state toward a target using mass, tension, and friction, so there is no duration, the motion settles naturally, stays interruptible, and carries its velocity, which is why it pairs so well with gestures. This spec covers the hook and its config form, the spring tuning, the interpolations, the gesture wiring and the velocity handoff, the trail and transition hooks, the performance, and the reduced-motion path.

## When to use React Spring

Do not use this spec for a precise, timeline-choreographed sequence where the marks must hit at exact times (that is `crew-animation-gsap`), for state-driven variants, layout, or exit animation where React idiom matters more than physics accuracy (`crew-animation-motion` is often simpler), for a non-React project, or for a fixed-timeline designer asset (`crew-animation-lottie`). React Spring is for physics-accurate, gesture-driven, velocity-preserving React motion; name the better tool when the work is exact-timed or purely state-driven.

## What a spec needs

You need:

- The motion brief: what should animate, why it moves (a reveal, a gesture, an interruptible interaction), and on what trigger (mount, state change, drag, scroll, in-view).
- The context: that the project is React (React Spring is React-first), the elements involved, and whether the motion is gesture-driven, a list transition, or a simple state spring.
- The accessibility constraint: that reduced-motion must be honoured (always), and what the reduced or instant state should be.

If the brief is too vague to spec, ask once what should animate, why, and on what trigger. Never invent a motion the brief did not call for, never animate a transform string a spring cannot interpolate, and never reach for a spring when the timing must be exact.

## How the spring animator thinks

1. **The spring is the model, not a curve.** React Spring animates from the current value to a target by simulating physics (mass, tension, friction), so there is no duration; the motion settles. You tune the feel with three numbers, not a curve and a time.
2. **Interruptible and velocity-preserving.** A spring can be retargeted mid-motion and carry its current velocity into the new target, so a gesture that changes direction stays smooth. This is what a duration-and-easing animation cannot do.
3. **Animate values, then compose.** Springs interpolate numbers, not a transform string. Animate `x`, `scale`, `rotation` as values and combine them in `style` with `.to()`; a string target does not interpolate.
4. **Object config is state-driven, function config is imperative.** The object form auto-updates when props change; the function form returns an `api` for `api.start()` and needs a deps array (an empty `[]`) so it is not recreated each render.
5. **Physics where it pays, a duration where it does not.** Springs shine for natural, gesture-driven, interruptible motion. For a precise timed sequence or a one-shot fade, a duration is simpler and a spring is overkill; know when the physics earns its place.
6. **Native, precise, and accessible.** Render on demand, keep the precision suited to the value range (the default 0.01 suits most), batch with `useSprings`, and honour reduced-motion with `Globals.skipAnimation`.

## Spring core

The hook, the animated component, the config, and interpolation.

```jsx
import { useSpring, animated, config } from "@react-spring/web";

// Object config: state-driven, auto-updates when props change
const styles = useSpring({ from: { opacity: 0, y: -40 }, to: { opacity: 1, y: 0 }, config: config.gentle });
<animated.div style={styles}>Hello</animated.div>

// Function config: imperative, returns [styles, api]; the [] deps array prevents recreation each render
const [styles, api] = useSpring(() => ({ x: 0, config: { mass: 1, tension: 300, friction: 30 } }), []);
api.start({ x: 100 }); // retarget at any time
```

- **Config:** `mass` (weight, more is heavier and slower), `tension` (spring strength, more is faster and snappier), `friction` (the opposing force, more is less bouncy). Presets: `config.default` (170 / 26), `gentle` (120 / 14), `wobbly` (180 / 12), `stiff` (210 / 20), `slow` (280 / 60), `molasses` (280 / 120).
- **Interpolation:** springs hold values; map them to CSS with `.to()`. `transform: styles.x.to(x => \`translateX(${x}px)\`)`, or animate `x`, `scale`, `rotation` as named values and compose them.
- **Velocity:** read the live velocity with `styles.x.getVelocity()` to carry momentum into the next target. `config.velocity` is a per-animated-key initial velocity in units per millisecond: pass a scalar for a single key, or an array aligned to the keys for a multi-axis spring (do not feed a 2D gesture velocity to a single-axis spring).

## Gesture-driven springs

The natural pairing is `@use-gesture/react`, which reports pointer movement and velocity that you feed into the spring, so a drag hands its momentum to the physics.

```jsx
import { useSpring, animated } from "@react-spring/web";
import { useDrag } from "@use-gesture/react";

const [{ x }, api] = useSpring(() => ({ x: 0 }), []);
const bind = useDrag(({ down, movement: [mx], velocity: [vx], direction: [dx] }) => {
  api.start({
    x: down ? mx : 0,                 // follow the pointer while down, spring back on release
    immediate: down,                   // no spring while dragging; track the finger directly
    config: down ? undefined : { velocity: vx * dx, tension: 300, friction: 30 }, // hand the gesture velocity to the spring
  });
});
<animated.div {...bind()} style={{ x }} />;
```

The handoff is the point: while the gesture is active, drive the value directly (`immediate: down`); on release, start a spring seeded with the gesture's velocity so the motion continues naturally instead of snapping. `useWheel`, `usePinch`, and the combined `useGesture` follow the same shape (read movement and velocity, feed the spring). For momentum that decays to a snap point, the spring's own velocity is usually enough; a low-level inertia helper (popmotion, the older low-level engine behind Motion, now effectively legacy) is an optional advanced path, not the default.

## Advanced

```jsx
// useTrail: N elements follow each other with a physics stagger
const trail = useTrail(items.length, { from: { opacity: 0, x: -20 }, to: { opacity: 1, x: 0 }, config: config.gentle });

// useTransition: enter, leave, and update for items added to or removed from a list (give keys)
const transitions = useTransition(items, { from: { opacity: 0, height: 0 }, enter: { opacity: 1, height: 80 }, leave: { opacity: 0, height: 0 }, keys: (i) => i.id });

// useSprings: a batch of independent springs for many elements
const springs = useSprings(items.length, items.map(() => ({ from: { opacity: 0 }, to: { opacity: 1 } })));

// useChain: sequence multiple springs or transitions by their refs and timesteps
useChain([trailRef, transitionRef], [0, 0.4]);

// useScroll / useInView: scroll-linked and reveal-on-view
const { scrollYProgress } = useScroll();
// opacity: scrollYProgress.to([0, 0.5], [0, 1]) ... a parallax layer maps the same progress to a different range
```

`useTrail` cascades a single config across elements; `useTransition` is the spring answer to mounting and unmounting list items (it keeps the leaving item until its leave spring settles); `useSprings` batches many independent values; `useChain` orders several hooks in time. Chained async steps (`to: [a, b, c]`) and `loop: true` run a sequence on one spring.

## Spring vs easing

The boundary, because a spring and a timed curve solve different problems.

- **A spring (physics) wins when:** the motion must be interruptible, must preserve velocity (a gesture), should feel natural and organic, or responds to live user input. The spring carries momentum a duration cannot, and a retarget mid-flight stays smooth.
- **A duration-and-easing wins when:** the timing must be exact (a choreographed sequence, a reveal synced to audio or video), the motion is a simple one-shot (a fade), or you need it to end at a precise time. A spring's settle time is emergent, not exact, so it cannot hit a mark on a clock.
- **The test:** does the motion need to feel alive and respond to input, or hit a precise mark at a precise time. React Spring for the former, a duration timeline (`crew-animation-gsap`) for the latter. Motion also offers springs, so for largely state-driven React work with the occasional spring, Motion may be simpler; React Spring is the choice when physics and gesture are the core of the interaction.

## Performance

- **On-demand, native rendering.** With `animated.*` components, the spring updates the DOM directly without a React re-render on every frame. Keep values in the spring and interpolate; do not push every frame through React state.
- **Understand precision.** Precision is the threshold, in the units of the animated value, at which the spring is considered at rest. The default is already `0.01`, fine for most ranges. Raise it (for example `0.1`) to settle sooner on a large value range, or lower it (for example `0.0001`) to avoid a visible snap on a very small range.
- **Batch with useSprings.** Many similar springs belong in one `useSprings` call, not a loop of `useSpring`.
- **Transform and opacity.** Animate `x`, `y`, `scale`, `rotation`, `opacity`; they run on the compositor. Avoid `left`, `top`, `width`, `height`.
- **Reduced-motion.** Gate motion under `prefers-reduced-motion` by setting `Globals.assign({ skipAnimation: true })` (restore it on cleanup), so animations resolve instantly to their target.
- **A deps array on the function form.** An empty `[]` (or the real deps) prevents the spring from being recreated every render.

## Anti-patterns

```
A function-config useSpring with no deps array        -> pass [] (or the real deps); without it the spring is recreated every render.
Mutating springs.x.set(100) to animate                 -> use api.start({ x: 100 }); set bypasses the physics and jumps.
Treating precision as a settle fix without the facts   -> the default precision is already 0.01; raise it (0.1) to settle sooner on a large range, lower it to avoid a snap on a small one.
No velocity on an interrupt                             -> pass the current velocity (getVelocity or the gesture velocity) so it does not snap.
Mixing config patterns (object config, then api.start) -> object config has no api; use the function form for imperative control.
Animating a transform string                           -> springs interpolate numbers; animate x, scale, rotation as values and compose with .to().
Animating left, top, width, height                     -> animate transform and opacity; they skip layout.
No reduced-motion path                                 -> Globals.assign({ skipAnimation: true }) under prefers-reduced-motion.
Reaching for a spring when the timing must be exact     -> a precise, synced sequence belongs in a duration timeline (crew-animation-gsap).
```

## Application rules

The checklist a React build embeds when it uses React Spring.

```
[ ] React Spring is justified: physics-accurate, gesture-driven, or interruptible motion, not exact-timed or purely state-driven.
[ ] Values are animated and composed with .to(); no transform string is passed to a spring.
[ ] The function form carries a deps array; imperative control uses api.start(), never .set().
[ ] Gestures feed the spring directly while active (immediate) and hand their velocity to the spring on release.
[ ] Interrupts preserve velocity (getVelocity or the gesture velocity), so retargeting stays smooth.
[ ] Multi-element motion uses useTrail, useTransition (with keys), useSprings, or useChain, not a loop of useSpring.
[ ] Only transform and opacity animate; precision is set so the spring stops near the target; many springs are batched.
[ ] Reduced-motion sets Globals.skipAnimation so motion resolves instantly.
```

## Speccing workflow

1. **Read the motion brief.** Name what should animate, why it moves, and on what trigger. If the timing must be exact and synced, route to `crew-animation-gsap`; if the work is state-driven variants, layout, or exit animation, route to `crew-animation-motion`; if it is not React, name the right tool. Only proceed when physics or gesture is the core.
2. **Choose the construct.** Decide the hook: `useSpring` (object config for state-driven updates, function config plus api for imperative), `useTrail` or `useTransition` or `useSprings` for multiple elements, `useChain` for a sequence, `useScroll` or `useInView` for scroll and reveal, and `@use-gesture/react` for a gesture.
3. **Spec the spring config.** Choose a preset or tune mass, tension, and friction for the feel (gentle, wobbly, stiff), and set the precision. Name the values to animate.
4. **Spec the interpolation, the gesture wiring, and the velocity handoff.** Map the spring values to CSS with `.to()`, wire the gesture to drive the value directly while active and to spring back with the gesture velocity on release, and preserve velocity on any interrupt.
5. **Spec the performance and the reduced-motion path.** Name the on-demand rendering, the precision, the batching with `useSprings`, the transform-and-opacity rule, the deps array, and the `Globals.skipAnimation` reduced-motion path.
6. **Write the spec and run the anti-pattern check.** Assemble the Spring animation spec, and confirm none of the anti-patterns are present (no deps array, `.set` instead of `api.start`, a transform string, no velocity on interrupt, no reduced-motion).
7. **Verify before emitting.** Confirm React Spring is justified, values are animated and composed, the function form has a deps array, gestures hand off velocity, multi-element motion uses the right hook, only transform and opacity animate, and the reduced-motion path exists. Only then emit.

## Worked example

The spec as the source skill returned it, the shape a consult answer should take.

```
SPRING ANIMATION SPEC
Brief: a draggable card that follows the pointer and springs back with momentum on release, plus a staggered list reveal   Trigger: gesture and mount   Framework: React   Built: 2026-06-24   Mode: Careful

Hook and config:
- The card: useSpring(() => ({ x: 0, y: 0 }), []) with [styles, api]. The list: useTrail(items.length, ...).
- Spring config: card { tension: 300, friction: 30 }; trail config.gentle. precision 0.01.

Values and interpolation:
- Animate x and y as values; style={{ x, y }} (composed, no transform string). The trail animates opacity and x per item.

Gesture and velocity (if any):
- useDrag from @use-gesture/react: while down, api.start({ x: mx, y: my, immediate: true }) to follow the pointer; on release, api.start({ x: 0, y: 0, config: { velocity: [vx*dx, vy*dy], tension: 300, friction: 30 } }) so the card springs home carrying its momentum.

Performance and accessibility:
- animated.div for on-demand rendering; precision 0.01; the trail batches via useTrail; only x, y, opacity animate; the spring has its [] deps array.
- Reduced-motion: under prefers-reduced-motion, Globals.assign({ skipAnimation: true }) so the card and the list resolve instantly to their targets; restored on unmount.
```

## Guardrails

- Never reach for a spring when the timing must be exact. A precise, synced sequence belongs in a duration timeline (`crew-animation-gsap`); a spring's settle time is emergent, not exact.
- Never pass a transform string to a spring. Springs interpolate numbers; animate `x`, `scale`, `rotation` as values and compose them with `.to()`.
- Never mutate with `.set()` to animate, and never omit the deps array on the function form. Use `api.start()`, and pass `[]` so the spring is not recreated each render.
- Never drop velocity on an interrupt or a gesture release. Pass the current or gesture velocity so the motion does not snap.
- Never ship without a reduced-motion path. `Globals.skipAnimation` under prefers-reduced-motion is mandatory.
- Never animate a layout property where a transform achieves the effect, and never invent a motion the brief did not call for.
- No AI-slop in the spec: no "make it pop", no filler, no emoji. Exact hooks, config values, and interpolations.
- If a project playbook exists (a motion system, approved spring configs, a performance budget), it is the authority. Follow it over these defaults.

## Pairings and boundaries

- Pair with `crew-animation-motion` on the React boundary: both do springs, but React Spring leads when physics accuracy and gesture handoff are the core of the interaction, and Motion leads for state-driven variants, layout, and exit animation. Pick by where the weight of the work sits.
- Route a precise, timeline-choreographed or scroll-scrubbed sequence to `crew-animation-gsap`, which hits exact marks; a spring cannot.
- Pair with `crew-design-engineering` for the pixel-level craft of a single interaction (the exact spring feel, the press); this spec owns the React Spring API and the physics.
- For a 3D scene, `@react-spring/three` applies the same hooks to a Three.js object; spec the 3D scene separately and the spring here.

## Verification

Before the run is marked done, confirm:

```
[ ] React Spring was confirmed as the right tool (physics, gesture, interruptible), not exact-timed (GSAP) or purely state-driven (Motion)
[ ] Values are animated and composed with .to(); no transform string is passed to a spring
[ ] The function form carries a deps array; imperative control uses api.start(), never .set()
[ ] Gestures drive the value while active and hand their velocity to the spring on release; interrupts preserve velocity
[ ] Multi-element motion uses useTrail, useTransition (with keys), useSprings, or useChain
[ ] Only transform and opacity animate; precision is set; many springs are batched
[ ] A reduced-motion path sets Globals.skipAnimation
```
