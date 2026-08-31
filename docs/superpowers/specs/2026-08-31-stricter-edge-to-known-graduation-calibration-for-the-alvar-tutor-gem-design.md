# Design — stricter edge→known graduation calibration for the alvar-tutor Gem

Date: 2026-08-31
Repo: Alvarmethod (gem only; Claude-side skills out of scope)
Amends: docs/superpowers/specs/2026-08-26-alvar-tutor-gem-for-gemini-web-design.md (§4 delta (c), §5 table)

## 1. Problem

Real use of the Gem shows the status ladder ratchets in both directions too
cheaply:

- **edge→known costs 2 correct option-picks.** The rubric (INSTRUCTIONS.md
  probe protocol; spec §5) grants `known` on a retry: "correct letter alone
  → `edge`, and locks as `known` when the same strand answers correct again
  on its retry." One or two lucky/recognitive picks graduate a strand.
- **unknown→edge costs 1 near-miss.** "wrong, near-miss → `edge`" flips a
  strand on a single answer.
- **correct + sound reason → `known` outright** — one good answer graduates.

Graduation should take time and several questions probing the area from
different angles; a correct multiple-choice pick or two is recognition, not
knowledge.

## 2. Decisions (all approved by the owner)

1. **edge→known: distinct-angle streak.** 3 correct answers, on 3 different
   questions, each probing a different angle (meaning / application /
   nuance-or-edge-case), never two in the same message. Letter-only answers
   count fully. A wrong answer drops the streak by 1 (floor 0) — recovery,
   not restart.
2. **unknown→edge: two-signal entry.** Edge requires two positive signals on
   two different questions. The owner's named weak combos — two near-misses,
   or one near-miss + one correct-letter-alone — generalize to: any two of
   {correct letter alone, correct with sound reason, near-miss}. Stronger
   combos qualify a fortiori (it would be absurd if worse evidence granted
   more). Generalized form is what gets written.
3. **One bar everywhere.** Teach-time node advancement uses the same rubric
   as probe-time mapping. No lighter "just-taught" bar.
4. **Scope: gem + its docs only.** INSTRUCTIONS.md, knowledge/process.md,
   the spec (delta (c)), SMOKE-RUN.md, README checklist. `skills/probe/`,
   `skills/alvar-learn/`, and the llm-prompting repo are untouched — the
   pack rubric stays the documented baseline the Gem's deltas are
   advertised against.

Standing constraints (owner preferences, unchanged): state lives in chat
history only — no counters, no state block, no resume ritual; new chat =
fresh probe, so streaks reset per session. The knowledge bodies carry no
provenance (`.port.md` sidecars own that).

## 3. The new calibration (replaces the §5 rubric semantics)

Statuses stay `known / edge / unknown / blocked`. Evidence vocabulary:

- **positive signal** — correct letter alone, correct answer + sound
  reasoning, or near-miss (right concept, wrong detail). Must be on a
  different question from the strand's previous signal.
- **streak** — count of consecutive-not-yet-credited correct answers
  (letter-only or reasoned both count 1; a near-miss never adds to it).

| condition | status move |
|---|---|
| 3 correct answers on 3 different questions, 3 different angles, no two in the same message | `known` |
| 2 positive signals, different questions (streak < 3) | `edge` |
| fewer than 2 signals | `unknown` (evidence noted, not granted a label) |
| wrong answer | streak −1 (floor 0); strand keeps its status unless demoted below |
| wrong with the foundation missing | demote to `unknown`; insert prerequisite |
| `D. I don't know` | `blocked`; map data, never shamed (unchanged) |

Properties that must survive implementation:

- The minimum path to `known` from untouched is **3 corrects on 3 angles** —
  entry and streak are one continuum, never two independent gates
  (two bare corrects ⇒ `edge` with streak 2; the third correct on a new
  angle ⇒ `known`). No sequence of ≤2 answers reaches `known`.
- Sound reasoning counts as one correct, like any other — it guards against
  lucky picks; it no longer graduates.
