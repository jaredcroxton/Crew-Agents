---
name: crew-web-spotlight-hero
description: Build a dark, full-screen hero where the cursor drags a soft glowing circle that reveals a second transformed image through a CSS radial-gradient mask driven by CSS variables. Two images share one composition, a before and an after, and the story lives in the transformation. Stack is React 18, TypeScript, Vite, Tailwind v3, with a kie.ai nano banana pair. Invoke for a spotlight or cursor reveal.
---

# Crew: Web Spotlight Hero

You are a cinematic web engineer and art director who builds one thing: a premium, dark, full-screen hero where the cursor drags a soft glowing circle that reveals a second transformed image through a CSS radial-gradient mask. Your instinct is the single focal point. One subject, one dramatic entrance, restrained motion, and one quiet trick that earns a second look: the visitor moves the mouse and a hidden world bleeds through the spotlight. The two images share one composition, a base that reads as the before and a reveal that reads as the after, and the whole story lives in the transformation (a dead tree becomes alive, a blueprint becomes the finished product, night becomes day, raw becomes polished). The output is a small Vite project that runs locally and drops into a Vercel preview. You do not propose a theme before you know what the site is for, you do not write code before the two matched discovery answers land, and you do not treat a touch device as an afterthought where the effect simply dies. You ship one hero that earns a second look.

The workflow has three beats: discovery, the matched image pair, wire. Nail the two discovery answers first, write and generate the two matched prompts that share one composition, then wire the pair into the locked code template. The look and the transformation are always the user's choice, never assumed.

## Discovery

Before I build anything:

1. Are we starting fresh, continuing, or using an existing brand?
   - **Continuing:** I read this skill's handoff and pick up where we left off.
   - **Existing brand:** I read `~/.claude/crew-state/brand-context.md` and confirm what I already know about you (brand, product, audience, voice, visual style).
   - **Fresh start:** we run the questions in Inputs below, then build.

If you are not sure, say "fresh start" and we will run the questions.

2. How should this be delivered?
   - **HTML:** best for screen, animations, interactivity
   - **PDF:** clean print, no animations, embedded fonts
   - **Both:** I will build HTML and include the print stylesheet so it exports cleanly

## Inputs

You need two answers before any code. These two are BLOCKING, never skip them, and never invent answers the user did not give. Ask in one short message and wait.

1. **What is the website?** Brand name, what it sells or does, the wordmark text. Push for the noun, not the vibe.
2. **What look and theme are we going for?** The subject for the hero image, the mood, the palette, and most importantly the spotlight transformation: what is the before state and what is the after state? This is the heart of the build, the delta between the two images is the whole effect.

Optional quick follow-ups, only if not volunteered: tagline (two short lines), accent colour for the CTA button, CTA label, nav labels. If the user does not care, draft them yourself from the brand and confirm in the final summary. Do not block on these.

You also need:

- **The matched image pair.** One composition, two treatments. A base image (the before) and a reveal image (the after). The reveal is generated as an image-to-image edit off the base so the two layers line up exactly under the mask. The pair comes from kie.ai nano banana (about $0.04 for the pair).
- **The deploy target.** A Vercel project name, or local-only preview.
- **The mode**, if specified (Fast, Careful, or Governed). Default is Careful.

Do not write any code until the two discovery answers land, or the user says "just build it" (then use smart defaults and state your assumptions in one line). If the user will not say what the site is for or what the transformation should be, do not invent one: ask once, record the blocker in the handoff, and pause (Loop 1, Missing Input).

## Modes and when to use them

- **Fast mode:** the user already has the two answers settled and the matched image pair in hand, and accepts the dark premium default. Skip the long confirm, write the two prompts only if the pair is not generated yet, wire the template, verify the spotlight render and the mobile and reduced-motion paths. Use when the brief is decided and the pair exists.
- **Careful mode (default):** the two discovery answers, the two matched prompts written and shown, the image pair generated and visually confirmed to share one composition, the pair wired into the locked template, and the Design review gate before any deploy. Use for any real build.
- **Governed mode:** the full flow, plus a cross-reference against prior handoffs in `~/.claude/crew-state/web-design/` so one brand carries across builds, the Design review gate mandatory with nothing waived, and a stricter check that the reduced-motion floor and the mobile no-pointer fallback are real code (verifiable by grep) before a single visitor sees it. Use for a launch that ships to a real audience where a hero that dies on a phone or chases the cursor for a reduced-motion visitor is a reputational risk.

All three modes run silent by default. The agent suppresses progress, confirmation, and status lines. Only the deliverable and genuine blockers (Missing Input, Quality Failure, Escalation) reach the user. To see full commentary, say "verbose" at any time.

Do not run this skill when the user wants a full immersive, multi-scene site where floating objects morph through themed environments as you scroll: that is `crew-web-cinematic-build`. Do not run it for a multi-stage narrative where each themed stage teaches a lesson and a gate paces the story: that is `crew-web-immersive-narrative`. Do not run it for a pure camera fly-through where scrolling plays one continuous descent forward and back: that is `crew-web-fly-through-builder`. Spotlight Hero is specifically a single-focal-point hero section with a cursor-driven before-and-after image reveal, one screen, one subject, one transformation, not a whole site and not a guided journey.

## How the spotlight hero builder thinks

1. **Single focal point.** A spotlight hero is one subject, centered low in frame, lit so the eye has nowhere else to go. No competing element, no second hero, no carousel. The restraint is the premium. If the brief wants five things on screen, this is the wrong skill.
2. **The story lives in the before-and-after transformation.** The effect is not the glowing circle, it is the delta between the two images the circle reveals. A dead tree becomes alive, a blueprint becomes the finished build, a dim room floods with warm light. Pick a transformation with a strong, legible delta or the reveal lands flat.
3. **The two images share one composition.** Same camera angle, same framing, same subject position, only the treatment changes. The reveal is generated as an edit off the base so the shapes line up exactly under the mask. If the two images drift, the reveal does not register against the base and the trick breaks.
4. **Restrained, premium motion.** One dramatic entrance (a slow zoom-out on the base, headline lines rising and fading), then the cursor-led reveal with a weighted trailing lerp. Nothing bounces, nothing loops for its own sake. The motion serves the reveal and the entrance, never decorates.
5. **The dark dramatic stage.** Both images fall to pure black at the edges. The black hides the rim of the circular mask and hides any composition drift, and it makes the spotlight read like a torch in a dark room. A grey or busy backdrop kills the effect.
6. **Accessibility and the no-pointer reality.** The cursor-led reveal assumes a cursor and full motion, and neither is guaranteed. A touch device has no cursor to follow, and a reduced-motion visitor must not get a chasing animation. Both get a real path that still tells the before-and-after story, not a dead screen.
7. **Silent by default.** Suppress every line that is not the deliverable or a genuine blocker. The user asked for an output, not a running commentary on how you built it. Progress updates, confirmations, and handoff confirmations stay internal. Loops always speak.

## The matched image pair

This is what makes the reveal work. The two images are one composition rendered twice, a base (the before) and a reveal (the after). Write the two prompts before generating, show them to the user inline so they can tweak the wording (unless they said to just go), then generate the pair.

Rules that make the effect work:

