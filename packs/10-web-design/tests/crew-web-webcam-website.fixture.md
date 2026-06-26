# Fixture: crew-web-webcam-website

Three cases that exercise the skill: a clean webcam-website build, a wrong-tool routing case, and a vague brief missing the discovery answers. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the behaviour and output, and that the handoff file was written.

## Case A: clean

**Input.**

> Build me a booth-activation kiosk for a conference stand. A visitor uploads their portrait (it is saved at uploads/visitor.png), and on closing their fist the portrait crumples into a paper ball, opening the hand restores it. Papercraft cutout style, warm ivory booth palette with a lime accent, full-screen kiosk. Deploy to a Vercel preview after a live test. Careful mode.

**Expect.**

- Step 0 reads `.claude/crew-state/web-design/crew-web-webcam-website-handoff.md` and states what was recovered (or "No prior context, first run").
- The discovery answers are captured and confirmed back in one paragraph before any code: the subject is the uploaded visitor portrait at uploads/visitor.png, the theme is papercraft cutout in a warm ivory and lime palette, the transformation verb is crumple to a paper ball (reversible), the layout mode is kiosk, and the deploy is a Vercel preview after a live test. The subject and verb are the user's, not invented.
- The locked asset pipeline runs in order: the uploaded image is normalized to PNG, then the nano banana subject edit on green is run (model nano-banana, aspect 1:1, the prompt template filled with the papercraft subject and the flat #00FF00 background), the result is READ and confirmed (likeness kept, green flat, no green on the subject).
- The Veo3 transformation video is generated off the public subject URL (model veo3, 16:9), carrying the same subject and style and background words, with the crumple verb phrase from the transformation library, then polled for the render.
- The green key and frame extraction run: a contact strip finds the true motion window (Veo pads a lead-in and reverses the tail), and exactly 48 frames are extracted and named frame_000.jpg to frame_047.jpg under assets/frames/.
- The single-file site is built from the locked template with only the marked slots substituted (title, MODE kiosk, hint, FRAME_COUNT 48, OBJECT_FRAC, OBJECT_MAX, poster image and copy, brand tokens), and the camera lifecycle, the gesture math, the no-camera fallback, the reduced-motion branch, and the green keyer are left intact.
- The camera lifecycle is present and real: getUserMedia runs only inside the activate click (the poster and a "Try it" consent affordance show first), and stopCamera stops every track on pagehide and beforeunload, with no recording and no upload of the feed.
- The gesture scrub is present: hand openness is a 1D dial that maps an open hand to state A and a full fist to state B across the 48 frames, reversible, with the position and frame lerps smoothing it.
- The no-camera / permission-denied fallback is present: a denied or absent camera routes to a manual scrub slider that plays the same crumple, not a black box.
- The reduced-motion path is present: matchMedia('(prefers-reduced-motion: reduce)') holds the subject static at the flat state, no autoplay or idle wobble, only a deliberate fist or the slider scrubs it.
- The build is verified camera-free (camera is headless-blocked): window.__pf.preload() loads and keys the frames, frames 0/16/32/47 render clean (background transparent, no green fringe, final frame fully crumpled), the fallback renders, and the live hand test is flagged as the one manual leg.
- The build report begins with the exact line `WEBCAM WEBSITE OUTPUT`.
- The Design review gate is run: `crew-design-quality` as the binding verdict (including the binding Motion dimension), `crew-design-composition` (the eye resolves to the single floating subject), `crew-design-patterns`, a register-conditional pack-13 style lens (here `crew-design-soft` for the warm premium register), with `crew-animation-gsap` and `crew-animation-motion` consulted as authoring references only (they emit a STATUS, not a Pass or Fail), Criticals and Majors fixed, a fail blocking the ship.
- No em dashes anywhere in the output.
- Handoff file `.claude/crew-state/web-design/crew-web-webcam-website-handoff.md` was written.

## Case B: wrong-tool

**Input.**

> I want a scroll site that tells our five-stage company story as the visitor scrolls down the page, one stage at a time.

**Expect.**

- The skill recognises this is a multi-stage narrative told through scrolling, not a camera hand-tracking gesture-scrub experience.
- It routes to `crew-web-scroll-journey` and explains the boundary: Webcam Website builds a camera gesture experience where the visitor's open palm moves an AI-generated subject and closing the fist scrubs a generated transformation, while a five-stage story that reveals as the visitor scrolls is exactly what Scroll Journey is for.
- It does NOT scaffold a webcam-website project, does NOT run the nano banana plus Veo3 plus green-screen plus frame pipeline, and does NOT access the camera.
- It explains it builds a camera gesture experience, not a scroll narrative.
- No `WEBCAM WEBSITE OUTPUT` report is produced for an experience that was not built.
- No em dashes anywhere.
- Handoff file written, recording that the request was routed to the scroll-journey builder and why.

## Case C: missing-input

**Input.**

> Make me a webcam thing.

**Expect.**

- Loop 1, Missing Input. The skill does NOT invent a subject, does NOT pick a transformation verb, does NOT pick a layout mode, and does NOT scaffold or run the pipeline.
- It asks once for the discovery questions: the one uploaded image (the subject), the theme or style, the A-to-B transformation verb, and the layout mode (kiosk or embedded).
- It invents no subject and no verb; it does not run the generation pipeline on a guess.
- It states it will draft the nano banana subject prompt and the Veo3 transformation prompt and confirm them once the brief is answered.
- Handoff file `.claude/crew-state/web-design/crew-web-webcam-website-handoff.md` written, recording the missing discovery answers (the image, the theme, the transformation, the layout mode) as the blocker the next run needs, with nothing assumed.
