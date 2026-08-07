# Web Design Pack

**Turn a brief and a brand into a finished, single-file web asset.**

These skills build production-ready web output (decks, sites, dashboards, cinematic scroll films) that runs offline with zero dependencies, in a brand you provide or a preset theme. Each one applies the brand you give it; none invent colours, fonts, names, or content.

| Skill | Does | Output |
|---|---|---|
| `crew-web-page-builder` | Builds a clean, premium multi-page business site (home, about, services, pricing, contact, FAQ, blog) with sticky nav, dark and light toggle, mobile-first, no framework and no canvas | One self-contained `.html` site, under 2s load |
| `crew-web-landing-page-builder` | Builds a conversion-focused page for ONE offer: above-the-fold outcome headline, one repeated CTA, honest social proof, objection blocks, and a real form with inline validation | One self-contained landing-page `.html` |
| `crew-web-booking-site-builder` | Builds the local-service business site (trades, salons, clinics, tutors) that drives the booking or the call: click-to-call, honest pricing, scheduler embed with tel and mailto fallback, LocalBusiness schema | One self-contained booking-site `.html` |
| `crew-web-slide-deck-builder` | Builds a single-file HTML slide deck (title, content, code, image, CTA slides) in your brand or a preset theme, with keyboard, dot, arrow, counter, and swipe navigation | One self-contained `.html` deck, under 500KB |
| `crew-web-slide-deck-mobile` | Builds a 9:16 vertical story deck for the phone: full-screen snap panels, reels-native type, media generated vertical at the source, plus a Mobile Quote template for sending proposals by text | One self-contained vertical `.html` deck |
| `crew-web-cinematic-build` | Builds an epic scroll-driven site with floating 3D objects in themed environments, scenes that morph on scroll, fog, bloom, oversized editorial type; the 3D world is built in-browser from nine still images, no footage needed | One self-contained cinematic scroll `.html` |
| `crew-web-fly-through-builder` | Builds a scroll-scrub site where scrolling scrubs one continuous camera journey forward and back under stage typography, ending at an arrival that expands into a listing, product, or story | One scroll-scrub site (canvas frame-sequence) |
| `crew-web-scrollytelling` | Builds a scroll-film site where the whole page is one continuous cinematic shot that plays as the visitor scrolls, beats of copy riding on the film, resolving into standard content sections; pure-code motion by default, chained generated footage as the opt-in signature lane | One self-contained scroll-film `.html` |
| `crew-web-product-film` | Builds an Apple-grade cinematic product film site (scroll-scrubbed video opening act plus a kinetic content act) for one physical product, seeded from the brand's own real imagery via the KIE pipeline | One self-contained product-film site plus generated frames |
| `crew-web-real-estate-immersive` | Builds a scroll-scrubbed cinematic property tour from a REAL listing: the listing's tour footage plays forward and back under serif chapter type, one chapter per room, plus photo gallery, floorplan, and agent CTAs | One self-contained listing tour site (real footage only) |
| `crew-web-lead-dashboard-builder` | Turns a scrape target into a branded one-page lead dashboard: fit-scores every lead 0 to 100, finds the decision-maker via LinkedIn with backups, drafts a cold email and a LinkedIn DM per lead, verify-before-send | One dashboard.html plus scrape/leads JSON and outreach drafts |
| `crew-web-website-architect` | Scrapes a live competitor or inspiration site and reverse-engineers type, colour, spacing, layout, surface, and motion into a reusable system; an analysis skill, it studies a site, it does not build one | One design-architecture report plus a fill-in token kit for `crew-web-page-builder` |
| `crew-web-stitch` | Generates an agent-friendly `DESIGN.md` taste contract for Google Stitch screen generation, encoding premium anti-generic standards, then verifies Stitch's rendered screens against the contract | One `DESIGN.md` taste contract plus a verification pass |
| `crew-web-app-builder` | The Express automation build protocol: scaffolds and builds any automation, scraper, webhook, cron job, or API integration as deterministic, self-healing Python tooling through the five-phase (Blueprint, Link, Architect, Stylize, Trigger) A.N.T. three-layer architecture | A scaffolded project (memory files, architecture SOPs, tested tools) and a build report |

## Routing the cinematic cluster

Four cinematic flagships (`crew-web-webcam-website`, `crew-web-immersive-narrative`, `crew-web-learning-experience`, `crew-web-spotlight-hero`) live in Pack 16, Showcase: a separate add-on zip that is not part of the standard install. Routing lines below that name them assume the Showcase pack is installed.

Several skills sit close together. Route in one read:

- **Clean multi-page single file** with real content, no motion film: `crew-web-page-builder`.
- **One offer, one page, built to convert**: `crew-web-landing-page-builder`.
- **Local service business that needs bookings and calls**: `crew-web-booking-site-builder`.
- **3D world and atmosphere on scroll** (objects, fog, bloom, built from stills, no footage): `crew-web-cinematic-build`.
- **One continuous camera journey scrubbed by the scrollbar**: `crew-web-fly-through-builder`.
- **The page IS the film, several beats on one unbroken shot, ending in content sections**: `crew-web-scrollytelling`.
- **A long-form story world with gated multi-stage reveals**: `crew-web-immersive-narrative` (Showcase pack).
- **An Apple-style page for one physical product**: `crew-web-product-film`.
- **A single-effect hero**: `crew-web-spotlight-hero` (cursor reveal) or `crew-web-webcam-website` (hand-tracking gesture scrub), both in the Showcase pack.

The dividing line inside the scroll-film skills is the camera: `cinematic-build` builds a 3D world from stills, `fly-through-builder` scrubs one ungated camera path, `immersive-narrative` (Showcase pack) gates a multi-stage story, and `product-film` and `real-estate-immersive` scrub footage for a product or a real listing.

## Craft law

Every skill in this pack reads `shared/web-standards.md`, installed beside the skills. It is the pack's craft law: the shared standard for type, colour, spacing, motion, and performance that keeps output premium and off the generic-AI baseline. Skills apply it before they ship.

`crew-web-slide-deck-builder` ships four preset themes in its `themes/` folder (Slate + Ink + Lime, White + Slate + Cyan, Black + Teal + Terminal, Ink + Blue + Violet). The user picks a preset or supplies their own brand; nothing is hardcoded.

Install this pack (Core comes with it): `./install.sh --pack web-design`