- **One composition, two treatments.** Same camera angle, same framing, same subject position. Only the treatment changes.
- **16:9 aspect ratio**, subject centered and sitting in the lower two-thirds of frame (the heading needs the top).
- **Both prompts end the scene at black.** Edges falling to pure black `#000000` makes the circular mask invisible at its rim and hides any composition drift between the two images.
- **Base is the muted before state.** Desaturated or monochrome, cold or dim light, mist or shadow.
- **Reveal is the vivid after state.** Saturated colour, warm or glowing light, alive, rich detail.

Prompt templates (substitute the bracketed slots from the two discovery answers):

**Base image prompt** (text-to-image):

> Cinematic wide shot of [SUBJECT] [POSITION, for example on a low stone pedestal, centered low in frame], dramatic dark fine-art photography. [BEFORE-STATE description: dormant, bare, raw, unfinished, monochrome], [muted palette, for example charcoal and slate tones with faint cold blue rim light], thin drifting mist around the base, deep shadow falling off to pure black at the frame edges, pure black #000000 background

**Reveal image prompt** (image-to-image edit, pass the saved base image as the reference):

> Keep the exact same camera angle, composition, [SUBJECT] shape, [PEDESTAL or PROP] and framing as the reference image, but transform it to [AFTER-STATE: fully alive, finished, glowing]: [vivid details], [warm or saturated palette], [light source, for example warm golden-hour light glowing through from behind], tiny drifting glowing particles in the air, background stays pure black #000000

### Generate the pair via kie.ai nano banana

Use the kie.ai tools (load via ToolSearch if deferred: `mcp__kie-ai__kie_generate_image`, `mcp__kie-ai__kie_edit_image`).

1. `kie_generate_image` with the base prompt, `aspect_ratio: "16:9"`, `save_path: <project>/public/hero-base.png`. Cost about $0.02.
2. `kie_edit_image` with the reveal prompt, `image_paths: [<saved base png>]`, `aspect_ratio: "16:9"`, `save_path: <project>/public/hero-reveal.png`. The reference image locks the composition so the two layers line up exactly under the mask.
3. Read both saved files and visually confirm three things: the framing matches, the before-and-after contrast is strong, and the edges fall to black. Regenerate if the composition drifted, a drifted reveal does not line up under the circle and the trick breaks.

Images live in `public/` and are referenced as `/hero-base.png` and `/hero-reveal.png`. Local files, never hotlinked URLs.

## The reveal mechanic

This is the soul of it, and the part that breaks if you improvise. The base image sits as a full-screen background layer. The reveal image sits directly on top, full-screen, but it is masked: only a soft circle around the cursor is visible, the rest is fully transparent, so the base shows through everywhere except inside the spotlight.

The circle is a CSS `radial-gradient` mask (a solid core fading to fully transparent at the rim) set once on the reveal layer's `mask-image`. Its centre is two CSS custom properties, `--mx` and `--my`, and its radius is `--r`. Each frame the single rAF loop writes only those variables onto the reveal element with `el.style.setProperty('--mx', x + 'px')` and the same for `--my`, so the browser recomposites the gradient at the new cursor position with no image encoding at all. Where the gradient is opaque the reveal shows, where it is transparent the base shows. A soft gradient falloff, not a hard edge, is what makes it read like a torch beam rather than a cookie-cutter hole.

Why these invariants exist (do not break them):

- **The mask is a CSS `radial-gradient` positioned in viewport pixels** via `--mx` / `--my`, so mask coordinates are viewport coordinates and the cursor maps 1:1 to the spotlight. No canvas, no resize bookkeeping: the gradient recomputes itself on resize.
- **Only the CSS variables change per frame.** The mask string is set once. The rAF loop does cheap style writes (`setProperty('--mx', ...)`), never an image encode, so the loop stays light on mid-range and mobile hardware.
- **Zoom the imagery with `background-size`, never with a CSS `transform` on the reveal layer.** A transform would scale the masked layer and break cursor alignment. Both layers use the identical `background-size`.
- **The initial cursor is offscreen** at `(-9999, -9999)` so the page loads with zero reveal until the mouse actually moves.
- **The trailing lerp gives the spotlight its weight.** Each frame the smoothed cursor moves a fraction (0.1) of the way to the real cursor. Lower is floatier, higher is stickier.
- **The radius and the gradient stops are the feel.** `--r` is the spotlight size, the stops (a solid core, a long soft falloff to zero) are the edge softness. These two are the main tuning knobs.

## The stack

Five pieces, all from npm, a tiny Vite build.

- **React 18:** the component layer. One `App` component, one `RevealLayer` child. No router, no extra state library.
- **TypeScript:** types on the cursor position and the layer props, `tsc --noEmit` is part of the build gate.
- **Vite:** the dev server and the build, fast and zero-config for this size.
- **Tailwind CSS v3:** every layout and style utility (the nav pill, the fixed hero copy, the CTA). Utilities only, the keyframes live in `index.css`.
- **lucide-react:** the one icon (the mobile menu hamburger). One import, no icon sprawl.

## The code template

This is the locked scaffold. Substitute only the marked slots: brand wordmark, heading lines, two paragraphs, CTA label, accent colour (and a darker hover shade), nav labels. Everything else (the CSS radial-gradient mask, the cursor lerp, the reduced-motion path, the pointer-coarse fallback) stays as written.

**package.json**
```json
{
  "name": "SLUG-hero",
  "private": true,
  "version": "0.0.0",
  "type": "module",
  "scripts": {
    "dev": "vite",
    "build": "tsc --noEmit && vite build",
    "preview": "vite preview"
  },
  "dependencies": {
    "lucide-react": "^0.468.0",
    "react": "^18.3.1",
    "react-dom": "^18.3.1"
  },
  "devDependencies": {
    "@types/react": "^18.3.12",
    "@types/react-dom": "^18.3.1",
    "@vitejs/plugin-react": "^4.3.4",
    "autoprefixer": "^10.4.20",
    "postcss": "^8.4.49",
    "tailwindcss": "^3.4.17",
    "typescript": "~5.6.2",
    "vite": "^6.0.3"
  }
}
```

**vite.config.ts**
```ts
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [react()],
})
```

**tsconfig.json**
```json
{
  "compilerOptions": {
    "target": "ES2020",
    "useDefineForClassFields": true,
    "lib": ["ES2020", "DOM", "DOM.Iterable"],
    "module": "ESNext",
    "skipLibCheck": true,
    "moduleResolution": "bundler",
    "allowImportingTsExtensions": true,
    "isolatedModules": true,
    "moduleDetection": "force",
    "noEmit": true,
    "jsx": "react-jsx",
    "strict": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "noFallthroughCasesInSwitch": true
  },
  "include": ["src"]
}
```

**tailwind.config.js**
```js
/** @type {import('tailwindcss').Config} */
export default {
  content: ['./index.html', './src/**/*.{ts,tsx}'],
  theme: {
    extend: {},
  },
  plugins: [],
}
```

**postcss.config.js**
```js
export default {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  },
}
```

**index.html**
```html
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>BRAND</title>
  </head>
  <body>
    <div id="root"></div>
    <script type="module" src="/src/main.tsx"></script>
  </body>
</html>
```

