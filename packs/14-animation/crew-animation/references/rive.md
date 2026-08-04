# Rive spec (consulted via crew-animation)

Rive is the state-machine animation engine: a designer-authored vector asset that, unlike a fixed-timeline asset, carries states, inputs that drive transitions, ViewModels that bind live application data both ways, and events that flow back to code. This spec covers the asset and its state machine, the named inputs (the design-dev contract), the runtime and implementation, the interactivity wiring, the ViewModel binding and the events, the performance, and the cleanup and reduced-motion path.

## When to use Rive

Do not use this spec for a fixed-timeline playback animation (a logo reveal, a loader, a marketing accent with no states or input, that is `crew-animation-lottie`, which is lighter for one-way playback), for code-authored UI motion (a transition or a sequence belongs in `crew-animation-motion`, `crew-animation-gsap`, or `crew-animation-anime`), for a scroll-scrubbed timeline (GSAP), or when there is no .riv asset. Rive is for stateful, interactive, or data-bound designer animations; if the animation just plays, name Lottie instead.

## What a spec needs

You need:

- The asset: the Rive (.riv) file (or a clear description of the interactive animation), and the names from the editor: the state machine, its inputs (boolean, number, trigger), any ViewModel properties, and any events.
- The context: what the animation is for (an interactive control, a data-bound visualisation, a game-like UI), the framework (Web, React, React Native, iOS, Android, Flutter), and the inputs that should drive it (hover, press, drag, a data value, scroll).
- The accessibility constraint: that reduced-motion must be honoured (always), and what the static or reduced state should be for a control that conveys meaning.

If there is no .riv asset and no description of the state machine and its inputs, ask once for the file or what the interactive animation should do and which inputs drive it. Rive wires a designer-authored state machine; it cannot author one. Never invent a state machine, an input name, or an event the editor did not define, and never reach for Rive when a fixed-timeline asset (Lottie) or code motion would do.

## How the Rive integrator thinks

1. **The state machine is the contract.** A designer authors the states, the inputs, and the transitions in the Rive editor; the developer wires real input to those named inputs and the engine handles the transitions. The exact names are the interface between design and code.
2. **Stateful and two-way, unlike Lottie.** Lottie plays a fixed timeline; Rive responds to input in real time and can emit events back to code. Reach for Rive when the animation has states (idle, hover, pressed, toggled) or binds to live data.
3. **Inputs drive states, in three kinds.** Boolean for on or off (isHovered), number for a value (progress), trigger for a one-time event (a click, via `fire()`). Set the input, and the machine transitions.
4. **ViewModels bind live data, both ways.** The ViewModel API maps app data (a name, a price, a colour) to animation properties and carries triggers and events back. `autoBind` must be off for manual ViewModel control.
5. **The asset is authored, not coded.** Like Lottie, the motion lives in the .riv file. The developer wires the inputs and reads the events; the states, transitions, and blend durations are the designer's job, and a missing state is an editor change, not a code change.
6. **Light, preloaded, and clean.** Keep artboards small and vector, preload critical files, use the off-screen renderer for performance, and clean up the listeners. And honour reduced-motion with a still or a reduced state.

## Rive core

The pieces of a Rive animation.

- **State machine:** the logic graph of states and the transitions between them, with listeners and conditions. It is what makes Rive interactive rather than a fixed timeline.
- **Inputs (three types):** `boolean` (an on or off state, `input.value = true`), `number` (a value, `input.value = 50`), and `trigger` (a one-time event, `input.fire()`). Inputs are the levers the developer pulls to drive the machine.
- **ViewModels:** the two-way data-binding layer. A ViewModel exposes `string`, `number`, `color`, `enum`, and `trigger` properties that map app data to the animation and carry values and triggers back.
- **Events:** general named events the animation emits to code, with attached properties, read through the runtime's event listener.
- **Artboards:** the named canvas that holds the animation; one .riv file can contain several artboards, animations, and state machines.

## Implementation

```jsx
import { useRive, useStateMachineInput } from "@rive-app/react-canvas";

const { rive, RiveComponent } = useRive({
  src: "/animations/button.riv",
  stateMachines: "Button State Machine",   // run the state machine, not just a timeline
  artboard: "Button",
  autoplay: true,
  layout: { fit: "contain", alignment: "center" },
});

// Get a named input from the state machine (null if the name does not match the editor)
const hover = useStateMachineInput(rive, "Button State Machine", "isHovered", false);
```

