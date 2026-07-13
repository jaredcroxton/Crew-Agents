# SOP 05 - Compliance (AI disclosure and recording consent)

## Goal

Keep the build lawful across every Australian state by disclosing AI use and recording at the start of every call, and by handling call data privately.

## Input

- The greeting in the system prompt (tools/system-prompt.md).
- The recording and retention settings in the platform.

## Tool logic

1. Every call opens with the combined disclosure line, before anything else:
   "You are speaking with an AI assistant, and this call may be recorded for quality and training purposes."
2. Adopt the strictest state standard nationally (all-party consent). Do not rely on QLD, VIC or NT being permissive, because a caller may be interstate.
3. Set recording and transcript retention to the minimum useful period in the platform. Restrict who can access them.
4. Do not forward transcripts or recordings to any address not owned by the business. No use for AI training without consent.
5. If a caller objects to recording, the agent offers to take a message without recording, or to have a person call back.

## Output

Every call carries a spoken disclosure and consent notice. Call data is stored securely with limited retention and access.

## Edge cases and failure modes

- Caller hangs up during the disclosure: no consent, no usable recording. Acceptable, no action.
- Sensitive sectors (health, legal, finance): tighten retention further and confirm the business's own privacy obligations under the Privacy Act 1988 (APP entities).
- Marketing or outbound use: this blueprint is inbound only. Outbound AI calling carries extra obligations (DND registers, telemarketer identity) and is out of scope here.
- Interstate callers: covered, because the strictest standard is applied to all calls by default.