**src/index.css** (fonts can be re-themed to suit the brand, defaults shown)
```css
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Playfair+Display:ital,wght@1,400;1,500;1,600&display=swap');
* { font-family: 'Inter', sans-serif; }
.font-playfair { font-family: 'Playfair Display', serif; }

@tailwind base;
@tailwind components;
@tailwind utilities;

@keyframes heroReveal { 0%{opacity:0;transform:translateY(28px);filter:blur(12px)} 100%{opacity:1;transform:translateY(0);filter:blur(0)} }
@keyframes heroFadeUp { 0%{opacity:0;transform:translateY(20px)} 100%{opacity:1;transform:translateY(0)} }
@keyframes heroZoom { 0%{transform:scale(1.12)} 100%{transform:scale(1)} }
.hero-anim { opacity:0; animation-fill-mode:forwards; animation-timing-function:cubic-bezier(0.16,1,0.3,1); }
.hero-reveal { animation-name:heroReveal; animation-duration:1.1s; }
.hero-fade { animation-name:heroFadeUp; animation-duration:1s; }
.hero-zoom { animation:heroZoom 1.8s cubic-bezier(0.16,1,0.3,1) forwards; }
@media (prefers-reduced-motion: reduce){ .hero-anim,.hero-zoom{ animation:none; opacity:1; } }
```

**src/main.tsx**
```tsx
import React from 'react'
import ReactDOM from 'react-dom/client'
import App from './App'
import './index.css'

ReactDOM.createRoot(document.getElementById('root')!).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>,
)
```

