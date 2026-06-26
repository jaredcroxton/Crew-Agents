# Web Design Pack

**Turn a brief and a brand into a finished, single-file web asset.**

These skills build production-ready web output (decks, sites) that runs offline with zero dependencies, in a brand you provide or a preset theme. Each one applies the brand you give it; none invent colours, fonts, names, or content.

| Skill | Does | Output |
|---|---|---|
| `crew-web-slide-deck-builder` | Builds a single-file HTML slide deck (title, content, code, image, CTA slides) in your brand or a preset theme, with full keyboard, dot, arrow, and swipe navigation | One self-contained `.html` deck, under 500KB |
| `crew-web-fly-through-builder` | Builds a cinematic scroll-driven fly-through site where scrolling scrubs a camera journey forward and backward under stage typography | One scroll-scrub site (canvas frame-sequence) |
| `crew-web-lead-dashboard-builder` | Turns a scrape target into a branded one-page lead dashboard with LinkedIn research, cold email drafts, follow-up sequences, and a design review gate | One dashboard.html plus scrape/leads JSON and outreach drafts |

`crew-web-slide-deck-builder` ships four preset themes in its `themes/` folder (Slate + Ink + Lime, White + Slate + Cyan, Black + Teal + Terminal, Ink + Blue + Violet). The user picks a preset or supplies their own brand; nothing is hardcoded.

Install this pack (Core comes with it): `./install.sh --pack web-design`
