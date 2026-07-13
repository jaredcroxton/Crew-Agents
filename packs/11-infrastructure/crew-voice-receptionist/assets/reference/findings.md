# findings.md

Research log for the AI Phone Receptionist blueprint. Australia market, mid 2026.

## The keep-your-number mechanism (Australia)

You do not port the number or change the SIM. You use conditional call forwarding (call divert) built into every Australian mobile and most landline plans. Dial a GSM code once on the handset and the carrier routes unanswered calls to the AI number.

Codes verified across Telstra, Optus, Vodafone:

- `**61*<AI-number>**15#` divert on No Answer after 15 seconds (delay value can be 5, 10, 15, 20, 25 or 30 seconds; Telstra and Optus both accept this range).
- `**67*<AI-number>#` divert when Busy.
- `**62*<AI-number>#` divert when Unreachable (phone off or no signal).
- `**21*<AI-number>#` divert All calls (used for a dedicated AI line, not a personal mobile).
- `##002#` cancel every divert.
- `*#61#` check current No Answer divert status.

The `<AI-number>` is a phone number rented from Twilio or Telnyx that points at the voice agent platform. Caller rings the business mobile, business does not answer in 15 seconds, carrier bounces the call to the AI number, the agent answers. The caller never learns they were redirected. This is the whole "your number, now answered by AI" claim. No porting, no new handset.

Landlines: same idea via the carrier's call-forward-no-answer feature, set in the account portal or by the carrier.

## The technical stack (four layers)

Round trip per conversational turn is 600 to 900 ms in practice.

1. Telephony: carries the number and the audio. Twilio or Telnyx. AU local number about USD 2.50 per month, plus about USD 0.01 per minute.
2. STT (speech to text): transcribes caller speech. Deepgram, about USD 0.004 per minute.
3. LLM (the brain): decides what to say and which action to take. GPT-4o-mini or Claude Haiku. About USD 0.001 to 0.01 per minute.
4. TTS (text to speech): the voice the caller hears. This is where "A-class" lives. ElevenLabs.

## Orchestration platforms (the resold product)

Sits on top, glues the four layers, handles interruption and turn-taking, runs the booking logic. This is what agencies white-label and resell.

Decision: ElevenLabs Agents. It bundles STT, the LLM and TTS in one dashboard, imports the Twilio number natively, has built-in post-call webhooks, and ships the best Australian voice. The other platforms below were surveyed and not chosen for this build.

| Platform | Cost | Notes |
| --- | --- | --- |
| Retell | USD 0.07 to 0.31/min | More packaged, similar capability |
| ElevenLabs Agents | ~USD 0.12/min all-in (Creator plan USD 22/mo incl 250 min) | Best voice out of the box, simplest, STT+LLM+TTS bundled |
| Telnyx | USD 0.05/min + USD 0.06 STT/TTS | Cheapest telephony, native single-vendor stack |
| LiveKit (self-host) | Raw model cost | For scale or AU data residency; self-host on AWS ap-southeast-2; you build it |

Done-for-you AU products already in market (the recipient can also just buy these): Curious Thing (Lucy AI), Callease (built on Australian infrastructure). Agencies frequently rebrand these.

## Voice quality: the OpenAI vs "4.0" vs ElevenLabs confusion

These are not competitors at the same layer.

- "4.0" = GPT-4o / GPT-4o-mini = the LLM brain. Good thinking, generic native voice.
- OpenAI Realtime API = one model doing voice-in, voice-out. Lowest latency, but generic voice and most expensive at volume (~USD 0.12+/min for the model alone).
- ElevenLabs = the TTS layer. Best-in-class human voice, has genuine Australian-accent voices. Roughly 50% cheaper than OpenAI Realtime at volume because it bundles STT+TTS and bills standard rates.

Recommendation for A-class voice at minimal cost: ElevenLabs for the voice + a cheap LLM (GPT-4o-mini or Claude Haiku) for the brain. Only choose OpenAI Realtime if absolute lowest latency matters more than sounding human.

"A-class" is not only voice. Content quality comes from four configured things, not the model: a tight system prompt, a knowledge base of business facts, guardrails (answer vs take a message vs escalate), and tool calls (the actions).

## Australian compliance (call recording + AI disclosure)

State law splits on consent:
- All-party consent (stricter): NSW, ACT, TAS, SA, WA.
- Participant recording generally allowed: QLD, VIC, NT.
- Privacy Act 1988 applies to APP entities; store recordings securely, limit retention, control disclosure.

Safest national approach: adopt the strictest standard everywhere. Announce recording and AI use at the start of every call and obtain consent. Minimum spoken disclosure:

"You are speaking with an AI assistant, and this call may be recorded for quality and training purposes."

This single line satisfies both the AI-disclosure expectation and the recording-consent notice.

## Cost model

Fixed:
- Twilio AU number ~USD 2.50/mo
- ElevenLabs Creator ~USD 22/mo (250 min included)
- cal.com free tier for booking

Variable: ~USD 0.10 to 0.15 per minute all-in beyond included minutes.

Worked example: 200 calls/month at ~2 min each = 400 min. Lands around USD 45 to 60/month, roughly AUD 70 to 95/month all-in.

Reseller reality: agencies charge AUD 300 to 500+/month for this exact stack. Setup is a few hours of no-code configuration (ElevenLabs Agents, or a reseller wrapper like GoHighLevel). The gap between cost and price is the business model, which is why businesses are pitched this constantly.

## No-code build path (confirmed feasible)

ElevenLabs Agents dashboard flow (all no-code): create the agent (voice, System prompt, first message, Knowledge Base); import the Twilio number under the Phone Numbers tab (Label, number, Twilio SID, Twilio Token) and assign the agent for inbound; add Webhook tools under Agent, Add Tool for booking (cal.com) and SMS (Twilio); enable the built-in Post-call webhook. Booking connects to cal.com or Google Calendar. Post-call transcript and summary route to email/CRM via a Make or Zapier scenario. Confirmed against ElevenLabs docs (Twilio native integration, Webhook tools, Post-call webhooks).

## Sources

- amjid.au Retell vs Vapi vs LiveKit shootout (AU operator view)
- Telnyx voice AI providers and AU call recording law guides
- Retell AI and Twilio published pricing
- Waboom / Curious Thing / RealVoice call-forwarding setup guides (AU/NZ divert codes)
- CallSphere ElevenLabs vs OpenAI Realtime cost comparison
- Vapi docs (Twilio + SMS tool setup)
