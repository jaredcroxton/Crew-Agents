# Lottie spec (consulted via crew-animation)

Lottie renders an animation that a designer authored in After Effects and exported (via the Bodymovin plugin) as a JSON or dotLottie file; the motion lives in the asset, so this spec covers loading it, sizing it, controlling its playback, wiring its interactivity, the player and renderer choice, the export and performance budget, and the cleanup and reduced-motion path, not authoring the motion in code.

## When to use Lottie

Do not use this spec for code-authored motion (a UI transition, a sequence, or a stagger is cheaper and more flexible in `crew-animation-gsap`, `crew-animation-motion`, or `crew-animation-anime` than a JSON asset), for scroll-scrubbed timeline choreography (GSAP), or when there is no After Effects asset to render. Lottie is for designer-made vector animations shipped as a file; if the motion is better authored in code, name the better tool.

## What a spec needs

You need:

- The asset: the After Effects JSON or dotLottie file (or a clear description of the designer animation to render), its source (a bundled file, a hosted URL, an After Effects export), and a rough complexity.
- The context: what the animation is for (an icon, a loader, onboarding, a marketing accent), the framework (vanilla, React, Vue, Svelte), and the trigger (load, interaction, in-view, scroll).
- The accessibility constraint: that reduced-motion must be honoured (always), and what the static or reduced state should be if the animation carries meaning.

If there is no asset and no description of the designer animation, ask once for the file or what it should depict. Lottie renders an asset; it cannot author one. Never invent an animation file, never autoplay everything by default, and never ship a remote runtime path where a bundled or self-hosted asset belongs.

## How the Lottie integrator thinks

1. **The animation is an asset, not code.** A designer made it in After Effects; Lottie ships it as JSON and renders it. You load it, size it, control playback, and keep it light, you do not author the motion.
2. **Vector, scalable, smaller than a GIF or video.** Lottie is the right call for designer-crafted icons, loaders, onboarding, and marketing motion, where you want pixel-perfect fidelity at a small size. Use it instead of a GIF or a video.
3. **dotLottie for production.** The `.lottie` format is a compressed archive (often much smaller than raw JSON) and can carry multiple animations and themes; prefer it over raw JSON for shipping.
4. **Control playback, do not autoplay everything.** Default to autoplay off and loop off unless the brief wants them; an autoplaying looping animation is a distraction and a battery cost. Play on interaction or when in view.
5. **The export is half the battle.** The file size and what renders correctly are decided in After Effects (the Bodymovin export), not in the code. Effects, blend modes, 3D, and expressions do not survive export; test the file in a browser before shipping.
6. **Light, lazy, and clean.** Keep the file small, lazy-load it below the fold, pick the renderer for the complexity, and destroy the instance on unmount. And honour reduced-motion.

## Lottie core

Where the asset comes from and what plays it.

- **Origin.** A designer animates in After Effects and exports with the Bodymovin plugin to a Lottie file. The file encodes the layers, shapes, and keyframes as data the player renders frame by frame.
- **JSON (`.json`):** the original format, human-readable, uncompressed, widely supported, larger.
- **dotLottie (`.lottie`):** a compressed ZIP archive holding the JSON plus assets, often far smaller, and able to carry multiple animations and themes in one file. Preferred for production.
- **Players:** `lottie-web` (the original library), `@lottiefiles/dotlottie-web` (the modern player, canvas-based), and the framework wrappers `@lottiefiles/dotlottie-react` (or the alternative `lottie-react`), `@lottiefiles/dotlottie-vue`, and `@lottiefiles/dotlottie-svelte`.
- **Renderers (lottie-web):** `svg` (best quality, crisp at any size, slower for complex art), `canvas` (faster, rasterised, better for complex animations), `html` (limited, simple cases only). The dotLottie player renders to canvas.
- **Sources:** a bundled local file (best performance, no network request, version-controlled), a hosted URL or CDN (a network dependency and a CORS consideration), or a fresh After Effects export.

## Implementation

