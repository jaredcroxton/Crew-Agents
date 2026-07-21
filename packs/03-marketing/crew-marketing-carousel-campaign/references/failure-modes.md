# Failure Modes: Carousel Campaign

Every entry here is scar tissue from a real production run. Read this before you fight a bug; the answer is probably already here. Ordered by pipeline stage. Example wording below uses the fictional Saltbrook campaign (date 14.11); substitute your campaign's values.

---

## Stage 1: Hero prompts (Google Flow / Nano Banana Pro)

**Poster-in-a-poster.** The single most common failure. Words like "poster" and "print" in the master style block make Nano Banana render a physical printed poster hanging on a wall, framed, with a drop shadow, occupying ~60% of the frame. It happens on roughly half of runs and it is silent (some heroes escape it, some do not).
*Fix, baked into the bundled prompt pack:* the master block must say "artwork ... full bleed: the artwork itself IS the image, edge to edge. Never render it as a printed poster or card hanging on a wall or lying on a surface; no poster borders, no margins, no mockup presentation, no drop shadow around the artwork."

**Reference-image wording leaks.** When the user attaches a style reference image in Flow, its lettering and its palette bleed into the output (a gold reference turns your lime campaign gold; its headline text appears as garbage). ALWAYS end the TYPE block with the guard line: "ignore all wording in any attached reference image, use only the wording below". Baked into every bundled prompt. Also tell the user NOT to attach the reference for hero 1, generate hero 1 from the prompt alone, then chain it.