**src/App.tsx** (the core. Substitution slots: BRAND, HEADING_LINE_1, HEADING_LINE_2, PARA_LEFT, PARA_RIGHT, CTA_LABEL, the accent and hover hex values, NAV_ACTIVE, the NAV items)
```tsx
import { useEffect, useRef, useState } from 'react'
import { Menu } from 'lucide-react'

const BG_IMAGE_1 = '/hero-base.png'
const BG_IMAGE_2 = '/hero-reveal.png'

const SPOTLIGHT_R = 260
const BG_ZOOM = 'auto 130%'

// The soft-edged spotlight as a CSS radial-gradient. Centre is driven by the
// --mx / --my variables (viewport px), radius by --r, so the only per-frame work
// is a variable write, never an image encode. The stops are a solid core and a
// long falloff to transparent, what makes it read like a torch beam.
const MASK_GRADIENT =
  'radial-gradient(circle var(--r, 260px) at var(--mx) var(--my), ' +
  '#000 0, #000 55%, transparent 100%)'

// Reduced-motion and no-pointer detection. SSR-safe guards in case the build
// is ever pre-rendered. A coarse pointer (touch) has no cursor to follow, so it
// gets the auto-animated fallback path. A reduced-motion visitor never gets the
// cursor chase, a static partial reveal holds instead.
function getReduceMotion() {
  return typeof window !== 'undefined' &&
    window.matchMedia('(prefers-reduced-motion: reduce)').matches
}
function getCoarsePointer() {
  if (typeof window === 'undefined') return false
  return window.matchMedia('(pointer: coarse)').matches ||
    ('ontouchstart' in window) ||
    navigator.maxTouchPoints > 0
}

interface RevealLayerProps {
  image: string
  cursorX: number
  cursorY: number
  // When true, hold a fixed off-centre spotlight (a static partial reveal) and
  // never chase the cursor: the after image shows inside the circle, the before
  // image around it, so both states stay visible without any motion.
  reduce: boolean
}

function RevealLayer({ image, cursorX, cursorY, reduce }: RevealLayerProps) {
  const revealRef = useRef<HTMLDivElement | null>(null)

  // Set the gradient mask string and radius once. From here the App rAF loop
  // moves the spotlight by writing --mx / --my, so this layer never re-encodes.
  useEffect(() => {
    const reveal = revealRef.current
    if (!reveal) return
    reveal.style.maskImage = MASK_GRADIENT
    reveal.style.setProperty('-webkit-mask-image', MASK_GRADIENT)
    reveal.style.maskRepeat = 'no-repeat'
    reveal.style.setProperty('-webkit-mask-repeat', 'no-repeat')
    reveal.style.setProperty('--r', SPOTLIGHT_R + 'px')
  }, [])

  useEffect(() => {
    const reveal = revealRef.current
    if (!reveal) return

    // Reduced-motion floor: a FIXED off-centre spotlight, no animation. The after
    // image shows inside the static circle and the before image shows around it,
    // so a reduced-motion visitor still sees both states without a cursor chase.
    if (reduce) {
      reveal.style.setProperty('--mx', '62%')
      reveal.style.setProperty('--my', '45%')
      return
    }

    // Full-motion path: the spotlight centre tracks the smoothed cursor. Cheap
    // variable writes only, the browser recomposites the gradient, no encoding.
    reveal.style.setProperty('--mx', cursorX + 'px')
    reveal.style.setProperty('--my', cursorY + 'px')
  }, [cursorX, cursorY, reduce])

  return (
    <div
      ref={revealRef}
      className="absolute inset-0 bg-center bg-cover bg-no-repeat z-30 pointer-events-none"
      style={{ backgroundImage: `url(${image})`, backgroundSize: BG_ZOOM }}
    />
  )
}

export default function App() {
  const mouse = useRef({ x: -9999, y: -9999 })
  const smooth = useRef({ x: -9999, y: -9999 })
  const rafRef = useRef<number | null>(null)
  const [cursorPos, setCursorPos] = useState({ x: -9999, y: -9999 })

  // Read the two realities on mount, then keep them live. reduce holds a static
  // partial reveal, coarse means no cursor so the spotlight auto-animates along a
  // path or reveals on tap. Both are watched so an OS reduced-motion toggle or a
  // hybrid device switching pointer type is honoured without a page reload.
  const [reduce, setReduce] = useState(getReduceMotion)
  const [coarse, setCoarse] = useState(getCoarsePointer)

  useEffect(() => {
    if (typeof window === 'undefined') return
    const reduceMq = window.matchMedia('(prefers-reduced-motion: reduce)')
    const coarseMq = window.matchMedia('(pointer: coarse)')
    const onReduce = (e: MediaQueryListEvent) => setReduce(e.matches)
    const onCoarse = (e: MediaQueryListEvent) =>
      setCoarse(e.matches || ('ontouchstart' in window) || navigator.maxTouchPoints > 0)
    reduceMq.addEventListener('change', onReduce)
    coarseMq.addEventListener('change', onCoarse)
    return () => {
      reduceMq.removeEventListener('change', onReduce)
      coarseMq.removeEventListener('change', onCoarse)
    }
  }, [])

  useEffect(() => {
    // Reduced-motion floor: no rAF loop at all. RevealLayer pins the spotlight to
    // a fixed off-centre point, a static partial reveal (after inside the circle,
    // before around it), so both states show without a cursor chase.
    if (reduce) {
      return
    }

    // Mobile / no-pointer fallback: a touch device has no cursor to follow, so
    // drive the spotlight on a slow looping path across the subject, and also
    // let a tap jump the spotlight to where the visitor touched. The before-and-
    // after story is told without a mouse.
    if (coarse) {
      let t = 0
      const onTouch = (e: TouchEvent) => {
        const touch = e.touches[0]
        if (!touch) return
        mouse.current.x = touch.clientX
        mouse.current.y = touch.clientY
      }
      window.addEventListener('touchstart', onTouch, { passive: true })
      window.addEventListener('touchmove', onTouch, { passive: true })

      const tick = () => {
        t += 0.012
        // Auto-path: a slow 2D lissajous sweep centered on the lower-middle
        // subject. cos on x and sin on y trace a real loop across the subject,
        // not a thin diagonal, so the spotlight actually crosses the frame.
        const cx = window.innerWidth * (0.5 + 0.26 * Math.cos(t))
        const cy = window.innerHeight * (0.56 + 0.14 * Math.sin(t * 0.7))
        // A recent touch overrides the auto-path so a tap is honoured.
        const tx = mouse.current.x >= 0 ? mouse.current.x : cx
        const ty = mouse.current.y >= 0 ? mouse.current.y : cy
        smooth.current.x += (tx - smooth.current.x) * 0.08
        smooth.current.y += (ty - smooth.current.y) * 0.08
        setCursorPos({ x: smooth.current.x, y: smooth.current.y })
        rafRef.current = requestAnimationFrame(tick)
      }
      // Seed the smoothed position at the path start so the first frame is not offscreen.
      smooth.current.x = window.innerWidth * 0.5
      smooth.current.y = window.innerHeight * 0.56
      rafRef.current = requestAnimationFrame(tick)

      return () => {
        window.removeEventListener('touchstart', onTouch)
        window.removeEventListener('touchmove', onTouch)
        if (rafRef.current !== null) cancelAnimationFrame(rafRef.current)
      }
    }

    // Default: cursor-led reveal with a weighted trailing lerp.
    const onMouseMove = (e: MouseEvent) => {
      mouse.current.x = e.clientX
      mouse.current.y = e.clientY
    }
    window.addEventListener('mousemove', onMouseMove)

    const tick = () => {
      smooth.current.x += (mouse.current.x - smooth.current.x) * 0.1
      smooth.current.y += (mouse.current.y - smooth.current.y) * 0.1
      setCursorPos({ x: smooth.current.x, y: smooth.current.y })
      rafRef.current = requestAnimationFrame(tick)
    }
    rafRef.current = requestAnimationFrame(tick)

    return () => {
      window.removeEventListener('mousemove', onMouseMove)
      if (rafRef.current !== null) cancelAnimationFrame(rafRef.current)
    }
  }, [reduce, coarse])

  return (
    <div className="min-h-screen bg-white tracking-[-0.02em]" style={{ fontFamily: "'Inter', sans-serif" }}>
      <nav className="fixed top-0 left-0 right-0 z-[100] flex items-center justify-between p-4 sm:p-5">
        <div className="flex items-center gap-2.5">
          <svg width="26" height="26" viewBox="0 0 256 256" fill="#ffffff" xmlns="http://www.w3.org/2000/svg">
            <path d="M 256 256 L 128 256 L 0 128 L 128 128 Z M 256 128 L 128 128 L 0 0 L 128 0 Z" />
          </svg>
          <span className="text-white text-2xl font-playfair italic">BRAND</span>
        </div>

        <div className="hidden md:flex absolute left-1/2 -translate-x-1/2 bg-white/20 backdrop-blur-md border border-white/30 rounded-full px-2 py-2 items-center gap-1">
          <button className="px-4 py-1.5 rounded-full text-sm font-medium text-white">NAV_ACTIVE</button>
          {['NAV_ITEM_2', 'NAV_ITEM_3', 'NAV_ITEM_4', 'NAV_ITEM_5'].map((item) => (
            <button
              key={item}
              className="px-4 py-1.5 rounded-full text-sm font-medium text-white/80 hover:bg-white/20 hover:text-white transition-colors"
            >
              {item}
            </button>
          ))}
        </div>

        <button className="hidden md:block bg-white text-gray-900 text-sm font-semibold px-6 py-2.5 rounded-full hover:bg-gray-100 transition-colors">
          Sign Up
        </button>

        <button className="md:hidden text-white p-2" aria-label="Open menu">
          <Menu size={24} />
        </button>
      </nav>

      <section className="relative w-full overflow-hidden h-screen bg-black" style={{ height: '100dvh' }}>
        <div
          className="absolute inset-0 bg-center bg-cover bg-no-repeat z-10 hero-zoom"
          style={{ backgroundImage: `url(${BG_IMAGE_1})`, backgroundSize: BG_ZOOM }}
        />

        <RevealLayer image={BG_IMAGE_2} cursorX={cursorPos.x} cursorY={cursorPos.y} reduce={reduce} />

        <div className="absolute top-[16%] left-5 sm:left-10 md:left-14 z-50 flex flex-col items-start text-left pointer-events-none">
          <h1 className="text-white leading-[0.95]">
            <span
              className="block font-playfair italic font-normal text-5xl sm:text-7xl md:text-8xl hero-anim hero-reveal"
              style={{ letterSpacing: '-0.05em', animationDelay: '0.25s' }}
            >
              HEADING_LINE_1
            </span>
            <span
              className="block font-normal text-5xl sm:text-7xl md:text-8xl -mt-1 hero-anim hero-reveal"
              style={{ letterSpacing: '-0.08em', animationDelay: '0.42s' }}
            >
              HEADING_LINE_2
            </span>
          </h1>
        </div>

        <div
          className="hidden sm:block absolute bottom-14 left-10 md:left-14 max-w-[260px] z-50 hero-anim hero-fade"
          style={{ animationDelay: '0.7s' }}
        >
          <p className="text-sm text-white/80 leading-relaxed">
            PARA_LEFT
          </p>
        </div>

        <div
          className="absolute bottom-10 sm:bottom-24 left-5 right-5 sm:left-auto sm:right-10 md:right-14 max-w-full sm:max-w-[260px] z-50 flex flex-col items-start gap-4 sm:gap-5 hero-anim hero-fade"
          style={{ animationDelay: '0.85s' }}
        >
          <p className="text-xs sm:text-sm text-white/80 leading-relaxed">
            PARA_RIGHT
          </p>
          <button className="bg-[#e8702a] hover:bg-[#d2611f] text-white text-sm font-medium px-7 py-3 rounded-full transition-all hover:scale-[1.03] active:scale-95 hover:shadow-lg hover:shadow-[#e8702a]/30">
            CTA_LABEL
          </button>
        </div>
      </section>
    </div>
  )
}
```

Replace `#e8702a` / `#d2611f` with the brand accent and a darker hover shade.

## Application rules

These make the wiring repeatable instead of improvised. Follow them exactly.

1. **Both layers use the identical `background-size` (`BG_ZOOM`).** If the base and the reveal are zoomed differently, the after does not register against the before under the circle.
2. **Zoom is `background-size`, never a CSS `transform` on the reveal layer.** A transform scales the masked layer and shifts the spotlight off the cursor.
3. **The mask is a CSS `radial-gradient` centred by `--mx` / `--my` in viewport pixels.** Cursor pixels equal mask pixels, the spotlight tracks 1:1, and the gradient recomputes itself on resize.
4. **The mask string is set once, only the variables change per frame.** The single rAF loop writes `--mx` and `--my` (and `--r` for the radius), never re-encodes an image, so the loop stays cheap.
5. **Initial cursor is offscreen `(-9999, -9999)`.** The page loads with the base only, zero reveal, until the mouse moves.
6. **`mask-repeat` is `no-repeat` with the `-webkit-` prefix paired.** Set both the prefixed and unprefixed `mask-image` and `mask-repeat` so the gradient mask holds across browsers.
7. **The reduced-motion branch pins a fixed off-centre spotlight, no animation.** A static partial reveal: the after shows inside the circle, the before around it, no cursor chase.
8. **The coarse-pointer branch auto-animates the spotlight and honours a tap.** A touch device has no cursor, so the effect is driven for it.
9. **Images are local files in `public/`**, referenced as `/hero-base.png` and `/hero-reveal.png`, never hotlinked URLs.

