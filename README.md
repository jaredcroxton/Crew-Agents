<p align="center">
  <img src="https://img.shields.io/badge/version-1.0-lime?style=for-the-badge" alt="Version 1.0">
  <img src="https://img.shields.io/badge/license-MIT-lime?style=for-the-badge" alt="License MIT">
  <img src="https://img.shields.io/badge/skills-93-lime?style=for-the-badge" alt="93 Skills">
  <img src="https://img.shields.io/badge/packs-14-lime?style=for-the-badge" alt="14 Packs">
  <img src="https://img.shields.io/badge/QA-PASS-lime?style=for-the-badge" alt="QA PASS">
</p>

<p align="center">
  <strong>Claude Code · Hermes Agent · OpenClaw</strong>
</p>

---

# CREW — World-Class AI Agent Skills

93 gold-standard skills. 14 packs. Every business function covered.

CREW gives your AI agents the skills to operate as a full business team. Not one agent with surface-level knowledge — 93 specialised skills that know their domain, reference each other, and produce premium output with built-in quality gates.

One conversation onboards your business. Every skill reads your brand, your voice, your audience. Then they work.

## Architecture

```
                    ┌──────────────────────────┐
                    │   BUSINESS ONBOARDING     │
                    │   11 questions, one file  │
                    │   brand-context.md        │
                    └──────────┬───────────────┘
                               │
                               ▼
                    ┌──────────────────────────┐
                    │   SKILL INVOKED           │
                    │   93 skills, 14 packs     │
                    └──────────┬───────────────┘
                               │
                               ▼
                    ┌──────────────────────────┐
                    │   BRAND CONTEXT LOADED    │
                    │   Every skill reads it    │
                    └──────────┬───────────────┘
                               │
                               ▼
                    ┌──────────────────────────┐
                    │   DISCOVERY               │
                    │   fresh / continuing /    │
                    │   existing brand          │
                    └──────────┬───────────────┘
                               │
                               ▼
                    ┌──────────────────────────┐
                    │   BUILD → GATE → OUTPUT   │
                    │   Design review cross-    │
                    │   references packs 12-14  │
                    └──────────────────────────┘
```

## Design system

CREW's design packs use a three-layer architecture:

```
BEDROCK (Pack 12 — Design Standards, 7 skills)
The eye. Quality, composition, patterns, language, reference.
Never invoked directly. Embedded into every build skill's gate.

        ↓

FUEL (Packs 13-14 — Design Styles + Animation, 17 skills)
The look and the motion. Visual languages + animation engines.
Never invoked directly. Embedded into build skills.

        ↓

ENGINE (Pack 10 — Web Design, 9 skills)
The output. Slide decks, cinematic sites, dashboards, scroll journeys.
THE ONLY SKILLS A BUSINESS INVOKES. One call, one output.
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

| Gate | What it does |
|------|-------------|
| **Discovery section** | Fresh, continuing, or existing brand routing |
| **Modes** | Fast, Careful, Governed with anti-triggers |
| **Domain reference sections** | Extracted from buried expertise, promoted to named sections |
| **Decision briefs** | The real ambiguous calls, with trade-offs named |
| **Adversarial review** | 3 lenses (harness, white-label, senior domain expert) before QA |
| **Design review gates** | Build skills cross-reference packs 12-14, block on failure |
| **Fixtures** | Cases A, B, C per skill |

## Quality

- 0 em dashes
- 0 banned terms
- 0 fabricated output
- Every claim labelled Evidence or Inference
- Every skill above 15 sections
- QA PASS on all 14 packs
- AU-law jurisdiction-neutral
- Brand-context onboarding for every business

## Compatibility

CREW skills work with:

- **Claude Code** — native skills, full workflow support
- **Hermes Agent** (Nous Research) — agent orchestration platform
- **OpenClaw** — multi-agent framework

Any platform that reads Claude Code SKILL.md files can use CREW.

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

# Hermes Agent
cp -r packs/* ~/.hermes/skills/crew/

# OpenClaw
claw skills import ./packs/
```

## First run

Open your AI agent. Run any skill. If brand-context.md does not exist, the skill asks 11 questions about your business. Every skill you run after that knows your business — your voice, your audience, your product, your rules.

## License

MIT — use freely, modify freely, credit appreciated.

Built by PerformOS.
