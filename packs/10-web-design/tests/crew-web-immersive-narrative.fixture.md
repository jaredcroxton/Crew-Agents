# Fixture: crew-web-immersive-narrative

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the behaviour and output, and that the handoff file was written.

## Case A: clean
INPUT:
Programme: New Hire Voyage. Metaphor: a ship voyage. Audience: new crew on their first week.
Stages: 5 (Cast Off, Open Water, The Reckoning, Landfall, The Harbour), with subtitles, summaries,
and an action verb each supplied. Palette: brass plus parchment plus dark navy, classical, Georgia serif.
Persistent UI: a compass rose plus a five-port progress track. Deploy: Vercel preview link.
Source MP4 plus JPEG per stage are in ~/Desktop/new-hire-voyage/.
EXPECT:
- Skill runs Step 0 Context Recovery and states recovered context or "No prior context, first run."
- Discovery is confirmed back in one paragraph before any code; the theme is the user's ship voyage, not invented.
- Output begins with the literal line "SCROLL JOURNEY OUTPUT".
- The report carries the theme, the five stages, the scroll-math constants (STAGE_HEIGHT_VH 320 / VIDEO_ZONE_END 0.7 / CROSSFADE_RATIO 0.1), the two-state gating line, the arrival hero, and the compass-rose persistent UI.
- The two-state gate is built: mark-complete and advance are two separate clicks, and unlockedStageCount resolves to advancedStageCount in production, not stageCount.
- localStorage keys are namespaced per programme (new_hire_voyage_v1_completion and new_hire_voyage_v1_advancement).
- The Design review gate is run against crew-design-quality, crew-design-composition, crew-design-patterns, crew-animation-gsap, and crew-animation-locomotive, with Criticals and Majors fixed before deploy.
- A reduced-motion path is present and confirmed: the scrub snaps to the arrival frame and reveals are instant, and the story still reads.
- No em dashes anywhere in the output.
- Handoff file `~/.claude/crew-state/web-design/crew-web-immersive-narrative-handoff.md` was written.

## Case B: wrong-tool
INPUT:
"I want a single cinematic camera fly-through from deep space down to a penthouse interior. No stages,
no story copy, no learning, just one continuous descent that scrubs as I scroll and lands on the room."
EXPECT:
- Skill recognises the brief is a pure camera fly-through with no narrative stages and no story copy.
- It routes to crew-web-fly-through-builder and explains the boundary: Immersive Narrative is for a multi-stage narrative told through a metaphor, where each stage is completed and advanced past, gated as a story; a single continuous descent with no stages belongs in the fly-through builder.
- It does NOT scaffold a journey, does NOT ask the ten-question discovery brief, and does NOT extract frames.
- No SCROLL JOURNEY OUTPUT report is produced for a journey that was not built.
- Handoff file written, recording that the request was routed to crew-web-fly-through-builder and why.

## Case C: missing-input
INPUT:
"Build me a scroll site." No theme, no stages, no audience, no palette, no deploy target.
EXPECT:
- Skill follows Loop 1 Missing Input: it does NOT invent a theme, does NOT pick a metaphor, and does NOT scaffold.
- It asks once for the ten-question discovery brief (programme name, metaphor, audience, stage count, stage names and copy, visual register, persistent-UI motif, asset folder, deploy target).
- It states it will confirm the journey back in one paragraph before any code, once the brief is answered.
- Handoff file written, recording the missing discovery brief as the blocker the next run needs, with no theme assumed.
