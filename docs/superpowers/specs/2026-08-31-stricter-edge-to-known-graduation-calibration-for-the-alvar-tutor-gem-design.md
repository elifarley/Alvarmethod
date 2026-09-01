# Design — stricter edge→known graduation calibration for the alvar-tutor Gem

Date: 2026-08-31
Repo: Alvarmethod (gem only; Claude-side skills out of scope)
Amends: docs/superpowers/specs/2026-08-26-alvar-tutor-gem-for-gemini-web-design.md
("INSTRUCTIONS.md — behavioral contract" item 4 — delta list; item 5 — probe
rubric table)
Rev 2: folds in the 2026-08-31 spec-roast (F-001..F-012, O-001..O-006); see
§7 for the disposition ledger.

## 1. Problem

Real use of the Gem shows the status ladder ratchets in both directions too
cheaply:

- **edge→known costs 2 correct option-picks.** The rubric (INSTRUCTIONS.md
  probe protocol; 2026-08-26 spec item 5 table) grants `known` on a retry:
  "correct letter alone → `edge`, and locks as `known` when the same strand
  answers correct again on its retry." One or two lucky/recognitive picks
  graduate a strand.
- **unknown→edge costs 1 near-miss.** "wrong, near-miss → `edge`" flips a
  strand on a single answer.
- **correct + sound reason → `known` outright** — one good answer graduates.

Graduation should take time and several questions probing the area from
different angles; a correct multiple-choice pick or two is recognition, not
knowledge.

## 2. Decisions (all approved by the owner)

1. **edge→known: distinct-angle streak.** 3 correct answers, on 3 different
   questions, each probing a different angle, never two in the same message.
   Letter-only answers count fully. A wrong answer drops the streak by 1
   (floor 0) — recovery, not restart. (Refined by §3b's pop rule: the
   streak generalizes to the whole ledger.)
2. **unknown→edge: two-signal entry.** Edge requires two positive signals on
   two different questions. The owner's named weak combos — two near-misses,
   or one near-miss + one correct-letter-alone — generalize to: any two of
   {correct letter alone, correct with sound reason, near-miss}. Stronger
   combos qualify a fortiori (it would be absurd if worse evidence granted
   more).
3. **One bar everywhere — same thresholds, not a shared ledger.** Teach-time
   node advancement applies the identical rules; but each taught node starts
   a fresh evidence record (§3). The owner-approved cost preview was "every
   node locks in ≥3 quiz exchanges", which is only true under fresh-per-node;
   probe statuses gate which nodes exist and in what order — nothing else.
4. **Scope: gem + its docs only.** INSTRUCTIONS.md, knowledge/process.md,
   the amended 2026-08-26 spec, SMOKE-RUN.md, README (checklist AND the
   contributor-workflow paragraph). `skills/probe/`, `skills/alvar-learn/`,
   and the llm-prompting repo are untouched — the pack rubric stays the
   documented baseline the Gem's deltas are advertised against.

Standing constraints (owner preferences, unchanged): state lives in chat
history only — no counters, no state block, no resume ritual; new chat =
fresh probe, so records reset per session. The knowledge bodies carry no
provenance (`.port.md` sidecars own that). §3 honors the no-counter
constraint by externalizing the one ledger into the map's evidence column
(roast simplification, adopted): the printed table IS the state.

## 3. The new calibration (replaces the item 5 rubric semantics)

### 3a. Evidence model — one ledger, externalized

Statuses stay `known / edge / unknown / blocked`. Each strand carries ONE
ledger: the **standing credit list**, written in the map table's evidence
column (that column is the ledger — there is no other state, satisfying the
no-counter constraint and surviving context drift):

- **credit** — one entry, `correct·<angle>` or `near-miss`, appended newest
  last, on a fresh question — never a re-ask of a question already put to
  the learner on this strand — different from every other standing credited
  question; never two credits from one message.
- **angle** (closed taxonomy, ring-fenced): one of **meaning** (what it is),
  **application** (using it), **nuance-or-edge-case** (where it bends).
  Questions differing only in wording share an angle. The tutor names the
  angle when crediting.
- **correct credit** — a correct answer, letter-only or with reasoning,
  credits one correct entry labeled with its angle. Sound reasoning guards
  the credit (guards against lucky picks); a correct letter with unsound
  reasoning still credits the letter — the unsound reasoning is noted in
  evidence, not scored. Reasoning never substitutes for the angle: the
  credit's angle is the question's angle.
