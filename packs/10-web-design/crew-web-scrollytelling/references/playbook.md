# The Scroll-Film Playbook (Lane B, cinematic footage)

Hard-won rules for making the whole page one continuous generated film. These are a floor, not a ceiling: break them knowingly, never by accident. The KIE route is primary for CREW builds (section 4); the Higgsfield route is the documented alternative (section 5); any image-to-video engine that accepts a start image runs the same chain contract with only the generate, wait, and download calls swapped.

## 1. Footage-first law

The film is the source of truth; the website is a player. Design the camera arc first (one continuous journey, about 5 chapters), then build the page around whatever footage actually comes back. Never storyboard the site and force footage to match: footage drifts, copy is cheap to move.

## 2. Chaining law (flawless joins)

Each clip's start image is the ffmpeg-extracted literal last frame of the previous clip. Not a lookalike keyframe, the actual pixels:

```bash
ffmpeg -sseof -0.05 -i clipN.mp4 -update 1 -q:v 1 clipN-last.png
```

KIE route: upload `clipN-last.png` via the base64 file endpoint and pass the hosted url as clip N+1's `image_url` (`scripts/kie.py` does this per link in the chain).

Higgsfield route:

```bash
higgsfield generate create seedance_2_0 --prompt "..." \
  --start-image clipN-last.png --duration 5 --resolution 1080p \
  --mode std --generate-audio false
```

Only the opening keyframe (nano-banana) starts the chain; every later start image is a real last frame. Keep one continuous camera direction the whole way (always descending, or always pushing in); reversals read as cuts. Uniform clip length gives constant scrub speed.

## 3. The junction gate (measured, never eyeballed)

```bash
ffmpeg -i A-last.png -i B-first.png -lavfi ssim -f null - 2>&1 | grep All
```

- At or above 0.88: pass. 0.80 to 0.88: watch it in motion before judging. A true fail is structural.
- SSIM under-reads on stochastic texture (clouds around 0.66, embers around 0.72, liquid caustics around 0.60 can all be seamless). The number says where to look; the side-by-side decides. Production evidence: the reference forge build's junctions measured 0.71 to 0.83 and every one was seamless in motion, because sparks, smoke, and caustics are stochastic.
- The number one real failure is grade or geometry drift (an invented sunrise, a new horizon). Fix by regenerating with: "Continue the exact same shot from the reference frame, identical framing, identical colour grade. Do not change the colour grade."
- Dissolves and crossfades over a bad junction are forbidden. The scrub lets the user park on the seam, which exposes the mask instantly. Fix the join, do not hide it.

## 4. The KIE route (primary, verified by a shipped build)

The verified REST contract:

- Create task: `POST https://api.kie.ai/api/v1/jobs/createTask` with `{model, input}`, returns `data.taskId`.
- Poll: `GET https://api.kie.ai/api/v1/jobs/recordInfo?taskId=...`; `data.state` is `success` or `fail`, result urls in `data.resultJson.resultUrls`.
- Upload a local frame for chaining: `POST https://kieai.redpandaai.co/api/file-base64-upload` with `{base64Data: "data:image/png;base64,...", uploadPath, fileName}`, returns `data.downloadUrl`.
- Credit balance: `GET https://api.kie.ai/api/v1/chat/credit`. Quote the cost before generating; report the balance delta after (the receipt).
- Keyframe model: `google/nano-banana`. (`nano-banana-pro` returns 422 on some keys; fall back silently.) Input: `{prompt, output_format: "png", aspect_ratio: "16:9"}`. About 4 credits per image.
- Clip model: `bytedance/v1-lite-image-to-video`. Input: `{prompt, image_url, resolution: "720p", duration: "5", camera_fixed: false}`. About 22.5 credits per 5s 720p clip.
- v1-lite is single-seed only (no last-frame anchor), so the chain contract is: ffmpeg-extract the literal last frame of clip N, upload it, use the hosted url as clip N+1's `image_url`. The same chaining law as section 2.
- **720p IS the master tier on this route.** Frames ship at about 1280px wide and 720p is 1280x720 native, so there is no draft-and-master split here; the Higgsfield draft-cheap-then-master flow does not apply.
- Transient KIE 500s and server-side fails happen: retry the same create up to 4 times, 12 seconds apart.

A full five-chapter film (one keyframe plus five 720p clips, with uploads) ran 139 credits end to end and passed every gate.

## 5. Billing truths, Higgsfield route (verify by balance delta, not docs)

- `--generate-audio false` is THE cost lever. Audio ON silently multiplies the bill by about 3.
- Measured price ladder per 5s clip (confirm with `higgsfield generate cost`): 1080p/std about 45, 720p/std about 22.5, 720p/fast about 17.5, 480p/fast about 7.5. A 10s clip is twice a 5s.
- Draft the whole chain at 480p/fast to validate, then re-run only the approved prompts at 1080p. A regen at draft tier costs a fraction of a full one.
- About 15% of jobs fail server-side with no reason and do not bill. Just retry the same call.

