# Animation components spec (consulted via crew-animation)

A component library hands you a catalogue of ready animated primitives (an animated button, a modal, a toast, an accordion) that already encode the right motion, the right focus handling, and the right reduced-motion path, so standard UI ships fast and the whole surface stays consistent. This spec covers which primitive from the catalogue, the motion primitives it composes from (fade, slide, scale, rotate), the composition, the framework mapping, the pre-built versus custom call, the performance, and the reduced-motion path.

## What a spec needs

You need:

- The component brief: what UI element animates (a button, a card, a modal, a nav, a loader, a toast, an accordion, a tabset), why it moves (feedback, entrance, state change, attention), and on what trigger (hover, click, mount, open, dismiss, in-view).
- The context: the framework (React, Vue, or vanilla), the design system already in use (shadcn/ui, Tailwind, a headless library), and whether the motion is a standard pattern or a brand signature.
- The accessibility constraint: that reduced-motion must be honoured (always), that interactive overlays must trap focus and restore it, and what the reduced or instant state should be.

If the brief is too vague to spec, ask once which UI element animates, why, and on what trigger. Never invent a component the brief did not call for, never pull a whole library for a single primitive, and never ship an overlay primitive without a focus trap and a reduced-motion path.

## How the component animator thinks

1. **The catalogue is the default, custom is the exception.** A modal, a toast, an accordion are solved problems. Reach for the primitive that already encodes the right motion and the right accessibility before hand-writing one. Build custom only when the motion is a brand signature or no primitive matches.
2. **Components compose from primitives.** Every animated component is a small set of motion primitives layered together: a modal is overlay-fade plus panel-scale plus focus-trap, a toast is slide-in plus auto-dismiss plus exit. Name the primitives, then the composition, not a monolith.
3. **Transform and opacity, always.** The primitives animate `opacity`, `transform: translate`, `transform: scale`, `transform: rotate`. They run on the compositor. A primitive that animates `width`, `height`, `top`, or `left` is the wrong primitive; the accordion height case is the one honest exception and it needs care.
4. **Accessibility is part of the primitive, not a bolt-on.** An overlay primitive (modal, dialog, popover, menu) traps focus, restores it on close, and closes on Escape. Every primitive honours `prefers-reduced-motion`. A pretty animation that ignores focus or reduced-motion is a broken primitive.
5. **A primitive earns its dependency.** Pulling a 150-component library to ship one animated button is a bad trade; copy the one component or hand-write it. A library earns its place when you use many of its primitives and want them consistent.
6. **Consistency is the payoff.** The reason to use a catalogue is that every modal opens the same way, every toast slides from the same edge, every tab transition matches. Compose from the same primitives so the surface reads as one system, not a patchwork.

## Component catalogue

The pre-built animated primitives, what each animates, and why.

- **Animated buttons.** Hover lift and a soft press (`scale` down to about `0.97` on press), plus optional effects layered on the surface (a shimmer sweep, an animated border beam, a magnetic pull toward the cursor). The press is the load-bearing one: it confirms the tap. Effects are decorative and should stay subtle.
- **Cards.** Entrance (fade plus a small `translateY` rise), hover lift (`translateY` up with a shadow), and optional reveal-on-view for a grid. The lift gives depth; the entrance stagger gives a grid rhythm.
- **Modals and dialogs.** Overlay-fade (the scrim) plus panel-scale-and-fade (the panel rises and scales from roughly `0.95` to `1`), wrapped in a focus trap that restores focus on close and an Escape-to-close. The motion is secondary; the focus management is the reason to use a primitive.
- **Navs and menus.** Dropdown and popover open with a fade plus a small `translateY` or `scale` from the trigger origin, a mobile drawer slides in from an edge, and a tab or pill indicator slides between items (a shared-element move). Menus are overlays: they trap focus and close on Escape and outside-click.
- **Loaders and spinners.** A continuous `rotate` for a spinner, a `translateX` sweep for a skeleton shimmer, a pulse (`opacity` or `scale`) for a placeholder. These run on a loop; under reduced-motion a spinner may keep its rotation as a functional indicator while a decorative shimmer drops to a static state.
- **Toasts and notifications.** Slide-in from an edge (`translateX` or `translateY`) plus fade, an auto-dismiss timer, and an exit (slide-and-fade out). Stacked toasts reflow as one leaves. A toast must sit in an `aria-live` region (role="status" or polite for a routine message, role="alert" or assertive for an error) so a screen reader announces it. That live-region announcement, not just the exit animation, is a primary reason to reach for a pre-built toast primitive; the exit is the other part hand-rolled versions usually forget.
- **Accordions.** Expand and collapse the panel height with a synchronised chevron `rotate`. Height is the honest exception to the transform rule: animate `height` from `0` to the measured content height (or use a CSS grid `grid-template-rows` `0fr` to `1fr` trick that avoids measuring), and pair it with `opacity` on the content. The grid-rows trick needs `overflow: hidden` and `min-height: 0` on the inner content wrapper or the row will not collapse; it is the cross-browser choice (not `interpolate-size: allow-keywords` or `calc-size()`, which are Chromium-only).
- **Tabs.** A sliding indicator (the shared-element move under the active tab) plus an optional cross-fade or slide of the panel content. The indicator is the signature motion; keep the panel transition short so it does not lag the click.

