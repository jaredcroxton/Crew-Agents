# Fixture: crew-design-blueprint

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the output, and that the handoff file was written.

## Case A: clean
INPUT:
Blueprint a site for a local roofing company in Dallas (Careful mode). Primary goal: phone calls and free-estimate form fills. Single location, eight services (roof repair, replacement, storm damage, inspection, gutters, ventilation, skylights, maintenance).
EXPECT:
- Output begins with "SITE BLUEPRINT" and includes a Business line, a Niche line, an Archetype line (local service), a Primary goal line, a Built date, and a Mode.
- A "Sitemap (page map and hierarchy):" block with top-level pages (Home, Services, Service area, About, Reviews, Contact) and the Services parent with a service-detail child per service, plus legal pages in the footer.
- A "Navigation:" block specifying all four layers: a primary nav (five to seven destinations plus a Call CTA), secondary (breadcrumbs), a footer with legal links, and a mobile collapse with a persistent call or quote bar.
- A "Page specs (per page):" block where the Home page lists its sections in order (a hero with phone and free inspection, trust badges near the top, services, before-and-after, reviews, service-area map, financing, FAQ, final CTA) and names one primary conversion.
- A "Key user flows:" block with a primary path to the estimate or call, a secondary not-ready path, and dead ends resolved.
- A "Content gaps (must be created before build):" block naming real content needed (real team photos, the license number, real reviews, before-and-after images), with no placeholder names shipping.
- The structure is local-service-specific (phone CTA, trust badges, service-area map), not a generic SaaS template.
- No em dashes anywhere in the output.
- Handoff file `~/.claude/crew-state/design-styles/crew-design-blueprint-handoff.md` was written.

## Case B: archetype-conflict
INPUT:
Blueprint a site for my business. I run a one-on-one coaching practice, but I also sell a self-paced online course and I publish a weekly newsletter. I want the site to do all three.
EXPECT:
- The reviewer identifies the conflict: the brief spans three archetypes (high-ticket professional for the coaching, education for the course, media or creator for the newsletter), each with a different primary conversion.
- It does not blur all three into one muddy structure with three competing conversions on the homepage; it recommends one primary archetype and one primary conversion, with the other two as secondary paths (for example lead with the coaching practice and a book-a-call conversion, with the course and the newsletter as secondary flows and their own pages).
- It produces a short decision brief because the call (which goal leads) is genuinely contested and is the user's to confirm.
- One primary conversion per page is maintained across the proposed structure.
- It invents no business detail beyond what was given.
- Handoff file written, recording the archetype decision and the primary conversion chosen.

## Case C: missing-input
INPUT:
"Build me a sitemap." No business, niche, or primary goal is provided.
EXPECT:
- The skill follows Loop 1 (Missing Input): it asks once for the business and niche (specific enough to pick an archetype) and the primary goal, because a blueprint derives its structure from an archetype and a goal.
- It does not invent a business, fabricate a page map, or impose a generic template against an unknown niche.
- If it emits any partial output, the Business, Archetype, and Primary goal fields are marked "Not provided" rather than filled.
- Handoff file `~/.claude/crew-state/design-styles/crew-design-blueprint-handoff.md` written, recording the missing niche and goal as the blocker the next run needs.
