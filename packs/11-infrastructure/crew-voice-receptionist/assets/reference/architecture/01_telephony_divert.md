# SOP 01 - Telephony and Divert

## Goal

Get inbound calls the business misses onto the AI agent, on the business's existing number, with zero porting and zero new handset.

## Input

- The business's existing mobile or landline number.
- An AI number rented from Twilio or Telnyx (AU local, about USD 2.50 per month).
- The ElevenLabs Agents account, with the agent already created.

## Tool logic

1. Rent one AU local number in Twilio (Phone Numbers, Buy a Number, country Australia). Note the SID and token.
2. Import the number into ElevenLabs. Open the Phone Numbers tab, Add number, and paste a Label, the number, the Twilio SID and the Twilio Token.
3. Assign the agent. In the same import screen, choose the agent to handle incoming calls (the dropdown appears once the number supports inbound).
4. On the business handset, set conditional call divert so unanswered calls route to the AI number. Standard AU GSM codes (Telstra, Optus, Vodafone), see tools/divert-codes.md:
   - No Answer after 15 s: `**61*<AI-number>**15#`
   - Busy: `**67*<AI-number>#`
   - Unreachable: `**62*<AI-number>#`
5. For a dedicated AI line (not a personal mobile), divert All calls: `**21*<AI-number>#`.
6. Landline: set call-forward-no-answer in the carrier account portal to the AI number.

## Output

A live path: customer dials the business number, no answer in 15 s, carrier forwards to the AI number, platform answers with the agent. Caller is unaware of the redirect.

## Edge cases and failure modes

- Divert silently not set: verify with `*#61#` (shows No Answer divert status). Test by calling the AI number directly, then the business number unanswered.
- Voicemail steals the call: the carrier voicemail no-answer timer must be longer than the divert timer, or voicemail must be disabled. If voicemail answers first, lower the divert delay to 10 s or ask the carrier to raise the voicemail timer.
- Number shows as international to the agent: normalise to E.164 (+61) in the platform variable mapping so SOP 04 SMS works.
- Two diverts fighting (old forward still set): clear everything first with `##002#`, then set the wanted code.