```javascript
// lottie-web (vanilla)
import lottie from "lottie-web";
const anim = lottie.loadAnimation({
  container: document.getElementById("lottie"),
  renderer: "svg",        // or "canvas"
  loop: false, autoplay: false, // control playback, do not autoplay by default
  path: "/animations/logo.json", // a self-hosted or bundled path, or animationData: jsonData for a bundled import
});

// dotLottie-web (vanilla, canvas)
import { DotLottie } from "@lottiefiles/dotlottie-web";
const player = new DotLottie({ canvas: document.getElementById("c"), src: "/animations/logo.lottie", autoplay: false, loop: false });
```

```jsx
// React (DotLottieReact), with a ref for control
import { DotLottieReact } from "@lottiefiles/dotlottie-react";
<DotLottieReact src="/animations/logo.lottie" autoplay={false} loop={false}
  dotLottieRefCallback={setDotLottie} style={{ height: 240 }} />
// control via the ref: dotLottie.play(), .pause(), .stop(), .setFrame(30)

// lottie-react (alternative), animationData for a bundled JSON import
import Lottie from "lottie-react"; import data from "./logo.json";
<Lottie animationData={data} loop={false} autoplay={false} />
```

Keep the container a stable size in CSS (a fixed width and height, or a contained aspect ratio) so the animation does not cause a layout shift. For a local import use `animationData` (bundled, no network); for an external file use `path` or `src` (mind CORS, and in a framework place the file in the public or static folder). Vue uses `DotLottieVue` and Svelte `DotLottieSvelte` with the same props. Note: `lottie-react` and `@lottiefiles/dotlottie-react` are different packages, not drop-in swaps; `lottie-react` takes `animationData` (a JSON import) and uses the lottie-web renderers, while `DotLottieReact` takes `src` (a `.lottie` file) and renders to canvas.

## Interactivity

The player exposes events and state control, and Lottie supports config-driven interactivity.

```jsx
// Events (clean up the listeners)
dotLottie.addEventListener("load", onLoad);
dotLottie.addEventListener("complete", onComplete);
dotLottie.addEventListener("frame", ({ currentFrame }) => {});
// in React, removeEventListener in the effect cleanup

// State control
dotLottie.play(); dotLottie.pause(); dotLottie.stop(); dotLottie.setFrame(30);
```

```jsx
// Scroll and cursor interactivity (lottie-react), via the useLottieInteractivity hook (not a bare prop)
const lottieObj = useLottie({ animationData: data });
const View = useLottieInteractivity({ lottieObj, mode: "scroll", actions: [
  { visibility: [0, 0.2], type: "stop", frames: [0] },
  { visibility: [0.2, 0.45], type: "seek", frames: [0, 45] },   // scrub the asset's frames to scroll
  { visibility: [0.45, 1], type: "loop", frames: [45, 60] },
]});
return View; // use useLottieInteractivity (or the LottieInteractivity wrapper); a bare interactivity prop may be ignored
// mode "cursor" with position actions drives hover and click zones (a like button that loops while hovered)
```

A dotLottie file can carry multiple animations and themes; read `manifest.animations` and `manifest.themes` on load and switch via `activeAnimationId` and `activeThemeId`. For heavy scroll syncing tied to precise scroll position, drive the player's frame from GSAP ScrollTrigger (route to `crew-animation-gsap`) rather than a raw scroll listener.

## Performance

- **A file-size budget.** A simple icon should be a few KB, not 500KB. If a simple animation exports large, the fix is in After Effects (below) plus dotLottie compression and an optimiser pass, not in the code.
- **dotLottie compression.** Ship `.lottie` over raw `.json` for the size win.
- **Lazy-load below the fold.** Render the player only when it enters the viewport, via an `IntersectionObserver`, so off-screen animations cost nothing until needed.
- **Renderer by complexity.** Use `svg` for a crisp simple icon, `canvas` for a complex animation (it rasterises and performs better). The dotLottie player is canvas by default.
- **Offload a heavy animation to a worker.** `DotLottieWorker` renders off the main thread; group animations by `workerId`.
- **Mobile.** Serve a lighter variant and a lower `devicePixelRatio` on phones for an expensive animation.
- **Reduced-motion.** Under `prefers-reduced-motion`, do not autoplay or loop; show a static frame.

## After Effects workflow

The size and the fidelity are decided in the Bodymovin export, so the designer and developer loop on the export, not the code.

