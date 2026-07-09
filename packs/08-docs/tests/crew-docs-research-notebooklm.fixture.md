# Fixture: crew-docs-research-notebooklm

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the behaviour and output, and that the record was written into the active project. All businesses are fictional. The NotebookLM tool is a local dependency; the smoke asserts the skill's ORCHESTRATION and guardrails, not a live Google call.

## Case A: clean
INPUT:
Continuing the project. Brand context exists. The NotebookLM tool is installed and logged in
(assume `notebooklm --help` and `notebooklm auth check --test` both pass, and the data
boundary was accepted earlier this project). Sources to research: three URLs about small-business
AI adoption and one YouTube talk. Goal: a grounded brief answering "what stops small businesses
adopting AI, and what changes it", plus an audio overview to listen to.
EXPECT:
- Skill runs Step 0 Context Recovery and settles the project (new or continuing).
- The Setup gate is honoured: because the tool is installed, logged in, and the boundary already accepted this project, it proceeds without re-asking, and reopens the project notebook via notebooklm use <id> from notebooklm.json rather than creating a new one.
- Sources are added with `notebooklm source add` per source and each is confirmed via metadata before any question; the skill never claims a source is in the notebook without confirming it.
- The grounded answer is produced with `notebooklm ask` and every claim carried out cites its source; nothing is answered from training when the notebook does not cover it.
- The audio overview is generated with `notebooklm generate audio ... --wait` (polled), then downloaded into the active project folder with `notebooklm download audio ./.../overview.mp3`, and the file is confirmed non-empty.
- notebooklm.json in the project records the notebook id, the four sources, the boundary acceptance, and the downloaded audio path.
- The data boundary (sources sent to Google) is stated, and a brief carried into a Crew document is rendered to the crew-design-documents standard.
- Output begins with the literal line "DEEP RESEARCH (NotebookLM)".
- No invented answers, sources, or artifacts; nothing claimed without tool confirmation.
- No em dashes anywhere in the output.
- The record was written to ~/.claude/crew-state/projects/<project>/crew-docs-research-notebooklm-handoff.md with the frame intact.

## Case B: messy
INPUT:
Fresh start. Brand context exists. The user wants "everything NotebookLM can make" from a folder
of eight PDFs, but one PDF is password-protected and will not add, the video generation errors
partway ("endpoint changed"), and one of the source topics is a confidential internal salary
document.
EXPECT:
- The confidential salary PDF triggers the data-boundary guardrail: the skill names that sources go to Google and gets explicit go-ahead before adding it; if the user hesitates it is left out and noted.
- The password-protected PDF is reported as the specific source that failed with the reason; the other PDFs are added; a workaround is offered (unlock and add, or paste text); it is never claimed to be in the notebook.
- The video generation error is reported honestly; the skill retries once, then says the tool may need updating (uv tool upgrade notebooklm-py) and offers the Crew-native fallback for the parts that do not need NotebookLM; no partial or stale video is presented as complete.
- The artifacts that DID generate are downloaded into the project and recorded; the ones that failed are named as gaps.
- STATUS is DONE_WITH_GAPS with the failed source, the failed video, and any withheld sensitive source named.

## Case C: missing input
INPUT:
"Do some deep research for me with NotebookLM."
EXPECT:
- No tool call that sends data anywhere. The skill asks once, plainly, for at least one source and the goal (a question to answer or an artifact to make), per Loop 1.
- If the tool is not installed or not logged in, the Setup gate gives the one install line (uv tool install "notebooklm-py[browser]") and the one login command (notebooklm login) and waits; it never pip-installs silently or handles the Google password.
- No sources, answers, or artifacts are invented while waiting.
- The record is still written into the active project first, STATUS: BLOCKED, naming the missing input or the incomplete setup as the blocker.
- The chat Completion status is NEEDS_CONTEXT or BLOCKED, never DONE.
