# Fixture: crew-web-learning-experience

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the behaviour and output, and that the handoff file was written. All businesses are fictional.

## Case A: clean
INPUT:
Roastline Coffee Co., a fictional five-cafe group, hands over the complete training chain for its
barista onboarding programme: a signed-off module outline, a full facilitator guide with a
minute-by-minute run-of-show (scripted say/do/ask segments, activities with setup and debrief,
check questions, timings on every segment), and a learner workbook with page numbers. Five
modules: Bean to Cup, The Machine, Milk Craft, Service Flow, Closing the Bar. Theme metaphor
chosen: the journey of a single coffee order through the cafe. Brand context exists. Media folder
ready at ~/Desktop/roastline-onboarding/media/ with a clip per module. Mode: dual (projector plus
laptop). Deploy: Vercel preview link.
EXPECT:
- Skill runs Step 0 Context Recovery and states recovered context or "No prior context, first run."
- Skill confirms the chain outputs exist before building; it activates the finished programme and writes no training content of its own.
- A course.json manifest is generated on the block spine: programme -> modules -> steps -> blocks[]. A step is one screen. Every block is one of the typed union (heading, text, script, whiteboard, discussion, media, split); each module carries its themed stage name and its verbatim objectives[] rendered in the module opener; each step carries presenter notes (say / do / ask with timings) and a workbook page cue where the workbook maps one.
- Full-guide coverage is proven: every run-of-show segment in the facilitator guide became a step, every objective appears in its module opener, every timing feeds the presenter view's session clock, and a complete coverage table (guide segment -> step) is produced. No segment is dropped; a gap would be a build failure. The whole workshop is mapped, not a highlight reel.
- The visual register holds: content steps are calm editorial slides (generous white space, large disciplined type, exactly one accent from the brand tokens, background imagery at 10 percent presence or less, no wall-to-wall photography, no colour noise); the cinematic moment (the frame-scrub or a themed hero, about five seconds of arrival) appears ONLY at module openers. A content step would pass for a premium keynote slide, never for a film poster.
- The engine matches v2: Vite plus React 18; content steps are DOM slides advanced by the presenter through the block renderer; the rAF canvas frame-scrub exists only at module openers; content-step motion is restrained deck style (CSS keyframes plus element.animate() plus IntersectionObserver one-shot reveals, transform and opacity only); no GSAP, no Motion, no Locomotive, no animation library anywhere; reduced-motion collapses openers to their arrival still.
- Edit mode ships as a first-class feature, presenter-side only: a keypress (E) or a visible edit affordance opens a sidebar listing the full sequence (modules -> steps -> blocks); any block's text edits inline; a media block accepts a pasted URL; steps can be added, removed, and reordered; edits persist to localStorage immediately and export/import as course.json, the live data file the app reads and writes. No backend, no save server. Edit mode never appears in the audience view. Boot precedence is explicit: on load the renderer reads the edited course key if present and only seeds it from the bundled course.json when absent, so a redeploy never silently discards edits.
- Whiteboard blocks render a live type-into capture surface on the audience screen: answers typed in live build the list in front of the room, persist as typed (localStorage keyed by session plus step), and are included in the session-notes export.
- Discussion blocks render the checkpoint question large, facilitator-led, never scored; no quiz, no answer marking, no learner accounts, no completion writes, no gating, no persistence beyond the local session.
- The "export session notes" action is built and produces a rendered file of the room's captured whiteboard and discussion answers per module, held to the crew-design-documents standard, never raw markdown.
- The gate stays the facilitator's clicker: only the presenter layer advances steps, the audience can never move ahead of the trainer, and both solo (keypress drawer) and dual (two same-origin tabs over BroadcastChannel, audience input locked) modes are verified; the presenter view (say / do / ask with timings, the session clock, next-step preview) is present and driven from the guide. In dual mode a committed edit replicates to the audience tab as a COURSE message carrying the full manifest (posted on block blur or commit, never per keystroke), and the SYNC reply carries the course, so the wall updates without a reload and a late-joining tab converges onto the edited course.
- Presenter notes are lifted from the facilitator guide's scripted sections, not invented.
- Output begins with the literal line "LEARNING EXPERIENCE PLAN".
- The Design review gate is run with a binding verdict from crew-design-quality, and Criticals and Majors are fixed before deploy.
- No em dashes anywhere in the output.
- Handoff file `~/.claude/crew-state/web-design/crew-web-learning-experience-handoff.md` was written, naming the upstream artifacts consumed (the module outline, the facilitator guide, and the workbook).

## Case B: messy
INPUT:
Fernwood Garden Centres, a fictional plant retail chain, wants its four-module "seasonal team
onboarding" turned into a facilitator-presented deck journey. The module outline and the
facilitator guide both exist and are signed off, but the guide is imperfect: three run-of-show
segments carry no timings, and one module (Winter Care) has scripted say/do/ask sections but no
activities at all. A theme metaphor (a season turning from planting to harvest) and brand context
are supplied. No learner workbook.
EXPECT:
- Skill proceeds with what is real: the full block-spine manifest is built from the outline and the guide.
- The coverage table is still complete: every run-of-show segment, including the three without timings, became a step; no segment is dropped or merged to hide the gaps.
- The three timing-less segments are marked "timing needed" in the presenter view and the session clock rather than given invented minutes.
- The activity-less Winter Care module is flagged back to crew-training-facilitator-guide-creator as the named gap; its steps carry no fabricated activity content, since this skill activates finished content and does not write it.
- Nothing is fabricated: no say/do/ask line, timing, activity, objective, or fact is invented anywhere; a field with no source reads "Not provided".
- Workbook cues are absent, because no workbook was provided.
- The handoff records the gaps (three missing timings, the activity-less module) and names the facilitator guide skill as the routing target for the next run.
- No em dashes anywhere in the output.
- Handoff file `~/.claude/crew-state/web-design/crew-web-learning-experience-handoff.md` was written.

## Case C: missing-input
INPUT:
"Make our training an online journey." No module outline, no facilitator guide, no workbook, no
theme, no media, no brand context, nothing.
EXPECT:
- If no brand context exists, the brand hard gate fires first and the skill does not proceed past Step 0 without it.
- Skill follows Loop 1 Missing Input: it does NOT invent modules, objectives, activities, steps, or facts, and does NOT scaffold a deck.
- It asks once for the chain outputs (the module outline and facilitator guide, plus the optional learner workbook, or any markdown matching their shape) along with the theme metaphor, media folder or "generate prompts", mode, and deploy target.
- It routes content creation to the training pack: the programme must be written by crew-training-module-outline-builder and crew-training-facilitator-guide-creator before this skill can activate it.
- The BLOCKED handoff is written BEFORE pausing for the answer, recording the missing chain outputs as the blocker, with nothing assumed.
- No LEARNING EXPERIENCE PLAN report is produced for a build that did not happen.
- Handoff file `~/.claude/crew-state/web-design/crew-web-learning-experience-handoff.md` was written with STATUS: BLOCKED.
