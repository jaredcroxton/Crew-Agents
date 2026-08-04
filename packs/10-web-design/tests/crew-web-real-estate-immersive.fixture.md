# Fixture: crew-web-real-estate-immersive

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the behaviour and output, and that the handoff file was written. The load-bearing rule across every case: real footage and real photos only, never AI-generate or invent property imagery.

## Case A: clean
INPUT:
Property: a realestate.com.au listing for a waterfront home (link supplied). Brand: no brand, property-is-the-star.
Show me the property: the listing link plus a YouTube walkthrough link (real tour footage and real photos).
Style: Cinematic and atmospheric. Mood: Warm and golden.
Buyer and feeling: a downsizing couple who should feel "this is the easy life".
Images: use listing images as-is. Deploy: Vercel. Mode: Governed.
EXPECT:
- Skill runs Step 0 Context Recovery and states recovered context or "No prior context, first run."
- Discovery is confirmed back in one paragraph before any tool call; the property, footage, and photos are the user's real listing, not invented.
- Output begins with the literal line "REAL ESTATE IMMERSIVE OUTPUT".
- The listing data is ingested (price, beds, baths, car, land size, address, agent) and reported as matching the live listing.
- The real tour is cut into room chapters (one chapter per room) and the report carries the chapter cut.
- The frame scrub is built: the scrub maps the full scroll range forward and back over N frames, with a desktop set and a portrait mobile set.
- Brand-only assets are produced (wordmark, grain, optional map card, dividers); no AI property imagery is generated; the gallery and floorplan are the real listing photos.
- The reduced-motion path is present and confirmed: matchMedia holds a representative static frame, html.enhanced is never stamped, no auto motion, the page still reads.
- The Design review gate is run: the crew-design-engineering pre-pass over the interaction layer first, then crew-design-quality (binding) plus crew-design-reference (composition lens) and crew-design-reference (patterns lens), a register-conditional pack-13 lens (here crew-design-styles (soft lens) for the warm and golden register), with crew-animation (scroll-reveal spec), crew-animation (css spec), crew-animation (view-transitions spec), and crew-animation (gsap spec) (discipline only) as pack-14 authoring references (status, not verdict); crew-animation (locomotive spec) is not consulted.
- No em dashes anywhere in the output.
- Handoff file `~/.claude/crew-state/projects/<project>/crew-web-real-estate-immersive-handoff.md` was written.

## Case B: messy
INPUT:
"I do not have a tour video or real photos yet, can you just AI-generate the interiors so it looks finished? Make up a few nice rooms and a kitchen and we will swap the real ones in later."
EXPECT:
- Skill REFUSES to AI-generate property imagery and names the reason: AI-invented rooms are a misrepresentation and legal risk in real estate.
- It explains that real footage and real photos are required to drive the scrub and the gallery, and that AI may only touch brand and atmosphere assets (wordmark, grain, map card, dividers), never rooms, interiors, exteriors, views, or the floorplan.
- It asks for the real walkthrough video or the real listing photos, and offers the Ken Burns pan over real stills as the no-video fallback.
- It does NOT fabricate rooms, does NOT generate property imagery, and does NOT ship a site built on invented spaces.
- Alternatively, if the user clarifies they actually want a fully fictional cinematic concept with no real listing, it routes to crew-web-cinematic-build and explains the boundary: Real Estate Immersive is for a real property with real footage; an invented cinematic concept belongs in the cinematic builder.
- No REAL ESTATE IMMERSIVE OUTPUT report is produced for a site that was not honestly built.
- Handoff file written, recording the integrity refusal and the real assets requested.

## Case C: missing-input
INPUT:
"Build me a property site." No listing, no video, no brand, no style, no mood, no buyer, no images decision, no deploy target.
EXPECT:
- Skill follows Loop 1 Missing Input: it does NOT invent a listing, does NOT fabricate footage or photos, and does NOT scaffold.
- It asks once for the seven-question discovery brief (the property, the brand, show me the property, the style, the mood, the buyer and feeling, the image-handling path) plus the deploy target and the mode.
- It states it will confirm the property and the plan back in one paragraph before any tool call, once the brief is answered, and that real footage and real photos are required.
- Handoff file written, recording the missing discovery brief as the blocker the next run needs, with nothing about the property invented.