```jsx
// Render with a stable container size
<div onMouseEnter={() => hover && (hover.value = true)} onMouseLeave={() => hover && (hover.value = false)}>
  <RiveComponent style={{ width: 200, height: 100 }} />
</div>
```

The runtime renders to canvas and runs the state machine. The same .riv asset and the same state-machine concept work across Web, React, React Native, iOS, Android, and Flutter, each with its platform runtime. Keep the container a stable size so the canvas does not cause a layout shift. Preload a heavy file with `useRiveFile` and pass `riveFile` to `useRive`, handling the loading and failed states. Control playback through the `rive` instance (`rive.play()`, `rive.pause()`). The hook API is identical across the renderer packages (`@rive-app/react-canvas` is the default; `@rive-app/react-canvas-lite` and `@rive-app/react-webgl2` are siblings), so the renderer choice is independent of the wiring this spec covers.

## State-machine design

This is the design-dev contract, and the names are the interface.

- **The designer authors, in the Rive editor:** the states (idle, hover, pressed), the transitions (the rules to move between states), the conditions (the input thresholds that fire a transition), and the blend durations (the smooth interpolation between states). The smoothness is authored, not coded.
- **The developer wires, in code:** the named inputs to real input. The state machine name, the input names, the ViewModel property names, and the event names must match the editor exactly; a mismatch returns null and the wiring silently does nothing. Always check the input exists before using it.
- **A missing state is an editor change.** If a control needs a state the machine does not have, that is a designer task in the editor, not something to fake in code. Route it back, do not approximate the state with code.
- **Confirm the contract first.** Before wiring, get the exact names (state machine, inputs and their types, ViewModel properties, events) from the designer or the .riv file. The spec names them so the build does not guess.

## Interactivity patterns

```jsx
// Hover and press via boolean and trigger inputs
const hover = useStateMachineInput(rive, "SM", "isHovered", false);
const click = useStateMachineInput(rive, "SM", "onClick"); // a trigger
onMouseEnter={() => hover && (hover.value = true)};
onClick={() => click && click.fire()};

// A number input for progress or drag
const progress = useStateMachineInput(rive, "SM", "progress");
progress && (progress.value = 0.6);

// ViewModel two-way data binding (autoBind off for manual control)
const { rive } = useRive({ src: "/dashboard.riv", autoplay: true, autoBind: false });
const vm = useViewModel(rive, { name: "Dashboard" });
const inst = useViewModelInstance(vm, { useDefault: true, rive }); // a selector (useDefault / name / useNew) plus rive is required
const { setValue: setPrice } = useViewModelInstanceNumber("stockPrice", inst);
useEffect(() => { if (setPrice) setPrice(price); }, [setPrice, price]);

// Events back to code: subscribe with rive.on; General events fire without automaticallyHandleEvents
const { rive } = useRive({ src: "/rating.riv", stateMachines: "SM", autoplay: true });
useEffect(() => {
  if (!rive) return;
  const onEvent = (e) => { if (e.data.type === RiveEventType.General) { /* e.data.name, e.data.properties */ } };
  rive.on(EventType.RiveEvent, onEvent);
  return () => rive.off(EventType.RiveEvent, onEvent);
}, [rive]);
// automaticallyHandleEvents controls only the auto-navigation of RiveEventType.OpenUrl events; it is not needed to read General events
```

Patterns: hover and toggle map to boolean inputs, press and submit to trigger inputs (`fire()`), drag and progress to number inputs, live data to ViewModel properties (two-way), and animation-driven moments to events read in code. For a scroll trigger, fire an input from an IntersectionObserver or a GSAP ScrollTrigger `onEnter` (route the scroll choreography to `crew-animation-gsap`), not a raw scroll listener.

## Performance

- **Keep the file and artboards light.** Vector over raster (raster images bloat the .riv); keep an artboard under about 2MB; minimise bones in skeletal rigs; simplify the state machine.
- **Use the off-screen renderer.** It improves performance for complex animations.
- **Preload critical animations.** Load the .riv with `useRiveFile` during app init so the animation is ready when it appears.
- **Know what `automaticallyHandleEvents` does.** It auto-navigates `RiveEventType.OpenUrl` events (it opens the URL for you); set it false to handle those yourself. It is not required to read General events, which fire through `rive.on` regardless.
- **Lazy-load below the fold and respect the device.** Mount the canvas when it enters the viewport, and serve a lighter artboard on weak devices.
- **Reduced-motion.** Under `prefers-reduced-motion`, hold a static state rather than animating; do not autoplay an ambient loop.

