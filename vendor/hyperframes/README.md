# Bundled third-party: HyperFrames

Six agent skills for HyperFrames, the HTML-to-video engine ("Write HTML. Render video. Built for agents."). Bundled with Crew so a fresh install can produce rendered video: compositions, captions synced to audio, text-to-speech voiceovers, audio-reactive visuals (beat sync, glow, pulse), hand-drawn emphasis (marker sweeps, scribble, sketchout, burst lines), shader transitions, and full renders.

## Provenance and licence

- Upstream: https://github.com/heygen-com/hyperframes
- Licence: Apache License 2.0 (the full text is in LICENSE beside this file)
- These skill files are redistributed verbatim from the upstream project's skills, unmodified, vendored 2026-07-18.
- HyperFrames is a third-party project. It is NOT a Crew-authored skill: it does not follow the Crew gold template, the Context Loop, or the Crew QA gates, and it is deliberately excluded from the Crew QA scans. It ships as-is, under its own licence, because it is excellent at what it does.

## What each skill does

| Skill | Job |
|-------|-----|
| hyperframes | Author video compositions in HTML: layout, timing, captions, voiceover, audio-reactive motion, transitions |
| hyperframes-cli | The dev loop: init, lint, inspect, preview, render |
| hyperframes-media | Asset preprocessing: text-to-speech, transcribe, remove-background |
| hyperframes-registry | The component shelf: install effects like marker highlights, scribble, sketchout, burst lines, shimmer sweeps, grain, data charts via `npx hyperframes add <name>` |
| remotion-to-hyperframes | Port a Remotion project to HyperFrames |
| website-to-hyperframes | Turn an existing website into a video composition |

## Requirements

The skills drive the HyperFrames CLI through `npx hyperframes ...`, so the machine needs Node.js 18 or newer. Nothing else to configure: npx fetches the tool on first use.

## How it fits the Crew

Invoke the `hyperframes` skill directly when you want a rendered video. Crew build skills stay in charge of live websites and decks; HyperFrames is the rendered-video lane. Brand facts still come from your Crew brand context: tell the skill your colours, fonts, and voice (or paste the brand block) when you brief it.
