# Fixture: crew-web-webcam-website

Three cases that exercise the skill: a clean webcam-website build, a messy contradictory brief the skill has to cope with, and a vague brief missing the blocking discovery answers. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the behaviour and output, and that the handoff file was written. State root is `~/.claude/crew-state/`; project records live under `~/.claude/crew-state/projects/<project>/`.

## Case A: clean

**Input.**

> Build me a booth-activation kiosk for a conference stand. A visitor uploads their portrait (it is saved at uploads/visitor.png), and on closing their fist the portrait crumples into a paper ball, opening the hand restores it. Papercraft cutout style, warm ivory booth palette with a lime accent, full-screen kiosk. The venue wifi is unreliable. Deploy to a Vercel preview after a live test. Careful mode.

**Expect.**

- Step 0 Context Recovery runs first: it reads `~/.claude/crew-state/brand-context.md` (the hard gate passes silently because the brand is onboarded), settles the project, then reads ONLY this skill's own record at `~/.claude/crew-state/projects/<project>/crew-web-webcam-website-handoff.md` and states what was recovered (or "No prior record in this project for this skill").
- The seven discovery answers are captured and confirmed back in one paragraph before any code: the subject is the uploaded visitor portrait at uploads/visitor.png, the theme is papercraft cutout in a warm ivory and lime palette, the transformation verb is crumple to a paper ball (reversible), the layout mode is kiosk, the deploy is a Vercel preview after a live test, and the unreliable venue wifi means the MediaPipe model is VENDORED into assets/vendor/ (not CDN). The subject and verb are the user's, not invented.
- The locked asset pipeline runs in order: the uploaded image is normalized to PNG, then the nano banana subject edit on green is run (model nano-banana not nano-banana-pro, aspect 1:1, the prompt template filled with the papercraft subject and the flat #00FF00 background), the result is READ and confirmed (likeness kept, green flat, no green on the subject).
- The Veo3 transformation video is generated off the public subject URL (model veo3, 16:9), carrying the same subject and style and background words, with the crumple verb phrase from the transformation library, then polled for the render.
- The green key and frame extraction run: a contact strip finds the true motion window (Veo pads a lead-in and reverses the tail), and exactly 48 frames are extracted as WebP and named frame_000.webp to frame_047.webp under assets/frames/ (JPEG only if no WebP encoder, recorded as a Gate 7 residual). The poster still is compressed to a WebP under 100KB.
- The single-file site is built from the locked template with only the marked slots substituted (title, MODE kiosk, VENDOR_BASE assets/vendor/, hint, FRAME_COUNT 48, OBJECT_FRAC, OBJECT_MAX, the poster image and POSTER_ALT, the brand tokens including accent-ink, the type slots, and the head hygiene meta/OG/favicon), and the engine (camera lifecycle, gesture math, the no-camera fallback, the reduced-motion branch, the kiosk idle reset, and the green keyer) is left intact.
- The camera lifecycle is present and real: getUserMedia runs only inside the activate click (the poster and a "Try it" consent affordance show first), stopCamera stops every track on pagehide and beforeunload, the kiosk auto-deactivates to the attract poster after KIOSK_IDLE_RESET with the camera off, and the feed is never recorded or uploaded.
- The gesture scrub is present: hand openness is a 1D dial that maps an open hand to state A and a full fist to state B across the 48 frames, reversible, with the position and frame lerps smoothing it.
- The no-camera / permission-denied / model-load-failure fallback is present: a denied or absent camera, or a timed-out model load, routes to a manual scrub slider that plays the same crumple, never a black box, and activate never hangs.
- The reduced-motion path is present in BOTH the JS and the CSS: matchMedia('(prefers-reduced-motion: reduce)') holds the subject static, and the @media (prefers-reduced-motion: reduce) block gates the poster float, the kiosk CTA pulse, and smooth scroll.
- The build is verified camera-free against the web-standards Verification Gate (camera is headless-blocked): served over HTTP from a /tmp copy, window.__pf.preload() loads and keys the frames, frames 0/16/32/47 render clean (background transparent, no green fringe, final frame fully crumpled), the fallback renders, screenshots at desktop and 375px show nothing clipped, the console is read for zero errors, and the live hand test is flagged as the one manual leg.
- The build report begins with the exact line `WEBCAM WEBSITE OUTPUT`.
- The Design review gate is run: `crew-design-quality` (binding), `crew-design-engineering` (binding, the pixel-and-easing leg), `crew-design-composition`, `crew-design-patterns`, a register-conditional pack-13 style lens (here `crew-design-soft` for the warm premium register), with `crew-animation-css` / `crew-animation-scroll-reveal` / `crew-animation-view-transitions` (and gsap / motion for the scrub feel) consulted as authoring references only, Criticals and Majors fixed, a fail blocking the ship. Each leg is invoked with the `CREW CONSULT from crew-web-webcam-website:` preamble.
- No em dashes anywhere in the output.
- Handoff file `~/.claude/crew-state/projects/<project>/crew-web-webcam-website-handoff.md` was written, opening with the `# crew-web-webcam-website handoff` title line, a `Date:` line, and a `STATUS:` line.

## Case B: messy

**Input.**

> Make a booth thing that crumples our logo. The logo is pasted right here in the chat. Put it in our website as a full-screen kiosk.

**Expect.**

- The skill flags that a chat-pasted image is not on disk and asks the user to save the logo to a folder first (it may check the Downloads folder by recency); it does NOT invent or fabricate the subject, and it does not run the generation pipeline on a guess.
- The skill surfaces the mode contradiction ("in our website" is embedded, "full-screen kiosk" is kiosk) rather than silently picking one: it produces a short Decision brief (kiosk versus embedded) and asks or makes the conservative call, marking any assumed value as "Assumed".
- It fills sensible defaults from the theme (papercraft cutout as the default look) and confirms the one-paragraph summary back before building; nothing about the brand, the copy, or a price is fabricated.
- The transformation verb (crumple) is taken from the user's "crumples our logo", not invented; the engine stays locked when the build proceeds.
- No em dashes anywhere.
- Handoff file `~/.claude/crew-state/projects/<project>/crew-web-webcam-website-handoff.md` was written, carrying the open items forward (the logo not yet on disk, the kiosk-versus-embedded mode to confirm) as unfinished work.

## Case C: missing-input

**Input.**

> Make me a webcam thing.

**Expect.**

- Loop 1, Missing Input. The skill does NOT invent a subject, does NOT pick a transformation verb, does NOT pick a layout mode, and does NOT scaffold or run the pipeline.
- It asks once for the discovery answers: the one uploaded image (the subject), the theme or style, the A-to-B transformation verb, the layout mode (kiosk or embedded), and (for kiosk) the hardware and venue-wifi reliability.
- It invents no subject and no verb; it does not run the generation pipeline on a guess.
- It states it will draft the nano banana subject prompt and the Veo3 transformation prompt and confirm them once the brief is answered.
- Handoff file `~/.claude/crew-state/projects/<project>/crew-web-webcam-website-handoff.md` was written FIRST (a Loop 1 pause counts as finishing for the Context Loop), with STATUS: BLOCKED and the missing discovery answers (the image, the theme, the transformation, the layout mode) named as the blocker the next run needs, with nothing assumed.
