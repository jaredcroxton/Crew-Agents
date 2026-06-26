# Fixture: crew-marketing-content-repurpose

## Case A: clean
INPUT:
Source: full transcript of a 40-minute webinar, "Cutting churn in the first 30 days", presented by Priya Anand, Head of Growth.
Source format: webinar. Speaker named.
Channels requested: blog, LinkedIn, newsletter, short video.
Brand voice: plain, direct, no hype. CTA preference: drive to the full blog post.
Key material in the transcript, at named timestamps: at 14:30 they state week-one onboarding emails took 30-day churn from 18% to 12%; at 6:10 the quote "People do not churn because of price, they churn because they never got started"; at 22:00 they explain three triggered emails beat one long welcome email.

EXPECT:
- Output is a full CONTENT REPURPOSE PACK whose first line is exactly "CONTENT REPURPOSE PACK", with Source, Type: Webinar, Thesis, and a Channels line.
- The source classified as a Webinar (a spoken argument with a narrative arc), the cut following the arc.
- A "Key messages (the spine)" list of three to six messages, each with its traceable spot (14:30, 6:10, 22:00) and a Quoted / Paraphrased / Data tag; this set is the spine every asset keeps.
- Four assets present, each anchored on a message and adapted to its channel: a blog summary (with word count, opens on the problem and resolves it), labelled social posts (each with platform and posting order, two hook options as Hook A and Hook B both tracing to the same spine message, point/CTA), a newsletter (subject + body + CTA, one takeaway with a link), and a video script (rough length, short spoken sentences, length roughly 110 to 200 words for its stated runtime).
- The exact numbers carried with no rounding: the 18% and the 12% appear exactly and match the source; the quote is verbatim and tagged Quoted.
- Each social or email asset within its platform's character limit (LinkedIn lead before the "see more" fold and under about 3000, email subject under about 50 characters).
- Any alt text describes only the actual or intended image and invents no data value, chart contents, or visual detail not present; a placeholder visual is marked "Alt text (to finalise once the image is made)".
- The source credited to Priya Anand at least once across the pack and on each asset where attribution reads naturally; alt text noted for the video or any image asset (accessibility); a suggested publishing sequence; CTAs drive to the blog.
- The spine and the numbers consistent across all assets (no asset states the churn figures differently).
- Handoff written at `.claude/crew-state/marketing/crew-marketing-content-repurpose-handoff.md` recording assets produced, anchor messages, and the source classification.

## Case B: messy
INPUT:
Source: rough, partial notes from a podcast, no timestamps, some lines contradict. Notes say both "retention went up about 20 percent" and later "retention improved, roughly a fifth". A separate pair of notes gives two conflicting precise figures for the same metric: one line says "churn dropped to 18%", another says "churn dropped to 22%". Host is named (Dev Okoro), guest is "the founder" with no name given. No channels specified. One note reads "great quote about pricing somewhere near the start" but the quote itself is not written down.
Brand voice: not provided.

EXPECT:
- Source classified as a Podcast or interview (dialogue, the value is in exchanges and quotes); thesis stated, or flagged as unclear if no single thesis is findable, with a note that the missing spine limits how much can be repurposed.
- The two rough phrasings reconciled to one consistent claim across all assets (treats "about 20 percent" and "roughly a fifth" as the same ~20%, states it once, marked approximate, never fabricates a precise number).
- The two conflicting precise figures (18% and 22%) are NOT averaged or split into a single invented ~20%. Both are quoted as the notes gave them, or the contradiction is flagged and escalated; no single synthesised number is shipped.
- The "great quote" that was never written down is NOT invented. It is flagged "referenced in the notes but not provided, not included."
- The unnamed guest attributed as "the founder (name not provided)", never invented.
- Channels marked "Assumed: default repurpose set" since none were specified.
- The missing brand voice flagged; no voice rules invented, assets kept plain.
- Handoff written, recording the assumptions made and the missing pieces (the unwritten quote, the unnamed guest).

## Case C: missing-input
INPUT:
"Can you repurpose our latest webinar into a blog, some posts, a newsletter, and a video script?"
No transcript, no notes, no summary of what was said, no speaker, no topic beyond "our latest webinar" is provided.

EXPECT:
- Loop 1 (Missing Input) fires. The skill names the gap plainly: repurposing needs the source material, there is nothing to extract from, only a reference to a webinar, and it will not invent content.
- Asks once, plainly, for the one thing needed (the transcript, recording notes, or a summary of the actual points made), explaining that repurposing without source material would mean inventing the content.
- Does NOT draft a blog, posts, newsletter, or script from nothing. Invents no claims, no numbers, no quotes, no speaker name.
- If it emits anything, it returns only the empty pack structure with every field marked "Not provided", not filled with placeholder content.
- Handoff still written at `.claude/crew-state/marketing/crew-marketing-content-repurpose-handoff.md` recording the run was blocked on missing source content and what to supply next time.
