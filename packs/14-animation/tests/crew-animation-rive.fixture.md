# Fixture: crew-animation-rive

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the output, and that the handoff file was written.

## Case A: clean
INPUT:
Spec an interactive button from a designer's Rive file (Careful mode). Framework: React.
The state machine is "Button State Machine" with a boolean input isHovered, a boolean input isToggled, and a trigger input onClick. It has idle, hover, and pressed states with smooth blend transitions, plus a toggle on/off, and it emits a "clicked" event back to the app. Honor reduced-motion.
EXPECT:
- Output begins with "RIVE ANIMATION SPEC" and includes a Brief line, an Asset line, a Framework line (React), a Built date, and a Mode.
- An "Asset and contract (the names from the editor):" block naming the state machine "Button State Machine", the inputs by type (isHovered boolean, isToggled boolean, onClick trigger), and the "clicked" event.
- An "Implementation:" block with useRive naming the stateMachines (the state machine is run, not just a static timeline) and a stable container size.
- An "Interactivity wiring:" block mapping hover to isHovered.value, the toggle to isToggled.value, and the click to the onClick trigger via fire(), with each input guarded for existence, and the "clicked" event read via rive.on with listener cleanup.
- A "Performance and accessibility:" block with a reduced-motion path that holds a static state, and cleanup (rive.off on unmount).
- No fabricated input or state name beyond what the brief gives; the names match the editor contract.
- No em dashes anywhere in the output.
- Handoff file `.claude/crew-state/animation/crew-animation-rive-handoff.md` was written.

## Case B: wrong-tool
INPUT:
I have a designer's animated logo that just plays once on load, with no interaction, no states, and no input. Should I use Rive for this?
EXPECT:
- The reviewer judges Rive is overkill here: the logo is fixed-timeline playback with no states and no input, so a state-machine engine adds runtime and complexity for nothing, and a fixed-timeline asset is lighter and simpler.
- It routes the request to `crew-animation-lottie` (fixed-timeline designer playback), rather than speccing a Rive state machine.
- It explains the boundary: Rive is for stateful, interactive, or data-bound animations; a play-once asset belongs in Lottie.
- It does not fabricate a state machine, inputs, or events for an animation that has none.
- Handoff file written, recording that Rive was not the right tool and where the request was routed.

## Case C: missing-input
INPUT:
"Add a Rive animation to my app." No .riv file is provided, and no state machine name, inputs, or events are described.
EXPECT:
- The skill follows Loop 1 (Missing Input): it asks once for the Rive (.riv) asset and the names from the editor (the state machine, its inputs and types, any ViewModel properties, and events), because Rive wires a designer-authored state machine and cannot author one.
- It does not invent a state machine, fabricate input names, or assume the interactivity.
- If it emits any partial output, the Asset and the contract fields are marked "Not provided" rather than filled.
- Handoff file `.claude/crew-state/animation/crew-animation-rive-handoff.md` written, recording the missing asset and contract as the blocker the next run needs.