```jsx
// A modal primitive (React + Motion), the composition made concrete.
// FocusTrap takes exactly one child, so wrap the scrim and panel in one container.
<AnimatePresence>
  {open && (
    <FocusTrap>                                              {/* focus trapped, restored on close, Escape closes */}
      <div>
        <motion.div aria-hidden="true" initial={{ opacity: 0 }} animate={{ opacity: 1 }} exit={{ opacity: 0 }} className="overlay" onClick={close} />
        <motion.div
          role="dialog" aria-modal="true"
          initial={{ opacity: 0, scale: 0.95, y: 8 }}        {/* panel: fade + scale + small rise */}
          animate={{ opacity: 1, scale: 1, y: 0 }}
          exit={{ opacity: 0, scale: 0.95, y: 8 }}
          transition={{ type: "spring", stiffness: 300, damping: 30 }}
        >{children}</motion.div>
      </div>
    </FocusTrap>
  )}
</AnimatePresence>
```

## Motion primitives

The reusable building blocks the components compose from. Four motions and a small set of presets.

- **Fade.** `opacity` from `0` to `1` (and back for an exit). The cheapest primitive, the base of almost every entrance, and the one that always survives reduced-motion because it conveys appearance without movement.
- **Slide.** `transform: translate` along one axis (a toast from the right, a drawer from the left, a dropdown a few pixels down from its trigger). The distance is small for UI affordances (8 to 16 px) and large only for full panels (a drawer).
- **Scale.** `transform: scale`, used for a press (down to about `0.97`), a modal panel (up from `0.95`), and a pop-in. Scale from the element's transform-origin so it grows from the right point.
- **Rotate.** `transform: rotate`, used for a spinner (a continuous loop), an accordion chevron (`0deg` to `180deg`), and a small icon flip. Pair the chevron rotate with the panel expand so they move as one.

