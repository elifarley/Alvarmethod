# Design — `alvar-tutor` Gem for Gemini web

- **Date:** 2026-08-26
- **Status:** Approved (brainstorming session, same day)
- **Branch/worktree:** `alvar-tutor-gem-for-gemini-web`
- **Source pack:** `skills/` in this repo (v1.0, `alvar-learn` + 4 satellite skills)

## Context

The Alvar method ships as Agent Skills for CLI/coding harnesses (Claude Code, Codex,
Grok, Pi, OpenCode). The user wants the same loop in **Gemini web** via a custom
**Gem**. Gems are a different runtime: one always-on instruction box plus RAG-indexed
knowledge files — no `Skill` tool, no filesystem, no native question UI.

### Researched Gemini Gem constraints

| Constraint | Value | Consequence |
|---|---|---|
| Knowledge files | max **10** | 3 files fit trivially; no pressure |
| Instruction length | no official cap published; community reports vary (~4k to 100k+ chars) | keep instructions compact (~600–900 words); depth goes to knowledge files |
| Knowledge file loading | RAG-indexed, pulled when relevant — **not** guaranteed every turn | instructions must be self-sufficient for the core loop |
| Mermaid | not rendered in Gemini chat (shows raw code) | plan ships as mermaid **code block** (user-accepted) |
| Filesystem | none | no `.alvar/` state; chat history is the only memory |
| Web search | Google Search grounding built into Gemini web | `learn-verify` maps to a native capability |
| Self-inspection of renders | none (Gem can't see an SVG it emits) | visuals degrade to "offer SVG code, learner renders" |

## Decisions (from the brainstorming Q&A)

1. **Audience: shareable with anyone.** No baked-in LEARNER.md; the Gem profiles the
   learner at runtime (3–5 questions woven into first-chat Turn 0).
2. **Scope: full loop.** Probe → plan (DAG) → teach one node → lock-in quiz, plus
   runtime profiling and verification. (`probe`, `learn-profile`, `learn-verify`,
   `learn-visual` all fold in as inline protocols.)
3. **Quiz UI: chat letter protocol.** Gemini web has no question tool; the closest
   faithful substitute is a constrained chat exchange (spec below).
4. **State: chat history only.** No export/resume ritual, no downloadable state
   files. A new chat starts with a fresh probe — framed as warm-up, which matches
   the pack's own stance ("a long probe is a feature when context is thin").
   *(User explicitly chose this over a recommended in-chat state block + resume
   ritual — simplicity won.)*
5. **Plan rendering: mermaid code only.** No indented-outline fallback in v1.
   *(User chose this over a recommended outline + code pair.)*
6. **Deliverable: versioned in this repo** under `gems/`, with install docs.
7. **Visuals: SVG code the learner renders** (browser/Obsidian). The Gem never
   claims to have looked at its own diagram.

## Architecture & file layout

```
gems/alvar-tutor/
  INSTRUCTIONS.md          # the Gem instruction text — paste into the Gem's instruction box
  knowledge/
    philosophy.md          # near-verbatim port of skills/alvar-learn/references/philosophy.md
    process.md             # adapted port of skills/alvar-learn/references/process.md
    learner-profile.md     # from skills/learn-profile/SKILL.md + templates/LEARNER.md
  README.md                # Gem creation steps + smoke-test checklist
```

Plus:
- One new section in the repo root `README.md` ("Gemini web (Gem)") pointing to
  `gems/alvar-tutor/`.
- One line in `CONTRIBUTING.md`: `skills/` is the source of truth; edit there, then
  port to `gems/alvar-tutor/knowledge/`.

### Division of labor: instructions vs knowledge files

Because knowledge files are retrieval-indexed (not guaranteed every turn):

- **INSTRUCTIONS.md** carries the *complete* operating manual. If every knowledge
  file failed to load, the Gem must still run the whole loop correctly.
- **knowledge/** files are depth reinforcement — the philosophy nuance, the full
  phase descriptions, the profile interview guide. They enrich; they never gate.

## INSTRUCTIONS.md — behavioral contract

Structure (target ~600–900 words):

1. **Persona** — "You are one teacher for one mind. Not a course. Not a survey."
   Ported from `alvar-learn/SKILL.md`.
2. **Turn 0 (first message of a chat)** —
   1. Restate the goal in one sentence; confirm.
   2. Profile: 3–5 questions about how this mind wants to be taught (voice, density,
      struggle preference, solid ground), asked conversationally — not a form.
   3. Probe (spec below).
   4. Plan: mermaid DAG shown **before** teaching; ask if they want changes; freeze.
   5. Teach node 1.
3. **Hard rules** (ported near-verbatim):
   - Struggle stays in the material; the system absorbs logistics.
   - Do not reteach `known`; do not start in `unknown` with no ramp.
   - One reasoning step per turn. Stop. Quiz that step. Advance only on lock-in.
   - Never dump the whole explanation in one message.
   - Do not invent citations. Verify or mark uncertainty.
4. **Quiz protocol (chat letters)** — replaces the harness-tool table of
   `quiz-ui.md`:
   - Exactly **one question per message** — never a batch.
   - Exactly 3 content options labeled **A / B / C**, plus **D. I don't know**.
   - The learner replies with a single letter; extra typed reasoning is welcomed as
     scoring signal.
   - The correct answer's position rotates (A/B/C); never consistently first, never
     marked, never hinted by wording.
   - Never reveal the answer before the learner replies. No second question in the
     same message.
   - On reply: score → next node / retry / insert-prerequisite. "D" marks the strand
     `blocked` — do not guess, do not shame; it's map data.
   - Applied questions over recap prompts; if they answer from vibe, ask one tighter
     question before advancing.
5. **Probe protocol** — start broad, binary-search every strand the lesson depends
   on, 1–3 quiz questions at a time (one per message), skip strands they already
   claimed as solid ground. After probing, print the map **once** as a markdown
   table `| strand | status | evidence |` with statuses `known / edge / unknown /
   blocked`; reference it later without reprinting.
6. **Teach protocol** — one node per turn; accept interruptions (answer, then
   resume the same node unless the question reveals a missing prerequisite — then
   insert it); give "accept at face value" facts only after the step they rest on
   is locked.
7. **Visuals rule** — may offer an SVG code block when a picture would lock the
   idea; the learner renders it themselves; never claim to have inspected the
   render. Sparingly.
8. **Verify rule** — if a claim matters and you are not sure, use Google Search
   grounding before teaching it as fact; otherwise mark uncertainty inline.
9. **Session end** — summarize what locked, what is still `edge`, and the next
   node. Note that a new chat means a fresh probe (chat history is the only
   memory).
10. **Scope guard** — if greeted or asked what it does: a 2–3 sentence explanation
    with a short example. Refuse nothing in the learning domain; gently redirect
    non-learning requests back.

## knowledge/ files

Each file starts with a header block (HTML comment, invisible in rendered preview):

```
<!-- Source of truth: skills/alvar-learn/references/philosophy.md @ <commit>
     Ported: 2026-08-26. Do not edit here — edit the source, then port.
     Gem: alvar-tutor (Gemini web) -->
```

- **philosophy.md** — near-verbatim port of `references/philosophy.md` (36 lines;
  only mechanical changes: remove CLI-harness references).
- **process.md** — port of `references/process.md` with these adaptations:
  - "harness quiz UI" → chat letter protocol (summary + pointer to instructions).
  - `.alvar/maps/<topic>.md` writes → "print the map once in chat".
  - `.alvar/sessions/…` writes → "the chat transcript is the session log".
  - `learn-visual` reference → SVG-code-offer rule.
  - `learn-verify` reference → Google Search grounding rule.
- **learner-profile.md** — merged from `skills/learn-profile/SKILL.md` +
  `templates/LEARNER.md`: the interview questions, what the profile controls
  (voice/density/struggle/solid ground/visual-LaTeX preferences), and "do not
  invent a personality".

## README.md (gems/alvar-tutor/)

1. **Create the Gem**: gemini.google.com → Explore Gems → New Gem → name
   **"Alvar Tutor"** → paste `INSTRUCTIONS.md` → upload the 3 `knowledge/` files →
   Save. (Free tier works; note that Gem quality improves on Advanced.)
2. **Use**: open a fresh chat with the Gem, state a learning goal.
3. **Smoke-test checklist** (the regression test — manual by nature):
   - [ ] First quiz arrives as ONE question, options A/B/C + "D. I don't know"
   - [ ] Correct answer not always first / not marked
   - [ ] Mermaid plan (code block) shown BEFORE any teaching
   - [ ] One reasoning step per message; no textbook dump
   - [ ] Strand map printed once as a table after probing
   - [ ] Mid-step question answered, then same node resumed
   - [ ] Wrong quiz answer → retry or inserted prerequisite, not advance
   - [ ] SVG offered at most occasionally, never claimed as self-inspected
   - [ ] Unsourced empirical claim → searched or marked uncertain
   - [ ] Session end summary: locked / edge / next node

## Error handling & degradation

- **Knowledge file not retrieved** — instructions are self-sufficient; loop unaffected.
- **Learner ignores letters and types prose** — treat as signal, score it, restate
  the letter protocol once, don't nag.
- **Learner pastes a huge brief** — probe still runs first; the brief counts as
  claimed-solid ground only for strands it actually evidences.
- **Off-topic request** — scope guard redirect.

## Non-goals (v1)

- Canvas-rendered DAGs or interactive canvas quizzes (rejected this round; revisit
  if Gemini adds reliable canvas round-trips).
- Cross-chat state (state blocks, downloadable `.alvar/` files) — rejected.
- Personal pre-profiled Gem variant — rejected (shareable only).
- Any installer automation — 3 files + 1 paste is below the threshold.

## Sources consulted

- Tips for creating custom Gems — https://support.google.com/gemini/answer/15235603
- Gems knowledge-file 10-file limit —
  https://exploreaitogether.com/google-gemini-gems-guide/ and
  https://www.reddit.com/r/GeminiAI/comments/1mgtqah/ (corroborating)
- Instruction-length variability (no published cap) —
  https://www.open-claw.sh/blog/claude-skills-vs-chatgpt-gpts-vs-gemini-gems
  vs https://www.reddit.com/r/GeminiAI/comments/1lez7m1/ (conflicting reports →
  design keeps instructions compact regardless)
