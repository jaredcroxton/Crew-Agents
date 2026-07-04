# Fixture: crew-web-learning-experience

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the behaviour and output, and that the handoff file was written. All businesses are fictional.

## Case A: clean
INPUT:
Roastline Coffee Co., a fictional five-cafe group, hands over the complete training chain for its
barista onboarding programme: a signed-off module outline, a full facilitator guide with scripted
say/do/ask sections and timings, and a learner workbook with page numbers. Five modules: Bean to
Cup, The Machine, Milk Craft, Service Flow, Closing the Bar. Theme metaphor chosen: the journey of
a single coffee order through the cafe. Brand context exists. Media folder ready at
~/Desktop/roastline-onboarding/media/ with a clip per module. Mode: dual (projector plus laptop).
Deploy: Vercel preview link.
EXPECT:
- Skill runs Step 0 Context Recovery and states recovered context or "No prior context, first run."
- Skill confirms the chain outputs exist before building; it activates the finished programme and writes no training content of its own.
- A course.json manifest is generated with exactly one themed stage per module, five stages total, each carrying idx, module title, learning goal, the verbatim objectives array, journey copy with the themed stage name (journeyCopy.stageName, the arrival headline, with the module title as eyebrow), presenter notes, checkpoint prompts, media slots, and a workbook page ref.
- Presenter notes (say / do / ask, timings, activity setup) are lifted from the facilitator guide's scripted sections, not invented.
- Checkpoint prompts are facilitator-led discussion questions; no scored quiz, no scoring database, no learner accounts, no progress tracking appears anywhere.
- Both views are planned and built: the fullscreen audience journey and the presenter view with current-stage say/do/ask, timings, workbook cue, the per-stage elapsed timer, next-stage preview, and the presenter-only controls (checkpoint run, advance, activity, back one stage, and the confirm-guarded restart session).
- The gate is driven by the presenter: document height stays bound to unlockedStageCount and only the presenter advances, so the room can never scroll ahead of the trainer. Both solo (keypress drawer) and dual (state-carrying BroadcastChannel sync with a HELLO/SYNC handshake across two same-origin tabs, normalized scroll progress driving the audience tab, audience input locked with overflow hidden plus preventDefault) modes are verified.
- Media slots map to media/stage-N/ folders with the supplied clips, each stage resolving a hero still (supplied, or promoted from the last extracted frame); no upload server, no cloud storage.
- Output begins with the literal line "LEARNING EXPERIENCE PLAN".
- The Design review gate is run with a binding verdict from crew-design-quality, and Criticals and Majors are fixed before deploy.
- No em dashes anywhere in the output.
- Handoff file `~/.claude/crew-state/web-design/crew-web-learning-experience-handoff.md` was written, naming the upstream artifacts consumed (the module outline, the facilitator guide, and the workbook).

## Case B: messy
INPUT:
Fernwood Garden Centres, a fictional plant retail chain, wants its four-module "seasonal team
onboarding" turned into a presented online journey. Only a module outline exists. There is no
facilitator guide. Two of the four modules have titles but no learning objectives. A theme metaphor
(a season turning from planting to harvest) and brand context are supplied.
EXPECT:
- Skill proceeds with what is real: it builds the manifest skeleton and stage structure from the outline.
- Presenter notes for every stage are explicitly marked as "guide needed, not invented"; no say/do/ask content, timings, or activity setups are fabricated.
- The missing facilitator guide is routed back upstream to crew-training-facilitator-guide-creator as the named gap, since this skill activates finished content and does not write it.
- The two modules without objectives are flagged as thin; their arrival panels are marked incomplete rather than filled with invented objectives.
- No checkpoint prompts are invented for stages that have no guide content to draw from.
- The handoff records the skeleton state, the two thin modules, and the facilitator guide as the blocker the next run needs.
- No em dashes anywhere in the output.
- Handoff file `~/.claude/crew-state/web-design/crew-web-learning-experience-handoff.md` was written.

## Case C: missing-input
INPUT:
"Make our training an online journey." No module outline, no facilitator guide, no workbook, no
theme, no media, no brand context, nothing.
EXPECT:
- If no brand context exists, the brand hard gate fires first and the skill does not proceed past Step 0 without it.
- Skill follows Loop 1 Missing Input: it does NOT invent modules, objectives, activities, or facts, and does NOT scaffold a journey.
- It asks once for the chain outputs (the module outline and facilitator guide, plus the optional learner workbook, or any markdown matching their shape) along with the theme metaphor, media folder or "generate prompts", mode, and deploy target.
- It routes content creation to the training pack: the programme must be written by crew-training-module-outline-builder and crew-training-facilitator-guide-creator before this skill can activate it.
- The BLOCKED handoff is written BEFORE pausing for the answer, recording the missing chain outputs as the blocker, with nothing assumed.
- No LEARNING EXPERIENCE PLAN report is produced for a journey that was not built.
- Handoff file `~/.claude/crew-state/web-design/crew-web-learning-experience-handoff.md` was written with STATUS: BLOCKED.
