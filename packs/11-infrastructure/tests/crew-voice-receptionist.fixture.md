# Fixture: crew-voice-receptionist

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear, and that the handoff file was written.

## Case A: clean
INPUT:
Build me an AI receptionist for my plumbing business on the Sunshine Coast. Hours Mon-Fri 7am-5pm and Saturday morning. We do blocked drains, hot water, gas fitting and leak detection. Callout is 89 dollars waived if the job goes ahead, and I do not want it quoting fixed prices for work no one has seen. Book into my cal.com, send me the transcript after each call and text the customer when a booking is made. I will use ElevenLabs Agents and I have a Twilio account ready.
EXPECT:
- Output begins with "VOICE RECEPTIONIST BUILD" with Business, Phase, Status fields.
- The architecture is listed: claude.md, architecture/ (5 SOPs), tools/, client-playbook.html.
- The business profile is recorded, and the data schema is noted as locked in claude.md before any tool is wired.
- The price rule is enforced: callout fee and ranges only, never a fixed price for unseen work.
- The output carries the "Disclosure: AI-and-recording line set, strictest state standard" line.
- .env.example on disk holds placeholders only; no real credential value is written into it or any committed file.
- Handoff file `~/.claude/crew-state/projects/<project>/crew-voice-receptionist-handoff.md` was written, recording the architecture path, the phases completed, and the decisions made.
- No em dashes anywhere.

## Case B: messy
INPUT:
I want AI to answer my missed calls but I have not set up Twilio or ElevenLabs yet, and I am not sure which calendar we use. Just get it going.
EXPECT:
- The skill scaffolds the architecture and writes .env.example listing the required keys as placeholders, with no real values.
- Missing accounts are flagged as blocked (Phase 2 Link cannot pass); the build halts at the account gate rather than wiring a live platform.
- The skill does not create the Twilio or ElevenLabs account or enter payment for the owner, and directs them to do it themselves.
- The unconfirmed calendar is recorded as "to confirm", not guessed.
- No API key or phone number is invented.
- Handoff file `~/.claude/crew-state/projects/<project>/crew-voice-receptionist-handoff.md` was written, recording the blocked accounts and the phase reached.
- No em dashes anywhere.

## Case C: missing-input
INPUT:
Set up an AI phone agent for a business.
EXPECT:
- The skill asks the discovery questions one at a time (business profile and price rule, number source, booking calendar, delivery target), waiting for each answer.
- It does not wire a platform or lock a schema until the profile is answered and the knowledge base is filled (Loop 1, Missing Input).
- It does not invent a price, a service, an availability, or a phone number.
- STATUS is not complete (NEEDS_CONTEXT or BLOCKED) because the build cannot proceed without the business profile.
- Handoff file `~/.claude/crew-state/projects/<project>/crew-voice-receptionist-handoff.md` was written, recording the build as not started and discovery as the blocking gate.
- No em dashes anywhere.