## 6. Keyframe prompt law (letterbox bars)

nano-banana bakes letterbox bars into cinematic prompts. They survive cover-fit and show on 16:9 viewports. Every keyframe prompt must end with: "Full-bleed full-frame image, no letterbox bars, no black bars, no borders, no text, no watermark, no logo." Avoid the word "anamorphic" (it invites bars).

## 7. The bright-ending law

Final clips drift bright. A closing chapter prompted to "fade toward darkness" can come back as a lit room. The regen that works stacks explicit darkness language: "pitch-black", "all lights dimming", "the frame gradually darkening until almost everything is pure black", "no bright room, no visible ceiling lights". Budget one regen for the final clip; it carries the seam handoff into the after-film content.

## 8. Assembly

- Concat dropping the duplicate junction frame (`select='gte(n,1)'` on clips 2 and up), and always `-fps_mode vfr` on the master encode. Default CFR sync pads about 5 duplicate frames per junction, which reads as frozen scrub zones.
- Extract every 2nd frame to about 300 JPEGs at about 1280px, `-q:v 4`. (Dark, grainy footage nearly doubles JPEG bytes; 1280 at q4 keeps the payload light without visible loss at cover fit.)
- Sample the final frame's edge colour: that hex is the seam for the film-to-content handoff.

`scripts/assemble.sh` does all of this and prints the frame count. Set FRAME_COUNT to exactly that number in the engine; never guess it.

## 9. The scrub engine (why it is jank-free)

- Canvas plus pre-extracted JPEGs, never `<video currentTime>` scrubbing (seek stutter).
- ImageBitmap sliding window: `drawImage(HTMLImageElement)` forces a synchronous JPEG decode on first paint (and again after cache eviction), and that decode spike IS the frame-by-frame jank. `createImageBitmap` decodes off-thread; keep a window of decoded bitmaps around the playhead (about 18 ahead, evict and close beyond about 28) so every draw is a pure GPU blit.
- Lerp the frame index (`current += (target - current) * 0.14`) for butter. Cap DPR at about 1.5.
- **Lerp the playhead, but SNAP when the gap exceeds about 12% of the film** (fast flicks): a lerp-only playhead sweeps every intermediate frame and the decode storm freezes the page. Snap to 8 frames short of the target, lerp the rest (see engine.md, snap-on-big-gap).
- Lenis smooth scroll; a concurrency-capped image pump; a `nearestFrame()` fallback so a missing frame never blanks the canvas.
- Measure jank with rAF deltas (p95 and max), never average fps. Target max under 50ms. Production evidence: 301 frames at 1280w with the DPR cap measured avg 16.7ms, p95 27.3ms, max 30ms over 873 rAF frames; the first cold run showed one 276ms spike (cold decode) and warm runs were clean. Run the jank test twice before believing a spike.

## 10. Chrome, seam, and the ambient layer

- Adaptive header: sample the drawn frame's top strip luminance (about every 180ms) and toggle an `.on-light` class. Fixed chrome over a changing film cannot be one hard-coded colour.
- Seamless handoff: start the next section's background gradient at the sampled final-frame colour. No visible line between film and content.
- Ambient hero layer (optional, free): sprite-based canvas particles themed to the world (snow glisten, gold pollen, embers) over the static first frame, fading out across the first 7% or so of scroll, so the hero feels alive before the scrub starts. Use one offscreen radial-gradient sprite and `drawImage` per particle (never `shadowBlur`); stop rendering entirely at alpha 0; skip under `prefers-reduced-motion`.
- Film grain plus vignette sell the one-shot feel; fade both out with the handoff.

## 11. Verification harness

Host preview panes throttle hidden tabs (rAF freezes, so screenshots go stale). The reliable path is puppeteer-core plus system Chrome plus a page dev contract:

- `?jump=<scrollY>`: land pre-scrolled and force-settle all scroll state.
- `window.__ready = true` only after frames are decoded and settled.
- Capture: goto, waitForFunction(__ready), wait about 1200ms, screenshot. Shoot every beat position AND every junction. Hide any cursor-follower until the first real mousemove or it photobombs captures at 0,0.
- On macOS, serve from a /tmp copy: TCC blocks preview servers reading Desktop paths, so copy index.html plus assets and frames to /tmp and serve there.

`scripts/verify.js` does capture plus the jank test.

## 12. Governance

Design taste and design code are done by the Claude model only. Mechanical steps (ffmpeg, SSIM, puppeteer, vercel) are pure code, no model. Quote credits before spending; show the balance-delta receipt after. One continuous shot, one world per brand.