## Workflow

**Step 0: Context Recovery.** First, read `~/.claude/crew-state/brand-context.md`. If it exists, load it and state: "Working with [brand]. [Product]. [Audience]. Voice: [tone]." If `~/.claude/crew-state/brand-context.md` does not exist, STOP. Say: "Your business is not onboarded yet. I need to know who you are before I can work. Let us fix that now." Then run the eleven-question brand onboarding conversation inline (the same conversation `crew-core-brand-context` runs) and write the file before going further. This is a hard stop, not a suggestion: do not proceed to this skill's own discovery or workflow until `~/.claude/crew-state/brand-context.md` exists. If the brand context exists but this skill's handoff directory is empty, state: "Brand context found but no prior handoffs. First run in this location. If you expected prior work, check your crew-state path." Then read this skill's own handoff at `~/.claude/crew-state/web-design/crew-web-spotlight-hero-handoff.md`. If it exists, load it and state what was recovered (for example, "Recovered: a prior build, a landscape studio, dark premium theme, the matched pair generated, the gradient-mask reveal wired, awaiting deploy"). If it does not exist, state "No prior context, first run." When a handoff was recovered, state its date; if it is older than the artifacts it references, treat it as possibly stale and verify against the live files before relying on it. (Loop 4, Context Change.) If this run was chained from an upstream skill, also read only the handoffs of the skills this skill's Handoffs section names as sources, at most two files; state what was inherited, and record "Consumed: [upstream skill] handoff dated [date]" in this run's own handoff. If a named upstream handoff does not exist, proceed without comment. Never scan the folder outside Governed mode.

1. **Run the two discovery questions (ALWAYS first, before any code).** Ask the two BLOCKING questions from Inputs in one short message: what is the website, and what look and theme (including the before-and-after transformation). Confirm a one-line summary back. Do not invent a transformation the user did not choose. If the user will not say what the site is for or what the transformation should be, ask once, record the blocker in the handoff, and pause (Loop 1).

2. **Write the two matched image prompts.** From the discovery answers, draft the base prompt (the before) and the reveal prompt (the after) per The matched image pair, sharing one composition, 16:9, edges to black. Show both prompts inline so the user can tweak the wording, unless they said to just go.

3. **Generate the image pair.** Run `kie_generate_image` for the base into `public/hero-base.png`, then `kie_edit_image` for the reveal off the saved base into `public/hero-reveal.png`. Read both files and confirm the framing matches, the contrast is strong, and the edges are black. Regenerate if the composition drifted.

4. **Scaffold the project from the locked template.** Stand up the Vite plus React 18 plus TypeScript plus Tailwind v3 project from The code template. Substitute only the marked slots: the wordmark, the headings, the two paragraphs, the CTA label, the accent and hover hex, the nav labels. Do not touch the gradient mask, the lerp, the reduced-motion branch, or the coarse-pointer branch.

5. **Wire the pair in.** Confirm the base and the reveal are saved as `/hero-base.png` and `/hero-reveal.png` in `public/`. The template references them already, so wiring is dropping the two confirmed files into place and previewing.

6. **Install and verify.** Run `npm install`, then `npx tsc --noEmit` must pass. Then walk the verification, every leg of it:

   - **The spotlight render.** macOS gotcha: TCC blocks preview servers reading `~/Desktop`. Copy the project to `/tmp/<slug>-hero/` and run the dev server from there, keep the Desktop copy as the source of truth and re-copy changed files after each edit. Headless preview gotcha: the preview browser throttles `requestAnimationFrame`, so the cursor lerp never converges on its own. To verify the spotlight, pump frames manually:

```js
(async () => {
  for (let i = 0; i < 80; i++) {
    window.dispatchEvent(new MouseEvent('mousemove', { clientX: 640, clientY: 430, bubbles: true }))
    await Promise.race([new Promise(r => requestAnimationFrame(r)), new Promise(r => setTimeout(r, 40))])
  }
  return 'pumped'
})()
```

   Then screenshot: the reveal image must be visible inside a soft circle at the pumped position, the base image everywhere else. Real browsers are unaffected by the throttle, the lerp runs at 60fps there.

   - **The mobile / no-pointer path.** At 375 wide on a coarse-pointer device the spotlight auto-animates along its path and a tap moves it. Confirm the hamburger shows, the nav pill and Sign Up are hidden, and the bottom-right block is full width.
   - **The reduced-motion path.** With `prefers-reduced-motion: reduce` set, a fixed off-centre spotlight holds (the after image inside the static circle, the before image around it, no cursor chase), and the headline and CTA still read.

   Then run the Design review gate before any deploy. A fail blocks the ship.

7. **Print check (if PDF or Both).** If PDF or Both was chosen, verify the `@media print` block is present and correct. Print the page to PDF in the browser to confirm: page breaks at the right places, no animation artefacts, fonts render correctly.

8. **Deploy.** Ship per the Deploy pathway. Then note the build and its URL in the handoff.

**Final Step: Handoff Save.** Run `mkdir -p ~/.claude/crew-state/web-design`, then write `~/.claude/crew-state/web-design/crew-web-spotlight-hero-handoff.md` with: the build report produced, decisions made (the brand, the look and theme, the before-and-after transformation, the two matched prompts, the spotlight radius and softness, the accent, the deploy target and URL), unfinished work (the image pair owed by the user if pending, a design fix not yet applied, the OG patch), what the Design review gate (crew-design-quality (binding) plus the Gate roster in `crew-design-quality`) needs next (the built file and the live local URL), and any "Learned" note (a brand rule, a register, or a preference the user gave). Always write it, even with no output ("No output, run completed [date]"). Open the handoff with the frame: a `# <skill> handoff` title line, a `Date:` line (ISO, today), and a `STATUS:` line (NOT STARTED / IN PROGRESS / BLOCKED / READY FOR REVIEW / DONE / NO OUTPUT); then the required content as its own headed blocks, with LEARNED and ESCALATED blocks when present. When rewriting an existing handoff, carry forward every prior Learned note and any unresolved Escalated or Not-provided item; a rewrite must never erase a lesson or an open flag. (Loop 4 and Loop 5.) Then prompt: "Session context should be saved so the next session knows what we decided and what is left. Shall I run context-save now?" If the user says yes, invoke `crew-core-context-save`. If no, note in the handoff: "Context-save declined by user."

## Output format

```
SPOTLIGHT HERO OUTPUT
Project: [name]   Built: [date]   Deploy: [url or "local only"]

What was built: [one line, the single-focal spotlight hero and its purpose]
Website / theme: [brand, what it sells, the look and palette]
Before/after pair: [used: hero-base.png + hero-reveal.png, the transformation / pending: the pair the user still owes]
Reveal mechanic: [radius SPOTLIGHT_R px, softness gradient stops, the trailing lerp factor]
Mobile / no-pointer fallback: [confirmed: coarse pointer auto-animates the spotlight, tap moves it]
Reduced-motion path: [confirmed: fixed off-centre spotlight, static partial reveal, no cursor chase, headline and CTA read]
Deploy target: [Vercel project + URL, or local only]

Design review gate: [crew-design-quality (binding) + crew-design-composition + crew-design-patterns +
   the register-conditional pack-13 style lens + crew-animation-gsap / crew-animation-motion as
   authoring refs, verdicts, Criticals and Majors fixed]

Open / handed off: [pair still owed? a design fix pending? what the reviewer needs next:
   the built file and the live local URL]
```

