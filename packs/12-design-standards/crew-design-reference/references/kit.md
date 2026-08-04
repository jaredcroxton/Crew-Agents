# Design kit spec (consulted via crew-design-reference)

The design kit is a curated lookup of premium colour palettes and font pairings for the person with no brand, no designer, and no reference, only a feeling and a thing to ship; this spec matches that feeling to a ready, accessible, copy-paste kit, one palette and one font pairing, already filled into a `:root` token block and a Google Fonts link, contrast checked before it ships.

## When to use the design kit

Do not use this spec to design a logo or a wordmark (this spec ships colour and type, not a mark). Do not use it to score an existing design (that is `crew-design-quality`, which scores a built result against the premium line). Do not use it to find real-world reference sites for a problem (that is `crew-design-reference`, which points at Stripe-level examples). Do not use it to onboard a real brand with a real palette and voice (that is `crew-core-brand-context`, which captures who you actually are). This spec is for the person with no brand who needs a good one to start.

## What a kit needs

You need:

- The feeling, one of the ten: Soft and warm, Clean and minimal, Bold and confident, Trustworthy and established, Cinematic and dark, Luxury and refined, Playful and friendly, Earthy and organic, Editorial and literary, Tech and electric.
- A dark or light preference, if you have one. If you do not, I return both so you can pick.
- The business type, optional (cafe, law firm, gym, SaaS, florist). Used only to confirm the feeling, never to override your choice.

If no feeling is given, ask once which of the ten it should feel like. Never guess the feeling. The feeling is the whole input; guessing it wrong wastes the kit. If you describe a business but no feeling, I name the feeling I would map it to and confirm before returning the kit.

## How the design kit thinks

1. **Feeling first.** The input is a feeling, not a colour. "Trustworthy" picks the palette; you do not start from a hex you like. Everything downstream is in service of the feeling the user named.
2. **Colour is a system, not a swatch.** A kit is eight tokens that relate (background, surface, text, border, accent), not a hero colour with the rest guessed. The relationships are what read premium; a single nice swatch surrounded by default greys does not.
3. **Contrast is non-negotiable and accessibility is the floor.** Body text clears 4.5:1 or the palette does not ship. This is not a nicety to add later, it is the gate every kit passes before it is named.
4. **A pairing is a contrast of role, not two display faces.** A pairing is a heading voice against a body workhorse (a serif display over a clean sans, a grotesk over a humanist sans), not two personalities competing. One face leads, one carries the reading.
5. **One accent discipline.** A single accent does the work: links, the primary button, the one thing the eye should find. A second accent appears only when the feeling earns it (Playful, Bold). Scattering accents is the fastest way to look default.
6. **Ownable beats default.** A muted terracotta over a warm off-white reads chosen. Indigo `#6366f1` on `#ffffff` reads "an AI picked this in two seconds". The library exists to keep you out of the default basin.
7. **Copy-paste ready.** The deliverable is a filled `:root` block and a working Google Fonts link, not a description of a palette. The user pastes it and it works.

## The palette library

Twenty curated palettes, two per feeling (one dark canvas, one light). Every set is a full token system with verified WCAG AA body contrast. Copy the :root block straight into a build. Swap nothing but the values you have a real brand reason to change.

### Soft and warm

**Cocoa and Apricot** (dark)  
Swatches: bg #221c19 / surface #2c2521 / text #f3e9e1 / muted #c1ab9d / accent #e8a06a  

```css
/* Cocoa and Apricot :: dark */
:root {
  --bg: #221c19;
  --surface: #2c2521;
  --surface-2: #372e29;
  --text: #f3e9e1;
  --text-muted: #c1ab9d;
  --border: #4a3e37;
  --accent: #e8a06a;
  --accent-ink: #2a1c10;
}
```

