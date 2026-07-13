# Fixture: crew-web-product-film

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the behaviour and output, and that the record was written into the active project. All businesses are fictional.

## Case A: clean
INPUT:
Harbourline Boot Co., a fictional boot and belt maker, wants a cinematic product film
site for its flagship boot, demo mode, to pitch them as a prospect. Brand context exists.
Their public product page serves six high-resolution transparent product plates from a
Cloudinary-backed store. A KIE key is available in .env. Deploy: local preview only.
EXPECT:
- Skill runs Step 0 Context Recovery and settles the project (new or continuing).
- The asset route is settled first: route A (brand's own public imagery), checking the PDP image CDN and stripping URL transform segments to pull original transparent plates; nothing is generated pretending to be the client's own product photography beyond plates seeded FROM their real imagery.
- A scene map is produced and approved BEFORE any generation: hero reveal, detail macro, anatomy explode, environment settle, adapted to a boot.
- Clip prompts follow the camera-only lock with the named forbidden-features list applied to every prompt.
- The mandatory artifact sweep runs before stitching: three timestamps inspected per clip with back-half emphasis, and any artefacted clip is regenerated, not shipped.
- The encode is the GOP 12 crf 18 scrub pair with the maxrate cap; the weight budget is met and stated in the build report (scrub_d <= 12MB, scrub_m <= 5MB, first-load <= 15MB desktop / 6MB mobile); the WebP frame pipeline is not used for this engine.
- The page is cloned from product-film-reference.html (engine locked: load gate, poster underlay, continuous-flow arrival, legibility kit), with brand tokens and copy fitted to Harbourline Boot Co.
- Verification runs the web-standards Verification Gate roster: a real browser over a Range-capable server (206 check), desktop AND 375px passes with scrub_m confirmed at mobile width, a Safari pass (or the six static checks with the named residual), a reduced-motion pass (no video scrubbing, runway collapsed, content readable), head hygiene, the keyboard walk with the skip link first, contrast math, the weight audit, and the live matrix green.
- Because this is a demo of a brand the user does not own, the concept-demonstration footer and not-affiliated line are present.
- The Design review gate runs with a binding verdict and Criticals/Majors are fixed.
- No em dashes anywhere in the output.
- The record was written to ~/.claude/crew-state/projects/<project>/crew-web-product-film-handoff.md with the frame intact.

## Case B: messy
INPUT:
Fresh start. Brand context exists. A fictional cookware brand wants a product film for a
cast-iron pan, but their site serves only tiny 400px JPEGs with baked backgrounds, the
second generated clip grows a floating handle artifact in its back half, and the user asks
mid-build to "also add a full store with checkout".
EXPECT:
- The thin plates are named as the constraint: route A cannot deliver originals, so the skill offers route B (client supplies plates) or route C (studio-style regeneration seeded from the small images, honestly labelled), and does not upscale-and-pretend.
- The floating-handle artifact is caught by the mandatory three-timestamp sweep (back-half emphasis), the clip is regenerated with the forbidden-features list tightened, and the defect never ships.
- The store-with-checkout request is routed out (a product film is one cinematic page, not a storefront); the film continues, the routing is recorded (Loop 3).
- STATUS is DONE_WITH_GAPS if any clip is still awaiting regeneration, with the gap named.

## Case C: missing-input
INPUT:
"Build me one of those product film sites."
EXPECT:
- No artifact is produced and no assets are generated. The skill asks once, plainly, for the product and an asset route (their imagery, supplied plates, or a KIE key), per Loop 1.
- No product, plates, claims, or prices are invented while waiting.
- The record is still written into the active project first, STATUS: BLOCKED, naming the missing product and asset route as the blocker.
- The chat Completion status is NEEDS_CONTEXT or BLOCKED, never DONE.
