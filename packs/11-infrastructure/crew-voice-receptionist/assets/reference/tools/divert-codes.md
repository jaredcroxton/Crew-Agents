# Divert code card (Australia)

Set these on the business handset. Replace `<AI-number>` with the Twilio AU number in E.164 (for example +61712345678). Dial the code like a phone call.

Works on Telstra, Optus, Vodafone and their resellers (Boost, Belong, Aldi Mobile, etc.), which all use the same GSM feature codes.

## The one most businesses want (recommended)

Forward only calls you do not answer, after 15 seconds:

    **61*<AI-number>**15#

Delay can be 5, 10, 15, 20, 25 or 30 seconds. Shorten to 10 if voicemail keeps grabbing the call first.

## The full set

- No Answer (after N seconds):  `**61*<AI-number>**15#`
- Busy:                         `**67*<AI-number>#`
- Unreachable (off / no signal): `**62*<AI-number>#`
- All calls (dedicated AI line): `**21*<AI-number>#`

## Check and cancel

- Check No Answer status: `*#61#`
- Cancel every divert:    `##002#`

## Notes

- Set No Answer, Busy and Unreachable together for full missed-call coverage on a personal mobile.
- Use All calls only on a separate number that the AI owns end to end.
- Landlines: set call-forward-no-answer to the AI number in the carrier's account portal or by calling the carrier. The codes above are for mobiles.
- If carrier voicemail answers before the divert, either disable voicemail or ask the carrier to raise the voicemail no-answer timer above your divert delay.
