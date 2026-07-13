# Fixture: crew-web-immersive-narrative

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the behaviour and output, and that the handoff file was written.

## Case A: clean
INPUT:
Programme: New Hire Voyage. Metaphor: a ship voyage. Audience: new crew on their first week.
Stages: 5 (Cast Off, Open Water, The Reckoning, Landfall, The Harbour), with subtitles, summaries,
and an action verb each supplied. Palette: brass plus parchment plus dark navy, classical serif register.
Persistent UI: a compass rose plus a five-port progress track. Deploy: Vercel preview link.
Destination: induction course. Asset route: source MP4 plus JPEG per stage are in ~/Desktop/new-hire-voyage/.
EXPECT:
- Skill runs Step 0 Context Recovery and states recovered context or "No prior record in this project for this skill."
- Discovery is confirmed back in one paragraph before any code; the theme is the user's ship voyage, not invented.
- Output begins with the literal line "SCROLL JOURNEY OUTPUT".
- The report carries the theme, the five stages, the scroll-math constants (STAGE_HEIGHT_VH 320 / VIDEO_ZONE_END 0.7 / CROSSFADE_RATIO 0.1), the two-state gating line, the arrival hero, and the compass-rose persistent UI.
- The two-state gate is built: mark-complete and advance are two separate clicks, and unlockedStageCount resolves to advancedStageCount in production, not stageCount.
- localStorage keys are namespaced per programme (new_hire_voyage_v1_completion and new_hire_voyage_v1_advancement).
- Frames extract in two rungs (1920 and 960) as WebP with JPEG fallback, budget-checked against the web-standards Perf 1 class C limits; the report carries a Weight line and a "web-standards Gate:" verdict line.
- The stage opens poster-first: no loading counter is the first impression, and the next stage prefetches on idle.
- The Design review gate is run with binding verdicts from crew-design-quality, crew-design-composition, crew-design-patterns, crew-design-engineering, and the register-conditional pack-13 lens, Criticals and Majors fixed before deploy; crew-animation-gsap and crew-animation-locomotive are applied as authoring references only, with no Pass or Fail verdict attributed to them.
- A reduced-motion path is present and confirmed: the scrub snaps to the arrival frame and reveals are instant, and the story still reads.
- No em dashes anywhere in the output.
- Handoff file `~/.claude/crew-state/projects/<project>/crew-web-immersive-narrative-handoff.md` was written.

## Case B: messy
INPUT:
"Build the onboarding journey. Theme is a mountain climb. Four stages, I think: Base Camp, First Climb,
Ridge Line, Storm Zone, Summit, Descent. I only have MP4 plus JPEG for the first three. No subtitles or
summaries written yet, just draft something that fits, and feel free to spice the theme up however you like.
Also make it advance automatically when they finish a stage so it flows."
EXPECT:
- Skill flags the contradiction (four stages claimed, six names listed) and asks once or confirms the resolved list back before any code; it does not silently pick a count.
- The metaphor stays the user's mountain climb: subtitles and summaries may be drafted from the theme plus programme name (Q6 allows this), but no new theme twist is invented and the drafts are confirmed back.
- Asset-less stages get pending placeholder manifest entries (frameCount 0, pending true) so they hold their 320vh band, and ship the honest "Content coming" stub, never fake-real placeholder content.
- The auto-advance request is refused with the reason: mark-complete and advance are two separate clicks, the pacing engine of the build; the skill offers the fluid scroll-through gate only as the documented destination-based alternative, stated, not silently applied.
- Output begins with "SCROLL JOURNEY OUTPUT" and the open items (three stages awaiting assets and copy) appear under Open / handed off.
- Handoff file `~/.claude/crew-state/projects/<project>/crew-web-immersive-narrative-handoff.md` was written with the unresolved items named.

## Case C: missing-input
INPUT:
"Build me a scroll site." No theme, no stages, no audience, no palette, no deploy target.
EXPECT:
- Skill follows Loop 1 Missing Input: it does NOT invent a theme, does NOT pick a metaphor, and does NOT scaffold.
- It asks once for the twelve-question discovery brief (programme name, metaphor, audience, stage count, stage names and copy, visual register, persistent-UI motif, asset folder, deploy target, asset creation route, destination).
- It states it will confirm the journey back in one paragraph before any code, once the brief is answered.
- Handoff file `~/.claude/crew-state/projects/<project>/crew-web-immersive-narrative-handoff.md` written with STATUS: BLOCKED, recording the missing discovery brief as the blocker the next run needs, with no theme assumed.
