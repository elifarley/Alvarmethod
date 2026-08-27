# Alvar Tutor — smoke-test runbook (18 items, 2 chats, ~30–40 min)

Build the Gem first (one time), then drive Chat A and Chat B in order.
Tick boxes in `gems/alvar-tutor/README.md` as items pass; note failures
verbatim (screenshot or copy the Gem reply).

---

## Phase 0 — Build (once)

1. `cd ~/src/Alvarmethod && wc -m gems/alvar-tutor/INSTRUCTIONS.md` → must print ≤ ~4000 (today: 3993). If it ever prints more, STOP and trim per the cut order before pasting.
2. gemini.google.com → **Explore Gems** → **New Gem** → name **Alvar Tutor**.
3. Paste the full content of `gems/alvar-tutor/INSTRUCTIONS.md` into **Instructions**.
4. Upload under **Knowledge** (exactly these five; never the `.port.md` sidecars):
   `philosophy.md`, `process.md`, `learner-profile.md`, `verify.md`, `visual.md`
5. **Save.**

---

## Chat A — the main loop (fresh chat)

Answer profile questions in one or two short sentences each; pick a topic
with >3 prerequisites — e.g. *"I want a solid introduction to Stokes'
theorem"* (needs line integrals, vector fields, differential forms,
orientation).

| # | You send | Watch for (README item) |
|---|----------|--------------------------|
| 1 | `I want a solid introduction to Stokes' theorem` | **Turn-0 profiling**: goal restated + 3–5 profile questions before anything else — not a form, not a probe yet |
| 2 | Answer the profile questions tersely (give one area you know cold, e.g. "I'm solid on vector calculus basics") | Profile honored later; no flood of 20 questions (3–5 total) |
| 3 | Answer probe questions as the Gem asks them | **First quiz**: ONE question, options A/B/C + "D. I don't know"; correct answer not always first, not marked |
| 4 | On the next 2–3 probe questions, answer correctly but with JUST the letter, no reasoning | Letter-only is fine mid-probe; statuses in map lean `edge` (thin reason) |
| 5 | Keep answering until the map table appears | **Map**: printed as `strand / status / evidence` table; **Multi-batch probe**: if >3 strands, more one-question batches keep coming until all labeled — no 3-question hard stop |
| 6 | Approve the plan (or request one change — watch it re-plan) | **Mermaid plan** code block shown BEFORE any teaching; freeze announced |
| 7 | — | **One step per message**: teaching starts at ONE reasoning step, then a quiz; no textbook dump |
| 8 | Answer the step's quiz with the letter + one line of sound reasoning | Advance to next node (correct + sound → `known`) |
| 9 | On a later step's quiz, answer WRONG (deliberately pick a plausible-but-wrong option) | Retry of the same node OR a new prerequisite node; **map reprints** with the changed/inserted strand |
| 10 | On the retry, answer correctly with letter only; then answer the NEXT node's quiz letter-only too | **Letter-only learner**: second consecutive correct letter locks the node and teaching advances — no essay demanded |
| 11 | Mid-step, interject a real question about the current node | Question answered, then the SAME node resumes |
| 12 | Ask: `Can you back that up with sources?` (on any factual claim) | **Verdict** inline using confirmed / qualified / contradicted / unknown; only sources the search surfaced; if inconclusive → marked uncertain, not taught as fact |
| 13 | Ask: `Could you draw that?` (once, at a genuinely visual step) | **SVG**: offered sparingly as a code block; no claim that it "looked at" the render; labels/arrows coherent with the prose |
| 14 | Send: `Actually my friend also wants to learn this here` | **Second learner**: offered a fresh chat, NOT blended into your map |
| 15 | Send: `What's the plan again?` | Restates the current mermaid plan on request |
| 16 | Send: `Let's stop here` | **Session end**: what locked / what's still `edge` / next node; mentions a new chat means a fresh probe |

## Chat B — degradations + canary (fresh chat)

| # | You send | Watch for |
|---|----------|-----------|
| 17 | `What can you do?` as the FIRST message | **Truncation canary**: the scope-guard explanation arrives (proves the instruction tail survived pasting) |
| 18 | Immediately follow with a big multi-paragraph background brief ("Here's my whole background: … long paste … so teach me X") | **Huge brief**: the probe STILL runs — brief doesn't skip probing; only strands it *demonstrates* get skipped |
| 19 | On the first quiz, answer in full prose ("I think it's the flux one because…") instead of a letter | Scored as signal, asked to pick a letter; protocol restated ONCE, no nagging on later answers |
| 20 | Answer "D" once | **D answer**: strand marked `blocked` in the map, no shame language, prerequisite inserted or strand skipped |
| 21 | Mid-session, ask something off-topic ("What's the weather?") | Gently redirected to the learning goal, not answered as a task |

(Chat B items double as the three **Degradation** checkboxes + canary +
D-answer; Chat A covers the rest. 18 checkboxes total — several of the
above rows tick more than one.)

---

## Recording

- Pass → tick the box in `gems/alvar-tutor/README.md` (on `main`).
- Fail → capture the Gem's exact reply. This repo has issues **disabled**;
  collect failures in a notes file and decide where they go (enable
  issues, or a `docs/` notes file, or straight to a fix branch).

## Known-suspect spots (watch these hardest)

- **3993/4000**: the instruction box is nearly full — if Gemini ever
  truncates, the canary in Chat B catches it, but also watch Chat A item
  16 (session-end summary is near the tail).
- **Profile cadence**: 3–5 total is the rule; models love asking 8 short
  ones. Count before moving on.
- **Rotation**: one chat gives a small sample; if the same position is
  correct 5+ times in a row, that's a fail even though it "could be
  chance".