**Wrong date / wrong spelling silently.** Nano Banana will render "04.11" instead of "14.11", drop a letter, or lower-case the brand name. This is invisible unless you check. The plate checklist (in the pack's Flow workflow) is mandatory: full bleed, date reads exactly, every word spelled right, brand capitalisation exactly as brand-context writes it. Any miss kills the plate, regenerate, do not ship.

**Chaining brings the whole room with it.** When you attach the winning hero 1 as a reference for heroes 2-6 to hold the grade, a colour-drenched room reference drags its colour onto every subsequent hero (all six come back the same colour). Append the explicit override: "Match the photographic grade, wardrobe, floor style and object design of this poster, but the room colour must follow THIS prompt, not the reference."

**Same face on every hero.** If Flow drifts toward one identity across a campaign family, add "a different person from previous images" to the subject line. (A campaign family is intentionally different people, not one character.)

**Micro-label gibberish.** Small monospace labels come out as alien glyphs. Keep hero text to three elements maximum: kicker, giant headline, subline. Big display type is safe; small labels are not. Anything smaller gets added in the coded body pages, never on the hero.

---

## Stage 2: Plates back, crop to 4:5

**Plates arrive landscape, not portrait.** Flow's "3:4" often returns 2400x1792 landscape (or similar) despite the aspect request. Cropping a landscape plate to 1080x1350 portrait clips the headline (headlines span the full width). DO NOT crop horizontally.
*Fix:* `extend_plates.py` extends the plate VERTICALLY by continuing the plain backdrop, then downscales to exact 1080x1350. No art is touched.

**Extension banding / streaks.** Two wrong ways to extend that both leave visible artefacts:
- Stretching a thin edge STRIP upward leaves streak bands across a flat backdrop.
- Continuing each column at its exact edge colour without smoothing turns per-column JPEG noise into vertical stripes.
*Fix (in `extend_plates.py`):* sample the edge row, resize it down to ~60px then back up (kills high-frequency column noise), NEAREST-stretch that smoothed row, and blend in matched coarse film grain. Seamless on flat walls.

**Subject touches the edge, then smears into the extension.** If a person or floor reaches the bottom edge, extending the bottom stretches their body into a gray column.
*Fix:* fade the last ~110 rows to near-black BEFORE extending (`FADE_BOTTOM`), or ramp the whole extension to black (`RAMP_BOTTOM`). For most product/portrait plates, extend the TOP only (backdrop is clean up there) and leave the bottom as-is.

**A missing family member.** If the user returns fewer plates than carousels (e.g. five concepts when you needed six), generate the gap with KIE `nano-banana` edit, feeding an approved plate as the style reference plus the full "full bleed, no poster mockup" + wording-guard prompt. It matches the family in one shot at ~$0.02. Do NOT send the user back to Flow for one plate. Note: KIE's `nano-banana-pro` model name 422s via the raw jobs API, use `nano-banana` (or seedream for edits).

---

## Stage 2b: Optional 4K quality upgrade (`regen_4k.py` + `text_surgeon.py`)

**Why:** plates generated on plain Nano Banana (not Pro) look flat, no depth of field, weak colour, no skin/fabric texture. `bytedance/seedream-v4-edit` at `image_resolution:4K` re-renders them to 4672x3504 with cinematic grade, identical composition.

**Seedream recomposes when asked to fix text.** seedream paints beautifully but the moment you ask it to fix a label AND keep the framing in one call, it re-zooms, crops the subject, or garbles the text. It failed this way every single time.
*The working pattern is two-step:* (1) ask seedream ONLY to erase the bad text back to clean wall, its strong suit; (2) code-typeset the correct text with `text_surgeon.py` (Helvetica, masked-fill: only glyph pixels replaced, wall = vertical colour lerp of clean rows, hair = clone-from-below). Never ask seedream to fix text and preserve framing in the same call.

**Seedream re-frames on a plain re-render too.** Even a straight "recreate at higher quality" occasionally zooms in and crops a head. Lock it: "keep the exact same framing and camera distance, do not zoom, do not crop; the person's entire head stays fully visible."

**One instruction per seedream call.** Batching several corrections into one prompt fails. One change per call (fix THIS label, or erase THIS line) succeeds.

**Recover pristine outputs from taskId.** If a code-edit pass corrupts a 4K plate, the untouched seedream output is still fetchable from its `taskId` via `recordInfo`, re-download rather than regenerate.

---

## Stage 3: Coded body pages

**Body text is ALWAYS coded, never AI-generated.** AI butchers body paragraphs. The heroes are the only AI images; slides 2/3/4 are HTML rendered by headless Chrome. Non-negotiable.

**Fit JS must run after `document.fonts.ready`.** Auto-fit measures scrollWidth/scrollHeight; before the display font loads those measurements are wrong and headlines overflow. Wrap the entire fit pass in `document.fonts.ready.then(...)`. Set `document.body.dataset.fitted='1'` at the end so the export script can wait on it.

**`.content > * { flex-shrink: 0 }`.** The content column is a flex column. Without flex-shrink:0 the browser squeezes blocks to fit and the layout collapses. Every direct child must refuse to shrink.

**Collision-proofing.** Right-anchored stickers, scrawls and price blocks overlap the body column at certain copy lengths. The fit pass must shrink sticker type until it clears the body, and re-anchor the scrawl under the real body bottom (or park it under the sticker if the column is full). See the fit pass in `body-pages-engine.html`.

**Hero fragment inside a disc/tile shows the plate's baked headline.** When you crop a piece of the finished hero into a circle/tile motif on a body page, a 1:1 crop shows the giant printed type. Zoom the image (`transform: scale(1.8 to 2.4)`) with `transform-origin` at the focus point so you land on the face/object, past the type. Tune each fragment's focus point by eye on the contact sheet.

**Headless export must serve from a running localhost, not file://.** `@font-face` and relative asset paths need an HTTP origin. Serve the project from a /tmp copy on a port, then `chrome --headless --screenshot="...c1p2.png" "http://localhost:PORT/pages.html?page=c1p2"`. `--window-size=1080,1350 --force-device-scale-factor=1 --virtual-time-budget=6000`.

**Review every page visually.** Build a 6x3 contact sheet (PIL) and read it. Common catches: progress dots running under the disc (move dots beside the brand), a fragment crop that caught the plate's kicker text (shift focus y), a headline one notch too big.

---

## Stage 4: Animate heroes (KIE Seedance i2v)

**Model + params (locked):** `bytedance/v1-lite-image-to-video`, `resolution:1080p`, `duration:5`, `camera_fixed:true`, `image_url` (singular). Aspect follows the input image. Endpoints: createTask / recordInfo / file-base64-upload (see `animate_heroes.py`).

**The guard prompt formula.** Seedance vandalises handwriting, sticker glyphs, and product labels, and it changes object shape/size. Every motion prompt is: a hard freeze clause ("Nothing changes shape, nothing new appears, no new writing appears, every letter stays exactly as printed, every face stays perfectly still like a photograph") + THE ONLY MOTION being one existing effect element ("the only motion: [the paint sheen travels once / the chips ripple / the circle brightens once]").

**"Held out to camera" reads as zoom-and-grow.** If a subject holds a labelled object toward the lens, Seedance interprets it as a push-in: the object grows and its label garbles. This failed twice identically on one hero. It is not fixable by prompt.
*Fix:* code-build the motion. `hero_motion_codebuild.py`: frozen plate + a brightness pulse confined to a masked halo around the object (object core excluded) + a diagonal light sheen sweep + live film grain. 125 frames @ 25fps, H.264. Pixel-locked, on-brief, loops.

**Motion verdicts that PASS:** paint sheen travelling along a stroke; particles/chips drifting or rippling; a circle or glow brightening once; a levitating object drifting gently up and down (on-concept for a levitation hero). **Verdicts that FAIL:** a circle that grows instead of pulsing; a laughing/close face that morphs; any object that changes size or whose label garbles; a screen/UI graphic that redraws into a different pattern.

**Frame-check every clip at early/mid/late.** `frame_check.sh` tiles frames 10/60/110 into one contact image per hero. Read all six. A clip can look fine at frame 10 and vandalise by frame 110.

**Retry once on "internal error".** createTask sometimes returns "internal error, please try again later" with no task created (no charge). Retry once after a short sleep (built into `animate_heroes.py`'s `create()`).

**Two-strikes rule.** If a hero fails frame-check twice via Seedance, stop paying for regenerations, build its motion in code from the still. Do not burn a third-plus Seedance credit on a hero Seedance cannot do.

---

## Stage 5: Posting kit

**Mirror the proven folder structure exactly.** One folder per carousel, files named so a non-technical user selects them in order: `0 - CAPTION.txt`, `1 - HERO video (post first).mp4`, `1 - HERO backup image.png`, `2 - slide.png`, `3 - slide.png`, `4 - slide.png`, plus a top-level `READ ME FIRST.txt`. This ordering is why the kit is usable without the chat.

**Caption file carries its own first comment.** Each `0 - CAPTION.txt` ends with `--- FIRST COMMENT (post right after publishing):` and the line with the `[BOOKING LINK]` placeholder. The READ ME says replace the placeholder once the event page is live.

**Build kit is re-runnable.** `build_kit.py` copies statics every run and adds hero videos only when the mp4s exist (>100kB). Safe to run before animation finishes (ships backup-image-only), then again after.

---

## Gallery (optional review deliverable)

**Do not autoplay many videos at once.** 18 hero `<video>` elements auto-playing on scroll froze the preview renderer (30s timeouts, black frames). Show POSTER stills in the strips with a "LIVE" badge; play the video only in a lightbox on click. Lighter, faster, screenshot-safe.

**Web-size the stills.** 72 full-res PNGs make the page heavy. `build_gallery.py` re-encodes each still to ~864px JPEG q85. Videos copied as-is.

**In-app preview pane blacks out on deep programmatic scroll.** Screenshots after a JS `scrollTo` to a deep offset (or a mid-page `#anchor`) come back pure black even though the DOM is correct and all images decoded, a compositor quirk of the in-app browser, NOT a page bug. Verify deep sections with a full-page headless-Chrome capture (`--window-size=WIDTH,FULL_HEIGHT --screenshot`) instead. Shallow anchors near the top render fine.
