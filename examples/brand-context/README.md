# Brand context starter files

The three brand files in this folder are fictional. No real company, no real person. They exist so you can see what a finished Crew brand context looks like, then copy one and make it yours. Every line in them is an example of the kind of answer Crew needs, not content you should keep.

## One brand or two?

Rule of thumb: if it has a different voice, a different audience, and different rules, it is its own brand and gets its own drawer. A product line inside one business (a new service tier, a seasonal offer, a second location that sounds the same) stays inside that brand's file.

## How to use these

1. Pick the file closest to your kind of business.
2. Copy it and replace every line with your own words. Do not leave any example text behind.
3. Save it as `your-brand.md` (use your actual brand name).
4. Repeat for any second brand that passes the rule of thumb above.
5. Attach your file or files to Claude and send this prompt exactly:

```
I am setting up Crew with my brands. I have attached my brand context files. Save them exactly as written, no edits:
- [main-brand].md is my main business. Save it as the ACTIVE brand at ~/.claude/crew-state/brand-context.md
- [other-brand].md is a separate brand. Save it to its own drawer at ~/.claude/crew-state/brands/[other-brand]/brand-context.md
Create any folders needed. Then list every path you wrote and tell me which brand is active.
```

Swap the bracketed names for your real file names. If you only have one brand, keep the first line item and drop the second.

Switch between brands anytime by telling Claude "switch to [brand]".
