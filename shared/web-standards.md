# Crew Web Standards

This is the craft law for every Crew web build skill. It exists because sixteen skills were each carrying their own drifting checklist and none of them forced a browser open. Now there is one standard. Skills cite it by name in their Handoffs ("Crew Web Standards" or "web-standards") and cite individual rules by section and number, for example "web-standards Type 3" or "web-standards Gate 2". A skill's own Verification section adopts Section 10, THE VERIFICATION GATE, by reference; a local checklist may add items but never remove or weaken a Gate item. This document plugs into the Crew Method (crew-method.md, installed beside the skills); Loop citations refer to that document.

Every browser-support claim in this document was verified against caniuse and MDN as of July 2026. When you extend this document, verify support the same way. Do not invent support.

Scope: single-page HTML sites (the Crew web deliverable), from a plain business page to a frame-scrubbed cinematic build. Where a rule only applies to one build class, capability tier, or delivery mode, the rule says so.

---

## 0. Delivery modes (Mode)

The deliverable ships in one of three modes, and several rules only exist in some of them. Every rule that assumes external asset files carries a "(Mode 2/3 only)" tag. The skill's brief picks the mode; when unstated, a business page defaults to Mode 1 and a cinematic build to Mode 2.

**Mode 1. Fully inlined single file.** One .html file, every asset base64-embedded, works from a double-click on disk. Every byte is on the critical path: nothing can load behind scroll windows, and mutually exclusive variants would all ship inside the file. Therefore Mode 1 is Build class A only (Perf 1), the inline budget is the whole file weighed against the Build class A critical-path budget, and the realistic asset ceiling is one hero image plus either the system font stack or one small subset font. In this mode, Perf 4, Perf 5, Perf 6, Perf 7, the download-exclusivity clause of Tiers 3, and Appendix A2, Appendix A4, and Appendix A5 are N/A, and the preloader (Craft 2) is banned.

**Mode 2. Single HTML file plus a sibling assets/ folder.** One page file with external renditions beside it, served over a local HTTP server (Gate 1). Works offline from disk. All rules apply.

**Mode 3. Hosted.** Deployed to a public URL. All rules apply, plus the deploy-only head items (og:image and og:url, Head 5).

Build class B and C builds (Perf 1) REQUIRE Mode 2 or Mode 3 and are forbidden in Mode 1. An agent asked for a "single-file cinematic build" delivers Mode 2 and says why.

---

## 1. Type system (Type)

**Type 1. Build the scale with clamp(), not breakpoints.** Every type size is a fluid token: `--step-2: clamp(2.4rem, 1.6rem + 3.2vw, 4.5rem)`. Define the whole scale as `:root` custom properties (`--step--1` through `--step-5` or role names like `--display`, `--headline`, `--body`, `--label`). Role-named classes that reference the tokens beat raw sizes in selectors. Body copy is 17px (1.0625rem) by default; 16px is the absolute floor at 375px and for dense UI text such as labels and table cells.

