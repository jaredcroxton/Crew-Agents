# claude.md - AI Phone Receptionist (Project Constitution)

This file is law. It holds the data schemas, the behavioural rules, and the architectural invariants for a no-code AI phone receptionist built for an Australian small business. The planning files (task_plan.md, findings.md, progress.md) are memory. Change this file only when a schema changes, a rule is added, or the architecture is modified.

The receptionist answers calls the business misses on its own number, sounds human, answers common questions, books appointments, takes structured messages, and delivers a transcript plus an SMS confirmation after every call. It is built entirely with no-code platform configuration. No servers to run, no code to maintain.

## North Star

Never let a customer call go unanswered. Turn every missed call into a booked job, an answered question, or a structured message in the owner's inbox, on the business's existing phone number, for under AUD 100 per month.

## Target

One Australian small business (trades, clinic, salon, real estate, hospitality, professional services). Worked example in this blueprint: Coastline Plumbing and Gas, a four-van plumbing business on the Sunshine Coast QLD that misses 15 to 20 calls a week while on the tools, each worth an average job of AUD 280.

Fill-in fields for the recipient business are marked `<< >>` throughout.

## Architecture (A.N.T. three layer)

Layer 1, Architecture (`architecture/`): five SOPs, one per subsystem. Divert, Voice Agent, Booking, Post-call, Compliance. If the logic changes, the SOP changes before the platform config.

Layer 2, Navigation (`architecture/05_navigation.md` in a coded build; here the call flow itself): the decision routing inside a single call. Greet, identify intent, branch to answer or book or take a message, close, deliver. The voice platform executes this as a system prompt plus tools. No human in the loop during a call.

Layer 3, Tools (`tools/`): the deterministic assets a no-code operator pastes into the platform. The system prompt, the tool JSON schemas the platform calls, the knowledge-base template, the divert-code card, and the post-call webhook field map. These are the "engines". In a no-code build the engines are configuration, not Python, but the contract is identical: fixed input shape in, fixed output shape out.

## Skills used

- Express / A.N.T. protocol for the scaffold and the self-annealing repair loop.
- crew-design-documents for the client-facing HTML playbook standard.
- flow-support voice and escalation patterns for the message-taking script.

## Decisions locked

1. Keep the number. Use carrier conditional call divert, never porting. The business keeps its printed and Google-listed number.
2. Voice platform is ElevenLabs Agents. It bundles the speech-to-text, the language model and the voice in one dashboard, imports the Twilio number natively, and ships the best Australian voice. One platform, no glue, non-coder friendly.
3. Voice is ElevenLabs, an Australian-accent voice. The brain is a cheap LLM (GPT-4o-mini or Claude Haiku). Never OpenAI Realtime unless sub-500 ms latency is a hard requirement.
4. Booking calendar is cal.com (free tier) or the business's existing Google Calendar.
5. Every call opens with the combined AI-and-recording disclosure. Non-negotiable, applied nationally at the strictest state standard.
6. Messages are captured as structured text fields, never as an audio voicemail file. The owner reads, never re-listens.
7. The agent answers only from the knowledge base. If it does not know, it takes a message. It never invents prices, availability, or promises.

## Data Schema

Data-first rule. These shapes are locked before any platform is configured. The platform's variables and webhook payload must map onto these exactly.

### Business profile (fill-in input, one per client)

```json
{
  "business_name": "Coastline Plumbing and Gas",   // << business name
  "trading_hours": "Mon-Fri 7am-5pm, Sat 8am-12pm", // << hours
  "service_area": "Sunshine Coast QLD",             // << area
  "services": ["blocked drains", "hot water", "gas fitting", "leak detection", "general plumbing"], // << list
  "price_guidance": {                                // << what the agent MAY quote
    "callout_fee": "89 AUD, waived if job proceeds",
    "policy": "quote ranges only, never a fixed price for unseen work"
  },
  "booking_calendar": "calcom",                      // "calcom" | "google"
  "owner_number": "<<+61 4xx xxx xxx>>",             // where messages + transcripts go
  "ai_number": "<<+61 x xxxx xxxx>>",                // Twilio AU number the divert points to
  "voice_id": "<<elevenlabs_voice_id>>",             // chosen AU-accent voice
  "escalation": "urgent gas smell or burst main -> read owner mobile aloud and advise to call now"
}
```