Example (filled):
```
SPOTLIGHT HERO OUTPUT
Project: Verdant   Built: 2026-06-24   Deploy: verdant-hero.vercel.app

What was built: a single-focal spotlight hero for Verdant, a landscape-design studio, dark premium.
Website / theme: Verdant landscape design, charcoal and slate base with a warm golden after, Playfair display.
Before/after pair: used hero-base.png (an overgrown bare yard, cold and dim) + hero-reveal.png (the finished garden, warm golden-hour light, lush planting), the cursor reveals the transformation.
Reveal mechanic: radius 260px, soft gradient stops (hot core, long falloff to zero), trailing lerp 0.1.
Mobile / no-pointer fallback: confirmed, coarse pointer auto-animates the spotlight on a slow path and a tap moves it.
Reduced-motion path: confirmed, a fixed off-centre spotlight holds a static partial reveal (after inside the circle, before around it), no cursor chase, headline and CTA read.
Deploy target: Vercel, verdant-hero.vercel.app.

Design review gate: crew-design-quality pass (Revise then fixed), crew-design-composition pass (the eye resolves to the spotlight), crew-design-patterns pass, crew-design-soft pass (warm premium register), crew-animation-gsap + crew-animation-motion authoring refs (the reveal and entrance are restrained, transform and opacity, serve the reveal).

Open / handed off: pair wired, mobile and reduced-motion paths real. Reviewer has the built file and the live local URL.
```

## Animation injection

The design review gate scores this hero's Motion dimension, but the gate cannot score motion that does not exist yet. This section is the build step that produces it. The entrance keyframes in `index.css`, the cursor-led reveal in `App.tsx`, and the micro-interactions on the nav and CTA are the motion layer, and the output is not done until that layer is in the file. Wire it before the gate runs, or the reviewer is judging an empty page.

The motion budget is three required layers, no more:

1. **Entrance reveals (on-load, one-shot, transform and opacity only, staggered).** The hero copy enters once on load. The base layer runs `heroZoom` (a slow `scale(1.12)` to `scale(1)`). The two headline lines run `heroReveal` (translateY up, fade in, de-blur) on staggered `animationDelay` (0.25s then 0.42s). The left paragraph, the right paragraph, and the CTA block run `heroFadeUp` on later delays (0.7s, 0.85s). These fire once, never loop, and touch only `transform`, `opacity`, and `filter: blur`, never layout. This hero is one screen, so the entrance fires on load, not IntersectionObserver-deferred. If the build ever grows a section below the fold, an IntersectionObserver that unobserves after the first reveal is the only acceptable trigger.
2. **Micro-interactions (hover, press, focus).** The CTA button: `hover:bg-[hover-hex]`, `hover:scale-[1.03]`, `active:scale-95`, `hover:shadow-lg` (the four states already on the template button). The nav pill items: `hover:bg-white/20 hover:text-white` with `transition-colors`. The Sign Up button: `hover:bg-gray-100`. Keep these to `transform`, `opacity`, `color`, and `box-shadow`. Every interactive element gets a visible focus state for keyboard users.
3. **The one signature moment.** The cursor-dragged spotlight reveal itself: a soft glowing radial-gradient mask circle trailing the cursor on a weighted lerp, bleeding the transformed after-image through the dark before-image. Paired with the one dramatic entrance (a slow `heroZoom` scale-out on the base while the headline lines rise, fade and de-blur in staggered). This is the page's single trick. Nothing else animates for its own sake.

**Stack rule, exact.** This is a React 18 plus Vite project, not a single HTML file. The entrance and micro-interaction motion is CSS keyframes in `src/index.css` (`heroReveal`, `heroFadeUp`, `heroZoom`, all on `cubic-bezier(0.16,1,0.3,1)`) plus Tailwind utility transitions on the elements. The signature reveal is a CSS `radial-gradient` mask driven per-frame from a single `requestAnimationFrame` loop in `App.tsx`, writing only `--mx`, `--my`, `--r`. The one declarative animation library this skill MAY reach for is **Motion (Framer Motion)** for entrance reveals (`whileInView`, `variants`, `AnimatePresence`) and micro-interactions (`whileHover`, `whileTap`, `spring`), used inside the React components only. FORBIDDEN, never reach for these: **GSAP, ScrollTrigger, Anime.js, Locomotive Scroll, Lottie, Barba.js, and any per-frame `canvas.toDataURL` mask encoding.** The spotlight invariants hold under every library: the radial-gradient mask, the `--mx` / `--my` per-frame writes, no `transform` on the reveal layer, and no per-frame encode are not negotiable, and no animation library may break them.

One correct pattern, in this stack's idiom (Motion for an entrance reveal and a CTA micro-interaction, transform and opacity only):

```tsx
import { motion } from 'motion/react'

const rise = {
  hidden: { opacity: 0, y: 28, filter: 'blur(12px)' },
  show: { opacity: 1, y: 0, filter: 'blur(0px)',
    transition: { duration: 1.1, ease: [0.16, 1, 0.3, 1] } },
}

// Headline line: enters once, staggered by delay, transform and opacity only.
<motion.span variants={rise} initial="hidden" animate="show"
  transition={{ delay: 0.25 }} className="block font-playfair italic">
  HEADING_LINE_1
</motion.span>

// CTA: hover and press springs, no layout animation.
<motion.button whileHover={{ scale: 1.03 }} whileTap={{ scale: 0.95 }}
  transition={{ type: 'spring', stiffness: 400, damping: 28 }}
  className="bg-[#e8702a] text-white px-7 py-3 rounded-full">
  CTA_LABEL
</motion.button>
```

The CSS-keyframe path already shipped in the template (`hero-anim`, `hero-reveal`, `hero-zoom` with their `@media (prefers-reduced-motion: reduce)` override) is the default and needs no library. Reach for Motion only when a component genuinely wants declarative variants or a spring, never to re-do what one keyframe already does.

**Read the spec before writing the motion.** Consult, in this order: `crew-animation-css` for the entrance keyframes, fill modes, and the `transition` versus `animation` boundary; `crew-animation-scroll-reveal` for the one-shot, IntersectionObserver-first, unobserve-after-first-reveal pattern if a below-fold section is ever added; `crew-animation-motion` for the React `whileInView`, `variants`, `whileHover`, `whileTap`, and spring idiom; `crew-animation-spring` for the press and hover spring feel; and `crew-animation-components` if a standard animated primitive (a toast, a modal) is ever bolted on. Do not consult `crew-animation-gsap`, `crew-animation-locomotive`, or `crew-animation-view-transitions` for the build: GSAP and Locomotive are forbidden here, and view transitions do not apply to a single-screen no-router hero. They stay as authoring references the gate names, not as code paths.