**Type 2. Apply the tracking compensation curve: bigger type gets tighter.** Optical spacing is not optional. The measured curve (taken from a shipped flagship product page's CSS, works for any grotesque; attribution in the Appendix): 48px and up = -0.003em or tighter, 40px = 0, 32px = +0.004em, 28px = +0.007em, 24px = +0.009em, 21px = +0.011em, 19px and below = +0.012em. For display sizes near 80px and up, tightening further (to around -0.01em) is a reasonable extension of the curve; that figure is a recommendation beyond the measured data, not part of it. Rule of thumb: negative tracking above 40px, add roughly 0.002 to 0.003em per size step down. Uniform letter-spacing across all sizes is a defect.

**Type 3. Line-height bands.** Display type (48px+): 1.0 to 1.1. Headlines (28 to 48px): 1.1 to 1.2. Subheads (20 to 28px): 1.25 to 1.35. Body (16 to 19px): 1.5 to 1.6. Captions and labels: 1.3 to 1.4. Headline weight is 600 (semibold), not 700; bold display type reads cheap.

**Type 4. Fonts ship as one subset variable woff2, embedded or preloaded.** One variable font file covering the weight axis replaces 4 to 6 static files and is universally supported. Subset to latin with fonttools: `pyftsubset Font-Variable.ttf --flavor=woff2 --unicodes="U+0000-00FF,U+2010-2027,U+20AC,U+2122" --layout-features="*" --output-file=font.woff2`. The source file comes from the brief, the brand context, or an openly licensed family fetched at build time. Decision rule: if no subsetting tool is available or no licensed file can be fetched, use the system stack (below), do not embed an unsubset font. In Mode 1, base64-embed the woff2 in the `<style>` block; in Mode 2/3, `<link rel="preload" as="font" type="font/woff2" crossorigin>`. Always `font-display: swap` with a metric-tuned fallback: a second `@font-face` that aliases a local system font and matches the web font's metrics via `size-adjust`, `ascent-override`, and `descent-override`. Maximum two families per site. Font budget: 200KB total woff2, measured as binary bytes before any encoding; base64 inlining charges roughly 1.33x that against the Perf 1 budgets. The modern system stack (`-apple-system, system-ui, ...`) is a legitimate zero-byte alternative when weight matters.

**Type 5. Animated numerals use tabular figures.** Any number that changes (counters, prices toggling, dashboard stats, scrub progress) gets `font-variant-numeric: tabular-nums` so digits do not jitter horizontally as they change. Proportional figures on a live counter is a visible amateur tell.

**Type 6. text-wrap: balance on headings, text-wrap: pretty on prose. Unconditionally.** `balance` on h1 to h4, blockquotes, and hero subheads (Baseline: Chrome 114+, Firefox 121+, Safari 17.5+; Chromium balances up to ~6 lines). `pretty` on p and li to kill orphans (Chrome 117+, Safari 26+; Firefox ignores it and falls back to normal wrapping, zero breakage). Two lines of CSS that remove the most recognisable typographic AI tell: the single-word last line in a headline.

**Type 7. Oversized editorial type is the layout, not a decoration.** On cinematic and brand-led builds, viewport-scale headlines (10 to 20vw via clamp) with the tracking curve applied are the dominant 2026 identity move and cost nothing in weight. Build the grid around the type. Pair a high-contrast display face (serif or expressive) with a grotesque or mono for labels when the brand needs to escape the default-grotesque look.

---

## 2. Colour and contrast (Color)

**Color 1. Define brand colour in oklch, derive the ramp with color-mix.** Both are Baseline Widely Available (oklch: Chrome 111+, Firefox 113+, Safari 15.4+; color-mix: Chrome 111+, Firefox 113+, Safari 16.2+; 92%+ global). One brand token generates the system: `--brand-hover: color-mix(in oklch, var(--brand), black 12%)`, `--brand-tint: color-mix(in oklch, var(--brand), white 85%)`. This guarantees harmonious hover, border, surface, and text tints, the chronic weakness of hand-picked palettes. Hex fallbacks only if the brief demands browsers older than roughly mid-2023.

**Color 2. Hard contrast floors, with the math.** WCAG contrast ratio = (L1 + 0.05) / (L2 + 0.05) where L1 and L2 are the relative luminances of the lighter and darker colours; the luminance formula and a copy-paste checker live in Appendix A6. Floors: 4.5:1 for body text, 3:1 for large text (24px+, or 18.66px+ at weight 700) and for UI components and focus indicators. These are floors, not targets; body copy at 4.6:1 passes but reads thin, aim for 7:1 on long-form prose. Verify with the Appendix A6 snippet in the console, never by eye. Grey-on-grey "muted" text below 4.5:1 does not ship.

**Color 3. Dark mode is a token flip, and it is designed, not inverted.** Dark mode ships when the skill or brief calls for it; the default for a Build class A business site is single-theme unless the brand is dark-native. When it ships: two sets of `:root` values switched by a `data-theme` attribute, honouring `prefers-color-scheme` on first load. Dark surfaces are near-black with hue (oklch lightness 0.13 to 0.2), never #000 with #fff text (too harsh) and never desaturated brand colours. Elevation in dark mode comes from lighter surfaces, not shadows. Re-verify every contrast pair in both themes; a palette that passes in light mode routinely fails in dark.

**Color 4. Style ::selection.** A brand-tinted selection colour (`::selection { background: var(--brand-tint); color: var(--ink) }`) is a two-line detail that separates a designed page from a default one. Verify the selected text still passes 4.5:1.

**Color 5. The anti-slop palette rules.** Never ship: purple or blue radial glows on black (the dark-glow SaaS-clone look, now the strongest generic-AI tell of this cycle), frosted-glass cards as a system, golden or purple AI-gradient imagery, or a rainbow of accents. The 2026 discipline is one motif and roughly two colours carried ruthlessly: the strongest current references run a single accent on a single ground (one orange on black; one idea, ice, carried through every asset). Pick one accent, build every state from it with color-mix, and let type and texture do the rest. Cross-reference Slop 1 to 3.

---

## 3. Performance budgets (Perf)

**Tooling prerequisites (Build class B/C).** The encoding rules below assume ffmpeg plus cwebp or avifenc (or ImageMagick) on the build machine. Canonical commands: WebP `cwebp -q 82 in.png -o out.webp`; AVIF `avifenc --min 18 --max 32 in.png out.avif` (or `ffmpeg -i in.png -c:v libaom-av1 -still-picture 1 out.avif`); all-intra scrub video `ffmpeg -i in.mp4 -an -c:v libx264 -g 1 -crf 20 -pix_fmt yuv420p out.mp4`; font subsetting per Type 4. Fallback rule: if no encoder is present, ship the source format, record the deviation in the Gate 7 evidence, and treat it as a named residual, never a silent pass.

**Perf 1. Hard page-weight budgets by build class.** Weigh the total transfer at first paint and the total after a full top-to-bottom scroll. The budgets:

| Build class | Build type | Critical path (first paint) | Full-scroll total (desktop) | Full-scroll total (mobile) |
|---|---|---|---|---|
| A | Content / business site (page-builder, decks, dashboards) | 500KB | 1.5MB | 1.5MB |
| B | Cinematic scroll site (cinematic-build, immersive, spotlight) | 2MB | 25MB | 10MB |
| C | Frame-scrub / fly-through (product-film, fly-through) | 2MB | 60MB | 15MB |

Critical path = HTML plus everything blocking the first designed frame (the hero poster renders from a static image immediately; the reference flagship product page ships an 846KB critical path doing exactly this, see the Appendix). Everything cinematic loads behind scroll windows (Perf 5, Mode 2/3). A 300MB frame sequence is not a build, it is a defect. Mobile gets its own rendition set, not the desktop payload scaled by CSS (Mode 2/3 only; in Mode 1 the one embedded rendition must fit the mobile budget). Budgets count uncompressed bytes as served: raw on-disk bytes for HTML, CSS, JS, and media (a local server sends them uncompressed; do not credit yourself hypothetical compression). Base64-inlined assets charge their encoded size, roughly 1.33x the binary. To quote a compressed figure alongside, produce it with `gzip -9 -c page.html | wc -c` and label it as such.

**Perf 2. AVIF first, WebP fallback, via picture.** AVIF is Baseline 2024 (Chrome 85+, Firefox 93+, Safari 16.4+, ~94-95% global) and 40 to 60% smaller than JPEG. Hosted pattern: `<picture><source type="image/avif" srcset="..."><source type="image/webp" srcset="..."><img src="....jpg" alt="..." width="" height=""></picture>`. Inlined data-URI assets have no fallback path, so inline WebP (zero-risk) or AVIF if the last ~5% of old iOS 15 devices does not matter for the client. Never emit PNG for photographic content when an encoder exists (tooling box above; no encoder = named residual). Always set width and height (or aspect-ratio) so images reserve layout (see Perf 9, CLS).

**Perf 3. Video beats frame sequences by default.** The reference 2025-2026 flagship product pages ship zero canvas elements in their markup; nearly every motion beat is a short muted video (the exceptions: one WebGL product-viewer moment and a long-form film served into a modal). Video is 10 to 50x smaller than a JPEG sequence and hardware-decoded. Reserve the canvas frame-scrub for the one hero moment that must scrub bidirectionally with per-frame precision; everything else is a `<video preload="none" muted playsinline>` with a scroll-triggered play window. Scrub-destined video is re-encoded all-intra (`ffmpeg -g 1`, every frame a keyframe) so currentTime seeks land exactly; without this the scrub snaps between sparse keyframes and looks broken.

**Perf 4. Every video is preload="none" with a designed poster. (Mode 2/3 only.)** No video downloads until its scroll window opens. Every animated element sits on top of a designed static fallback frame so there is always something composed on screen.

**Perf 5. Scroll-windowed asset loading with vh lead distances. (Mode 2/3 only.)** Do not use loading="lazy" for choreographed media; you cannot control its lead distance. Each heavy asset gets a load window that opens 150 to 200vh before its section arrives and a play window that opens 65 to 100vh before. Implement with an IntersectionObserver using rootMargin in pixels derived from vh, or scroll-position math. Media arrives just-in-time in scroll order; the section boundary never shows a loading state. Full pattern in Appendix A2.

**Perf 6. Unload finished decoders. (Mode 2/3 only.)** Mobile Safari tolerates 1 to 2 live video decoders. When a beat finishes and its section scrolls out, release the video (`video.removeAttribute('src'); video.load()`) and fall back to its poster. This unglamorous discipline is the reason heavy pages do not crash phones.

**Perf 7. The 3-second poster timeout. (Mode 2/3 only.)** Every scroll-triggered video carries a load timeout: if it has not become playable within 3000ms of its window opening, swap permanently to the static fallback frame. A slow network gets the designed still, never a black rectangle.

**Perf 8. Font budget: 200KB, two files maximum.** See Type 4.

**Perf 9. Core Web Vitals intent (advisory).** LCP under 2.5s (the hero poster or headline, never a video, is the LCP element), CLS under 0.1, INP under 200ms. These targets are design intent, not Gate items: over a local server they cannot be measured honestly (near-zero latency), and INP needs field data. The enforceable proxy is the Perf 1 budget audited at Gate 7, plus the structural rules that produce good vitals: a static LCP element, width/height or aspect-ratio reserved on all media (CLS), no injected layout-shifting content, and passive scroll handlers doing their work inside requestAnimationFrame (INP).

**Perf 10. The mobile data tier.** Assume a mid-range phone on 4G. Mobile gets smaller renditions (Appendix A4, Mode 2/3), fewer or no ambient videos, particles cut, and the Perf 1 budgets enforced at 375px. 60fps on a mid-range phone is the felt bar for every client's customer; treat it as design intent verified by proxy: the Perf 1 mobile budget plus Motion 1's compositor-only rule.

---

## 4. Motion standard (Motion)

**Motion 1. Animate transform and opacity only.** Never animate width, height, top, left, margin, or anything that triggers layout. Filter and clip-path are permitted sparingly on composited layers. This is non-negotiable in every build.

**Motion 2. Named easing vocabulary.** Ship easings as named tokens, never raw magic beziers scattered in selectors: `--ease-out-quart: cubic-bezier(0.25, 1, 0.5, 1)` (default for entrances), `--ease-in-out-sin: cubic-bezier(0.37, 0, 0.63, 1)` (scroll-linked position moves), `--ease-in-out-quad: cubic-bezier(0.45, 0, 0.55, 1)` (crossfades). Entrances ease out, exits ease in, scroll-linked moves ease in-out. Default `ease` on anything user-visible is a defect.

**Motion 3. linear() spring easings for interactive moments.** `linear()` stop lists approximate real spring physics that cubic-bezier cannot express (Baseline Dec 2023: Chrome 113+, Firefox 112+, Safari 17.2+). Use the three pre-baked named springs in Appendix A7 (`--spring-soft`, `--spring-out`, `--spring-snap`), copy-paste ready with their paired durations, for menus, cards, and popover entries; declare a plain ease-out on the preceding line as the ancient-browser fallback. Do not hand-roll new stop lists; if a new spring is genuinely needed, generate it with the Appendix A7 sampler so two builds never diverge. This is the cheapest single upgrade from default-ease AI motion to hand-tuned feel.

**Motion 4. Pinning is scarce: 3 to 4 pinned beats per page, maximum.** The reference flagship page carries ~10 sticky rules total and pins only its hero beats. Overused pinning is the number one tell of an amateur cinematic page. Every pinned beat uses the sticky-container pattern (Appendix A3): tall parent section controls dwell time, `position: sticky` child with `overflow: hidden` holds the stage. Everything that is not a hero beat is normal document flow.

**Motion 5. One reveal primitive, used everywhere.** Define a single staggered fade-up (opacity 0 to 1, translateY 16 to 24px to 0, 60 to 90ms stagger between children, one-shot: unobserve after firing) and use it for every non-hero reveal. The reference teardown uses one staggered fade-in primitive about 21 times and hand-choreographs 3 or 4 beats (see the Appendix); that ratio is why the page feels calm. A page where every section has its own animation idea feels cheap.

**Motion 6. Section handoffs are cuts, not morphs.** Each section owns its media and its scroll math; no animation state crosses a section boundary. A section closes on a designed rest state (its fallback still), the next section's assets are already fetched because its load window opened 150vh earlier, and the boundary is a clean editorial cut (often a theme flip or full-bleed colour change). Do not attempt to blend two scroll systems; choreograph within sections, cut between them.

**Motion 7. Scrub math is scoped and damped.** Per-section progress: `progress = sectionScrolled / (sectionHeight - viewportHeight)`, clamped 0 to 1. Drive values inside a requestAnimationFrame loop with passive scroll listeners, and lerp toward the target instead of coupling 1:1. Default lerp factor: 0.12 at 60fps, frame-rate corrected so it feels identical on 120Hz displays: `factor = 1 - Math.pow(1 - base, dt * 60)` where dt is the frame delta in seconds. Scrub-critical beats that must track the scrollbar tightly may raise the base toward 0.3; going past that reads twitchy. The lerp is what makes scrubbing feel damped and expensive instead of twitchy. Frame index: `Math.min(Math.floor(progress * frameCount), frameCount - 1)`.

**Motion 8. CSS scroll-driven animations where support allows, gated.** `animation-timeline: view()` / `scroll()` runs compositor-side with zero JS (Chrome/Edge 115+, Safari 26; Firefox still flagged as of mid-2026, ~75-80% coverage). Use it for decorative reveals, parallax, and progress bars, always inside `@supports (animation-timeline: view())` and authored from a visible base state so Firefox simply sees static content. Scrub-critical hero choreography keeps the JS path.

**Motion 9. will-change is managed, never permanent.** Add `will-change: transform` via JS just before an element animates (when its section window opens) and remove it when the window closes. Permanent will-change on dozens of elements exhausts GPU memory on mobile Safari and is a common cause of cinematic-page crashes.

**Motion 10. The reduced-motion DESIGNED TWIN.** `prefers-reduced-motion: reduce` gets a composed experience, never the broken full one and never a blank one: reveals become instant (elements visible, no observer dependency), scrub beats hold their designed fallback still, autoplay videos show posters, smooth scroll turns off, and the copy, imagery, and CTAs read completely top to bottom. The twin is designed in the same pass as the full experience and it is screenshot-verified at the Gate (Gate 6). A page that only works at full motion ships broken for part of the audience.

**Motion 11. Banned motion.** Scroll-hijacking (scroll position must always map 1:1 or damped to document position, back-scroll always works), autoplaying motion the user cannot scroll away from, uniform fade-up-on-everything (see Slop 2), decorative cursor trails, and any animation on the keyboard focus path that delays interaction.

---

## 5. Progressive enhancement and capability tiers (Tiers)

**Tiers 1. The static designed page is the foundation.** Author the complete page first as plain HTML and CSS: every section rests on a designed static composition, every CTA works, every image has its still. This page is what no-JS, reduced-motion, old browsers, and search engines receive, and it must look intentional, not degraded.

**Tiers 2. JS stamps a capability class that unlocks motion.** First lines of script: `document.documentElement.classList.add('enhanced')` (plus feature-gated classes if needed). All choreography CSS is scoped under `.enhanced`: `html.enhanced .sticky-container { ... }`. Without JS the selectors never match and the page renders as a clean scrolling document. Never hide content in the base state and reveal it with JS; the base state is complete.

**Tiers 3. The disabledWhen mental model.** Every heavy asset and every animation declares the conditions under which it does not exist: reduced-motion, no-JS, small breakpoint, save-data. Variants are mutually exclusive: in Mode 2/3, the reduced-motion still and the full-motion video never both download (in Mode 1 everything is embedded by definition, which is exactly why Mode 1 is Build class A only). When you add an animated asset, ask "which tier gets this, and what does every other tier get instead", and make the answer explicit in the markup or the loader.

**Tiers 4. Modern HTML primitives before JS.** Mobile menus, dropdowns, tooltips, and lightboxes use the Popover API (`popover` + `popovertarget`; Baseline Newly Available April 2024: Chrome 114+, Safari 17.4+, Firefox 125+) with `@starting-style` and `transition-behavior: allow-discrete` for entry/exit animation (Chrome 117+, Safari 17.5+, Firefox 129+). This removes the single most common JS bug class in generated sites: the broken hamburger. Accordions use details/summary. Carousels use native `overflow-x` scrollers with `scroll-snap-type: x mandatory`, not JS.

---

## 6. iOS and mobile reality (Mobile)

**Mobile 1. Autoplay requires muted + playsinline.** Every autoplaying video is `<video muted playsinline autoplay loop>` (and set `video.muted = true` in JS before calling play(), because the attribute alone is not always honoured after src swaps). Missing playsinline gives you the fullscreen takeover; missing muted gives you the silent black rectangle. play() returns a promise: catch rejection and show the poster.

**Mobile 2. Decoder limit: 1 to 2 videos alive.** iOS Safari degrades or crashes with several active video elements. Enforce Perf 6 (unload after play) and never have more than two videos with a live src at once. Verify on a real device or in the iOS simulator when one is available and the page carries more than two videos; otherwise Gate 5's static roster applies.

**Mobile 3. Canvas memory ceiling and devicePixelRatio.** iOS caps total canvas memory per page; a full-screen canvas at devicePixelRatio 3 is a 3x3 = 9x memory multiplier and a crash risk. Cap the backing store: `const dpr = Math.min(window.devicePixelRatio, 2)`. Size the canvas to its displayed CSS size times capped dpr, never larger. For frame-scrub builds, decode frames into a bounded pool (decode ahead of the playhead, release behind it), never all frames into memory.

**Mobile 4. safe-area-inset.** Fixed headers, footers, and full-bleed sections pad with `env(safe-area-inset-top/bottom/left/right)` and the page carries `<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">`. A CTA under the home indicator is an unusable CTA.

**Mobile 5. Ban bare 100vh.** Heroes and full-screen sections: `min-height: 100svh` (the safe minimum, never jumps, never hides content behind the URL bar). Overlays and fixed panels: `100dvh`. Declare `100vh` on the preceding line only as a legacy fallback. Units are Baseline since 2022-2023 (Chrome 108+, Safari 15.4+, Firefox 101+). 100vh-under-the-URL-bar remains the most common mobile bug in generated sites.

**Mobile 6. 375px is a first-class verification width.** The page is designed and verified at 375px, not shrunk to it. Nothing clips, nothing scrolls sideways (`overflow-x: clip` on html and body; never `overflow-x: hidden` on an ancestor of a sticky element, it silently kills the sticky), type stays at or above 16px body, and the cinematic build serves its mobile cut (Perf 10).

**Mobile 7. Touch targets: 44px minimum.** Every tappable control (links in nav, buttons, toggle, accordion headers, carousel dots) has a hit area of at least 44x44px, via padding if the visual is smaller.

**Mobile 8. Hover is a capability, not an assumption.** Anything that only works on hover is gated behind `@media (hover: hover) and (pointer: fine)` and has a touch-reachable equivalent. Custom cursors and hover-reveal effects are disabled on touch. Tap targets never depend on a hover state to be discovered.

---

## 7. Head hygiene (Head)

Every shipped page carries all of these. Missing head hygiene is a Gate failure (Gate 8).

**Head 1. lang.** `<html lang="en">` (or the site's actual language). Screen readers and translation depend on it.

**Head 2. Title pattern.** `<title>Page Name | Brand</title>` for inner pages, `<title>Brand: what it is in five words</title>` for the home page. Under 60 characters. Never "Untitled" or the template's name.

**Head 3. Meta description.** 150 to 160 characters, written for the click, containing the brand and the offer. Never empty, never lorem.

**Head 4. Favicon: SVG plus fallback.** In Mode 1 and Mode 2, everything is a data URI: `<link rel="icon" type="image/svg+xml" href="data:image/svg+xml,...">` plus a base64 PNG data URI on the fallback `<link rel="icon">` line and on `<link rel="apple-touch-icon">` (180x180) when the site will be saved to a home screen. A separate .ico or .png file ships only in Mode 3. A default browser globe icon in the tab is an unfinished build.

**Head 5. Open Graph and Twitter card.** `og:title`, `og:description`, and `og:type` always, plus `twitter:card` (summary_large_image). `og:image` and `og:url` require absolute public URLs (link-preview scrapers do not read data URIs or relative paths), so they are required only when a deploy URL exists (Mode 3); until then, ship both tags with a TODO-comment placeholder and Gate 8 records "og:image deferred to deploy" as a named residual. The image is 1200x630, a designed card, not a screenshot of the site. Method: build a standalone 1200x630 HTML card from the brand tokens (mark, headline, ground) and screenshot it headless, e.g. `chrome --headless --screenshot=og.png --window-size=1200,630 og-card.html`. The first place most clients see their own site is a link preview in a chat; ship it designed.

**Head 6. theme-color.** `<meta name="theme-color">` matched to the page background, so the browser chrome blends with the design on mobile. When a dark theme ships (Color 3), add a second tag carrying `media="(prefers-color-scheme: dark)"` with the dark value.

**Head 7. Viewport.** `width=device-width, initial-scale=1, viewport-fit=cover`. Never user-scalable=no; blocking zoom is an accessibility violation.

---

## 8. Accessibility floor (A11y)

This is a floor, not a feature. Every build, at every capability tier and build class, including the most cinematic, meets it.

**A11y 1. :focus-visible styles on every interactive element.** A visible 2px+ outline (or equivalent) with 3:1 contrast against its background, offset so it never clips. Never `outline: none` without a designed replacement.

**A11y 2. Skip link.** The first focusable element is a "Skip to content" anchor, visually hidden until focused, targeting the main landmark.

**A11y 3. One h1, a real heading hierarchy.** Exactly one h1 per page; h2 to h4 nest without skipping levels. Headings are chosen for structure, styled for size, never the reverse.

**A11y 4. Semantic landmarks.** header, nav, main, footer, and section with accessible names where sections are navigation targets. A div-only page fails the Gate.

**A11y 5. Decorative media is described.** Every ambient or choreographed video carries `role="img"` and an `aria-label` describing the shot editorially ("Three phones drift into alignment on black"). Every canvas carries `role="img"` and an aria-label, or `aria-hidden="true"` if a text equivalent sits beside it. Content images have real alt text; decorative images have `alt=""`.

**A11y 6. The keyboard pass.** Tab reaches every interactive element in a logical order, Enter/Space activates it, Escape closes overlays, and focus is trapped in open modals and returned on close. On choreographed pages, ensure pinned sections do not strand keyboard focus off-screen.

**A11y 7. Contrast floor.** Cross-reference Color 2. It is verified with math at the Gate, not by eye.

**A11y 8. Reduced-motion twin.** Cross-reference Motion 10. Accessibility owns this rule as much as motion does.

---

## 9. Anti-slop register (Slop) and premium separators (Craft)

Two registers share this section and their cite keys mean opposite things: Slop rules name banned patterns that never ship, in any build; Craft rules name the premium separators you reach for instead.

**Banned (Slop):**

**Slop 1. The dark-glow SaaS clone.** Black background, the default grotesque, purple or blue radial glows, frosted-glass cards, bento grid. Documented across 2025-2026 as the default aesthetic of AI page generators, indistinguishable between brands. If the brief demands dark SaaS, subvert it: serif display type, real texture, one non-purple accent.

**Slop 2. 2023 decorative motion.** Library-default uniform fade-up on every section, multi-layer mouse-parallax heroes, gradient cursor-follower blobs, scroll-hijacking, motion for its own sake. These date a build to 2022-2023 on sight. Replacements: one reveal primitive used sparingly (Motion 5), scrub-linked directed motion, functional cursors.

**Slop 3. Generator-default imagery.** Golden-hued or purple AI-gradient renders, hyper-glossy fake product shots, stock Lottie explainer packs. The 2026 counter-move is anti-AI crafting: real photographic plates, grain, dithering, visible human decisions. Asset pipelines push away from glossy defaults at the prompt level.

**Slop 4. Structural tells.** Misaligned card footers (use subgrid, Baseline since 2023: Firefox 71+, Safari 16+, Chrome 117+), orphan words in headlines (Type 6), default ease on everything (Motion 2), emoji as icons, and placeholder copy shipped as final.

**Premium separators (Craft):**

**Craft 1. Grain with a weight cap.** A subtle animated film-grain layer (SVG feTurbulence or a tiny tiling asset, under 50KB total, opacity under 0.08) over heroes and dark scenes. It kills the sterile AI-render look for near-zero cost and is now expected on cinematic dark sites. One layer, page-wide; never per-section grain stacks.

**Craft 2. Preloader as brand moment, only when assets truly need it.** A percentage counter tied to real asset loading, ending in a reveal that hands directly into the hero. Gate it on actual payload and delivery mode: permitted only in Mode 2/3 builds with a measurable deferred payload (an opening scene over 5MB). In Mode 1 nothing loads after parse, so a counter would animate a lie; banned. On a Build class A page it is pretension; banned.

**Craft 3. Contextual cursor, never decorative.** A small functional cursor that morphs into states ("Drag", "View", scrub direction) over media, with the native cursor semantics preserved, hover states never depending on it, and the whole thing disabled on touch (Mobile 8). Decorative trails read 2022.

**Craft 4. Oversized editorial type and single-motif art direction.** Cross-reference Type 7 and Color 5. One idea, ruthlessly repeated, beats ten decorations. Extract the motif in discovery, before code.

---

## 10. THE VERIFICATION GATE (Gate)

This gate is mandatory for every web skill, in every mode, before any build is called done. Each item names the EVIDENCE it produces. Evidence means an artifact or an observed value: a screenshot, a console transcript, a byte count, a list of elements checked. "Looks right" is not evidence. Evidence artifacts live with the deliverable (or in the skill's own Verification checklist output); the run receipt carries only the Gate verdict line (see the closing paragraph), consistent with the Crew Method's three-line receipt. A skill's Verification section adopts this roster by reference and may add build-specific items; it may never drop one. If an item cannot be executed in the environment, run the nearest emulation and NAME the residual risk in the Gate verdict; silently skipping is a Gate failure.

**Gate 1. Serve the file and open it in a real browser.** Serve over HTTP (not file://; fetch, video range requests, and some font paths behave differently). Navigate to it in the browser pane or a headless browser.
EVIDENCE: the serving URL and an HTTP 200.

**Gate 2. Screenshot desktop AND 375px mobile.** Full-page or per-section screenshots at 1280 to 1440px wide and at 375px. Inspect them: nothing clipped, nothing under the sticky header, no horizontal scroll, no unstyled flash, the hero composed at both widths.
EVIDENCE: the two screenshot sets, attached or path-named, with a one-line verdict each.

**Gate 3. Read the console. Zero errors.** Open the console after a full scroll to the bottom and back. Zero errors, zero unhandled promise rejections. Warnings are triaged: each one either fixed or named with a reason it is acceptable.
EVIDENCE: the console transcript (or "0 errors, 0 warnings" with the read actually performed).

**Gate 4. Full-scroll behaviour pass.** Scroll the entire page top to bottom and back in the browser. Every reveal fires once, every pinned beat enters and exits cleanly, every video plays in its window and unloads after, scrub beats track the scrollbar in both directions, and section cuts land on designed stills. On a page with no pinned beats or scrub sections (a typical Build class A page), the checklist is the reveal inventory (each reveal fires once) plus sticky-nav behaviour, and may be short.
EVIDENCE: a per-beat checklist with pass/fail, from an actual scroll, not from reading the code.

**Gate 5. iOS/Safari behaviours when media is present.** When the page carries video, canvas, or heavy media, and a real iOS device, the iOS simulator, or desktop Safari is available: verify autoplay actually starts (muted+playsinline honoured), no black video rectangles, no more than 2 live decoders, canvas memory within Mobile 3 limits, safe-area respected, svh/dvh units behaving. When none of those environments is available, run the static-check roster instead, executed, not waved at: (1) grep-verify `muted`, `playsinline`, and `autoplay` on every autoplay video and `video.muted = true` in JS before each play(); (2) verify the dpr cap line exists (`Math.min(window.devicePixelRatio, 2)`); (3) verify unload logic exists (`removeAttribute('src')` + `load()`); (4) read the loader logic and confirm its ceiling on simultaneous live srcs is 2 or fewer; (5) verify viewport-fit=cover plus safe-area padding; (6) verify svh/dvh declarations per Mobile 5. Pass = all six checks green plus this fixed residual line in the Gate verdict: "iOS behaviours verified by static checks only; decoder and canvas limits not exercised on real hardware."
EVIDENCE: the checked list with the environment used, and the fixed residual line when only static checks ran.

**Gate 6. Toggle prefers-reduced-motion and screenshot the twin.** Force reduced motion with an executable method: launch headless Chrome via Bash against the serving URL with `--force-prefers-reduced-motion` and screenshot, or drive CDP `Emulation.setEmulatedMedia` with the `prefers-reduced-motion: reduce` feature. Secondary path when neither is available: the page may expose a documented `?reduced-motion=1` test hook whose effect is the exact same rules the media query applies (the Appendix A1 engine honours this hook); using the hook is named in the Gate verdict as residual risk, because the hook, not the media query, was exercised. Reload, scroll, screenshot. The twin must be the designed static experience of Motion 10: all content visible, stills composed, nothing blank, nothing broken mid-animation. On a Build class A page whose only motion is the reveal primitive, the expected delta is: reveals pre-fired, nothing else changes.
EVIDENCE: the reduced-motion screenshot set with a one-line verdict and the method used.

**Gate 7. Audit total page weight against the build class budget.** Measure the byte totals at first paint and after a full scroll (network panel, or sum the asset bytes), in the units Perf 1 declares (raw uncompressed bytes; base64 charged at encoded size). State the build class (A/B/C from Perf 1), the delivery mode (Section 0), and the numbers against the budget, desktop and mobile renditions separately when they differ. Any tooling-fallback deviation (Section 3 tooling box) is recorded here.
EVIDENCE: the byte counts and the verdict (e.g. "Build class B, Mode 2: 1.4MB critical / 18MB full-scroll desktop / 7MB mobile. PASS").

**Gate 8. Check head hygiene.** Verify all seven Head rules are present: lang, title pattern, meta description, favicon, OG/Twitter tags, theme-color, viewport. Where Head 5 permits deferral (no deploy URL yet), the placeholder tags must exist and the verdict records "og:image deferred to deploy" as a named residual.
EVIDENCE: the seven-item checklist with each value quoted or stated.

**Gate 9. Keyboard-walk the interactive elements.** Tab through the page: skip link first, every control reachable and visibly focused, overlays open/close/trap correctly, Escape works, no focus stranded off-screen in pinned sections.
EVIDENCE: the ordered list of elements walked and the pass/fail per A11y 6.

**Gate 10. Contrast math on the shipped palette.** Compute (not eyeball) the ratio for body text, muted text, and every CTA against their real backgrounds, in both themes when a dark theme ships, against Color 2 floors. Method: run the Appendix A6 snippet in the console; it resolves each pair from computed styles (which also settles color-mix-derived values that only exist after the browser computes them) and prints the ratios.
EVIDENCE: the computed ratios per pair.

A build passes the Gate when all ten items produce their evidence and pass. A failed item follows Loop 2 (Quality Failure, defined in crew-method.md): stop, fix, re-run that item. The run receipt carries only the verdict line: "web-standards Gate: 10/10", or the failures and named residuals, e.g. "Gate: 9/10, Gate 5 static checks only, decoder limit not verified on real hardware".

---

## 11. Appendix: the flagship scroll patterns (Appendix)

Reusable engineering patterns extracted from live teardowns of Apple's 2025-2026 product pages, the "reference flagship pages" cited brand-free throughout Sections 1 to 10 (the tracking curve in Type 2, the 846KB critical path in Perf 1, the zero-canvas markup in Perf 3, the ~10 sticky rules in Motion 4, and the one-primitive ratio in Motion 5 all come from these teardowns). Adopt Appendix A2 to Appendix A5 as written; Appendix A1 ships as canonical code, paste it, never rewrite it. Appendix A2, Appendix A4, and Appendix A5 are Mode 2/3 only.

**A1. The declarative keyframe contract, with the canonical engine.** Author scroll animation as data, not code. Each animated element carries a JSON data attribute; one generic interpreter runs the page:

```html
<div data-anim='{
  "start": "t - 70vh", "end": "b",
  "anchors": [".section-cameras"],
  "ease": 0.5, "easeFunction": "easeInOutSin",
  "y": ["css(--y-start)", "0"], "opacity": [0, 1]
}'>
```

The anchor grammar: `t` / `b` = this element's top/bottom meets the bottom of the viewport; `a0t` / `a0b` = the first named anchor's top/bottom; offset math in vh (`"a0t - 150vh"`); `css(--var)` values so breakpoint CSS retunes trigger points and offsets without touching JS. Simple reveals declare `{"start": "t - 70vh", "cssClass": "animate"}` and the interpreter just adds the class.

The interpreter below is the canonical build. Paste it as-is; never re-derive it from this prose. It is a single rAF loop that reads scrollY, eases progress, and lerps current values toward targets (frame-rate corrected per Motion 7), with a ResizeObserver invalidating cached anchor positions, the `enhanced` capability stamp of Tiers 2, and the reduced-motion bail plus `?reduced-motion=1` test hook of Motion 10 and Gate 6:

```html
<script>
/* Crew scroll engine, canonical build (web-standards Appendix A1). Paste as-is; never rewrite. */
(() => {
  'use strict';
  const reduced = matchMedia('(prefers-reduced-motion: reduce)').matches
    || new URLSearchParams(location.search).has('reduced-motion');
  const nodes = [...document.querySelectorAll('[data-anim]')];
  if (!nodes.length || reduced) return;               // base state is complete (Tiers 1)
  document.documentElement.classList.add('enhanced'); // Tiers 2

  const items = nodes.map(el => {
    let spec; try { spec = JSON.parse(el.getAttribute('data-anim')); } catch { return null; }
    const anchors = (spec.anchors || []).map(s => document.querySelector(s)).filter(Boolean);
    return { el, spec, anchors, startY: 0, endY: 1, cur: {}, fired: false };
  }).filter(Boolean);

  // css(--var) resolution: numbers live in CSS so breakpoints retune without JS
  const cssNum = (el, v) => (typeof v === 'string' && v.startsWith('css('))
    ? (parseFloat(getComputedStyle(el).getPropertyValue(v.slice(4, -1))) || 0)
    : parseFloat(v);

  // Anchor grammar: "t" | "b" | "aNt" | "aNb", optional " +/- Nvh".
  // A token resolves to the scrollY at which the named edge meets the bottom of the viewport.
  const resolve = (item, expr) => {
    const m = String(expr).trim().match(/^(?:a(\d+))?([tb])(?:\s*([+-])\s*([\d.]+)vh)?$/);
    if (!m) return 0;
    const target = m[1] != null ? (item.anchors[+m[1]] || item.el) : item.el;
    const r = target.getBoundingClientRect();
    const top = r.top + window.scrollY;
    let y = (m[2] === 't' ? top : top + r.height) - window.innerHeight;
    if (m[3]) y += (m[3] === '-' ? -1 : 1) * (+m[4]) * window.innerHeight / 100;
    return y;
  };

  const measure = () => items.forEach(it => {
    it.startY = resolve(it, it.spec.start || 't');
    it.endY = Math.max(resolve(it, it.spec.end || 'b'), it.startY + 1);
  });

  const easings = {
    linear: p => p,
    easeInOutSin: p => 0.5 - 0.5 * Math.cos(Math.PI * p),
    easeInOutQuad: p => (p < 0.5 ? 2 * p * p : 1 - Math.pow(-2 * p + 2, 2) / 2),
    easeOutQuart: p => 1 - Math.pow(1 - p, 4),
  };

  let last = performance.now();
  const frame = (now) => {
    const dt = Math.min((now - last) / 1000, 0.1); last = now;
    const y = window.scrollY;
    for (const it of items) {
      let p = (y - it.startY) / (it.endY - it.startY);
      p = Math.max(0, Math.min(1, p));
      p = (easings[it.spec.easeFunction] || easings.linear)(p);
      if (it.spec.cssClass) {                          // simple one-shot reveal
        if (p > 0 && !it.fired) { it.el.classList.add(it.spec.cssClass); it.fired = true; }
        continue;
      }
      const base = it.spec.ease != null ? it.spec.ease : 0.12;  // Motion 7 default
      const k = 1 - Math.pow(1 - base, dt * 60);                // frame-rate corrected lerp
      const tr = [];
      for (const prop of ['x', 'y', 'scale', 'opacity']) {
        const range = it.spec[prop]; if (!range) continue;
        const from = cssNum(it.el, range[0]), to = cssNum(it.el, range[1]);
        const target = from + (to - from) * p;
        const cur = it.cur[prop] == null ? target : it.cur[prop] + (target - it.cur[prop]) * k;
        it.cur[prop] = cur;
        if (prop === 'opacity') it.el.style.opacity = cur.toFixed(4);
        else if (prop === 'scale') tr.push(`scale(${cur.toFixed(4)})`);
        else tr.push(`translate${prop.toUpperCase()}(${cur.toFixed(2)}px)`);
      }
      if (tr.length) it.el.style.transform = tr.join(' ');
    }
    requestAnimationFrame(frame);
  };

  const ro = new ResizeObserver(measure);
  ro.observe(document.body);
  items.forEach(it => { ro.observe(it.el); it.anchors.forEach(a => ro.observe(a)); });
  addEventListener('resize', measure, { passive: true });
  measure();
  requestAnimationFrame(frame);
})();
</script>
```

**A2. Scroll-windowed downloading. (Mode 2/3 only.)** The same anchor grammar drives fetching. Each heavy asset declares a download window: `data-download='{"start": "t - 150vh", "end": "b + 150vh"}'`, optionally anchored to another element. The loader fetches only while scroll position is inside the window and honours the tier conditions of Tiers 3 (an asset for the enhanced tier never downloads in the static tier; the reduced-motion still and the full video are mutually exclusive). Lead distances: 150 to 200vh for load, 65 to 100vh for play. This beats loading="lazy" because you control the lead per asset, and it is how a page with 16 videos stays inside budget.

**A3. The sticky-container spec.** The canonical pinned beat:

```css
.pin-section { height: 300vh; /* dwell time: taller = longer */ position: relative; }
html.enhanced .pin-section .sticky-container {
  position: sticky;
  top: var(--nav-height, 0px);
  height: calc(100svh - var(--nav-height, 0px));
  overflow: hidden;
}
```

Media and copy layers inside the sticky container are animated by the Appendix A1 engine while pinned; the tall parent alone controls how long the beat holds. Without the `enhanced` class the section collapses to normal flow and shows its designed still. Maximum 3 to 4 of these per page (Motion 4).

**A4. Per-breakpoint media renditions from one basepath. (Mode 2/3 only.)** One asset, four named widths, deterministic filenames: `_small` (to 734px), `_medium` (to 1068px), `_large` (to 1440px), `_xlarge`, each with a `_2x` density variant. Images ship as `<picture>` with media-queried sources and a plain img fallback; renditions are true art direction (the small crop recomposes, it does not just scale). Videos carry a basepath (`data-media-basepath="assets/hero/"`) and the runtime composes the URL per breakpoint, so a phone never downloads the desktop clip. Content-hash or version the filenames for immutable caching on hosted builds. This trio of breakpoints (734 / 1068 / 1440) is a complete, proven responsive pipeline; do not invent a new one per project.

**A5. Video beat lifecycle. (Mode 2/3 only.)** Compose Appendix A2 with Perf 4, Perf 6, and Perf 7 into one contract per video: `preload="none"`, poster or fallback-frame picture always present, load window opens 200vh early, play window 65 to 100vh early, 3s timeout to poster, pause on exit, unload at end. Scrub videos additionally: all-intra encoding (`ffmpeg -g 1`), audio stripped, 3 to 8s clips, currentTime driven by the Appendix A1 rAF-lerp, never by the scroll event directly.

**A6. The contrast checker (Color 2, Gate 10).** Paste into the console on the served page. It resolves each pair from computed styles, so color-mix and oklch-derived values are measured as the browser actually renders them:

```js
/* web-standards Appendix A6: WCAG contrast from computed styles */
const lum = (rgb) => {
  const [r, g, b] = rgb.match(/[\d.]+/g).slice(0, 3).map(Number).map(v => {
    v /= 255; return v <= 0.03928 ? v / 12.92 : Math.pow((v + 0.055) / 1.055, 2.4);
  });
  return 0.2126 * r + 0.7152 * g + 0.0722 * b;
};
const ratio = (fg, bg) => {
  const a = lum(fg), b = lum(bg);
  return ((Math.max(a, b) + 0.05) / (Math.min(a, b) + 0.05)).toFixed(2);
};
const bgOf = (el) => {
  for (let n = el; n; n = n.parentElement) {
    const c = getComputedStyle(n).backgroundColor;
    if (c && !/rgba?\(\s*0\s*,\s*0\s*,\s*0\s*,\s*0\s*\)/.test(c) && c !== 'transparent') return c;
  }
  return 'rgb(255, 255, 255)';
};
/* usage: pass the selectors of the pairs to check */
['body', 'p', '.muted', 'a', 'button', '.cta'].forEach(sel => {
  document.querySelectorAll(sel).forEach(el => {
    const s = getComputedStyle(el);
    console.log(sel, s.color, 'on', bgOf(el), '=', ratio(s.color, bgOf(el)) + ':1');
  });
});
```

**A7. The named spring tokens (Motion 3).** Copy-paste ready, generated from a damped spring (mass 1) with the fixed parameters shown; use each with its paired duration or scale duration proportionally. Do not hand-edit stop lists.

```css
/* stiffness 100, damping 15: settles without overshoot; pair with 920ms */
--spring-soft: linear(0, 0.0606 4.2%, 0.1986 8.3%, 0.3648 12.5%, 0.5286 16.7%, 0.6728 20.8%, 0.7901 25%, 0.8793 29.2%, 0.9428 33.3%, 0.9848 37.5%, 1.0101 41.7%, 1.0233 45.8%, 1.0281 50%, 1.0277 54.2%, 1.0244 58.3%, 1.0198 62.5%, 1.0151 66.7%, 1.0107 70.8%, 1.0071 75%, 1.0043 79.2%, 1.0022 83.3%, 1.0008 87.5%, 0.9999 91.7%, 0.9994 95.8%, 1);

/* stiffness 170, damping 18: gentle overshoot, the default entrance; pair with 770ms */
--spring-out: linear(0, 0.0714 4.2%, 0.2325 8.3%, 0.4232 12.5%, 0.6055 16.7%, 0.7594 20.8%, 0.8774 25%, 0.9596 29.2%, 1.0112 33.3%, 1.0387 37.5%, 1.0491 41.7%, 1.0486 45.8%, 1.042 50%, 1.0328 54.2%, 1.0233 58.3%, 1.015 62.5%, 1.0083 66.7%, 1.0035 70.8%, 1.0003 75%, 0.9985 79.2%, 0.9977 83.3%, 0.9975 87.5%, 0.9977 91.7%, 0.9982 95.8%, 1);

/* stiffness 300, damping 20: visible bounce for snappy micro-interactions; pair with 690ms */
--spring-snap: linear(0, 0.1014 4.2%, 0.3248 8.3%, 0.5754 12.5%, 0.7949 16.7%, 0.9563 20.8%, 1.0551 25%, 1.1005 29.2%, 1.1074 33.3%, 1.0914 37.5%, 1.0655 41.7%, 1.0388 45.8%, 1.0166 50%, 1.0011 54.2%, 0.9921 58.3%, 0.9885 62.5%, 0.9887 66.7%, 0.9908 70.8%, 0.9937 75%, 0.9965 79.2%, 0.9988 83.3%, 1.0002 87.5%, 1.001 91.7%, 1.0013 95.8%, 1);
```

The generator, if a new spring is genuinely needed (fixed formula, deterministic output):

```js
/* web-standards Appendix A7 sampler: damped spring -> linear() stop list */
function spring(stiffness, damping, n = 24) {
  const w0 = Math.sqrt(stiffness), z = damping / (2 * Math.sqrt(stiffness));
  const dur = -Math.log(0.001) / (z * w0);
  const x = t => {
    const wd = w0 * Math.sqrt(1 - z * z);
    return 1 - Math.exp(-z * w0 * t) * (Math.cos(wd * t) + (z * w0 / wd) * Math.sin(wd * t));
  };
  const stops = Array.from({ length: n + 1 }, (_, i) => {
    const p = i / n, v = +x(p * dur).toFixed(4);
    return i === 0 ? '0' : i === n ? '1' : `${v} ${+(p * 100).toFixed(1)}%`;
  });
  return { css: `linear(${stops.join(', ')})`, durationMs: Math.round(dur * 1000) };
}
```