## Rive vs Lottie

The boundary, because they look similar but differ on interactivity.

- **Lottie is a fixed timeline, one-way.** Code plays or seeks the asset; the motion does not hold state or respond to input. Right for a logo reveal, a loader, or a marketing accent.
- **Rive is a state machine, two-way.** Code feeds named inputs, the engine transitions between states, and events flow back. Right for an interactive control (a button with idle, hover, pressed, and toggle states), a data-bound visualisation, or a game-like UI.
- **The test:** does the animation have states and respond to input, or does it just play. States and input mean Rive; play means Lottie. Both ship a designer-authored vector asset; the difference is interactivity, state, and two-way data, and Rive's runtime and complexity are not worth it for one-way playback.

## Anti-patterns

```
autoBind left on while using ViewModels           -> set autoBind: false for manual ViewModel control, or the properties will not update.
A wrong state-machine, input, or property name     -> the hook returns null and the wiring silently does nothing; match the editor name exactly.
Using an input without checking it exists          -> guard every input (if (input) ...); a null input throws or no-ops.
Thinking automaticallyHandleEvents is needed for events -> General events fire via rive.on without it; the flag only auto-navigates OpenUrl events. Always clean up the listener.
No listener cleanup                                 -> rive.off(...) in the effect cleanup, or handlers stack and leak.
Raster images inside the artboard                   -> use vector; raster bloats the file and loses Rive's scalability.
Too many or oversized artboards (over ~2MB)         -> split, simplify, or optimise in the editor.
No reduced-motion path                              -> hold a static state under prefers-reduced-motion.
Faking a missing state in code                      -> a missing state is an editor change; route it to the designer, do not approximate.
Reaching for Rive for fixed playback                -> a play-once logo or a loader is lighter in Lottie; reserve Rive for stateful, interactive work.
```

## Application rules

The checklist a build embeds when it ships a Rive animation.

```
[ ] Rive is justified: the animation has states, responds to input, or binds to live data, not just fixed playback.
[ ] The state machine, input, ViewModel property, and event names match the Rive editor exactly (the design-dev contract).
[ ] The state machine is run (stateMachines named in useRive), not just a static animation timeline.
[ ] Inputs are wired by type: boolean for on/off, number for a value, trigger for a one-time event (fire()), each guarded for existence.
[ ] ViewModels use autoBind false for manual control; General events are read via rive.on with listener cleanup (automaticallyHandleEvents only auto-navigates OpenUrl).
[ ] The container has a stable size; artboards are vector and light; the off-screen renderer and preload are used where they help.
[ ] The animation lazy-loads below the fold; a reduced-motion path holds a static state.
[ ] A state-driven control has a non-animated fallback; a missing state is routed to the designer, not faked in code.
```

## Speccing workflow

1. **Confirm Rive is the right tool, and identify the asset.** State what the animation does. If it is fixed playback with no states or input, say so now and route it to `crew-animation-lottie`; if it is code-authored UI motion, route it to `crew-animation-motion` or `crew-animation-gsap`. If there is no .riv asset, ask for it. Only proceed when the animation is stateful or interactive.
2. **Establish the design-dev contract.** Get the exact names from the editor or the file: the state machine, its inputs and their types, the ViewModel properties, and the events. The spec names them so the build does not guess; a missing state is a designer task.
3. **Spec the implementation.** Name the runtime and the framework, the `useRive` config (src, stateMachines, artboard, layout), the stable container size, and any preload via `useRiveFile`.
4. **Spec the interactivity wiring.** Map the real inputs to the named state-machine inputs by type (hover and toggle to boolean, press to a trigger fire, drag and progress to number), the ViewModel two-way binding (autoBind off), and the events (read via rive.on with listener cleanup; automaticallyHandleEvents only for OpenUrl). Guard every input for existence.
5. **Spec the performance, the cleanup, and the reduced-motion path.** Name the artboard and file budget (vector, under about 2MB), the off-screen renderer and preload, the lazy-load, the listener cleanup, and the reduced-motion static state plus a fallback for a meaningful control.
6. **Write the spec and run the anti-pattern check.** Assemble the Rive animation spec, and confirm none of the anti-patterns are present (autoBind on with ViewModels, a name mismatch, an unguarded input, missing event handling, no cleanup, raster art, no reduced-motion).
7. **Verify before emitting.** Confirm Rive is justified, the names match the editor, the state machine is run, the inputs are wired and guarded by type, ViewModels and events are configured, the artboards are light, and the reduced-motion path exists. Only then emit.