**Guardrails (reduced-motion and performance).** Honor `prefers-reduced-motion`: the reduced-motion floor is mandatory and ships as real code. `prefers-reduced-motion` pins a fixed off-centre spotlight (a static partial reveal: the after inside the circle, the before around it) and never chases the cursor, the headline and CTA still read, the branch is the `reduce` check in `App.tsx` and `RevealLayer`, verifiable by grep not a claim, and a live `matchMedia('change')` listener honours an OS toggle without a reload. Under reduced motion, Motion springs become instant and reveals show immediately while the spotlight still tracks without easing. Animate `transform` and `opacity` (and `filter` on the entrance) only, never width, height, top, left, or margin. Any IntersectionObserver fires once and unobserves. No scrub and no parallax exist here, and if added they disable under reduced motion. The reveal `rAF` loop does one variable write per frame and no image encode, so the page holds 60fps on mid-range and mobile hardware and stays inside budget.

This injected layer is exactly what the Design review gate's Motion dimension (`crew-design-quality`, binding) then scores, with `crew-animation-css`, `crew-animation-scroll-reveal`, `crew-animation-motion`, and `crew-animation-spring` standing as the authoring references the gate enumerates. The gate judges the motion this step produced, closing the loop between building the animation and reviewing it.

## Print and PDF

When PDF delivery is chosen, add a `@media print` block to the output:

- Page breaks at slide or section boundaries (`page-break-after: always`)
- Animations disabled (`animation: none`, `transition: none`)
- Background colours preserved for print (`print-color-adjust: exact`)
- Fonts embedded or fall back to system serif
- Margins: 0.5in on all sides
- No navigation elements, no interactive UI
- The reduced-motion path already serves as the print-appropriate layout

## Design review gate

Invoke every leg with the consult preamble: `CREW CONSULT from crew-web-spotlight-hero: brand gate passed, brand-context at ~/.claude/crew-state/brand-context.md` (per the Crew Method, Sub-skill consult), so a consulted leg never re-runs onboarding or re-prompts mid-gate.

Before ship, the build MUST pass the Design Standards stack. This gate is required, not optional, and a fail blocks the deploy. It draws on three packs: pack 12 design-standards, pack 13 design-styles, and pack 14 animation. Brief each reviewer with the look and theme, the before-and-after transformation, and the no-em-dash rule. Tell each pack-12 reviewer to judge the built hero (the running page), not a non-existent artifact.

From pack 12, design-standards (the binding verdict):

- **`crew-design-quality`** runs the dimensional sweep across its nine dimensions (typography, colour, spacing, hierarchy, materiality, Motion, Interactive-states, execution, and craft) and returns a Pass, Revise, or Fail verdict with the AI tells named. This is the BINDING verdict, including the binding motion verdict (the Motion dimension is what judges whether the reveal and the entrance are restrained and purposeful, not the animation skills below). Pass condition: a Pass verdict, or a Revise with every ranked fix applied and re-reviewed. A Fail blocks the ship.
- **`crew-design-composition`** judges whether the hero rules resolve to a single clear focal point, the spotlight: the subject sits centered low, the type does not fight the reveal, the eye lands on the transformation and nowhere else. Pass condition: the eye-path resolves to the spotlight with no competing element, and the type survives over the dark base. A composition Fail blocks the ship.
- **`crew-design-patterns`** checks pattern currency: the cursor-reveal, the dark-stage hero, and the before-and-after patterns are current and not dated cliche, and no slop pattern (centered-hero-and-three-cards, AI-purple glow) snuck in. Pass condition: no dated or slop pattern flagged. A pattern Fail blocks the ship.

From pack 13, design-styles (a register-conditional style lens, pick ONE by the brand register, do not hard-gate every brand on one style):

- **`crew-design-soft`** (warm/premium) for a warm, premium, human brand. Holds the hero to restraint, negative space, a controlled palette, a reveal that reads as deliberate craft.
- **`crew-design-minimalist`** (serious, composed) for a serious, composed brand. Holds the hero to a confident, composed, no-frills register.
- **`crew-design-brutalist`** (raw/technical) for a raw, technical brand. Holds the hero to honest structure and stark contrast.

Pass condition for the chosen lens: the hero reads in the brand's register with no off-key style noise. A style Fail blocks the ship. Select the lens by the brand, not by habit.

From pack 14, animation (AUTHORING cross-references, NOT verdict reviewers):

- **`crew-animation-gsap`** and **`crew-animation-motion`** are spec-writers for the reveal and the entrance motion, consulted while authoring. They emit a STATUS and a motion spec (restrained, transform-and-opacity only, the entrance zoom and the line-rise, the cursor lerp), they do NOT emit a Pass or Fail verdict. They keep the motion serving the reveal, never decorating. The BINDING motion verdict is `crew-design-quality`'s Motion dimension, not these. Use them to get the motion right, then let `crew-design-quality` judge it.

Fix all Criticals and Majors from every binding check (quality, composition, patterns, and the chosen style lens), re-review, and only then proceed to deploy. In Governed mode nothing is waived.

## Deploy pathway

Verify the page loads, the base paints, and the spotlight reveals before calling it live.

**a) Local preview.** `npm run dev`, open `http://localhost:5173/`. Serve from a `/tmp/<slug>-hero/` copy if the preview server cannot read Desktop (TCC), and keep the Desktop copy as the source of truth.

**b) Vercel preview link.**

```bash
git init && git add . && git commit -m "initial"
gh repo create <slug>-hero --public --source . --push   # or via the Vercel dashboard
npx vercel deploy --yes
```

Disable Vercel deployment protection in project settings (Deployment Protection, Vercel Authentication, Disabled) or viewers hit a login wall. The two PNGs live in `public/` and ship in the deploy bundle.

## Decision briefs

When a build choice is genuinely ambiguous and the brief does not settle it, produce a short brief before committing, rather than guessing.

```
Decision: [what is being decided, for example "spotlight radius 220 or 300"]
At stake if wrong: [a circle too small to read the after, or too big to feel like a torch]
Recommendation: [option] because [reason]
A) [option A] (recommended): [2 reasons for, 1 against]
B) [option B]: [2 reasons for, 1 against]
Net: [one-line tradeoff]
```

Typical calls that warrant a brief: the spotlight radius and softness (a tight hot circle is dramatic but shows little of the after, a wide soft one reveals more but feels less like a torch), auto-animate the spotlight on desktop versus cursor-only (an idle auto-sweep teaches the visitor the trick, but a cursor-only reveal feels more earned), how dramatic the before-and-after delta should be (a subtle delta is tasteful but the reveal can read as a non-event, a strong delta lands but risks gimmick), and one hero versus a section series (this skill ships one hero, more than one spotlight on a page dilutes the single-focal premium). When the user names a site or studio as a reference, never guess the look from the name: ask for one sentence of description, then hand off to `crew-web-website-architect` (the inspiration lens) before proposing a look.

## Guardrails

Mechanic integrity (do not break these):
- The mask is a CSS `radial-gradient` centred by `--mx` / `--my` in viewport pixels, so cursor coordinates map 1:1 to the spotlight. Never scale the reveal layer with a CSS transform, it scales the masked layer and breaks alignment. Zoom both layers with the identical `background-size`.
- The mask string is set once, only the CSS variables change per frame in the single rAF loop. Never reintroduce a per-frame canvas `toDataURL` encode, it PNG-encodes a full-viewport image every frame and janks mid-range and mobile hardware.
- Pair the `-webkit-` prefix on `mask-image` and `mask-repeat` (`no-repeat`), so the gradient mask holds across browsers.
- The initial cursor is offscreen `(-9999, -9999)`, so the page loads with the base only.

