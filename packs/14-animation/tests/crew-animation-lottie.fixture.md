# Fixture: crew-animation-lottie

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the output, and that the handoff file was written.

## Case A: clean
INPUT:
Spec a hero logo reveal from a designer's After Effects export (Careful mode). Framework: vanilla, with a React variant.
It is an animated logo that should play once on load and then hold on the final frame, render crisply, lazy-load if below the fold, and respect reduced-motion. Keep the file light.
EXPECT:
- Output begins with "LOTTIE ANIMATION SPEC" and includes a Brief line, an Asset line, a Framework line, a Built date, and a Mode.
- An "Asset:" block specifying the file ships as dotLottie (preferred over raw JSON), bundled or self-hosted, with a size budget.
- A "Player and renderer:" block naming a player (dotLottie-web for vanilla, DotLottieReact for React) and a renderer choice with a stable container size to avoid layout shift.
- An "Implementation:" block with autoplay false and loop false, playing once on load (or in-view) and holding on the complete event.
- A "Performance, export, and accessibility:" block with lazy-load via an IntersectionObserver, After Effects export notes (simplify paths, shape layers, what does not survive export such as glows), cleanup (destroy and remove listeners on unmount), and a reduced-motion path showing a static frame.
- The animation does not autoplay-and-loop by default.
- No em dashes anywhere in the output.
- Handoff file `~/.claude/crew-state/animation/crew-animation-lottie-handoff.md` was written.

## Case B: wrong-tool
INPUT:
I want a card to slide in and fade when it mounts in my React app. Should I use Lottie for this?
EXPECT:
- The reviewer judges Lottie is the wrong tool here: there is no designer-made After Effects asset, and a slide-in plus fade on mount is a code-authored UI transition that is cheaper and more flexible in a React animation library (Motion variants or whileInView) than shipping a JSON file.
- It routes the request to `crew-animation-motion` (a React-state, code-authored transition), rather than speccing a Lottie integration.
- It explains the boundary: Lottie renders designer-made vector animations shipped as a file; code-authored UI motion belongs in Motion, GSAP, or Anime.
- It does not fabricate a Lottie asset or invent a JSON file for a code-driven transition.
- Handoff file written, recording that Lottie was not the right tool and where the request was routed.

## Case C: missing-input
INPUT:
"Add a Lottie animation to my page." No asset is provided and no description of what the animation should depict or when it should play.
EXPECT:
- The skill follows Loop 1 (Missing Input): it asks once for the animation asset (the After Effects JSON or dotLottie file, or a description of what it should depict) and the trigger, because Lottie renders an asset and cannot author one.
- It does not invent an animation file, fabricate a spec, or assume a depiction or a trigger.
- If it emits any partial output, the Asset and Implementation fields are marked "Not provided" rather than filled.
- Handoff file `~/.claude/crew-state/animation/crew-animation-lottie-handoff.md` written, recording the missing asset as the blocker the next run needs.