- **near-miss credit** — wrong-but-right-concept (chose the adjacent idea,
  misapplied one step) credits a `near-miss` entry. It never adds an angle,
  and as an answer it never pops anything.

### 3b. Status derivation (the table)

| condition | status |
|---|---|
| 3 standing correct credits, 3 distinct angles | `known` |
| ≥2 standing credits (any mix), not `known` | `edge` |
| <2 standing credits | `unknown` |
| wrong answer (not a near-miss) | **pop** the newest standing credit, any kind (floor: empty list) |
| wrong with the foundation missing | demote to `unknown`; **clear the ledger**; insert prerequisite |
| `D. I don't know` | `blocked`; **clear the ledger**; map data, never shamed |

The pop rule replaces the old "streak −1" with one mechanism for the whole
ledger (a wrong answer erodes the most recent credit whether it was a
correct or a near-miss; a near-miss itself never pops).

### 3c. Ledger lifecycle

- **Probe time:** credits accumulate on the strand's ledger as probe
  questions are answered; the map prints with final statuses when coverage
  is reached.
- **Teach time:** entering a taught node starts a **fresh ledger** for that
  strand. Probe statuses gate node selection and order only. (Same bar
  everywhere = same rules; not shared memory.)
- **Prerequisite detour:** an inserted prerequisite is its own strand with
  its own fresh ledger; the detoured strand's ledger pauses intact — no
  event fires on it while it waits.
- **Demotion or blocked:** the ledger clears; the ladder rebuilds from zero.
  No banked record survives a declared foundation failure (this closes the
  re-graduation-after-demotion hole and the known↔unknown oscillation).

### 3d. Maintenance

Every credit or pop updates that strand's row — the evidence line is
refreshed at the bottom of the same message. The full table reprints on any
status change (existing rule, unchanged in trigger, rarer in practice).

### 3e. Properties that must survive implementation

- No sequence of ≤2 answers reaches `known`.
- After a clearing event, no credit survives: one correct ⇒ 1 credit ⇒
  `unknown`; the strand cannot re-graduate off pre-failure evidence.
