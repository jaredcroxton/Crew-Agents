<p align="center">
  <img src="https://img.shields.io/badge/CREW-v1.0-000000?style=for-the-badge&logoColor=lime&labelColor=000000" alt="CREW v1.0">
  <img src="https://img.shields.io/badge/skills-93-lime?style=for-the-badge&logo=data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTYiIGhlaWdodD0iMTYiIHZpZXdCb3g9IjAgMCAxNiAxNiIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48cmVjdCB3aWR0aD0iMTYiIGhlaWdodD0iMTYiIHJ4PSIyIiBmaWxsPSIjMzJDRjMyIi8+PC9zdmc+" alt="93 Skills">
  <img src="https://img.shields.io/badge/packs-14-lime?style=for-the-badge" alt="14 Packs">
  <img src="https://img.shields.io/badge/QA-PASS-lime?style=for-the-badge" alt="QA PASS">
  <img src="https://img.shields.io/badge/license-MIT-lime?style=for-the-badge" alt="License MIT">
</p>

<p align="center">
  <strong>Claude Code · Hermes Agent · OpenClaw</strong>
</p>

---

# CREW: World-Class AI Agent Skills

> **The only agent skill pack with a built-in brand context system.** 93 gold-standard skills. 14 packs. Every business function covered. Onboard your business once, and every skill knows your brand, your voice, and your audience.

---

## What CREW is

CREW gives your AI agents the skills to operate as a full business team. Not one agent with surface-level knowledge: 93 specialised skills that know their domain, reference each other, and produce premium output with built-in quality gates.

**What makes CREW different:**

| CREW | Standard AI Skills |
|------|-------------------|
| 11-question business onboarding, every skill knows your brand | Generic prompts, no business context |
| Design review gates cross-reference 3 packs before output ships | No quality gates, output is whatever the model produces |
| 3-lens adversarial review on every skill | No adversarial review, bugs ship to production |
| Brand context persists across all 93 skills | Each skill is an island, no shared knowledge |
| Evidence/Inference discipline, nothing fabricated | No fabrication guardrails |

---

## Quick Start

```bash
# Clone and build
git clone https://github.com/jaredcroxton/crew-skill-packs.git
cd crew-skill-packs
bash package.sh && bash build-plugins.sh

# Install on your platform
claude plugins install crew-full          # Claude Code
cp -r packs/* ~/.hermes/skills/crew/      # Hermes Agent
claw skills import ./packs/               # OpenClaw
```

**First run:** Open your agent. Run any skill. It asks 11 questions about your business. After that, every skill knows who you are.

---

## Architecture

```
ONBOARDING → brand-context.md (11 questions, one file, all skills read)
    ↓
SKILL INVOKED → Discovery (fresh / continuing / existing brand)
    ↓
BUILD → DESIGN REVIEW GATE → OUTPUT
```

### Design system: Bedrock / Fuel / Engine

| Layer | Pack | Role |
|-------|------|------|
| **Bedrock** | 12: Design Standards (7 skills) | The eye. Quality, composition, patterns. Embedded in every build gate. |
| **Fuel** | 13-14: Styles + Animation (17 skills) | The look and the motion. Never invoked directly. |
| **Engine** | 10: Web Design (9 skills) | The output. The only skills a business invokes. One call, one output. |

---

## Packs

| # | Pack | Skills | What it does |
|---|------|--------|-------------|
| 01 | Core | 8 | Brand onboarding, context, quality, planning |
| 02 | Sales | 7 | Lead research, outreach, proposals, pipeline |
| 03 | Marketing | 7 | Campaigns, brand voice, content, SEO, social |
| 04 | Ops | 5 | Process mapping, automation, dashboards |
| 05 | HR | 5 | Interviews, role profiles, performance, policy |
| 06 | Finance | 6 | Invoicing, expenses, cashflow, dashboards |
| 07 | Support | 6 | Ticket triage, replies, FAQ, escalation |
| 08 | Docs | 7 | SOPs, policies, training guides, handovers |
| 09 | Training | 8 | Needs analysis, modules, facilitation, onboarding |
| 10 | Web Design | 9 | Slide decks, cinematic sites, scroll journeys |
| 11 | Infrastructure | 1 | Project scaffolding |
| 12 | Design Standards | 7 | Quality, composition, patterns, language |
| 13 | Design Styles | 5 | Brutalist, minimalist, soft, redesign |
| 14 | Animation | 12 | GSAP, Motion, Lottie, Rive, Spring, CSS |

---

## Skill Quality

Every skill is gold-standard. Here is what that means:

| Standard | What it does |
|----------|-------------|
| **15+ sections** | Every skill has Discovery, Modes, domain reference sections, Decision briefs, Verification, Completion |
| **3-lens adversarial review** | Harness check + white-label scan + senior domain expert before QA |
| **Design review gates** | Build skills cross-reference packs 12-14, block output on failure |
| **Fixtures** | Cases A, B, C per skill: clean, messy, and missing-input scenarios |
| **0 em dashes** | Strict white-label discipline across all 93 skills |
| **0 banned terms** | No leaked internal names, no placeholder names |
| **Evidence/Inference discipline** | Every claim labelled. Nothing fabricated. |
| **AU-law jurisdiction-neutral** | Business sets jurisdiction once. Skills adapt. |

---

## Compatibility

| Platform | Support |
|----------|---------|
| Claude Code | Native, install via plugins or source |
| Hermes Agent (Nous Research) | Compatible, copy packs to `~/.hermes/skills/` |
| OpenClaw | Compatible, `claw skills import` |
| Any agentskills.io platform | Standard SKILL.md format |

---

## FAQ

**Do I need all 14 packs?** No. Install what you need. A sales team might only want packs 02 (Sales) and 07 (Support). A design agency might only want 10 (Web Design), 12 (Standards), 13 (Styles), and 14 (Animation).

**Can I use this with my existing Claude Code setup?** Yes. CREW skills are standard SKILL.md files. They sit alongside your existing skills.

**What happens if a skill produces bad output?** All build skills have design review gates that cross-reference packs 12-14. Output that fails the gate is blocked. Non-build skills have Verification sections with checklists. Nothing ships unverified.

**How do I contribute a skill?** Open an issue with your skill idea. We review against the gold standard (15+ sections, 3-lens review, fixtures, white-label). Accepted skills are added to the appropriate pack.

---

## License

MIT. Use freely, modify freely, credit appreciated.

Built by [PerformOS](https://performos.com.au).
