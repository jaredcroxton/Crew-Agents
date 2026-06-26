# CREW — World-Class AI Agent Skills for Claude Code

93 gold-standard skills. 14 packs. Every business function covered.

## What CREW is

CREW gives Claude Code the skills to operate as a full business team. Not one agent with surface-level knowledge — 93 specialised skills that know their domain, reference each other, and produce premium output with built-in quality gates.

One conversation onboards your business. Every skill reads your brand, your voice, your audience. Then they work.

## Architecture

```
BUSINESS ONBOARDING (11 questions, one file)
    ↓
SKILL INVOKED (93 skills across 14 packs)
    ↓
BRAND CONTEXT LOADED (every skill reads brand-context.md)
    ↓
DISCOVERY (fresh / continuing / existing brand)
    ↓
BUILD → QUALITY GATE → OUTPUT
```

## Pack structure

| Pack | Skills | Domain |
|------|--------|--------|
| 01-core | 8 | Context, quality, planning, brand onboarding |
| 02-sales | 7 | Lead research, outreach, proposals, pipeline |
| 03-marketing | 7 | Campaigns, brand voice, content, SEO, social |
| 04-ops | 5 | Process mapping, automation, dashboards |
| 05-hr | 5 | Interviews, role profiles, performance, policy |
| 06-finance | 6 | Invoicing, expenses, cashflow, dashboards |
| 07-support | 6 | Ticket triage, replies, FAQ, escalation |
| 08-docs | 7 | SOPs, policies, training guides, handovers |
| 09-training | 8 | Needs analysis, modules, facilitation, onboarding |
| 10-web-design | 9 | Slide decks, cinematic sites, dashboards, scroll journeys |
| 11-infrastructure | 1 | Project scaffolding |
| 12-design-standards | 7 | Quality, composition, patterns, language, reference |
| 13-design-styles | 5 | Brutalist, minimalist, soft, redesign, blueprint |
| 14-animation | 12 | GSAP, Motion, Lottie, Rive, Spring, CSS, and more |

## How skills are built

Every skill follows the gold standard:

- **Discovery section** — fresh, continuing, or existing brand routing
- **Modes** — Fast, Careful, Governed with anti-triggers
- **Domain reference sections** — extracted from buried expertise, promoted to named sections
- **Decision briefs** — the real ambiguous calls, with trade-offs named
- **Adversarial review** — 3 lenses (harness, white-label, senior domain expert) before QA
- **Design review gates** — build skills cross-reference packs 12-14, block on failure
- **Fixtures** — Cases A, B, C per skill

## Quality

- 0 em dashes
- 0 banned terms
- 0 fabricated output
- Every claim labelled Evidence or Inference
- Every skill above 15 sections
- QA PASS on all 14 packs

## Installation

```bash
# Install a single pack
claude plugins install crew-support

# Install all packs
claude plugins install crew-full

# Or from source
git clone https://github.com/jaredcroxton/crew-skill-packs.git
cd crew-skill-packs
bash package.sh && bash build-plugins.sh
```

## First run

Open Claude Code. Run any skill. If brand-context.md does not exist, the skill asks 11 questions. Every skill you run after that knows your business.

## License

MIT — use freely, modify freely, credit appreciated.