Why premium: A warm brown-black canvas (#221c19, red and yellow channels lifted above blue) instead of neutral charcoal makes the dark mode feel like candlelight, not a terminal. The single apricot accent (#e8a06a) is a desaturated clay-orange, the colour of skin and warm light, so calls to action feel like a hand on the shoulder rather than a system alert.  
AI would pick instead: A lazy build uses #0a0a0a or #111827 cold-grey canvas with a bright blue or teal accent, which reads clinical and tech, the opposite of warm.  
Reach for it: An evening-mood wellness studio, a candle or skincare brand, a therapy or counselling practice homepage, a community membership landing page.  
Contrast (verified): text / bg 14.06:1, text / surface 12.6:1, textMuted / bg 7.67:1, accentInk / accent 7.6:1, accent / bg 7.75:1.

**Oat and Terracotta** (light)  
Swatches: bg #faf4ec / surface #fffbf5 / text #3a302a / muted #7a6557 / accent #b5512f  

```css
/* Oat and Terracotta :: light */
:root {
  --bg: #faf4ec;
  --surface: #fffbf5;
  --surface-2: #f3e8da;
  --text: #3a302a;
  --text-muted: #7a6557;
  --border: #e6d6c5;
  --accent: #b5512f;
  --accent-ink: #fff6ef;
}
```

Why premium: An oat canvas (#faf4ec, warm cream not white) with espresso-brown text instead of black keeps everything soft and low-contrast-feeling while still passing AA with room to spare. The terracotta accent (#b5512f) is a baked-clay red-orange, grounded and handmade, the colour of a clay pot or a brick wall in afternoon sun, which signals care and craft over corporate polish.  
AI would pick instead: A lazy build uses pure #ffffff background, near-black #000000 text, and a saturated #007bff or indigo accent, which feels like a default form and strips out all the warmth.  
Reach for it: A family or paediatric practice, a doula or midwife site, a neighbourhood cafe or bakery, a community nonprofit, a yoga or postnatal class page.  
Contrast (verified): text / bg 11.75:1, text / surface 12.45:1, textMuted / bg 5.02:1, accentInk / accent 4.71:1, accent / bg 4.59:1.

### Clean and minimal

**Graphite and Chalk** (dark)  
Swatches: bg #121316 / surface #1a1c20 / text #f1f2f4 / muted #9ca1a9 / accent #c8cdd4  

```css
/* Graphite and Chalk :: dark */
:root {
  --bg: #121316;
  --surface: #1a1c20;
  --surface-2: #22252a;
  --text: #f1f2f4;
  --text-muted: #9ca1a9;
  --border: #2e3238;
  --accent: #c8cdd4;
  --accent-ink: #16181b;
}
```

Why premium: The canvas is a warm-cooled graphite (#121316), not pure black, so surfaces stacked on it read as quiet planes rather than harsh cutouts. The accent is itself a near-neutral chalk (#c8cdd4): the studio move of using light-on-dark as the only emphasis, no hue at all. A greyscale system that still feels intentional is what separates a design studio from a template. text #f1f2f4 on bg sits near 16:1, textMuted #9ca1a9 on bg clears 6:1, and accentInk #16181b on the chalk accent is near 13:1.  
AI would pick instead: A lazy build defaults to pure #000000 bg with #ffffff text and a saturated indigo #6366f1 button, then adds a purple glow. The tell is reaching for any hue when the brief said minimal.  
Reach for it: A design studio or product consultancy homepage, a portfolio, or a developer-tool landing page where the work itself should be the only colour on screen.  
Contrast (verified): text / bg 16.58:1, text / surface 15.23:1, textMuted / bg 7.15:1, accentInk / accent 11.13:1, accent / bg 11.62:1.

**Bone and Ink** (light)  
Swatches: bg #f6f4ef / surface #fffdf9 / text #1c1b18 / muted #615e57 / accent #1c1b18  

```css
/* Bone and Ink :: light */
:root {
  --bg: #f6f4ef;
  --surface: #fffdf9;
  --surface-2: #edeae2;
  --text: #1c1b18;
  --text-muted: #615e57;
  --border: #dcd8cf;
  --accent: #1c1b18;
  --accent-ink: #f6f4ef;
}
```

Why premium: A warm bone canvas (#f6f4ef) instead of clinical white, with a true-ink near-black (#1c1b18) carried all the way through to the accent. The button is ink on bone, the gallery-wall move where the darkest neutral is the brand colour. Warm paper tones make the whole thing feel printed, not screen-default. text #1c1b18 on bg is about 15:1, on surface #fffdf9 about 16:1, textMuted #615e57 on bg clears 6:1, and ink accent vs bone bg is roughly 15:1 so the button reads with full force.  
AI would pick instead: A lazy build picks #ffffff bg, #111827 text, a #007bff or #6366f1 primary button, and grey #6b7280 everywhere. The tell is the cold pure-white canvas and the obligatory blue CTA.  
Reach for it: A consultancy or studio site, an editorial product page, a premium services one-pager, or any brand that wants to feel like quality stationery rather than a SaaS dashboard.  
Contrast (verified): text / bg 15.67:1, text / surface 16.95:1, textMuted / bg 5.88:1, accentInk / accent 15.67:1, accent / bg 15.67:1.

### Bold and confident

**Carbon and Volt** (dark)  
Swatches: bg #0c0d10 / surface #16181d / text #f4f5f7 / muted #9ba2af / accent #c6ff2e  

```css
/* Carbon and Volt :: dark */
:root {
  --bg: #0c0d10;
  --surface: #16181d;
  --surface-2: #20232b;
  --text: #f4f5f7;
  --text-muted: #9ba2af;
  --border: #2c303a;
  --accent: #c6ff2e;
  --accent-ink: #0c0d10;
}
```

Why premium: Near-black carbon (#0c0d10, not pure #000) gives the surfaces depth so the single volt-green accent (#c6ff2e) reads like a charged wire, not a highlighter. One loud colour against deep neutral is what makes sport and energy brands feel expensive instead of busy. Volt on carbon clears roughly 16:1, and the dark ink on the bright accent keeps buttons legible and aggressive.  
AI would pick instead: A lazy build picks pure #000000 bg with fluoro green #39ff14 text everywhere, no surface layering, and electric green glows on every element until nothing leads.  
Reach for it: Functional fitness gym, performance supplement brand, esports team, or a launch page that needs one CTA to dominate.  
Contrast (verified): text / bg 17.81:1, text / surface 16.28:1, textMuted / bg 7.57:1, accentInk / accent 16.42:1, accent / bg 16.42:1.

**Bone and Signal Red** (light)  
Swatches: bg #f6f4ef / surface #ffffff / text #16140f / muted #5c574d / accent #cf2410  

```css
/* Bone and Signal Red :: light */
:root {
  --bg: #f6f4ef;
  --surface: #ffffff;
  --surface-2: #ece8e0;
  --text: #16140f;
  --text-muted: #5c574d;
  --border: #d9d3c7;
  --accent: #cf2410;
  --accent-ink: #ffffff;
}
```

Why premium: Warm bone (#f6f4ef) instead of clinical white reads as printed paper and gives the signal red (#cf2410) something to slam against. Near-black warm ink (#16140f) keeps body text near 15:1 on bone. The red clears 3:1 against the bone for visible accents and carries white text at roughly 4.74:1 on buttons, so it can shout in headlines and still behave in UI.  
AI would pick instead: A lazy build uses pure #ffffff bg, generic Bootstrap red #dc3545, cool grey #6c757d muted text, and a blue secondary that fights the red for attention.  
Reach for it: Boxing or strength studio, race event, streetwear drop, or a manifesto landing page that wants editorial weight with a fight in it.  
Contrast (verified): text / bg 16.74:1, text / surface 18.4:1, textMuted / bg 6.53:1, accentInk / accent 5.37:1, accent / bg 4.88:1.

### Trustworthy and established

**Slate and Brass** (dark)  
Swatches: bg #11161d / surface #1a212b / text #eef1f5 / muted #a4b0bf / accent #c79a4b  

```css
/* Slate and Brass :: dark */
:root {
  --bg: #11161d;
  --surface: #1a212b;
  --surface-2: #222c38;
  --text: #eef1f5;
  --text-muted: #a4b0bf;
  --border: #33404f;
  --accent: #c79a4b;
  --accent-ink: #1a130a;
}
```

Why premium: A deep blue-slate canvas (#11161d) instead of black reads like the panelled boardroom, not a startup. The single brass accent (#c79a4b) carries the gravitas of an engraved nameplate: warm, metallic, old-money, never fluoro. Dark gold on dark slate is the private-bank and law-firm signature, and the muted steel-blue text (#a4b0bf) keeps secondary copy calm rather than shouting.  
AI would pick instead: A lazy build would put a glowing #007bff or indigo #6366f1 button on near-black #000000, add a purple-to-blue gradient header, and call it fintech. That reads generic SaaS, not a firm with a forty-year track record.  
Reach for it: A wealth management or corporate law firm homepage, a B2B compliance product, or an annual-report microsite where the dark mode should feel like a leather-bound document, not a dashboard.  
Contrast (verified): text / bg 16.03:1, text / surface 14.3:1, textMuted / bg 8.25:1, accentInk / accent 7.14:1, accent / bg 7.05:1.

**Bone and Deep Teal** (light)  
Swatches: bg #f7f5f0 / surface #ffffff / text #1c2a2c / muted #54625f / accent #0c5c54  

```css
/* Bone and Deep Teal :: light */
:root {
  --bg: #f7f5f0;
  --surface: #ffffff;
  --surface-2: #efece4;
  --text: #1c2a2c;
  --text-muted: #54625f;
  --border: #d9d4c8;
  --accent: #0c5c54;
  --accent-ink: #ffffff;
}
```

Why premium: A warm bone canvas (#f7f5f0) rather than stark white softens the page like quality stationery and signals heritage. The deep pine-teal accent (#0c5c54) is the colour of old institutional ledgers and medical signage: serious, healthy, and trustworthy without the cliche corporate navy everyone reaches for. Ink text is a near-black teal (#1c2a2c) so the whole system feels tonally unified rather than a black-on-white default.  
AI would pick instead: A lazy build would use pure #ffffff bg, #007bff Bootstrap-blue links, slate-grey #64748b body text, and a navy header, the exact stock palette of every template healthcare and accounting site.  
Reach for it: A medical practice, accounting or advisory firm, insurance or B2B services landing page where the light mode needs to feel established and reassuring, with a calm distinctive accent for buttons and headings.  
Contrast (verified): text / bg 13.6:1, text / surface 14.82:1, textMuted / bg 5.86:1, accentInk / accent 7.85:1, accent / bg 7.21:1.

### Cinematic and dark

**Obsidian and Ember** (dark)  
Swatches: bg #0c0a0d / surface #16131a / text #f3eef0 / muted #a59ba8 / accent #ff5a3c  

```css
/* Obsidian and Ember :: dark */
:root {
  --bg: #0c0a0d;
  --surface: #16131a;
  --surface-2: #1f1b24;
  --text: #f3eef0;
  --text-muted: #a59ba8;
  --border: #322c39;
  --accent: #ff5a3c;
  --accent-ink: #1a0a06;
}
```

Why premium: The canvas is a warm near-black with a hint of violet (#0c0a0d, not flat grey), so the single ember accent (#ff5a3c) reads like a key light hitting one object in a dark room. That low-key lighting ratio (one bright source, everything else falling to shadow through surface #16131a to #1f1b24) is exactly how cinematic stills are graded. Body text #f3eef0 on #0c0a0d clears about 16:1, textMuted #a59ba8 clears about 7:1, and the ember on near-black sits well past 3:1, so the drama never costs legibility.  
AI would pick instead: A lazy build uses pure #000000 canvas with #ffffff text and an indigo #6366f1 or violet glow, then adds a purple-to-blue gradient to fake atmosphere. The result is cold and flat, not lit.  
Reach for it: A product launch page, an agency homepage, or a premium tech teaser where one hero shot or one headline should feel spotlit against the dark.  
Contrast (verified): text / bg 17.18:1, text / surface 16.02:1, textMuted / bg 7.38:1, accentInk / accent 6.22:1, accent / bg 6.37:1.

**Bone and Graphite** (light)  
Swatches: bg #f4f1ec / surface #fbf9f5 / text #1c1a18 / muted #605a52 / accent #9a3b28  

```css
/* Bone and Graphite :: light */
:root {
  --bg: #f4f1ec;
  --surface: #fbf9f5;
  --surface-2: #ebe6dd;
  --text: #1c1a18;
  --text-muted: #605a52;
  --border: #d8d1c6;
  --accent: #9a3b28;
  --accent-ink: #fbf9f5;
}
```

Why premium: Cinematic does not have to mean a dark canvas. This is the gallery-wall version: a warm bone paper (#f4f1ec, not clinical white) with near-black graphite ink (#1c1a18) and a single oxblood accent (#9a3b28) that behaves like a deep red velvet curtain or a film-poster spot colour. The restraint plus the warm-on-warm temperature reads as a premium print piece. Ink on bone clears about 15:1, textMuted #605a52 clears about 5.6:1 on bg, and oxblood with bone ink reverses past 6:1, so buttons stay readable.  
AI would pick instead: A lazy build drops to pure #ffffff with #000000 text and a Bootstrap blue #007bff button, or sprinkles 12 pastel accents. It loses the warmth and the single-colour discipline that makes this feel curated.  
Reach for it: A studio or production-house about page, a premium print-leaning brand site, or a launch invite where the light surface should still feel editorial and weighted.  
Contrast (verified): text / bg 15.4:1, text / surface 16.5:1, textMuted / bg 6.05:1, accentInk / accent 6.59:1, accent / bg 6.15:1.

### Luxury and refined

**Espresso and Brass** (dark)  
Swatches: bg #1a1613 / surface #231e1a / text #f1ebe2 / muted #b3a795 / accent #c2a06b  

```css
/* Espresso and Brass :: dark */
:root {
  --bg: #1a1613;
  --surface: #231e1a;
  --surface-2: #2c2621;
  --text: #f1ebe2;
  --text-muted: #b3a795;
  --border: #3a332c;
  --accent: #c2a06b;
  --accent-ink: #1a1613;
}
```

Why premium: A near-black warmed with brown (not a cold charcoal) reads like a dim hotel bar, not a tech dashboard. The single muted-brass accent (#c2a06b) carries jewellery and hospitality weight without going literal gold or shiny. Text #f1ebe2 is a warm ivory at roughly 13:1 on bg, so type feels printed rather than glowing. The brass against bg clears 3:1 for visibility, and accentInk near-black on brass clears 4.5:1 for buttons.  
AI would pick instead: A lazy build picks #000000 canvas, #ffffff text, and a saturated gold #ffd700 that looks like a casino. Or it reaches for the cold slate-grey dark theme every SaaS ships, which kills all warmth.  
Reach for it: A boutique hotel or restaurant landing page, a jewellery house lookbook, a fragrance or spirits product page where the photography is dark and the type should glow quietly.  
Contrast (verified): text / bg 15.17:1, text / surface 13.93:1, textMuted / bg 7.6:1, accentInk / accent 7.31:1, accent / bg 7.31:1.

**Bone and Oxblood** (light)  
Swatches: bg #f4f1ea / surface #fbf9f4 / text #23201b / muted #6a6457 / accent #7a3b2e  

```css
/* Bone and Oxblood :: light */
:root {
  --bg: #f4f1ea;
  --surface: #fbf9f4;
  --surface-2: #ece7dc;
  --text: #23201b;
  --text-muted: #6a6457;
  --border: #dcd5c7;
  --accent: #7a3b2e;
  --accent-ink: #fbf9f4;
}
```

Why premium: A bone-paper bg (#f4f1ea) instead of pure white gives the editorial, gallery-catalogue feel that white cannot. Ink #23201b is a soft near-black at roughly 13:1 on bg, easy on the eye for long body copy. The accent is a deep terracotta-oxblood (#7a3b2e), a restrained earthy red that signals fashion and craft, clearing 3:1 on bg and carrying near-white accentInk above 4.5:1 for buttons. textMuted #6a6457 holds about 5:1 on bg for captions.  
AI would pick instead: A lazy build uses #ffffff bg, #111827 Tailwind-gray text, and a generic blue or indigo link colour, which strips every trace of warmth and reads like a default template. Or it adds a drop shadow on every card to fake depth.  
Reach for it: A fashion brand or atelier homepage, a spa or wellness site, a jewellery collection grid, an editorial about-page or a hospitality menu where the layout should feel like a printed catalogue.  
Contrast (verified): text / bg 14.39:1, text / surface 15.43:1, textMuted / bg 5.21:1, accentInk / accent 8.01:1, accent / bg 7.47:1.

### Playful and friendly

**Plum Night and Mango** (dark)  
Swatches: bg #1e1630 / surface #2a2042 / text #f4eefb / muted #bdb0d6 / accent #ff9d3c  

```css
/* Plum Night and Mango :: dark */
:root {
  --bg: #1e1630;
  --surface: #2a2042;
  --surface-2: #352a52;
  --text: #f4eefb;
  --text-muted: #bdb0d6;
  --border: #473a68;
  --accent: #ff9d3c;
  --accent-ink: #2a1500;
}
```

Why premium: A deep aubergine canvas (not black) makes a single warm mango accent glow like a stage light, the cheerful-on-rich-dark contrast that gives food and creator apps a confident, candy-lit feel without going fluoro. Surfaces step plum to lighter plum so cards feel layered, not flat.  
AI would pick instead: A lazy build would put a saturated purple #8b5cf6 on near-black #0a0a0a and call it fun, or slap a purple-to-pink gradient on every button. The ownable move here is the warm amber accent against muted plum, with accentInk as deep brown ink not white.  
Reach for it: A dessert or coffee brand, a kids learning app, a creator membership landing page, anywhere a dark mode needs to feel warm and inviting rather than techy.  
Contrast (verified): text / bg 15.23:1, text / surface 13.35:1, textMuted / bg 8.53:1, accentInk / accent 8.41:1, accent / bg 8.36:1.

**Cream and Watermelon** (light)  
Swatches: bg #fff7ef / surface #ffffff / text #2b1d22 / muted #6f5560 / accent #d12d47  

```css
/* Cream and Watermelon :: light */
:root {
  --bg: #fff7ef;
  --surface: #ffffff;
  --surface-2: #ffeede;
  --text: #2b1d22;
  --text-muted: #6f5560;
  --border: #f1d9c8;
  --accent: #d12d47;
  --accent-ink: #ffffff;
}
```

Why premium: A warm cream base (not stark white) with a confident watermelon red reads friendly and appetising, the bakery-window warmth that feels handmade rather than corporate. The peachy surfaceAlt gives quiet zoning so the bright accent stays a treat used sparingly. The accent sits at #d12d47 so white button text clears WCAG AA at about 4.8 to 1.  
AI would pick instead: A lazy build pairs pure #ffffff with Bootstrap blue #007bff or a rainbow of pastel chips. The discipline here is one cream temperature throughout, ink that is warm near-black not #000, and a single juicy red doing all the lifting while still passing contrast where it carries text.  
Reach for it: A juice bar, ice-cream shop, family event site, a friendly SaaS pricing page, any consumer landing page that wants to feel sunny and edible.  
Contrast (verified): text / bg 15.21:1, text / surface 16.13:1, textMuted / bg 6.3:1, accentInk / accent 5.03:1, accent / bg 4.74:1.

### Earthy and organic

**Forest Floor and Clay** (dark)  
Swatches: bg #1c2019 / surface #262b22 / text #ebe7dc / muted #a8a899 / accent #c08552  

```css
/* Forest Floor and Clay :: dark */
:root {
  --bg: #1c2019;
  --surface: #262b22;
  --surface-2: #2f352a;
  --text: #ebe7dc;
  --text-muted: #a8a899;
  --border: #3c4234;
  --accent: #c08552;
  --accent-ink: #1c2019;
}
```

Why premium: A deep cold-leaning forest green canvas (#1c2019, not black) with a warm terracotta-clay accent (#c08552) reads like wet moss and fired pottery. The green-on-green surface stepping (bg to surface to surfaceAlt all sit within one olive family) is what high-end botanical and ceramics brands use, depth without contrast jumps. The cream text (#ebe7dc) is paper, not screen white.  
AI would pick instead: A lazy build picks pure #000 or a flat slate grey with a single bright leaf-green #22c55e accent, which reads tech-dashboard, not soil. It also tends to use white #ffffff text that glares against dark green instead of a warm bone.  
Reach for it: A regenerative farm, a small-batch ceramics studio, a natural skincare line, or a wine and produce supplier wanting an evening, grounded, premium feel.  
Contrast (verified): text / bg 13.38:1, text / surface 11.71:1, textMuted / bg 6.87:1, accentInk / accent 5.29:1, accent / bg 5.29:1.

**Oat and Olive** (light)  
Swatches: bg #f4f1e8 / surface #fbf9f3 / text #33342b / muted #5f6151 / accent #5d6840  

```css
/* Oat and Olive :: light */
:root {
  --bg: #f4f1e8;
  --surface: #fbf9f3;
  --surface-2: #ebe6d8;
  --text: #33342b;
  --text-muted: #5f6151;
  --border: #dcd6c4;
  --accent: #5d6840;
  --accent-ink: #fbf9f3;
}
```

Why premium: A warm oat-paper canvas (#f4f1e8, not white) with a muted olive accent (#5d6840) is the Aesop-and-farmers-market register: nothing is saturated, everything looks dyed by plants. The accent is a real olive, not a primary green, and the text is a soft near-black charcoal (#33342b) with green undertone so even the type feels organic. Border #dcd6c4 is a paper crease, never a hard grey line.  
AI would pick instead: A lazy build uses pure #ffffff background with #000000 text and a saturated #16a34a green, which feels like a recycling icon, not craft. It misses the warm paper cast and reaches for cold neutral greys that kill the earthiness.  
Reach for it: An organic cafe or bakery, a sustainable goods shop, an artisan food producer, or a wellness and herbal brand wanting a bright, calm, daylight feel.  
Contrast (verified): text / bg 11.16:1, text / surface 11.97:1, textMuted / bg 5.61:1, accentInk / accent 5.67:1, accent / bg 5.28:1.

### Editorial and literary

**Ink and Oxblood** (dark)  
Swatches: bg #161310 / surface #211c18 / text #efe7db / muted #b3a695 / accent #c25340  

```css
/* Ink and Oxblood :: dark */
:root {
  --bg: #161310;
  --surface: #211c18;
  --surface-2: #2b2520;
  --text: #efe7db;
  --text-muted: #b3a695;
  --border: #3a322b;
  --accent: #c25340;
  --accent-ink: #ffffff;
}
```

Why premium: The canvas is a warm near-black brown (#161310) rather than cold grey, so cream text (#efe7db) reads like print warmed by lamplight, not a glowing screen. The single accent is a lifted oxblood terracotta (#c25340), the colour of a leather spine caught in lamplight, used only for a rule or a pull-quote. It sits at roughly 4.2:1 on the ground, so it stays legible without ever turning into a tech-blue link. That restraint is what separates a literary journal from a tech blog.  
AI would pick instead: A lazy build uses pure #000000 with #ffffff text and a bright blue link, then leans on a sans heading. It would never reach for warm-black or terracotta-oxblood, and it would scatter three or four accent colours instead of holding one.  
Reach for it: A literary magazine, an essayist's personal site, a small press homepage, or a long-read feature page that wants a nocturnal, bookish weight.  
Contrast (verified): text / bg 15.09:1, text / surface 13.77:1, textMuted / bg 7.76:1, accentInk / accent 4.56:1, accent / bg 4.06:1.

**Bone and Ink** (light)  
Swatches: bg #f3ede2 / surface #faf6ee / text #22201c / muted #5f5a51 / accent #3f5d4f  

```css
/* Bone and Ink :: light */
:root {
  --bg: #f3ede2;
  --surface: #faf6ee;
  --surface-2: #ece4d6;
  --text: #22201c;
  --text-muted: #5f5a51;
  --border: #d8cfbf;
  --accent: #3f5d4f;
  --accent-ink: #f7f4ec;
}
```

Why premium: The page is bone (#f3ede2), an aged-paper off-white that sits easy on the eye for thousands of words, with near-black ink (#22201c) that holds full contrast without the harshness of pure black on pure white. The accent is a muted forest ink (#3f5d4f), the green of a library binding, for links and quote rules. It reads as paper, not as an app.  
AI would pick instead: A lazy build defaults to #ffffff background, #111827 text, and an indigo or Bootstrap-blue link, plus Inter for everything. It avoids warm paper tones because grey feels safe, which is exactly why it reads generic.  
Reach for it: A publishing house, a writer's portfolio, an essay collection, a book launch page, or a magazine archive that wants daylight and quiet authority.  
Contrast (verified): text / bg 13.96:1, text / surface 15.09:1, textMuted / bg 5.87:1, accentInk / accent 6.61:1, accent / bg 6.24:1.

### Tech and electric

**Carbon and Live Lime** (dark)  
Swatches: bg #0a0c10 / surface #12151c / text #eef2f6 / muted #9aa4b2 / accent #b6ff2e  

```css
/* Carbon and Live Lime :: dark */
:root {
  --bg: #0a0c10;
  --surface: #12151c;
  --surface-2: #1a1f29;
  --text: #eef2f6;
  --text-muted: #9aa4b2;
  --border: #272d38;
  --accent: #b6ff2e;
  --accent-ink: #0a0c10;
}
```

Why premium: The canvas is #0a0c10, a blue-leaning carbon black, not flat #000, so surfaces stack as readable planes (#12151c, #1a1f29) and the lime reads as emitted voltage against them. Text #eef2f6 on #0a0c10 is about 17:1, textMuted #9aa4b2 on bg about 7:1, and lime #b6ff2e on bg clears 3:1 with room. accentInk #0a0c10 on lime is near 16:1, so buttons stay legible. One charged accent, used like a terminal cursor or a passing-test indicator.  
AI would pick instead: Pure #000000 background with #6366f1 indigo buttons and a violet-to-blue hero gradient, plus three or four extra accent colours competing for attention.  
Reach for it: A developer tool, CI or observability product, or an AI infrastructure landing page where the accent should feel like a live signal.  
Contrast (verified): text / bg 17.4:1, text / surface 16.24:1, textMuted / bg 7.76:1, accentInk / accent 16.15:1, accent / bg 16.15:1.

**Paper and Cobalt Circuit** (light)  
Swatches: bg #f6f7f9 / surface #ffffff / text #0d1117 / muted #525c6b / accent #1f4fff  

```css
/* Paper and Cobalt Circuit :: light */
:root {
  --bg: #f6f7f9;
  --surface: #ffffff;
  --surface-2: #eef1f5;
  --text: #0d1117;
  --text-muted: #525c6b;
  --border: #dadfe6;
  --accent: #1f4fff;
  --accent-ink: #ffffff;
}
```

Why premium: A near-paper #f6f7f9 canvas with #ffffff cards keeps the surface engineered and bright without the harsh glare of pure-white-on-pure-white. Text #0d1117 on bg is about 18:1, on white surface about 19:1, textMuted #525c6b on bg about 6.7:1. The cobalt accent #1f4fff is a saturated electric blue, not the tired Bootstrap #007bff, and sits at roughly 5:1 on bg so it stays visible; accentInk #ffffff on cobalt is about 5.2:1 for solid buttons. One disciplined blue carrying all interaction.  
AI would pick instead: Generic #007bff or indigo #6366f1 links on a stark #ffffff page with grey #6b7280 text everywhere and no surface separation.  
Reach for it: A SaaS dashboard, API docs site, or a B2B product page that wants to read precise and trustworthy in daylight while keeping an electric edge.  
Contrast (verified): text / bg 17.65:1, text / surface 18.92:1, textMuted / bg 6.32:1, accentInk / accent 5.8:1, accent / bg 5.41:1.

## The pairing library

Twenty font pairings, two per feeling. Every family is a real Google Font. A pairing is a contrast of role: one face carries the headline, one carries the reading. The Google Fonts link is ready to paste into the head.

### Soft and warm

**Fraunces and Hanken Grotesk**  
Heading: Fraunces (400, 600). Body: Hanken Grotesk (400, 500).  
Why premium: Fraunces is a soft-serif with gentle ball terminals and a slightly old-style warmth, so headings feel handwritten-adjacent and human rather than authoritative. Hanken Grotesk underneath is a rounded, open humanist sans that reads calmly at small sizes, so the body never competes. The role contrast is clear: one expressive face up top, one quiet workhorse below.  
AI would pick instead: A lazy build sets everything in Inter or Poppins at one or two weights, which is legible but characterless and reads as a generic startup template with no warmth.  
Reach for it: Wellness, care, and family brands where the headline should feel like a warm greeting: clinics, studios, community pages, founder-led service sites.  
```html
<link href="https://fonts.googleapis.com/css2?family=Fraunces:wght@400;600&family=Hanken+Grotesk:wght@400;500&display=swap" rel="stylesheet" />
```

**Newsreader and Figtree**  
Heading: Newsreader (400, 500). Body: Figtree (400, 600).  
Why premium: Newsreader is an editorial serif with a soft, readable contrast and an open aperture, so headings feel like a thoughtful letter or a magazine column rather than marketing. Figtree is a friendly geometric-humanist sans with rounded forms that keeps body copy gentle and modern. Together they read literate and personal, the tone of a brand that writes to you, not at you.  
AI would pick instead: A lazy build reaches for Playfair Display paired with Montserrat, the most overused premium-looking combo, which now signals template rather than taste and has tight Playfair counters that hurt readability at body-adjacent sizes.  
Reach for it: Community and care brands with real copy to read: nonprofit storytelling pages, coaching and counselling sites, parenting or postnatal resources, membership and newsletter landing pages.  
```html
<link href="https://fonts.googleapis.com/css2?family=Newsreader:wght@400;500&family=Figtree:wght@400;600&display=swap" rel="stylesheet" />
```

### Clean and minimal

**Fraunces and Inter**  
Heading: Fraunces (400, 600). Body: Inter (400, 500).  
Why premium: Fraunces is a high-contrast old-style serif with optical sizing, so large headings get the dramatic thick-thin modulation that signals editorial craft, while Inter underneath is the most legible neutral grotesk for running text. The role contrast is exact: expressive serif voice up top, silent workhorse body below. Set Fraunces 400 for big display lines, 600 for sub-heads, Inter 400 body with 500 for UI labels.  
AI would pick instead: A lazy build sets everything in one font, usually Inter or Roboto at 400, with bold headings and no display face at all. The tell is the total absence of a type voice, every level is the same UI font scaled up.  
Reach for it: A design studio, an editorial product page, or a consultancy that wants intelligence and warmth without looking corporate.  
```html
<link href="https://fonts.googleapis.com/css2?family=Fraunces:wght@400;600&family=Inter:wght@400;500&display=swap" rel="stylesheet" />
```

**Space Grotesk and Hanken Grotesk**  
Heading: Space Grotesk (500, 700). Body: Hanken Grotesk (400, 500).  
Why premium: An all-grotesk pairing that stays minimal but still has a signature: Space Grotesk has proto-mono letterforms (the distinctive g, a, and angled terminals) that give headings a modern-product personality, while Hanken Grotesk is a humanist sans with open apertures that reads softer in long paragraphs. Two sans, clearly different roles, one with character, one with calm. Space Grotesk 700 for hero lines, 500 for section labels, Hanken 400 for body and 500 for emphasis.  
AI would pick instead: A lazy build reaches for Poppins or Montserrat for headings and pairs them with themselves, geometric circles everywhere, which reads generic-startup rather than considered.  
Reach for it: A modern software product, a tech consultancy, or a startup landing page that wants to feel current and clean without a serif.  
```html
<link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@500;700&family=Hanken+Grotesk:wght@400;500&display=swap" rel="stylesheet" />
```

### Bold and confident

**Syne 800 over Hanken**  
Heading: Syne (700, 800). Body: Hanken Grotesk (400, 600).  
Why premium: Syne at 800 has flared, almost architectural terminals that feel like a sport wordmark or a festival poster, loud without being a novelty face. Hanken Grotesk underneath is a calm, wide-aperture grotesk that stays neutral at paragraph size, so the contrast is role (expressive display vs workhorse body), not two display faces shouting over each other.  
AI would pick instead: A lazy build sets everything in Inter or Poppins at one weight and calls it bold by just bumping headings to 700.  
Reach for it: Event sites, creative studios, gyms, and challenger product pages where the headline is the hero.  
```html
<link href="https://fonts.googleapis.com/css2?family=Syne:wght@700;800&family=Hanken+Grotesk:wght@400;600&display=swap" rel="stylesheet" />
```

**Archivo 900 over Work Sans**  
Heading: Archivo (700, 900). Body: Work Sans (400, 500).  
Why premium: Archivo at 900 is a dense, tightly-set grotesk built for big headlines that hold their weight at huge sizes, the look of a scoreboard or a sneaker billboard. Work Sans is a quieter, slightly humanist grotesk for body, so the pairing shares grotesk DNA but uses a sharp weight jump to drive hierarchy instead of two competing display faces.  
AI would pick instead: A lazy build reaches for Montserrat Bold headings on Open Sans body, the default corporate-energetic combo that reads as a 2016 template.  
Reach for it: Sportswear, fitness apps, bold SaaS landing pages, and conference or tournament sites that need maximum headline impact.  
```html
<link href="https://fonts.googleapis.com/css2?family=Archivo:wght@700;900&family=Work+Sans:wght@400;500&display=swap" rel="stylesheet" />
```

### Trustworthy and established

**Spectral and Public Sans**  
Heading: Spectral (500, 600). Body: Public Sans (400, 600).  
Why premium: Spectral is a Production Type serif drawn for screen reading with a calm, lawyerly authority: it carries headlines with weight without ever looking decorative. Public Sans (the US federal government design-system face) as body signals institutional credibility and is exceptionally legible at small sizes. The role contrast is clean: one composed serif voice for headings, one neutral civic grotesk for paragraphs.  
AI would pick instead: A lazy build would set everything in Inter, or pair two sans like Inter and Roboto, producing a flat generic SaaS page with no sense of establishment or hierarchy.  
Reach for it: Law firms, policy and advisory practices, financial-services pages, and any long-form trust copy (about pages, disclosures, white papers) where the body text has to stay readable across paragraphs.  
```html
<link href="https://fonts.googleapis.com/css2?family=Public+Sans:wght@400;600&family=Spectral:wght@500;600&display=swap" rel="stylesheet" />
```

**Libre Caslon and Libre Franklin**  
Heading: Libre Caslon Text (400, 700). Body: Libre Franklin (400, 500).  
Why premium: Caslon is the typeface of constitutions, legal documents, and centuries-old printing: nothing reads more established. Libre Caslon Text is optimised for body and heading sizes on screen so it keeps that pedigree without breaking. Pairing it with Libre Franklin (a refined Franklin Gothic revival, the classic American newspaper grotesk) gives a heritage serif heading over a quietly authoritative sans body, a documented historical pairing rather than two random fonts.  
AI would pick instead: A lazy build would reach for Playfair Display over Lato, the single most overused fake-premium combination on template sites, where Playfair's thin hairlines shimmer and break and the pairing reads wedding-blog rather than institution.  
Reach for it: Established professional firms, healthcare and insurance brands, heritage B2B companies, and trust-page or letterhead-style layouts where the brand wants to feel like it has existed for generations.  
```html
<link href="https://fonts.googleapis.com/css2?family=Libre+Caslon+Text:wght@400;700&family=Libre+Franklin:wght@400;500&display=swap" rel="stylesheet" />
```

### Cinematic and dark

**Fraunces and Hanken Grotesk**  
Heading: Fraunces (400, 600). Body: Hanken Grotesk (400, 500).  
Why premium: Fraunces is a high-contrast display serif with optical sizing and a soft wedge to its serifs, so a large dark-mode headline catches light the way film title cards do. Hanken Grotesk is a calm, slightly humanist grotesk that disappears into long body copy, so the contrast is purely role: expressive serif against quiet sans. The pairing has the weight and the warmth a cinematic dark page needs without two faces competing.  
AI would pick instead: A lazy build sets both heading and body in Inter, or pairs Playfair Display with Roboto and calls it elegant, producing a generic SaaS look with no editorial tension.  
Reach for it: Agency and launch pages where the headline is the hero and the body must stay readable at length.  
```html
<link href="https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,400;9..144,600&family=Hanken+Grotesk:wght@400;500&display=swap" rel="stylesheet" />
```

**Instrument Serif and Schibsted Grotesk**  
Heading: Instrument Serif (400). Body: Schibsted Grotesk (400, 600).  
Why premium: Instrument Serif is a single-weight high-contrast serif with tall, narrow letterforms that set enormous at hero scale and read as a film credit when sized to fill the viewport. Schibsted Grotesk is a tidy, modern grotesk with even rhythm that anchors the page underneath. One expressive serif, one neutral workhorse: the contrast is scale and role, not two loud faces fighting. The narrow serif is what keeps this from looking like every other dark template.  
AI would pick instead: A lazy build reaches for Space Grotesk as the headline plus DM Sans body, a default dark-mode tech combination with no serif drama and no ownable character.  
Reach for it: Premium tech teasers and single-product launch sites where one oversized serif headline carries the whole composition.  
```html
<link href="https://fonts.googleapis.com/css2?family=Instrument+Serif:ital@0;1&family=Schibsted+Grotesk:wght@400;600&display=swap" rel="stylesheet" />
```

### Luxury and refined

**Fraunces and Hanken Grotesk**  
Heading: Fraunces (400, 500). Body: Hanken Grotesk (400, 500).  
Why premium: Fraunces is a soft-serif with optical-size warmth and a slight calligraphic wobble that feels couture, not corporate, especially at large display sizes in 400. Hanken Grotesk is a humanist grotesk with enough warmth in its curves to sit under Fraunces without clashing, and it stays highly legible at 16px body. The contrast is role-based: expressive serif heading, calm grotesk body.  
AI would pick instead: A lazy pairing uses Playfair Display for headings and Inter for body on every single luxury template, so it now reads as the default AI luxury look rather than a choice.  
Reach for it: Fashion, jewellery, and beauty brands where headings are large and sparse and the body copy is short editorial blocks.  
```html
<link href="https://fonts.googleapis.com/css2?family=Fraunces:wght@400;500&family=Hanken+Grotesk:wght@400;500&display=swap" rel="stylesheet" />
```

**Cormorant Garamond and Work Sans**  
Heading: Cormorant Garamond (400, 600). Body: Work Sans (400, 500).  
Why premium: Cormorant Garamond is a high-contrast Garamond revival with tall, thin strokes that read as quiet old-world luxury when set large with loose tracking, the look of an engraved invitation. Work Sans is a low-key geometric-humanist grotesk that recedes and lets the serif lead, staying crisp at small sizes for menus and captions. Two roles, one expressive serif and one neutral body, never two display faces fighting.  
AI would pick instead: A lazy build sets Cormorant at body size where its thin strokes vanish and legibility collapses, or pairs it with another ornate serif so nothing leads.  
Reach for it: Hospitality and fine-dining sites, wedding or event pages, spa and resort homepages where headings can be set big with airy letter-spacing.  
```html
<link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400;600&family=Work+Sans:wght@400;500&display=swap" rel="stylesheet" />
```

### Playful and friendly

**Fraunces and Plus Jakarta Sans**  
Heading: Fraunces (500, 600). Body: Plus Jakarta Sans (400, 500, 600).  
Why premium: Fraunces has a soft, wobbly optical warmth (the soft serifs and slight wonkiness) that feels handmade and grin-inducing at display size, while Plus Jakarta Sans is a rounded humanist grotesk that stays calm and crisp in body copy. Expressive serif heading against a friendly neutral body, contrast of role not volume.  
AI would pick instead: A lazy build reaches for Poppins everywhere, or pairs two rounded display faces (Baloo plus Quicksand) so nothing leads. Here one warm serif signs the brand and one quiet rounded sans carries the reading.  
Reach for it: Food brands, bakeries, family or lifestyle apps, anywhere the headline should feel warm and characterful but the paragraphs must stay effortless to read.  
```html
<link href="https://fonts.googleapis.com/css2?family=Fraunces:wght@500;600&family=Plus+Jakarta+Sans:wght@400;500;600&display=swap" rel="stylesheet" />
```

**Bricolage Grotesque and Figtree**  
Heading: Bricolage Grotesque (600, 700). Body: Figtree (400, 500).  
Why premium: Bricolage Grotesque is a quirky, slightly irregular display grotesk with personality in its cuts, giving headlines a modern-playful edge without cartoon roundness, while Figtree is a soft, geometric sans that is open and friendly at paragraph size. One characterful display, one clean body, no competition.  
AI would pick instead: A lazy build uses Quicksand or Comic-adjacent rounded fonts for the whole page to signal fun, which reads juvenile and low-trust. This pairing keeps the fun in the headline shapes and lets the body stay sharp and credible.  
Reach for it: Creator tools, consumer apps, playful startups, event and community pages that want energy and edge while keeping a trustworthy, readable body.  
```html
<link href="https://fonts.googleapis.com/css2?family=Bricolage+Grotesque:wght@600;700&family=Figtree:wght@400;500&display=swap" rel="stylesheet" />
```

### Earthy and organic

**Fraunces and Hanken Grotesk**  
Heading: Fraunces (400, 600). Body: Hanken Grotesk (400, 500).  
Why premium: Fraunces is a soft-serif with a hand-cut, almost botanical character (the optical wonky axis gives headings a warmth that feels grown, not generated), and it pairs against Hanken Grotesk, a calm humanist sans that stays out of the way for body copy. The role contrast is clear: one expressive, one quiet.  
AI would pick instead: A lazy build sets headings in Playfair Display and body in Inter, the default editorial-template pairing seen everywhere, or worse runs everything in one weight of a single sans.  
Reach for it: A farm-to-table menu, a craft producer's about page, or a sustainability brand homepage where headings should feel handmade.  
```html
<link href="https://fonts.googleapis.com/css2?family=Fraunces:wght@400;600&family=Hanken+Grotesk:wght@400;500&display=swap" rel="stylesheet" />
```

**Spectral and Work Sans**  
Heading: Spectral (500, 600). Body: Work Sans (400, 500).  
Why premium: Spectral is a screen-native serif with generous, leafy serifs and real warmth at heading sizes, quieter and more grounded than a display face, so it suits earthy copy without shouting. Work Sans underneath is a friendly low-contrast grotesk that reads cleanly at small sizes. Serif heading plus grotesk body is a role contrast, not two competing voices.  
AI would pick instead: A lazy build pairs Lora with Open Sans (the generic blog-template combo) or sets both heading and body in the same Roboto, flattening any sense of craft.  
Reach for it: A regenerative agriculture explainer, a herbal or apothecary product page, or a slow-food editorial site that needs long-read comfort.  
```html
<link href="https://fonts.googleapis.com/css2?family=Spectral:wght@500;600&family=Work+Sans:wght@400;500&display=swap" rel="stylesheet" />
```

### Editorial and literary

**Fraunces and Newsreader**  
Heading: Fraunces (400, 600). Body: Newsreader (400, 500).  
Why premium: Fraunces is a high-contrast old-style display serif with optical sizing and a soft wonky character that signals a human-set headline, not a system font. Newsreader is built for screen reading at body size, so the eye travels paragraphs without fatigue. Serif heading over serif body keeps the whole page in one warm literary register.  
AI would pick instead: A lazy build sets Playfair Display headings over Inter or Roboto body, the most overused fancy-serif-plus-generic-sans combo on the web. It would not pick a body serif tuned for long reading.  
Reach for it: A magazine, a long-form essay site, or a small press where the headline should feel typeset and the body should disappear into the reading.  
```html
<link href="https://fonts.googleapis.com/css2?family=Fraunces:wght@400;600&family=Newsreader:wght@400;500&display=swap" rel="stylesheet" />
```

**Spectral and Source Serif 4**  
Heading: Spectral (500, 600). Body: Source Serif 4 (400, 600).  
Why premium: This is the tighter, more newspaper-column register, distinct from the warm Fraunces pairing. Spectral was drawn by Production Type for dense screen text, so its headings carry editorial gravity with a slightly cooler, more upright cut than Fraunces. Source Serif 4 is a low-contrast transitional serif sized for sustained reading, so columns hold their colour at small sizes. Two serifs from different optical families give a journal-and-bylines feel rather than a softer essay feel.  
AI would pick instead: A lazy build would use Merriweather headings over Open Sans body, or set the same serif at every level with no register shift. It would not deliberately contrast two serifs from different families to change the page's voice from soft to architectural.  
Reach for it: A dense editorial journal with bylines and captions, an annual report read like a magazine, or an archive index where every level needs to stay serif and crisp at small sizes.  
```html
<link href="https://fonts.googleapis.com/css2?family=Spectral:wght@500;600&family=Source+Serif+4:wght@400;600&display=swap" rel="stylesheet" />
```

### Tech and electric

**Space Grotesk and IBM Plex Mono**  
Heading: Space Grotesk (500, 700). Body: IBM Plex Mono (400, 500).  
Why premium: Space Grotesk has the squared terminals and slightly mechanical g and a that signal engineering without going full retro. Pairing it with IBM Plex Mono as body gives every line the feel of a config file or a readme, which is exactly the credibility a dev tool wants. The role contrast is structural display grotesk over a calm fixed-width body, never two display faces.  
AI would pick instead: Inter for both heading and body at 600 and 400, the default Vercel-clone stack that reads as a template.  
Reach for it: A CLI tool, an SDK landing page, or any product where the audience reads code all day and trusts a monospace voice.  
```html
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Mono:wght@400;500&family=Space+Grotesk:wght@500;700&display=swap" rel="stylesheet" />
```

**Sora and Spline Sans Mono**  
Heading: Sora (600, 700). Body: Spline Sans Mono (400, 500).  
Why premium: Sora is a geometric grotesk with tight, confident headlines that hold up at large display sizes for hero statements. Spline Sans Mono is a warmer, more humanist monospace than Plex, so longer body copy stays readable while keeping the engineered texture. The contrast is a clean geometric heading against a softer code-flavoured body, two distinct roles, not two loud faces.  
AI would pick instead: DM Sans paired with itself, or Space Grotesk used for both heading and body, flattening the hierarchy.  
Reach for it: An AI product, an infrastructure or platform site, or a technical pitch deck that needs bold headlines plus readable technical body copy.  
```html
<link href="https://fonts.googleapis.com/css2?family=Sora:wght@600;700&family=Spline+Sans+Mono:wght@400;500&display=swap" rel="stylesheet" />
```


## Kit lookup

Match a kit by the feeling you named, or by the kind of business you run.

**By feeling.** Name the feeling and see the palette and pairing entries above:

- Soft and warm: see the palette and pairing entries above.
- Clean and minimal: see the palette and pairing entries above.
- Bold and confident: see the palette and pairing entries above.
- Trustworthy and established: see the palette and pairing entries above.
- Cinematic and dark: see the palette and pairing entries above.
- Luxury and refined: see the palette and pairing entries above.
- Playful and friendly: see the palette and pairing entries above.
- Earthy and organic: see the palette and pairing entries above.
- Editorial and literary: see the palette and pairing entries above.
- Tech and electric: see the palette and pairing entries above.

**By business type.** If you know the business but not the feeling, this maps the common ones to the feeling that fits, then I return that feeling's kit:

- Cafe or coffee roaster: Soft and warm, or Earthy and organic if the bean and origin story leads.
- Law firm or accountant: Trustworthy and established.
- Gym, studio, or sports brand: Bold and confident.
- Salon, spa, or beauty: Luxury and refined, or Soft and warm for a gentler, community feel.
- SaaS or software product: Clean and minimal, or Tech and electric for a dev tool or AI product.
- Florist or event styling: Soft and warm, or Editorial and literary for a refined, type-led look.
- Design studio or agency: Clean and minimal, or Cinematic and dark for a premium launch feel.
- Clinic, dentist, or healthcare: Trustworthy and established.
- Restaurant or food brand: Playful and friendly, or Earthy and organic for farm-to-table.
- Consultancy or B2B service: Clean and minimal, or Trustworthy and established for finance and legal-adjacent work.
- Publisher, writer, or newsletter: Editorial and literary.
- Sustainability, outdoor, or craft brand: Earthy and organic.

The business type confirms the feeling. It never overrides a feeling you chose yourself.

## Anti-slop lens

The colours and fonts an AI defaults to, named so the library can avoid every one of them.

```
Indigo #6366f1 and violet #8b5cf6: the two hexes that scream "default AI accent". The library uses owned hues (terracotta, deep teal, ochre, oxblood, forest) tied to the feeling instead.
The purple-to-blue gradient: the single most recognisable AI-slop signature. The library uses flat colour fields or one restrained accent, never a glow.
Pure #000 and pure #fff: harsh, flat, and lazy. The library uses near-black (#11110F range) and warm or cool off-whites (#FAF8F4 range) so surfaces have depth.
Bootstrap blue (#007bff) and the generic SaaS blue: the "we picked the framework default" tell. The library uses a chosen blue with a job (Wise-green confidence, a deep navy for trust), never the stock one.
Inter for absolutely everything: a fine body face turned into a non-decision. The library pairs Inter only as a body workhorse under a face with a voice, never as the whole identity.
Poppins as a personality: geometric roundness mistaken for friendliness. The library reaches for a real display face (Fraunces, Space Grotesk, Bricolage) when a feeling needs character.
Two competing display fonts: two faces both shouting, no reading voice. The library always pairs one display face against one body workhorse, a contrast of role.
Grey-on-grey that fails contrast: #999 text on #f5f5f5, soft and unreadable. The library checks every body pair against 4.5:1 and names the ratio before it ships.
```

The library does the opposite of each line: owned hues over default indigo, flat fields over the gradient, near-black and off-white over pure black and white, a chosen blue over the framework one, a real display face over Poppins-as-personality, one heading voice against one body workhorse, and a contrast ratio stated, not assumed.

## Application rules

The canonical token template. Every palette in the library fills these eight names, so any build skill consumes a kit the same way.

```
:root {
  --bg:          /* the page background, the deepest or lightest surface */
  --surface:     /* a card or raised panel, one step off the background */
  --surface-2:   /* a second raised level, for nested cards or hover */
  --text:        /* the primary reading colour, clears 4.5:1 on --bg */
  --text-muted:  /* secondary text, captions, labels, clears 4.5:1 on --bg */
  --border:      /* hairline dividers and card edges */
  --accent:      /* the single accent: links, primary button, focal point */
  --accent-ink:  /* the text colour that sits on --accent, clears 4.5:1 on it */
}
```

How a build skill consumes a kit: paste the filled `:root` at the top of the stylesheet, then reference the tokens (`background: var(--bg)`, `color: var(--text)`, `background: var(--accent); color: var(--accent-ink)` for the primary button). The eight names never change across feelings, only the values do, so a skill written against the template works with any kit.

The Google Fonts link pattern, with `display=swap` and the two preconnect hints so the fonts load without a flash and without blocking render:

```
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Heading+Face:wght@400;700&family=Body+Face:wght@400;500;600&display=swap" rel="stylesheet">
```

This kit feeds `crew-web-page-builder` and `crew-web-slide-deck-builder`: both read the filled `:root` and the link, so the page and the deck share one palette and one pairing without re-deciding.

## Lookup workflow

1. **Identify the feeling.** Restate it in one line. If the user gave a business type but no feeling, name the feeling you map it to and confirm. If neither feeling nor business is given, ask once which of the ten it should feel like.
2. **Match the palette and the pairing.** Pull the palette and the font pairing for the feeling from the library above. Never reach outside the library for a font; every family is a named Google Font.
3. **Fill the `:root` and the link.** Drop the palette's hexes into the eight token names and build the Google Fonts link for the pairing with `display=swap` and the preconnect hints.
4. **State the contrast.** Name the body-on-background ratio and confirm it clears 4.5:1 (and note AAA, 7:1, where a stricter gate is wanted). If a palette pair fails, fix the value before it ships, do not ship and warn.
5. **Offer a dark and a light option.** Unless the user stated a preference, return both a dark and a light variant of the feeling so they can pick. If they stated one, return that one and note the other is available.
6. **Verify before emitting.** Confirm every font is a real Google Font, every body contrast passes 4.5:1, no AI-slop default slipped in (no indigo, no purple-to-blue, no pure black or white, no Inter-for-everything), one accent unless the feeling earns two, and the `:root` and link are complete and paste-ready. Only then emit.

## Worked example

The spec as the source skill returned it, the shape a consult answer should take.

```
DESIGN KIT
Feeling: Trustworthy and established   Mode: Careful

Palette: Harbour Navy (light)
:root {
  --bg:          #F7F8FA;
  --surface:     #FFFFFF;
  --surface-2:   #EEF1F5;
  --text:        #16202E;
  --text-muted:  #51607A;
  --border:      #D8DEE7;
  --accent:      #1E4D8C;
  --accent-ink:  #FFFFFF;
}

Pairing: Libre Franklin over Source Sans 3
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Libre+Franklin:wght@600;700&family=Source+Sans+3:wght@400;500;600&display=swap" rel="stylesheet">

Contrast: --text #16202E on --bg #F7F8FA is 14.6:1, passes AA and AAA. --text-muted #51607A on --bg is 5.1:1, passes AA. --accent-ink #FFFFFF on --accent #1E4D8C is 7.6:1, passes AA and AAA.
Why: a deep navy reads institutional and calm (the colour of finance and law for a reason), the off-white background and warm-grey muted text keep it credible without going cold. Libre Franklin's even weight signals authority, Source Sans 3 carries dense body copy cleanly.
```

## Guardrails

- Never invent a font. Google Fonts only, every family real and loadable. If a face you want is not on Google Fonts, pick the closest one that is and name it.
- Never ship body text below 4.5:1. The palette is rebuilt until it passes, it is never shipped with a warning.
- Every hex traces to a named palette in the library. No improvised colours, no "close enough" values typed from memory.
- One accent unless the feeling earns more. Bold and Playful may carry a second; the other eight feelings hold to one.
- No AI-slop defaults: no indigo `#6366f1`, no violet `#8b5cf6`, no purple-to-blue gradient, no pure `#000` or `#fff`, no Bootstrap blue, no Inter-as-the-whole-identity, no two competing display faces.
- No emoji, no filler adjectives ("clean", "modern", "sleek" as the whole reason). Name the hue and the reason it fits the feeling.
- If a project brand playbook exists (a real palette, a real pairing, an approved direction), it is the authority. This skill is for the no-brand starting point; the playbook wins the moment one exists.

## Pairings and boundaries

- Feed the filled `:root` and the Google Fonts link into `crew-web-page-builder` and `crew-web-slide-deck-builder`, so the page and the deck share one palette and one pairing.
- Pair with `crew-design-quality` to score the built result against the premium line, and with `crew-design-reference` to find real-world sites that hit the same feeling for layout and motion direction.
- If the user turns out to have a real brand (a logo, an existing palette, a voice), hand off to `crew-core-brand-context` to capture it properly; this spec is the placeholder until then.

## Verification

Before the run is marked done, confirm:

```
[ ] The feeling was identified (named by the user, or mapped from the business type and confirmed)
[ ] A palette and a pairing were returned with a filled :root and a Google Fonts link
[ ] Every font named is a real Google Font, loadable from the link
[ ] Every body contrast passes 4.5:1, with the ratio stated
[ ] No AI-slop default was used (no indigo, no purple-to-blue, no pure black or white, no Inter-for-everything)
[ ] One accent discipline held (a second only where the feeling earned it)
[ ] A dark and a light variant were both offered, or the user's stated choice was noted
```