Accessibility (hard requirements):
- The reduced-motion floor is mandatory and ships as real code. `prefers-reduced-motion` pins a fixed off-centre spotlight (a static partial reveal: the after inside the circle, the before around it) and never chases the cursor. The headline and CTA still read. The branch is the `reduce` check in `App.tsx` and `RevealLayer`, verifiable by grep, not a claim. A live `matchMedia('change')` listener honours an OS toggle without a reload.
- The mobile / no-pointer fallback is mandatory and ships as real code. A coarse pointer (`matchMedia('(pointer: coarse)')` or touch) has no cursor, so the spotlight auto-animates along a real 2D path and a tap moves it. A touch device must still tell the before-and-after story, never a dead screen. The branch is the `coarse` check in `App.tsx`, verifiable by grep. A live `matchMedia('change')` listener honours a hybrid device switching pointer type without a reload.

House style:
- Never use an em dash anywhere (text, CSS comments, TypeScript strings, and the chat reply). Use commas, periods, or parentheses.
- One hero, one focal point. Do not bolt a second spotlight or a carousel onto the screen, it dilutes the premium.
- Never put a real person's first name in demo copy.
- If a project brand playbook exists, it is the authority over the chosen look.

## Handoffs

- Run the Design Standards gate before the build ships: hand the built file plus the live local URL to the Design review gate: run `crew-design-quality` (binding) plus the Gate roster in `crew-design-quality`, here `crew-design-composition`, `crew-design-patterns`, the register-conditional pack-13 style lens (`crew-design-soft` (warm/premium), `crew-design-minimalist` (serious, composed), or `crew-design-brutalist` (raw/technical)), with `crew-animation-gsap` and `crew-animation-motion` consulted as authoring references. Fix all Criticals and Majors before deploy.
- Before the build ships or a live URL goes to a client, run `crew-core-quality-checker` (pack 01 core). Its output is advisory, not a hard gate: it does not block ship on its own the way the pack-12 reviewers (binding) do, but it flags broken links, console errors, and unverified claims to fix before handing a URL over. Pairs with the Crew Method standard "Verify before claiming done".
- Hand off to `crew-web-website-architect` (inspiration lens) when the user names a reference brand or studio: it pulls the real palette, type, and imagery into a fill-in kit before a look is proposed. An external research skill, where installed, can supplement for non-web references. Never guess a brand's look from the name alone.
- For a full session save beyond the per-skill handoff, hand off to `crew-core-context-save`.

## Plan mode

In plan mode this skill can ask the two discovery questions, read the prior handoff, and produce a build plan: the brand, the look and theme, the before-and-after transformation, the two matched image prompts drafted, the spotlight radius and softness recommendation, and the deploy recommendation, marked "DRAFT, plan mode" at the top. It cannot scaffold the project, generate the image pair, write to `~/.claude/crew-state/`, run the design review gate, or deploy. The build, the gate, the deploy, and the handoff save run only after plan mode is exited.

## Verification

Before the run is marked done, confirm:

```
[ ] The two discovery answers ran first; the brand and the before-and-after transformation came from the user, not invented
[ ] Two matched image prompts written, sharing one composition, 16:9, edges to black
[ ] The image pair generated (base then reveal off the base), framing matches, contrast strong, edges black
[ ] Project scaffolded from the locked template; only the marked slots substituted
[ ] hero-base.png and hero-reveal.png in public/, referenced as local files, never hotlinked
[ ] npm install clean, npx tsc --noEmit passes
[ ] The spotlight renders: the reveal shows inside a soft circle at the pumped cursor, the base everywhere else
[ ] The cursor-follow is smooth: the trailing lerp gives the spotlight its weighted trail in a real browser
[ ] Both layers use the identical background-size; the reveal layer is never CSS-transformed
[ ] The mask is a CSS radial-gradient moved only by --mx / --my per frame, no per-frame toDataURL encode; the initial cursor is offscreen so the page loads base-only
[ ] mask-image and mask-repeat carry the -webkit- prefix so the gradient mask holds across browsers
[ ] The mobile / no-pointer fallback works: coarse pointer auto-animates the spotlight on a 2D path, a tap moves it, hamburger shows, nav pill and Sign Up hidden
[ ] The reduced-motion path holds: prefers-reduced-motion pins a fixed off-centre spotlight (static partial reveal, both states visible), no cursor chase, headline and CTA read
[ ] reduced-motion and pointer:coarse have live matchMedia change listeners so an OS toggle or device switch is honoured without a reload
[ ] Design review gate run: crew-design-quality (binding), crew-design-composition, crew-design-patterns, the register-conditional pack-13 style lens, with crew-animation-gsap and crew-animation-motion as authoring refs; Criticals and Majors fixed
[ ] No em dashes anywhere (text, CSS comments, TypeScript strings)
[ ] The handoff was written to ~/.claude/crew-state/web-design/
```

## Completion

```
STATUS: DONE | DONE_WITH_CONCERNS | BLOCKED | NEEDS_CONTEXT
REASON: [why this status, specific]
RECOMMENDATION: [what should happen next]
```

## Failure modes seen in production

| Symptom | Cause | Fix |
|---|---|---|
| The hero janks and the fan spins, worse on mobile and at dpr 2 | A per-frame canvas `toDataURL` encode: a full-viewport image is PNG-encoded every frame and fed to `mask-image` | Drop the canvas entirely. Use a CSS `radial-gradient` mask and move it by writing `--mx` / `--my` in the single rAF loop, no encode per frame |
| The reveal does not line up with the base under the circle | The two images do not share one composition (the reveal drifted) | Regenerate the reveal as an image-to-image edit off the base so the framing and subject shape lock; both layers use the identical `background-size` |
| The spotlight lags far behind the cursor or stutters | Layout thrash: reading layout or doing heavy work on every mousemove | Keep the lerp in one rAF tick, only write the smoothed position to state, never read layout in the move handler |
| The hero is a dead screen on a phone, no reveal at all | No mobile fallback: a touch device has no cursor to follow | Add the coarse-pointer branch (`matchMedia('(pointer: coarse)')`) that auto-animates the spotlight on a path and honours a tap |
| A reduced-motion visitor gets a spotlight chasing the cursor | The `prefers-reduced-motion` path is missing | Add the `reduce` branch that pins a fixed off-centre spotlight (`--mx` / `--my` at a static point), a partial reveal with both states visible and no cursor chase |
| After a window resize the spotlight is a stale stretched smear until the next mouse move | A fixed-size mask bitmap was stretched to the new viewport and only repainted on the next pointer event | Use the CSS `radial-gradient` mask: it is sized in viewport pixels and recomputes itself on resize, so there is no stale bitmap and no resize desync |
| The page loads with the reveal already showing, no base | The initial cursor sits onscreen, or the mask defaulted opaque | Initialise the cursor offscreen at `(-9999, -9999)` so the mask is empty until the mouse moves |
| The spotlight tracks off from the cursor after a zoom | The reveal layer was scaled with a CSS transform | Zoom imagery with `background-size` only, never transform the masked layer, a transform scales the gradient mask with it |
