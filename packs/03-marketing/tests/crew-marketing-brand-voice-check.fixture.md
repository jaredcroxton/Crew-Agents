# Fixture: crew-marketing-brand-voice-check

## Case A: clean
INPUT:
- Asset: LinkedIn post for a solo bookkeeper, "Sole Trader Books".
- Voice source (stated guide): Formality casual, Warmth friendly, Energy steady, Person second-person "you", Sentence length short, Jargon none, Reading level plain words around grade 7, Vocabulary range plain. Banned words: solutions, leverage, robust, seamless. Signature words: sorted, on top of it, no surprises.
- Draft: "We provide robust, seamless bookkeeping solutions to leverage your financial data and drive efficiency. Our offering is best in class. Contact us today for a consultation."

EXPECT:
- Output begins with the line "BRAND VOICE CHECK", with a filled Voice profile used line (a value named on every axis) and Voice source: guide.
- The profile names its source: axes from the stated guide, banned words from the guide's banned list, signature words from the guide.
- Each off-brand span flagged with the exact span ("robust", "seamless", "solutions", "leverage", "best in class"), the axis it breaks (Banned word / Jargon / Formality), and a specific-mechanism reason, not "too formal", each with an on-brand Fix.
- A full Clean version that preserves the same promise (bookkeeping, a call to action) using signature words like "sorted" or "no surprises" naturally, not stuffed into every line, no em dashes.
- No invented claim, number, price, guarantee, or service that was not in the draft.
- Handoff written to `~/.claude/crew-state/marketing/crew-marketing-brand-voice-check-handoff.md` noting the clean copy and the voice profile used.

## Case B: messy
INPUT:
- Asset: homepage hero paragraph for a gym, mixed and contradictory, no formal guide.
- Voice source: no brand-context and no formal guide, but three past captions the owner loves are attached, all short, punchy, second-person, a bit cheeky ("Show up. We'll handle the rest.").
- Draft mixes registers: "Welcome to our state-of-the-art facility where we endeavour to deliver a holistic wellness journey. Get ripped or get out. We offer a 30-day money-back guarantee and award-winning trainers."

EXPECT:
- Voice source labelled "inferred from samples, not a stated guide" (Loop 1 fallback), and the profile inferred on every axis as casual / cheeky (playful) / second-person / short, with each axis marked inferred.
- A confidence note on the inferred profile: states it rests on three samples, and any axis the three captions do not actually settle (for example Reading level, Vocabulary range) is marked "low confidence, infer-and-confirm" rather than asserted, e.g. "Voice inferred from 3 samples; Reading level low-confidence, confirm".
- The formal, generic spans ("state-of-the-art facility", "endeavour to deliver a holistic wellness journey") flagged off-brand with the axis (Formality, Vocabulary range) and the mechanism, and the register clash noted ("Get ripped or get out" sits closer to the samples, the rest does not).
- A substance line, "30-day money-back guarantee" or "award-winning trainers", marked "Author decision needed" because it is a claim not a voice issue, original wording left intact (substance is not edited).
- The inference stated plainly, never presented as a stated rule. Invents no new claim, number, or banned word.
- Handoff written, with a Learned note that no formal guide exists yet and the voice was read off samples.

## Case C: missing-input
INPUT:
- Asset: an email subject line and body to check.
- Voice source: none provided, no brand-context, no guide, and no past samples attached. Just "make it sound like us".

EXPECT:
- Loop 1 (Missing Input) fires: names the gap plainly ("off-brand cannot be judged without a voice source"), and asks once for `brand-context.md`, a tone guide, or two or three past pieces the business is proud of.
- Does not run the check or rewrite blind. Marks the voice profile fields "Not provided" and emits no Clean version, holding for the input.
- Invents no voice profile, no banned words, no signature words, no rewrite. A blank profile beats a fabricated one.
- Handoff still written to `~/.claude/crew-state/marketing/crew-marketing-brand-voice-check-handoff.md` recording the gap (no voice source supplied) and what the next run needs.

## Case D: on-brand
INPUT:
- Asset: a short SMS for a cafe, "Daily Grind".
- Voice source (stated guide): Formality casual, Warmth friendly, Energy steady, Person second-person "you", Sentence length short, Jargon none, Reading level plain words around grade 6, Vocabulary range plain. Banned words: solutions, leverage, world-class. Signature words: fresh, your usual, see you soon.
- Draft: "Your usual is ready when you are. Fresh beans landed this morning. See you soon."

EXPECT:
- Output begins with "BRAND VOICE CHECK", a filled Voice profile used line (a value on every axis), Voice source: guide.
- Off-brand flags reported as the empty-state "Off-brand flags: none, copy is on-brand"; no flag manufactured to look thorough.
- The Clean version returns the draft unchanged or near-unchanged, every promise intact, no em dashes.
- Handoff written noting a clean pass, zero flags.

## Case E: source-conflict
INPUT:
- Asset: a landing page intro for an accountant.
- Voice source: BOTH a formal tone guide (says Formality formal, Person first-person "we", banned word "cheap") AND a `brand-context.md` captured summary (says Formality casual, Person second-person "you"). The two disagree on Formality and Person.
- Draft: a mix of both registers.

EXPECT:
- Names the conflict out loud (guide and brand-context disagree on Formality and Person), and follows the named authority: the formal tone guide WINS over brand-context.md (precedence: a brand book or tone guide over brand-context.md over samples).
- Builds the profile on the guide's values (Formality formal, Person first-person "we"), not the brand-context values, and flags the specific axes where they clash so the owner can reconcile the source of record.
- Handoff written noting the source conflict and which axes clashed, so the owner can reconcile.