Invariant: the agent may only quote what is inside `price_guidance`. Anything outside it is a message-take, not an answer.

### Call event (raw, emitted by the voice platform at call start)

```json
{
  "call_id": "elevenlabs_conversation_id",
  "from_number": "+61 4xx xxx xxx",   // the customer
  "to_number": "+61 x xxxx xxxx",     // the AI number (proves it was a diverted missed call)
  "started_at": "2026-07-12T14:03:11+10:00",
  "direction": "inbound"
}
```

### Booking record (produced by the Booking tool call, SOP 03)

```json
{
  "call_id": "…",
  "customer_name": "Dana R.",
  "customer_number": "+61 4xx xxx xxx",
  "service": "blocked drain",           // must map to business_profile.services
  "slot_start": "2026-07-14T08:00:00+10:00",
  "slot_end": "2026-07-14T09:00:00+10:00",
  "address": "12 Beach Pde, Maroochydore",
  "notes": "kitchen sink, standing water",
  "status": "booked"                    // "booked" | "held" | "failed"
}
```

### Message record (produced when the call does not book, SOP 02)

```json
{
  "call_id": "…",
  "caller_name": "Priya M.",
  "caller_number": "+61 4xx xxx xxx",
  "reason": "quote for gas cooktop install",
  "urgency": "Standard",                // "Emergency" | "Urgent" | "Standard"
  "preferred_callback": "after 3pm today",
  "captured_at": "2026-07-12T14:05:40+10:00"
}
```

Invariant: every completed call produces exactly one of a booking record or a message record. Never zero, never both.

### Post-call payload (delivered to the owner, SOP 04)

```json
{
  "call_id": "…",
  "summary": "New customer, blocked kitchen drain, booked Mon 8am.",  // one line, LLM-written
  "outcome": "booking",                 // "booking" | "message" | "answered_only" | "abandoned"
  "transcript": "full turn-by-turn text",
  "record": { "…booking or message record…" },
  "sms_sent": true,                     // confirmation SMS to the customer
  "delivered_to": ["owner_email", "owner_sms"]
}
```

Invariant: the owner receives the payload within 60 seconds of hang-up. The customer SMS fires only when `outcome` is "booking" or when a callback was promised.

## Behavioural rules

- Open every call with the disclosure line, then the greeting. Warm, brief, local. Never corporate.
- One question at a time. Never stack three questions in a breath.
- Confirm the number and the spelling of the name back before ending.
- Answer only from the knowledge base. Unknown means take a message.
- Never quote a fixed price for unseen work. Ranges and callout fees only, from `price_guidance`.
- On an emergency keyword (gas smell, burst, flooding, no hot water in winter for elderly), escalate per `business_profile.escalation` immediately.
- No em dashes in any spoken or written output. Australian spelling.
- Human handoff always offered if the caller asks for a person.

## Maintenance log

- 2026-07-12: Blueprint authored. Platforms, costs, divert codes and AU compliance researched and locked in findings.md. Schemas locked. Worked example set to Coastline Plumbing and Gas.

## How to run

This is a no-code build. "Running" means the divert is live and the platform is answering. See tools/divert-codes.md to set the divert, and the client playbook (client-playbook.html) for the full step-by-step. Once live, the platform runs 24/7 with no operator action.

## How to debug common failures

- Agent not answering: check the divert code is set (`*#61#` shows status) and the AI number is correct in the platform. Test by calling the AI number directly first, then via the diverted business number.
- Robotic or slow voice: wrong voice model or a non-AU region. Reselect an ElevenLabs AU voice, confirm platform region is closest to AU.
- Booking not landing: the Booking tool schema does not match the calendar API. Re-check tool-schemas.json against SOP 03.
- No transcript arriving: post-call webhook URL wrong or the Make/Zapier scenario is off. Re-check webhook-map.md.
- Wrong answers or invented prices: knowledge base too thin or `price_guidance` not enforced in the prompt. Tighten per SOP 02.