## Worked example

The spec as the source skill returned it, the shape a consult answer should take.

```
RIVE ANIMATION SPEC
Brief: an interactive button with idle, hover, and pressed states, a toggle, and a "clicked" event back to the app   Asset: button.riv   Framework: React   Built: 2026-06-24   Mode: Careful

Asset and contract (the names from the editor):
- State machine: "Button State Machine".   Inputs: isHovered (boolean), isToggled (boolean), onClick (trigger).   ViewModel properties: none.   Events: "clicked".

Implementation:
- @rive-app/react-canvas, useRive({ src: "/animations/button.riv", stateMachines: "Button State Machine", autoplay: true, layout: { fit: "contain" } }); container a fixed 200 by 60.

Interactivity wiring:
- onMouseEnter and onMouseLeave set isHovered.value; onClick fires onClick (the trigger); a toggle control sets isToggled.value. Each input is guarded (if (input) ...) because a name mismatch returns null.
- ViewModel: none. Events: rive.on(EventType.RiveEvent) reads the "clicked" General event name; rive.off on unmount (automaticallyHandleEvents is not needed for General events).

Performance and accessibility:
- File: vector, a small single-artboard button, off-screen renderer on, preload not needed for a light file.
- Reduced-motion: under prefers-reduced-motion, the button holds the idle or final state without the transition animation; it is a real button, so the native focus and click behaviour carry the interaction.
- Cleanup: remove the event listener on unmount.
```

## Guardrails

- Never use Rive for fixed-timeline playback that has no states or input. A play-once logo or a loader is lighter in Lottie; reserve Rive for stateful, interactive, or data-bound work.
- Never wire a name that does not match the editor. The state machine, input, ViewModel property, and event names must match exactly, and every input is guarded for existence (a mismatch returns null).
- Never leave autoBind on while controlling ViewModels manually; ViewModel binding needs autoBind false. General events are read via rive.on (automaticallyHandleEvents only auto-navigates OpenUrl events, it is not required to receive events).
- Never leave listeners un-removed on unmount. Cleanup is part of the spec.
- Never fake a missing state in code; a missing state is an editor change for the designer.
- Never skip the reduced-motion path, and never ship a state-driven control with no non-animated fallback.
- Never put raster images in an artboard where vector belongs, or ship an oversized file.
- No AI-slop in the spec: no "make it pop", no filler, no emoji. Exact state-machine, input, and property names.
- If a project playbook exists (a motion system, a file-size budget, a naming convention), it is the authority. Follow it over these defaults.

## Pairings and boundaries

- Pair with `crew-animation-lottie` on the asset boundary: Lottie for fixed-timeline playback (a logo, a loader), Rive for a stateful, interactive, or data-bound animation. When the animation just plays, route to Lottie; when it has states and input, this spec.
- Pair with `crew-animation-motion`: Motion owns the React layout and gesture motion around a Rive component (a card that springs in and contains a Rive control); this spec owns the Rive state machine inside it.
- Pair with `crew-animation-gsap`: when a Rive input should fire on scroll or sit in a scroll timeline, drive the input from GSAP ScrollTrigger; spec the Rive wiring here, the scroll choreography there.
- Route a code-authored UI transition (no designer asset) to `crew-animation-motion`, `crew-animation-gsap`, or `crew-animation-anime` instead.

## Verification

Before the run is marked done, confirm:

```
[ ] Rive was confirmed as the right tool (stateful, interactive, or data-bound), not fixed playback (Lottie) or code motion
[ ] The state machine, input, ViewModel property, and event names match the editor (the design-dev contract)
[ ] The state machine is run in useRive, not just a static timeline
[ ] Inputs are wired by type (boolean, number, trigger fire()) and each is guarded for existence
[ ] ViewModels use autoBind false; General events are read via rive.on with listener cleanup (automaticallyHandleEvents only for OpenUrl)
[ ] The container has a stable size; artboards are vector and under the size budget; off-screen and preload used where they help
[ ] The animation lazy-loads below the fold; a reduced-motion path holds a static state
[ ] A state-driven control has a non-animated fallback; a missing state is routed to the designer
```