```
EXPORT SETTINGS (smaller, cleaner files):
- Skip images that are not used; prefer glyphs over embedded fonts.
- Simplify paths (fewer points), use shape layers rather than vector or AI layers.
- Avoid effects that bloat the data (particles, noise, heavy gradients).
- Disable "include expressions" if the animation does not need them.

DOES NOT SURVIVE EXPORT (rebuild with shapes, or rethink):
- Layer effects (drop shadow, glow): recreate as shape layers.
- Blend modes: limited support.
- 3D layers: not supported.
- Expressions: partial support.
- Track mattes: partial support.
- Text and fonts: prefer glyphs over embedded fonts; expect substituted, shifted, or missing glyphs otherwise.
- Mask feather and time remapping: fragile, often render wrong.
```

Test the exported file in a browser, or the LottieFiles preview, early and often. An effect that looks right in After Effects may render wrong or blank in the player, and the only way to know is to view the actual file.

## Anti-patterns

```
A heavy, unoptimised JSON (500KB for a simple icon)   -> fix the After Effects export (simplify paths, shape layers), ship dotLottie, run an optimizer.
A remote path or URL at render time                   -> bundle or self-host the asset; a runtime fetch adds a network dependency, a CORS risk, and a flash.
Autoplay and loop on everything                        -> default autoplay off and loop off; play on interaction or in view. Looping motion is a distraction and a battery cost.
No destroy on unmount                                  -> call destroy() (or pause) on teardown, or instances and event listeners leak.
Event listeners never removed                          -> remove every listener in the cleanup, or handlers stack up.
SVG renderer for a complex animation                   -> use canvas or DotLottieWorker; SVG stutters on heavy art.
No reduced-motion path                                 -> under prefers-reduced-motion, do not autoplay; show a static frame.
No static fallback for a meaningful animation          -> if the animation conveys information, provide a still or text equivalent.
Assuming After Effects effects survive export          -> test the exported file in a browser first; effects, blend modes, 3D, and expressions often do not.
Reaching for Lottie to author a UI transition          -> a code-authored slide or fade belongs in GSAP, Motion, or Anime, not a JSON asset.
```

## Application rules

The checklist a build embeds when it ships a Lottie animation.

```
[ ] Lottie is justified: a designer-made After Effects asset to render, not a code-authored UI transition.
[ ] The asset ships as dotLottie (or optimised JSON), bundled or self-hosted, within a sensible size budget.
[ ] The player and renderer fit (svg for a crisp simple icon, canvas or a worker for a complex animation).
[ ] The container has a stable size; the animation does not cause a layout shift.
[ ] Autoplay and loop are off by default; the animation plays on a trigger (interaction, in-view) unless the brief wants otherwise.
[ ] The animation lazy-loads below the fold via an IntersectionObserver.
[ ] The instance is destroyed and the event listeners removed on unmount.
[ ] A reduced-motion path shows a static frame; a meaningful animation has a static or text fallback.
```

## Speccing workflow

1. **Confirm Lottie is the right tool, and identify the asset.** State what the animation is and that a designer-made After Effects asset exists or is coming. If the motion is a code-authored UI transition, say so now and route it (`crew-animation-motion` or `crew-animation-gsap`). If there is no asset and no description, ask for it. Only proceed when Lottie fits.
2. **Choose the player, the format, and the renderer.** Prefer dotLottie for production, pick the library for the framework (dotLottie-web, DotLottieReact, lottie-react, Vue, Svelte), and pick the renderer by complexity (svg crisp, canvas or worker heavy).
3. **Spec the implementation.** Name the load (the source, bundled or self-hosted, `animationData` or `path`/`src`), the stable container size, and the autoplay and loop defaults (off unless the brief wants them).
4. **Spec the interactivity if any.** Name the events and state control, and any scroll or cursor interactivity (the frame ranges mapped to visibility or pointer position), the click and hover zones, and any theme or multi-animation switching.
5. **Spec the performance, the After Effects export notes, the cleanup, and the reduced-motion path.** Name the file budget and dotLottie, the lazy-load, the worker for a heavy animation, the export fixes the designer must make, the destroy-on-unmount, and the reduced-motion static frame.
6. **Write the spec and run the anti-pattern check.** Assemble the Lottie animation spec, and confirm none of the anti-patterns are present (a heavy file, a runtime remote path, autoplay abuse, no cleanup, an SVG renderer on a complex animation, no reduced-motion).
7. **Verify before emitting.** Confirm the asset is justified and within budget, the player and renderer fit, autoplay and loop are off by default, the animation lazy-loads, the instance is cleaned up, and the reduced-motion path exists. Only then emit.