The spring presets the primitives tune with (in Motion's stiffness and damping terms, the same physics every primitive should share for consistency):

```
gentle   stiffness 120, damping 20    a soft, settled entrance (cards, panels)
snappy   stiffness 300, damping 30    a responsive UI move (modal panel, dropdown)
stiff    stiffness 400, damping 38    a fast, tight indicator slide that settles without overshoot
```

The `stiff` preset is for indicator slides. A press wants no overshoot at all (an underdamped spring overshoots and contradicts the "no heavy bounce on a serious form" rule), so its damping is raised to settle clean; for a button press, reach for `stiff` at this higher damping or a short tween rather than a springy, low-damping move.

Durations for the tween case (a fade, a loader loop) stay short: 150 to 300 ms for an entrance or exit, a fixed loop duration for a spinner or shimmer. Reach for a spring on anything that should feel physical (a panel, a press, an indicator) and a short tween on a pure fade.

## Composition

Components are primitives layered, not monoliths. The skill is to compose them without a prop explosion.

- **A modal** is overlay-fade plus panel-scale-and-fade plus focus-trap plus Escape-to-close. Four concerns, each its own primitive: the scrim fades, the panel scales and rises, the trap manages focus, the key handler closes. None of them is a prop on a giant component; they are layered.
- **A toast** is slide-in plus auto-dismiss plus exit. The slide is a primitive, the timer is a behaviour, the exit is the slide reversed wrapped in a presence boundary so the toast survives until its exit finishes. Stacked toasts add a reflow (a layout move) as one leaves.
- **An accordion** is height-expand plus chevron-rotate plus content-fade, synchronised on the same trigger and the same duration so they read as one motion.
- **A tabset** is an indicator-slide (shared element) plus a panel-transition (a short cross-fade or slide), kept independent so the indicator can be fast and the panel calm.

Layer these by composition, not by piling props onto one component. The anti-pattern is a single `<Modal animateOverlay overlayDuration panelScale panelFrom panelSpring trapFocus closeOnEscape ... />` with thirty knobs. Instead, compose small primitives (an `Overlay`, a `Panel`, a `FocusTrap`) and let each own one concern. Variants are named presets, not a new prop per case.

```jsx
// Composition over a prop tree: small primitives, each owning one concern.
// FocusTrap takes exactly one child, so the scrim and panel live in one wrapper.
function Modal({ open, onClose, children }) {
  return (
    <AnimatePresence>
      {open && (
        <FocusTrap onEscape={onClose}>     {/* one concern: focus + Escape   */}
          <div>
            <Overlay aria-hidden="true" onClick={onClose} />  {/* one concern: the fading scrim */}
            <Panel preset="snappy">{children}</Panel>         {/* one concern: the panel motion */}
          </div>
        </FocusTrap>
      )}
    </AnimatePresence>
  );
}
```

## Framework mapping

The same component pattern lands differently per framework. Spec the framework, then the primitive, then the library that ships it.

- **React with Motion (Framer Motion).** The mainstream path. `motion.*` components for the primitives, `AnimatePresence` for mount and exit, `layoutId` for the tab and modal shared-element morphs, `useReducedMotion` for the accessibility floor. Pre-built catalogues that ship on this stack: shadcn/ui plus a Motion-based animated set (the copy-paste primitive collections built on Tailwind plus Motion) for buttons, marquees, and effects, and a headless primitive library (Radix UI or React Aria) for the modal, menu, popover, and tabs behaviour with the motion layered on top. The headless-plus-motion split is the strong pattern: the headless library owns focus, keyboard, and ARIA; Motion owns the animation.
- **Vue with Transition.** Vue ships motion in the core via `<Transition>` and `<TransitionGroup>` (enter and leave classes, list reflow with a `move` class via FLIP). For richer physics, a Vue motion library (the Vue port of Motion) provides directives and composables. Headless behaviour comes from a Vue headless library (Headless UI for Vue or Reka UI, formerly Radix Vue), with the transition classes layered on the panel and overlay.
- **Vanilla with CSS or WAAPI.** No framework, no library. CSS transitions and keyframes drive the fade, slide, scale, and rotate; the Web Animations API (`element.animate()`) drives anything that needs JavaScript control (a sequence, a dynamic value, an interruptible loader). For the modal, a native `<dialog>` opened with `showModal()` gives page inertness (the rest of the page goes inert), Escape-to-close, the `::backdrop` pseudo-element, and the correct dialog ARIA for free. It does not trap Tab focus inside the dialog and does not close on a backdrop click. The modern accessibility position is that you need not trap focus on a native modal dialog, so you can accept the platform behaviour, or add a small focus-trap loop if the brief demands one; either way, focus restoration to the trigger on close and a backdrop-click-to-close handler are wired manually. Animate its open and close with CSS plus `@starting-style` for the entry, or WAAPI for finer control.

```js
// Vanilla modal: native <dialog> gives page inertness + Escape + ::backdrop for free.
// It does NOT trap Tab focus and does NOT close on backdrop click; wire those yourself.
const dialog = document.querySelector("dialog");
let lastFocused;
function open() {
  lastFocused = document.activeElement;                // remember the trigger to restore focus later
  dialog.showModal();                                  // page goes inert, Escape closes, ::backdrop appears
  if (matchMedia("(prefers-reduced-motion: reduce)").matches) return;
  dialog.animate(
    [{ opacity: 0, transform: "scale(0.95)" }, { opacity: 1, transform: "scale(1)" }],
    { duration: 200, easing: "ease-out" }
  );
}
// Backdrop click does not close natively; close when the click lands on the dialog's own box.
dialog.addEventListener("click", (e) => { if (e.target === dialog) dialog.close(); });
// Restore focus to the trigger on close (native dialog does not do this for you).
dialog.addEventListener("close", () => lastFocused?.focus());
```

The pattern is stable across all three: pick the primitive, let a headless or native layer own focus and keyboard, and let the framework's motion layer own the fade, slide, scale, and rotate.

## When to use pre-built vs custom

- **Reach for pre-built when** the UI is a standard pattern (a modal, a toast, a tab indicator, an accordion), you want consistency across many instances, and you want the accessibility (focus, keyboard, ARIA) solved correctly the first time. A catalogue gives you correct, consistent, fast.
- **Build custom when** the motion is a brand signature (a hero interaction nobody else has, a distinctive transition that is part of the product's identity) or no primitive matches the requirement. A signature motion is the one place hand-built physics or a bespoke timeline earns its cost; route it to the right tool (`crew-animation-spring` for physics, `crew-animation-gsap` for a timeline, `crew-animation-motion` for a one-off state-driven piece).
- **The dependency cost is real.** Pulling a large component library to ship one animated button adds weight you pay on every page load for one primitive you could copy or hand-write in a dozen lines. Copy the single component, or write the CSS, before adding the dependency. A library earns its place when you use many of its primitives and want them consistent; it does not earn its place for one.
- **The test:** is this a solved, standard pattern you want correct and consistent (pre-built), or a signature motion that is part of the brand (custom). Reach for the catalogue for the former, name the custom tool for the latter, and never pay a whole-library cost for a single primitive.

Do not use this spec for bespoke physics and gesture motion that needs velocity preservation and interruptible springs (that is `crew-animation-spring`), for state-driven one-off component animation where you hand-write the variants on a single element (`crew-animation-motion`), for scroll-driven reveals where the trigger and choreography are the scroll position (`crew-animation-scroll-reveal`), or for lightweight CSS-only motion that needs no library at all (`crew-animation-css`). Components is the pre-built primitive catalogue: reach for it to ship standard animated UI fast and consistently, and name the custom tool when the motion is a brand signature or no primitive fits.

## Anti-patterns

```
Over-composition into an unmaintainable prop tree   -> compose small primitives (Overlay, Panel, FocusTrap), each owning one concern; do not pile thirty props on one Modal.
A new prop for every visual variant                 -> name variants as presets (preset="snappy"); a prop per case is a combinatorial explosion.
An overlay primitive with no focus trap             -> a modal, dialog, popover, or menu traps focus, restores it on close, and closes on Escape; the motion is secondary.
No reduced-motion path                              -> every primitive honors prefers-reduced-motion; a decorative loop drops to static, an entrance keeps only the fade.
Importing a whole library for one component          -> copy the single primitive or hand-write it; do not pay a 150-component bundle for one button.
Animating width, height, top, left (except accordion)-> animate transform and opacity; the accordion height case is the one exception and needs the grid-rows trick or a measured height.
Motion that fights the design                        -> a heavy bounce on a serious form, a slow modal on a fast tool; the motion serves the product, it does not show off.
A toast or modal with no exit                        -> wrap the unmount in a presence boundary so the exit plays; a primitive that pops out of existence is unfinished.
Inconsistent motion across instances                 -> share the same presets so every modal, toast, and tab move matches; a catalogue exists to be consistent.
```

## Application rules

The checklist a build embeds when it ships animated components.

```
[ ] The right primitive from the catalogue is chosen for the pattern (modal, toast, accordion, tabs, button, card, nav, loader); custom only for a signature or an unmatched need.
[ ] The component is composed from named primitives (fade, slide, scale, rotate), not a monolith with a prop explosion.
[ ] Only transform and opacity animate, with the accordion height case handled by the grid-rows trick or a measured height.
[ ] Every overlay primitive (modal, dialog, popover, menu) traps focus, restores it on close, and closes on Escape.
[ ] Variants are named presets, not a new prop per case; the same spring presets are shared for consistency.
[ ] Toasts and modals have an exit wrapped in a presence boundary; stacked toasts reflow. A toast sits in an aria-live region (role status/polite, or alert/assertive) so a screen reader announces it.
[ ] No heavy library is pulled for a single primitive; the dependency cost is justified by multiple primitives in use.
[ ] Reduced-motion drops decorative loops to static and keeps only the fade on entrances, under prefers-reduced-motion.
```

## Speccing workflow

1. **Read the component brief.** Name which UI element animates, why it moves, and on what trigger. If the motion is bespoke physics or a gesture, route to `crew-animation-spring`; if it is a one-off state-driven piece on a single element, route to `crew-animation-motion`; if it is a scroll-driven reveal, route to `crew-animation-scroll-reveal`; if a CSS-only micro-interaction would do with no library, route to `crew-animation-css`. Only proceed when a pre-built primitive is the right call.
2. **Choose the primitive.** Pick from the catalogue (animated button, card, modal, nav or menu, loader, toast, accordion, tabs), or decide it is a signature that needs custom and name the right tool. Confirm a primitive fits before composing.
3. **Spec the motion primitives and the composition.** Name the fade, slide, scale, and rotate the component composes from, and the composition (a modal is overlay-fade plus panel-scale plus focus-trap), with the shared spring preset. Keep it primitives layered, not a prop tree.
4. **Spec the framework mapping.** Pick the path (React with Motion, Vue with Transition, vanilla with CSS or WAAPI), name the headless or native layer that owns focus and keyboard (Radix or React Aria, Headless UI, Reka UI, the native `<dialog>` for inertness, Escape, and dialog ARIA, with focus restore and backdrop-close wired manually and a focus-trap loop only if required), and name the library that ships the primitive, precisely.
5. **Spec the pre-built versus custom call, the performance, and the dependency cost.** Confirm a primitive is the right trade (consistency, correctness, speed) and not a whole-library cost for one component, name the transform-and-opacity rule (and the accordion height exception), and the bundle cost if a library is added.
6. **Spec the accessibility and the reduced-motion path.** Name the focus trap, focus restore, and Escape on any overlay primitive, and the `prefers-reduced-motion` path (decorative loops to static, entrances to fade only).
7. **Write the spec and run the anti-pattern check.** Assemble the animation component spec, and confirm none of the anti-patterns are present (a prop explosion, a missing focus trap, a heavy library for one primitive, a missing exit, no reduced-motion).
8. **Verify before emitting.** Confirm the right primitive is chosen, the component composes from named primitives, only transform and opacity animate (accordion excepted), overlays trap focus, the dependency cost is justified, and the reduced-motion path exists. Only then emit.

## Worked example

The spec as the source skill returned it, the shape a consult answer should take.

```
ANIMATION COMPONENT SPEC
Brief: a settings dialog that opens from a button, plus success toasts and a tabbed body   Trigger: click (dialog), event (toast), click (tabs)   Framework: React+Motion   Built: 2026-06-24   Mode: Careful

Primitive:
- Modal/dialog, toast, and tabs from the catalogue. All pre-built; none is a brand signature.

Motion primitives and composition:
- Dialog: overlay-fade + panel (scale 0.95 to 1, y 8 to 0) + focus-trap + Escape, in AnimatePresence.
- Toast: slide-in from the right (x 24 to 0) + fade + 4s auto-dismiss + exit (reverse); stacked toasts reflow with layout.
- Tabs: a layoutId indicator sliding under the active tab + a 150ms panel cross-fade.
- Preset: snappy (stiffness 300, damping 30) for the panel and indicator; a short tween for the toast fade.

Framework mapping:
- React with Motion for the animation; Radix UI for the Dialog, Tabs, and Toast primitives (focus, keyboard, ARIA, and the aria-live announcement owned by Radix), motion layered on top.
- Library: Radix UI primitives (@radix-ui/react-dialog, @radix-ui/react-tabs, @radix-ui/react-toast) + Motion. The toast uses @radix-ui/react-toast, already in the Radix bundle, so no second toast library.

Pre-built vs custom and dependency cost:
- Pre-built wins: these are standard patterns, used in many places, and Radix solves focus, keyboard, and the toast aria-live region correctly. @radix-ui/react-toast is zero new dependency on this bundle; it brings auto-dismiss, swipe-to-dismiss, Escape, timer-pause-on-hover, and the live-region announcement, with Motion layered for the slide and exit.

Performance and accessibility:
- Only transform and opacity animate. Radix Dialog traps focus, restores it to the trigger on close, and closes on Escape; the tablist is keyboard-navigable; the toast viewport is an aria-live region so a screen reader announces it.
- Reduced-motion: useReducedMotion drops the panel scale and the toast slide, keeping the opacity fade; the tab indicator snaps without the slide.
```

## Guardrails

- Never ship an overlay primitive (modal, dialog, popover, menu) without a focus trap that restores focus on close and an Escape-to-close. The motion is secondary; the focus management is the reason to use a primitive.
- Never ship without a reduced-motion path. Under prefers-reduced-motion, decorative loops drop to a static state and entrances keep only the fade; this floor is mandatory on every primitive.
- Never pull a heavy component library to ship a single primitive. Copy the one component or hand-write it; a library earns its place only when many of its primitives are in use.
- Never animate a layout property (width, height, top, left) where a transform achieves the effect. The accordion height case is the one honest exception, handled by the grid-rows trick or a measured height.
- Never explode a component into an unmaintainable prop tree. Compose small primitives, each owning one concern; name variants as presets, not a prop per case.
- Never ship a toast or modal without an exit, and never invent a component the brief did not call for.
- No AI-slop in the spec: no "make it pop", no filler, no emoji. Exact primitives, presets, libraries, and composition.
- If a project playbook exists (a design system, an approved component library, a motion budget), it is the authority. Follow it over these defaults.

## Pairings and boundaries

- This is the spec build skills read when their animation section calls for a pre-built animated component: any React, Vue, or vanilla UI build that ships a modal, toast, tabset, or animated control. Hand them the animation component spec to implement.
- Pair with `crew-animation-motion` and `crew-animation-spring` on the boundary: this skill picks the primitive and the composition, those own the underlying React motion API (Motion for state-driven work, React Spring for physics) when a primitive needs custom tuning or a signature interaction.
- Route a scroll-driven reveal to `crew-animation-scroll-reveal`, a CSS-only micro-interaction to `crew-animation-css`, an imperative timeline to `crew-animation-gsap`, and a designer-handed motion asset to `crew-animation-lottie`.
- Pair with `crew-design-engineering` for the pixel-level craft of a single primitive (the exact press scale, the focus ring, the modal shadow); this skill owns the catalogue and the composition.

## Verification

Before the spec is marked done, confirm:

```
[ ] A pre-built primitive was confirmed as the right call, not bespoke physics (spring), a one-off state-driven piece (motion), a scroll reveal (scroll-reveal), or CSS-only (css)
[ ] The right primitive from the catalogue is chosen for the pattern, or custom is named with the tool it routes to
[ ] The component composes from named primitives (fade, slide, scale, rotate), not a monolith with a prop explosion
[ ] Only transform and opacity animate, with the accordion height case handled correctly
[ ] Every overlay primitive traps focus, restores it on close, and closes on Escape
[ ] The framework mapping and the named library are correct; no heavy library is pulled for a single primitive
[ ] Toasts and modals have an exit; a toast sits in an aria-live region so it is announced; the same spring presets are shared for consistency
[ ] A reduced-motion path drops decorative loops to static and keeps only the fade on entrances
```
