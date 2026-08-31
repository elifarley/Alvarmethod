# Alvar Tutor — smoke-test runbook (23 rows, 21 checkboxes, 2 chats, ~35–50 min)

Build the Gem first (one time), then drive Chat A and Chat B in order.
Tick boxes in `gems/alvar-tutor/README.md` as items pass; note failures
verbatim (screenshot or copy the Gem reply).

---

## Phase 0 — Build (once)

1. `cd ~/src/Alvarmethod && wc -m gems/alvar-tutor/INSTRUCTIONS.md` → must print ≤ ~4000 (today: 3977). If it ever prints more, STOP and trim per the cut order before pasting.
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
| 4 | On the next TWO probe questions, answer correctly with JUST the letter, both against the SAME strand (ask the Gem to stay on that strand if it switches) | **Two-signal entry, observable**: after each answer the Gem acknowledges the new credit on that strand; the strand must NOT show `edge`/`known` after the first, and must show `edge` (not `known`) once the second lands |
| 5 | Keep answering until the map table appears | **Map**: printed as `strand / status / evidence` table; evidence cells show `correct·angle` / `near-miss` credits; **Multi-batch probe**: if >3 strands, more one-question batches keep coming until all labeled — no 3-question hard stop |
| 6 | Approve the plan (or request one change — watch it re-plan) | **Mermaid plan** code block shown BEFORE any teaching; freeze announced |
| 7 | — | **One step per message**: teaching starts at ONE reasoning step, then a quiz; no textbook dump |
| 8 | Answer the step's quiz with the letter + one line of sound reasoning | **First credit**: `correct·<angle>` appended to the strand's evidence cell (correct + reason counts as one credit, like any) |
| 9 | Answer the SAME node's next two quiz questions correctly, letter-only | **Negative check first**: after the FIRST credit the Gem keeps quizzing (no prerequisite insertion on thin positive evidence); after the second it is still quizzing — never advances on two. Then **letter-only lock-in**: third correct on a third distinct angle (meaning / application / nuance in some order) → node locks, teaching advances, map reprints |
| 10 | On the NEXT node's quiz, answer WRONG — pick an absurd option (foundation missing, not plausible) | **Demotion**: strand → `unknown`, its credits cleared, prerequisite node inserted, **map reprints** |
| 11 | After the prerequisite locks, answer the retried node's quiz plausibly-but-wrong (near-miss) TWICE on different questions; then answer further quiz questions correctly, letter-only, until it locks | **Near-miss**: each credit appended, no angle credited; after the FIRST the strand is still `unknown` (the demotion cleared everything — one signal ≠ `edge`); after the SECOND it shows `edge` with zero correct credits — never `known`. **No reprint** on either near-miss. Then normal lock-in at three angles |
| 12 | Mid-step, interject a real question about the current node | Question answered, then the SAME node resumes |
| 13 | Ask: `Can you back that up with sources?` (on any factual claim) | **Verdict** inline using confirmed / qualified / contradicted / unknown; only sources the search surfaced; if inconclusive → marked uncertain, not taught as fact |
| 14 | Ask: `Could you draw that?` (once, at a genuinely visual step) | **SVG**: offered sparingly as a code block; no claim that it "looked at" the render; labels/arrows coherent with the prose |
| 15 | When asked a quiz question, send TWO letters at once (`A B`) | **Packed reply**: Gem scores one, asks for a single letter — protocol restated once, no nagging; never two credits from one message |
| 16 | Send: `Actually my friend also wants to learn this here` | **Second learner**: offered a fresh chat, NOT blended into your map |
| 17 | Send: `What's the plan again?` | Restates the current mermaid plan on request |
| 18 | Send: `Let's stop here` | **Session end**: what locked / what's still `edge` / next node; mentions a new chat means a fresh probe |

## Chat B — degradations + canary (fresh chat)

| # | You send | Watch for |
|---|----------|-----------|
| 19 | `What can you do?` as the FIRST message | **Truncation canary**: the scope-guard explanation arrives (proves the instruction tail survived pasting) |
| 20 | Immediately follow with a big multi-paragraph background brief ("Here's my whole background: … long paste … so teach me X") | **Huge brief**: the probe STILL runs — brief doesn't skip probing; only strands it *demonstrates* get skipped |
| 21 | On the first quiz, answer in full prose ("I think it's the flux one because…") instead of a letter | Scored as signal, asked to pick a letter; protocol restated ONCE, no nagging on later answers |
| 22 | Answer "D" once | **D answer**: strand marked `blocked` in the map, its credits cleared, no shame language, prerequisite inserted or strand skipped |
| 23 | Mid-session, ask something off-topic ("What's the weather?") | Gently redirected to the learning goal, not answered as a task |

(Chat B items double as the three **Degradation** checkboxes + canary +
D-answer; Chat A covers the rest. 21 checkboxes total — several of the
above rows tick more than one.)

---

## Recording

- Pass → tick the box in `gems/alvar-tutor/README.md` (on `main`).
- Fail → capture the Gem's exact reply. This repo has issues **disabled**;
  collect failures in a notes file and decide where they go (enable
  issues, or a `docs/` notes file, or straight to a fix branch).

## Known-suspect spots (watch these hardest)

- **3977/4000**: the instruction box is nearly full — if Gemini ever
  truncates, the canary in Chat B catches it, but also watch Chat A item
  18 (session-end summary is near the tail).
- **Profile cadence**: 3–5 total is the rule; models love asking 8 short
  ones. Count before moving on.
- **Rotation**: one chat gives a small sample; if the same position is
  correct 5+ times in a row, that's a fail even though it "could be
  chance".
- **Angle honesty**: the tutor must name genuinely different angles for
  the three lock-in credits — three rewordings of "what does X mean" are
  ONE angle and must not lock the node.
- **Fresh start**: when teaching begins, the node's evidence cell starts
  empty — probe-phase credits vanish by design (a taught node starts
  fresh). That is the rubric working, not a ledger failure.
- **Reprints**: any status change reprints the full map — including
  `unknown`→`edge` at the second credit — before the bigger one at the
  lock.
- **Prerequisite locks too**: row 11 — get the inserted prerequisite to
  lock first (three angles, like rows 8-9) before starting the retried
  node's quiz.
- **Pop rule** (driver judgment): to watch a plain wrong pop one credit,
  answer a wrong that is neither near-miss nor foundation-missing
  mid-streak — the credit count drops by one and the status holds.
  Staging that boundary cleanly is your call; no row scripts it.