- Three corrects on only two distinct angles never graduate (the third
  credit's angle must be the missing one).
- Letter-only learners can still reach `known` — the bar is breadth of
  angles, not prose (delta (a)'s guarantee, restated in the amended doc).
- The existing rotation rule (correct option position across A/B/C) is
  orthogonal and unchanged; "never two in one message" restates
  one-question-per-message as an anti-gaming invariant on crediting.

## 4. Consequences (accepted)

- Every taught node locks in ≥3 quiz exchanges; a 6-node DAG ≈ 18+ quiz
  rounds. The DAG should stay shallow (this pressure is a feature).
- Probe sessions lengthen; `known` during probe is now rare and meaningful.
  Phase 2's "Start from `known`" (process.md) remains valid — it is a
  planning rule about the DAG's entry strands, not a probe promise; the ramp
  through prerequisites grows, which is the intended pressure.
- Map reprints on status change get rarer; each credited answer instead
  refreshes one evidence line. Because the ledger is the printed evidence
  column, long sessions (25+ exchanges) do not depend on the model
  re-deriving tallies from distant turns — the externalized row survives
  context drift.

## 5. Changes by file (worktree branch
`stricter-edge-to-known-graduation-calibration-for-the-alvar-tutor-gem`)

1. **`gems/alvar-tutor/INSTRUCTIONS.md`** — rewrite the scoring lines in
   Quiz protocol + Probe protocol to §3.
   **Budget gate: `wc -m` ≤ 4000 (today: 3993 — 7 chars of headroom).**
   The new text is longer than the old, so a **cut list is mandatory**
   (§5.1a; amended 2026-08-31: the shipped paste landed at 3983 — 10 under
   the old 3993 — so the cut list never fired as a gate, though the §5.1a
   compressions shipped anyway as part of the rewrite). **Ring-fenced clauses — never compressible, present verbatim:**
   the angle taxonomy with its three values; the clearing rule ("demotion
   or D clears the strand's credits"); the letter-only credit rule (correct
   letter with unsound reasoning still credits); the fresh-ledger-on-teach
   line; the evidence-column-maintenance line. Cut order when over budget:
   (1) micro-compress unchanged prose, (2) compress new rubric wording
   EXCEPT ring-fenced clauses, (3) **never** drop a §3 rule or a ring-fenced
   clause. The truncation canary (SMOKE-RUN Chat B item) re-verifies the
   tail survives pasting.

   **§5.1a Candidate cuts** (unchanged-meaning compressions, estimated
   recovery ≥ 300 chars total — the new rubric adds ≈ 250–350):
   - "Rotate the correct answer's position across A/B/C. Never mark or hint
     at it." → "Rotate the correct option across A/B/C; never hint at it."
     (−25)
   - "Prose or an invalid token reply: score what you can, ask for a letter;
     restate the protocol once — never nag." → "Prose or invalid token:
     score what you can, ask for a letter; restate the protocol once." (−20)
   - "Skip a strand only if their material shows work on it — a derivation,
     a correct usage, a solved problem — nameable in one sentence. A bare
     claim or pasted brief is probe data, not skip data." → trim
     "nameable in one sentence" and "or pasted brief" (−35)
   - Visuals section: "the learner renders it themselves — you have not
     seen the render, never claim to" → "the learner renders it; you have
     not seen the render — never claim to" (−20)
   - Session end / Scope: micro-trims ("A new chat means a fresh probe."
     merges into the probe line; "Redirect non-learning requests back,
     gently." → "Redirect non-learning requests gently.") (−30)
   - Verify section: "Cite only sources the search surfaced." merges into
     the report sentence (−20)
   - If still over: compress the rubric's non-ring-fenced connective prose,
     never its rule content.

2. **`gems/alvar-tutor/knowledge/process.md`** — align the Phase-3 advance
   line ("Advance only on lock-in" → lock-in defined by §3's bar) and the
   feedback-rules section (quiz rotates angles until the strand locks; the
   vibe line "if they answer from vibe, ask one tighter question" becomes
   "credit it per the rubric, then ask the next question at a fresh
   angle" — wording as shipped 2026-08-31, superseding the oracle's first
   draft "rotate to a fresh angle before crediting"). Phase 1 has no advancement
   language (verified: `process.md:8-20`) — nothing to change there; Phase
   2's "Start from `known`" stays (rationale in §4).
3. **`gems/alvar-tutor/knowledge/process.port.md`** (sidecar) — add one
   adaptation-list entry against source
   `skills/alvar-learn/references/process.md @ 848c91c` (source untouched
   by decision 4), **worded as a do-not-clobber warning**: "GEM-ONLY DELTA
   — do not overwrite from source; when re-porting, re-apply this entry
   verbatim — the source still carries the pack rubric."
4. **Spec `2026-08-26-alvar-tutor-gem-for-gemini-web-design.md`** — under
   "INSTRUCTIONS.md — behavioral contract":
   - item 4: add **delta (c)** (this calibration) beside (a)/(b), each
     amended passage dated 2026-08-31;
   - **rewrite delta (a)'s prose** — it states the old retry rule verbatim
     (`:148-151`); new text states the breadth-of-angles guarantee (3
     corrects / 3 angles, letter-only counts);
   - update the **delta count** "two deliberate deltas" (`:175`) → three;
   - align the **vibe line** (`:156-157`, "ask one tighter question") to
     rotate-a-fresh-angle;
   - item 5: replace the rubric table with §3's table; update the map
     columns note (evidence column now carries the ledger) and the
     reprint rule (§3d).
5. **`gems/alvar-tutor/SMOKE-RUN.md` + README checklist** — **restructure
   the script**, not just wording (the current sequence can never observe
   the new bar: item 8's single correct + item 9's wrong leaves node 1
   below 3 credits, so the rewritten item-10 assertion is unobservable).
   New Chat A sequence around lock-in:
   - node-1 lock-in: correct + reason (meaning) → letter-only (application)
     → letter-only (nuance) → **node locks, teaching advances** — the bar
     is observable;
   - then, on the NEXT node, a deliberate **foundation-missing** wrong
     (absurd option, not plausible) → demote to `unknown`, prerequisite
     inserted, **map reprints** (this is the reprint trigger — a plain or
     plausible wrong no longer reprints);
   - a **near-miss** answer → watch: strand holds, no status change, **no
     reprint**;
   - a **packed reply** (two letters in one message) → Gem scores one,
     asks for one (O-004);
   - a **negative-smoke item** (durable checkbox in this runbook AND the
     README list): 1–2 correct answers never graduate a strand or a node;
   - **renumber and recount** (today: "18 items"; new count after inserts),
     README checkbox list updated to match; fix the README map-reprint
     recipe ("test with a wrong answer → retry/insert") to key on the
     foundation-missing wrong.
6. **`gems/alvar-tutor/README.md` — Contributors paragraph** (`:99-102`):
   add the sanctioned-exception sentence: "Gem-only deltas recorded in a
   sidecar adaptation list are the sanctioned exception; when re-porting,
   re-apply them verbatim — the source still carries the pack rubric."
   Without this, the documented re-port procedure silently reverts the
   calibration.

**Not touched:** `skills/probe/SKILL.md`, `skills/alvar-learn/**`,
`skills/learn-profile|learn-verify|learn-visual`, the llm-prompting repo,
`.alvar/` maps and sessions (historical records),
`docs/superpowers/plans/2026-08-26-alvar-tutor-gem.md` (dated implementation
snapshot; keeps old-rubric quotes by design — declared historical, O-006).

## 6. Verification

1. **Budget:** `wc -m gems/alvar-tutor/INSTRUCTIONS.md` ≤ 4000, with every
   ring-fenced clause present verbatim.
2. **Negative — the fix's reason to exist:** 1 or 2 correct answers never
   show `known`, never advance a node (durable smoke checkbox, §5.5).
3. **Angle discrimination:** 3 corrects on only **2 distinct angles** → the
   strand stays `edge` (catches an implementation that ignores angles).
4. **Near-miss accounting:** two near-misses → `edge` with zero correct
   credits; the next single correct does **not** graduate (catches
   near-misses being scored as corrects).
5. **Post-demotion ledger:** after a foundation-missing demotion, one more
   correct → strand shows `unknown` (1 credit) — never `edge` or `known`
   (catches bank-keeping implementations).
6. **Positive:** three letter-only corrects on three different angles,
   separate messages ⇒ `known` and teaching advances — the letter-only path
   terminates.
7. **Setback:** a wrong mid-streak pops one credit (status holds); a
   foundation-missing wrong demotes to `unknown`, clears the ledger, and
   inserts a prerequisite node.
8. The updated SMOKE-RUN passes against the rebuilt Gem (Phase 0 re-paste —
   the running Gem keeps the old instructions until rebuilt).

## 7. Roast disposition ledger (2026-08-31 spec-roast, commit 744d84a)

| finding | disposition |
|---|---|
| F-001 demotion bank fate | §3b clearing rule; §3c; §6.5 |
| F-002 "angle" undefined | §3a closed taxonomy; ring-fenced in §5.1 |
| F-003 stale passages in amended doc | §5.4 ops (delta (a) rewrite, count, vibe line) |
| F-004 SMOKE-RUN unexecutable | §5.5 script restructure; §6.2 durable checkbox |
| F-005 suite can't discriminate | §6.3–6.5 three negative smokes |
| F-006 probe-bank vs node-bar | §2.3 + §3c fresh-per-node |
| F-007 implicit ledgers / drift | §2 + §3a evidence column IS the ledger; §3d |
| F-008 right-letter-wrong-reason | §3a correct-credit rule; INSTRUCTIONS line in §5.1 scope |
| F-009 README re-port reverts calibration | §5.6 carve-out; §5.3 do-not-clobber sidecar entry |
| F-010 "§5 table" mis-citation | header + §5.4 cite "behavioral contract" items 4/5 |
| F-011 Phase-1 advance language absent | §5.2 retargeted to Phase-3 line + feedback rules |
| F-012 "consecutive" vs −1-floor | §3b pop rule; near-miss never pops |
| O-001 Phase-2 start-from-known | no change; rationale §4 |
| O-002 D wipes bank? | §3b D clears |
| O-003 detour ledger | §3c pauses intact |
| O-004 packed reply | §5.5 smoke item |
| O-005 drift surface | §4 externalized-ledger rationale |
| O-006 plans-file perimeter | §5 not-touched, declared historical |
| Simplification (one ledger) | adopted — §3a |