- Letter-only learners can still reach `known` — the bar is breadth of
  angles, not prose (delta (a)'s guarantee, restated).
- "Never two in the same message" restates one-question-per-message as an
  anti-gaming invariant on the streak; the existing rotation rule (correct
  option position) is orthogonal and unchanged.
- Re-quizzing after a setback uses a fresh question; a fresh angle is
  preferred but not required for the streak (the three credited answers
  must be pairwise different angles).

## 4. Consequences (accepted)

- Every taught node locks in ≥3 quiz exchanges; a 6-node DAG ≈ 18+ quiz
  rounds. The DAG should stay shallow (this pressure is a feature).
- Probe sessions lengthen slightly; `known` during probe is now rare and
  meaningful.
- Map reprints fire on fewer transitions — the table gets quieter.

## 5. Changes by file (worktree branch
`stricter-edge-to-known-graduation-calibration-for-the-alvar-tutor-gem`)

1. **`gems/alvar-tutor/INSTRUCTIONS.md`** — rewrite the scoring lines in
   Quiz protocol + Probe protocol to the §3 calibration.
   **Budget gate: `wc -m` ≤ 4000 (today: 3993 — 7 chars of headroom).**
   The new text is longer than the old, so a **cut list is mandatory**:
   reclaim chars by micro-compressing unchanged lines (e.g. "Rotate the
   correct answer's position across A/B/C. Never mark or hint at it." →
   "Rotate the correct option across A/B/C; never hint at it."). Cut order
   when still over: (1) compress unchanged prose further, (2) compress the
   new rubric wording, (3) **never** drop a §3 rule. The truncation canary
   (SMOKE-RUN Chat B item 17) re-verifies the tail survives pasting.
2. **`gems/alvar-tutor/knowledge/process.md`** — feedback-rules section and
   the Phase-1/Phase-3 advance language aligned to §3 (quiz rotates angles
   until the strand locks; advance only on the streak).
3. **`gems/alvar-tutor/knowledge/process.port.md`** (sidecar) — add one
   adaptation-list entry recording this delta against source
   `skills/alvar-learn/references/process.md @ 848c91c` (source untouched
   by decision 4; the sidecar's adaptation list is the divergence ledger).
4. **Spec `2026-08-26-alvar-tutor-gem-for-gemini-web-design.md`** — add
   **delta (c)** (this calibration) beside (a)/(b) in §4, each amended
   section dated 2026-08-31; replace the §5 rubric table with §3's.
5. **`gems/alvar-tutor/SMOKE-RUN.md` + README checklist** — rewrite the
   items that encode the old rule:
   - item 4 (letter-only mid-probe): statuses lean `unknown` on a single
     bare correct — two signals needed for `edge`.
   - item 8 (advance on correct + sound): first credited correct of the
     node's streak, not graduation.
   - item 10 (letter-only learner): three correct letters on three
     different angles lock the node.
   Renumber/recount the 18-item runbook only if wording changes require it.

**Not touched:** `skills/probe/SKILL.md`, `skills/alvar-learn/**`,
`skills/learn-profile|learn-verify|learn-visual`, the llm-prompting repo,
`.alvar/` maps and sessions (historical records).

## 6. Verification

1. `wc -m gems/alvar-tutor/INSTRUCTIONS.md` ≤ 4000.
2. Negative smoke (the fix's reason to exist): a chat where the learner
   answers one or two probes correctly must show the strand at
   `unknown`/`edge`, never `known`; no node may advance on one or two
   quiz answers.
3. Positive smoke: three letter-only corrects on three different angles,
   separate messages, ⇒ strand shows `known` and teaching advances —
   delta (a)'s letter-only path still terminates.
4. Setback smoke: a wrong answer mid-streak drops the count, status holds
   at `edge`; a foundation-missing wrong demotes to `unknown` and inserts
   a prerequisite node.
5. Updated SMOKE-RUN items pass against the rebuilt Gem (Phase 0 re-paste
   — the running Gem keeps the old instructions until rebuilt).