## Worked example

The spec as the source skill returned it, the shape a consult answer should take.

```
LOTTIE ANIMATION SPEC
Brief: a hero logo reveal that plays once on load then holds   Asset: logo-reveal.lottie (designer After Effects export)   Framework: vanilla, with a React variant   Built: 2026-06-24   Mode: Careful

Asset:
- Ship as dotLottie (logo-reveal.lottie), self-hosted under /animations/, budget under about 30KB; raw JSON only if dotLottie is not available.

Player and renderer:
- dotLottie-web (canvas) for vanilla, DotLottieReact for the React variant; canvas renderer is fine for a logo; container a fixed 240px square to avoid layout shift.

Implementation:
- Load with autoplay false and loop false; play once on load (or on in-view), and on the "complete" event leave it on the final frame (hold).

Interactivity (if any):
- None beyond play-once; the "complete" event marks the held state. No scroll or cursor interactivity.

Performance, export, and accessibility:
- File: dotLottie compressed, lazy-load via an IntersectionObserver if below the fold, no worker needed for a light logo.
- After Effects export notes: simplify the paths, use shape layers, drop expressions; rebuild any glow as a shape (glows do not survive export); test the file in a browser before shipping.
- Cleanup: destroy the player on teardown; remove the complete listener.
- Reduced-motion: under prefers-reduced-motion, render the final frame statically (no play); the logo is decorative, so a still is sufficient.
```

## Guardrails

- Never autoplay and loop by default. Default both off; an autoplaying looping animation is a distraction and a battery cost, and play on a trigger.
- Never ship a heavy, unoptimised file. Fix the export in After Effects, ship dotLottie, and hold a file-size budget; a simple icon is a few KB, not 500KB.
- Never depend on a remote runtime path where a bundled or self-hosted asset belongs. A runtime fetch adds a network dependency, a CORS risk, and a flash.
- Never leave an instance or its listeners un-destroyed on unmount. Cleanup is part of the spec.
- Never skip the reduced-motion path, and never ship a meaningful animation with no static or text fallback.
- Never assume an After Effects effect survives export. Test the exported file in a browser first; effects, blend modes, 3D, and expressions often do not.
- Never reach for Lottie to author a UI transition that code would do lighter and more flexibly; name the better tool.
- No AI-slop in the spec: no "make it pop", no filler, no emoji. Exact player, renderer, source, and triggers.
- If a project playbook exists (a motion system, a file-size budget, an asset pipeline), it is the authority. Follow it over these defaults.

## Pairings and boundaries

- This is the spec build skills read for designer-made vector animations (icons, loaders, onboarding). Hand them the Lottie animation spec to implement.
- Pair with `crew-animation-gsap`: when a Lottie animation must scrub to precise scroll position or sit inside a scroll timeline, drive the player's frame from GSAP ScrollTrigger; spec the Lottie asset here, the scroll choreography there.
- Pair with `crew-animation-motion`: for a code-authored UI transition wrapping a Lottie (a card that springs in and contains a Lottie loader), Motion owns the React layout and gesture motion, this skill owns the Lottie asset inside it.
- Route a code-authored slide, fade, or sequence (no designer asset) to `crew-animation-motion`, `crew-animation-gsap`, or `crew-animation-anime` instead.

## Verification

Before the run is marked done, confirm:

```
[ ] Lottie was confirmed as the right tool (a designer-made After Effects asset), not a code-authored UI transition
[ ] The asset ships as dotLottie or optimised JSON, bundled or self-hosted, within a size budget
[ ] The player and renderer fit the complexity (svg crisp simple, canvas or worker heavy)
[ ] The container has a stable size and does not cause a layout shift
[ ] Autoplay and loop are off by default; the animation plays on a trigger unless the brief wants otherwise
[ ] The animation lazy-loads below the fold via an IntersectionObserver
[ ] The instance is destroyed and the listeners removed on unmount
[ ] The After Effects export notes name what to fix and what does not survive export
[ ] A reduced-motion path shows a static frame; a meaningful animation has a fallback
```
