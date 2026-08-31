# Stricter edge→known graduation calibration — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers-extended-cc:subagent-driven-development (recommended) or superpowers-extended-cc:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace the alvar-tutor Gem's 2-strike rubric with the credit-ledger calibration (3 corrects / 3 angles → known; 2-credit edge; pop-on-wrong; clear-on-demotion/D) across the Gem and its docs, per spec rev 2 (commit c0c93c8).

**Architecture:** All targets are prose/markdown — no code, no test framework. "Tests" are mechanical gates (`wc -m`, whitespace-tolerant greps, cross-file consistency) plus the manual SMOKE-RUN (user-gated, needs gemini.google.com). The scoring core moves into a new `## Rubric` section of INSTRUCTIONS.md — single source shared by quiz and probe (status derivation AND the action mapping: advance only on `known`; below that, keep quizzing at fresh angles; prerequisites come only from a foundation-missing wrong or D), which is what made the ≤4000-char budget achievable (3983 measured vs 3993 today).

**Tech Stack:** Markdown, Gemini Gems runtime, `hug` git wrapper (repo convention — NEVER bare `git` for index/commit operations). No Makefile in this repo → no `make sanitize` gate exists; do not invent one.

**Worktree:** execute in `/home/ecc/src/Alvarmethod.WT.stricter-edge-to-known-graduation-calibration-for-the-alvar-tutor-gem` (branch `stricter-edge-to-known-graduation-calibration-for-the-alvar-tutor-gem`, already carries spec + spec-rev2 commits).

**Budget receipt (measured while planning):** the Task 1 paste below measures **3983** chars (`wc -m`); all five ring-fenced clauses from spec §5.1 are present verbatim. Do not "improve" wording without re-running the gate.

**Ring-fenced clauses (spec §5.1 — must survive verbatim, whitespace-insensitive):**
1. `meaning (what it is), application (using it), nuance-or-edge-case (where it bends)`
2. `demotion or D clears the strand's credits`
3. `unsound reasoning still credits`
4. `A taught node starts its credit record fresh; probe statuses only order the DAG`
5. `every credit or pop rewrites that line`

---

### Task 1: INSTRUCTIONS.md — paste the calibration rubric (budget-gated)

**Goal:** INSTRUCTIONS.md carries the §3 calibration in a new `## Rubric` section; file stays ≤4000 chars.

**Files:**
- Modify: `gems/alvar-tutor/INSTRUCTIONS.md` (full rewrite — content below, 3983 chars measured)

**Acceptance Criteria:**
- [ ] `wc -m gems/alvar-tutor/INSTRUCTIONS.md` prints ≤ 4000 (expect 3983)
- [ ] All five ring-fenced clauses grep-match (whitespace-tolerant — use `grep -Pz` or `python3`, NOT plain grep, which cannot match across lines)
- [ ] Old-rubric identifiers absent: `locks as`, `answered correct again on its retry`, `correct + sound reason`, `consecutive`, `` `unknown` → insert a prerequisite `` (case-insensitive)
- [ ] Action mapping lives in the rubric: advance only on `known`; anything less keeps quizzing at fresh angles; prerequisite insertion appears ONLY from a foundation-missing wrong or D — never from thin positive evidence
- [ ] Section order: Quiz protocol references "the rubric"; `## Rubric (probe and quiz)` sits between Quiz protocol and Probe protocol

**Verify:** `wc -m gems/alvar-tutor/INSTRUCTIONS.md` → `3983`; `grep -c 'unknown. → insert a prerequisite' gems/alvar-tutor/INSTRUCTIONS.md` → 0; `python3 -c "import re;t=open('gems/alvar-tutor/INSTRUCTIONS.md').read();import sys;[sys.exit(f'missing: {c}') for c in ['demotion or D clears the strand','meaning (what it is), application (using it), nuance-or-edge-case','unsound reasoning still credits','starts its credit record fresh','every credit or pop rewrites that line'] if not re.search(r'\\s+'.join(map(re.escape,c.split())),t)];print('ring-fence OK')"` → `ring-fence OK`

**Steps:**

- [ ] **Step 1: Replace the entire file content** with exactly this (3983 chars — do not reflow):

````markdown
You are one teacher for one mind. Not a course. Not a survey.

## Turn 0 (each step is its own exchange)

1. Restate the goal in one sentence. Confirm.
2. Profile: 3–5 questions on how this mind learns best — solid ground, goal,
   pace, struggle, voice, visuals. Conversational, not a form.
3. Probe (below).
4. Show the plan as a mermaid code block BEFORE teaching; ask for changes.
   Freeze until a quiz failure adds a node or they ask to replan.
5. Teach node 1.

## Hard rules

- Struggle stays in the material; you absorb logistics.
- Never reteach what they know; never start in `unknown` with no ramp.
- One reasoning step per message. Stop. Quiz it. Advance only on a `known`
  strand.
- Never dump the whole explanation at once.
- No invented citations.
- Only your quizzes credit the map.

## Quiz protocol (chat letters)

- Exactly one quiz question per message: A, B, C, plus D. I don't know.
- They reply one letter; typed reasoning is signal.
- Rotate the correct option across A/B/C; never hint at it.
- Never reveal the answer before their reply.
- Prose or invalid token: score what you can, ask for a letter; restate once.
- A taught node starts its credit record fresh; probe statuses only order the DAG.
- Score by the rubric.

## Rubric (probe and quiz)

- Each correct or near-miss answer appends one credit — a fresh question,
  never a re-ask, never two per message: `correct·angle` or `near-miss`.
- Angles: meaning (what it is), application (using it), nuance-or-edge-case
  (where it bends). Each correct credit names a different angle; wording-only
  variants share an angle.
- A correct answer — letter or prose — credits its angle; unsound
  reasoning still credits, noted not scored. Invite talk-through: reasons
  sharpen evidence, never credits.
- Wrong but right concept (adjacent idea, one misstep) is a near-miss: adds
  no angle and pops nothing.
- Status: 3 correct credits on 3 distinct angles → `known`; 2+ credits →
  `edge`; fewer → `unknown`. Below `known`, keep quizzing at fresh angles. A wrong pops the newest credit, any kind; a foundation-missing
  wrong inserts a prerequisite (a demotion); demotion or D clears the
  strand's credits.
- D → `blocked` — never shame: prerequisite first before
  anything built on it, or skip the strand.
- Print the map after probing: | strand | status | evidence |. The evidence
  cell is the credit record — every credit or pop rewrites that line immediately;
  reprint on request or on any status change.

## Probe protocol

- Start broad; binary-search every strand — up to 3 questions per batch,
  one message each, map updated between batches. Stop on coverage, not a
  count.
- No teaching mid-probe; one-line corrections after an answer are fine.
- Skip a strand only on shown work — derivation, correct usage, solved
  problem; a bare claim is probe data.

## Teach protocol

- One node per message.
- Interruptions: answer, resume — unless the question reveals a missing
  prerequisite; insert it first.
- Face-value facts come only after their supporting step locks.

## Visuals

Offer an SVG code block only when a picture would lock the idea; the
learner renders it; you have not seen the render — never claim to. Audit
the SVG source as text: arrow directions, one symbol per object, no
cropped text. Sparingly.

## Verify

Empirical, historical, or API claims — or unearned certainty: one
falsifiable sentence, grounded via Google Search, verdict inline —
confirmed / qualified / contradicted / unknown, citing only surfaced
sources. Inconclusive: mark uncertain, proceed; never teach as fact.
In-session derivations may be taught, labeled derived.

## Session end

Summarize what locked, what is `edge`, the next node. A new chat
means a fresh probe; on request, restate the mermaid plan.

## Scope

If greeted or asked what you do: explain in 2–3 sentences with one short
example. One chat, one learner — a second learner starts a fresh chat.
Redirect non-learning requests gently.
````

- [ ] **Step 2: Run the budget gate** — `wc -m gems/alvar-tutor/INSTRUCTIONS.md`. If it prints ≠ 3983 (an editor reflowed something), diff against this plan's block and restore the exact text. If ever > 4000: STOP, trim per spec §5.1a cut order, never dropping a ring-fenced clause.
- [ ] **Step 3: Run the ring-fence check** (the Verify python one-liner) → `ring-fence OK`.
- [ ] **Step 4: Old-rubric absence check** — `grep -in 'locks as\|answered correct again\|correct + sound reason\|consecutive' gems/alvar-tutor/INSTRUCTIONS.md` → no matches.
- [ ] **Step 5: Commit**

```bash
hug a gems/alvar-tutor/INSTRUCTIONS.md
hug c -F - <<'EOF'
feat(gem): credit-ledger rubric replaces the 2-strike lock-in rule

Scoring core moves to its own `## Rubric (probe and quiz)` section —
one source shared by quiz and probe, which is what fit the new
calibration into the 4000-char box at all (3983 measured; the old file
sat at 3993 with the OLD, shorter rubric).

Ring-fenced per spec §5.1: angle taxonomy, demotion/D clearing,
letter-only credit, fresh-per-node record, evidence-cell maintenance.
Quiz-time semantics: known advances, edge keeps quizzing at fresh
angles (was: retry), unknown inserts a prerequisite.
EOF
```

---

### Task 2: knowledge/process.md + sidecar do-not-clobber entry

**Goal:** The ported process file teaches the new lock-in bar; the sidecar records the divergence with a do-not-clobber warning (F-009/F-011 ops).

**Files:**
- Modify: `gems/alvar-tutor/knowledge/process.md:40,49` (two lines)
- Modify: `gems/alvar-tutor/knowledge/process.port.md` (append two adaptation entries before the `Gem:` line)

**Acceptance Criteria:**
- [ ] `grep -c 'three correct credits on three distinct angles' gems/alvar-tutor/knowledge/process.md` → 1
- [ ] `grep -c 'rotate to a fresh angle before crediting' gems/alvar-tutor/knowledge/process.md` → 1
- [ ] `grep -c 'GEM-ONLY DELTA' gems/alvar-tutor/knowledge/process.port.md` → ≥ 2 (once per entry, both inside the adaptation list)
- [ ] Sidecar `Source of truth` pin and `Ported:` line untouched

**Verify:** `grep -n 'Advance only on lock-in\|answer from vibe' gems/alvar-tutor/knowledge/process.md` → both lines show the new wording; `grep -c 'do not overwrite from source' gems/alvar-tutor/knowledge/process.port.md` → 2

**Steps:**

- [ ] **Step 1:** In `process.md`, replace:

```markdown
- Advance only on lock-in. Fail → stay, or insert a prerequisite node.
```

with (one line — the file's house style is one bullet per line):

```markdown
- Advance only on lock-in — three correct credits on three distinct angles (the instructions' rubric). Fail → stay, or insert a prerequisite node.
```

- [ ] **Step 2:** In `process.md`, replace:

```markdown
- If they answer from vibe, ask one tighter question before advancing.
```

with:

```markdown
- If they answer from vibe, rotate to a fresh angle before crediting.
```

- [ ] **Step 3:** In `process.port.md`, insert immediately BEFORE the line `Gem: alvar-tutor (Gemini web)`:

```markdown
- phase 3 "Advance only on lock-in. Fail → stay, or insert a prerequisite node." -> "Advance only on lock-in — three correct credits on three distinct angles (the instructions' rubric). Fail → stay, or insert a prerequisite node." GEM-ONLY DELTA (2026-08-31 graduation calibration): do not overwrite from source — when re-porting, re-apply this entry verbatim; the source still carries the pack rubric (correct + sound reason → known outright; letter alone → edge, retry locks)
- feedback rules "If they answer from vibe, ask one tighter question before advancing." -> "If they answer from vibe, rotate to a fresh angle before crediting." (same GEM-ONLY DELTA — do not overwrite from source)
```

- [ ] **Step 4: Commit**

```bash
hug a gems/alvar-tutor/knowledge/process.md gems/alvar-tutor/knowledge/process.port.md
hug c -F - <<'EOF'
docs(gem): process.md teaches the credit-ledger lock-in; sidecar gets do-not-clobber

The knowledge file's Phase-3 advance line now points at the Gem's bar
(3 credits / 3 angles) instead of the pack's implicit one, and the vibe
line rotates to a fresh angle instead of "one tighter question" —
under the new calibration one tighter question can never lock a node.

The sidecar entries are worded as GEM-ONLY DELTA warnings because the
documented re-port procedure regenerates knowledge bodies from the
source skills — which still carry the pack rubric. Without the
warning, a by-the-book re-port silently reverts the calibration
(roast F-009). Source skills stay untouched by design: they are the
baseline the Gem's deltas are advertised against.
EOF
```

---

### Task 3: Amend the 2026-08-26 design spec (delta (c) + stale-passage repair)

**Goal:** The amended doc carries ONE calibration: delta (c) advertised, delta (a) rewritten, count = three, vibe line aligned, item-5 table replaced (F-003/F-010 ops).

**Files:**
- Modify: `docs/superpowers/specs/2026-08-26-alvar-tutor-gem-for-gemini-web-design.md` (item 4 quiz protocol block, item 5 probe rubric block)

**Acceptance Criteria:**
- [ ] `grep -c 'delta (c)' docs/superpowers/specs/2026-08-26-*.md` → ≥ 1; `grep -c 'Three deltas' docs/superpowers/specs/2026-08-26-*.md` → 1
- [ ] Zero matches for `locks as \`known\` when answered correct again`, `ask one tighter`, and `wrong reason is \`edge\`` in that file
- [ ] The item-5 table contains `pops the newest credit` and `credits cleared`
- [ ] `grep -c 'letter twice' <file>` → 0 (smoke item amended to the three-angle bar; added during execution — the roast missed it)
- [ ] No bare `§4 above` / `§5` cross-references remain in the two amended blocks (use "item 4 above" / "item 5")

**Verify:** `grep -n 'amended 2026-08-31\|Three deltas' docs/superpowers/specs/2026-08-26-alvar-tutor-gem-for-gemini-web-design.md` → four+ dated markers (delta (a) rewrite, delta (c), table footnote, evidence-cell note)

**Steps:** Read lines ~135-200 first; apply these replacements with the Edit tool (old strings are unique in the file):

- [ ] **Step 1 — delta (a) rewrite.** Replace:

```markdown
advertised: **(a)** row 2 is not the
     pack's "correct, thin reason | edge" — a bare correct letter is
     `edge` and locks as `known` when answered correct again on its retry,
     because a compliant letter-only learner must be able to advance;
```

with:

```markdown
advertised: **(a)** row 2 is not the
     pack's "correct, thin reason | edge" — a bare correct letter is one
     credit of evidence, and lock-in demands breadth of angles, not prose:
     three correct credits on three distinct angles graduate, letter-only
     answers count fully (amended 2026-08-31 by delta (c));
```

- [ ] **Step 2 — delta count + delta (c).** Replace `(Two\n     deltas from the pack's rubric, advertised:` with `(Three deltas from\n     the pack's rubric, advertised:` (keep `Three deltas` on one line — the verify greps are line-based); then replace:

```markdown
never applies in a runtime with no tools.)
```

with:

```markdown
never applies in a runtime with no tools; **(c)** amended 2026-08-31:
     the rubric itself is replaced by the stricter credit-
     ledger calibration (docs/superpowers/specs/2026-08-31-stricter-
     edge-to-known-graduation-calibration-for-the-alvar-tutor-gem-
     design.md §3) — graduation needs three correct credits on three
     distinct angles, edge needs two credits, a wrong pops the newest
     credit, and demotion or D clears the strand's credits.)
```

- [ ] **Step 3 — vibe line.** Replace:

```markdown
   - Applied questions over recap prompts; if they answer from vibe, ask one tighter
     question before advancing.
```

with:

```markdown
   - Applied questions over recap prompts; if they answer from vibe, rotate to a
     fresh angle before crediting.
```

- [ ] **Step 4 — talk-through sentence + item 5 lead-in.** Replace (the
  old string starts at the talk-through sentence on purpose: "`known`." is
  its tail, and the replacement must rewrite the whole sentence, not
  orphan it):

```markdown
   Invite a talk-through: a right letter with a wrong reason is `edge`, not
   `known`. Score every answer against the pack's rubric (ported from
   `skills/probe/SKILL.md` @ 848c91c, with the two deliberate deltas
   advertised in §4 above — this table IS what `edge` means; without
   it the map is improvised):
```

with:

```markdown
   Invite a talk-through: reasons sharpen evidence, never credits — a right
   letter with a wrong reason earns only the letter's credit (amended
   2026-08-31). Score every answer against the Gem's calibration (adapted
   from the pack's rubric — `skills/probe/SKILL.md` @ 848c91c — with
   the three deliberate deltas advertised in item 4 above; this table
   IS what `edge` means; without it the map is improvised):
```

- [ ] **Step 5 — replace the rubric table.** Replace the table + trailing paragraph (from `| result | status move |` through `...where the learner stands.`) with:

```markdown
   | answer | credit |
   |---|---|
   | correct — letter alone or reasoned, on a fresh question | one
     `correct·angle` credit; each correct credit names a different angle
     (meaning / application / nuance-or-edge-case); wording-only variants
     share an angle |
   | correct letter, unsound reasoning | still credits the letter's angle;
     the reasoning is noted, not scored |
   | wrong, near-miss (right concept, wrong detail) | one `near-miss`
     credit — never adds an angle, never pops |
   | wrong | pops the newest credit of any kind |
   | wrong, foundation missing | demote `unknown`; credits cleared;
     insert a prerequisite |
   | I don't know (D) | `blocked`; credits cleared |

   Status from the evidence cell: 3 correct credits on 3 distinct angles →
   `known`; 2+ credits → `edge`; fewer → `unknown`. A taught node starts a
   fresh credit record — probe statuses only order the DAG. (Table
   amended 2026-08-31 — delta (c).)

   After probing, print the map **once** as a markdown table
   `| strand | status | evidence |` with statuses `known / edge / unknown /
   blocked`; reference it without reprinting — but reprint the current table
   on request and whenever **any** strand's status changes or a strand is
   added (a lock-in failure can flip `edge`→`unknown`; an inserted
   prerequisite adds a row), so the printed record never silently misstates
   where the learner stands. The evidence cell IS the credit record — every
   credit or pop rewrites that line (amended 2026-08-31).
```

- [ ] **Step 6: Commit**

```bash
hug a docs/superpowers/specs/2026-08-26-alvar-tutor-gem-for-gemini-web-design.md
hug c -F - <<'EOF'
docs(spec): advertise delta (c); repair passages the new rubric orphans

Delta (a)'s prose restated the old retry rule verbatim — leaving it
meant the design doc carried two calibrations with no mark saying
which survives (roast F-003). Delta (a) now states the surviving
guarantee (breadth of angles, letter-only counts), the count is three,
and the item-5 table is the credit ledger. Cross-references use
"item 4/5" — the doc's bare section numbers don't point where a
reader expects (roast F-010).
EOF
```

**Execution note (added during implementation):** beyond the plan's original six replacements, the amended spec's own README smoke-checklist section carried FOUR stale items (letter-only "letter twice"; map-print reprint test keyed to a plain wrong; "Wrong quiz answer → retry"; D-answer without credits-cleared). All four are restated under the credit ledger and dated "amended 2026-08-31". The roast's F-003 cited three stale passages; the spec's smoke list was a further four, missed by both the roast and the original plan — lesson: when a spec embeds a copy of another artifact's checklist, sweeping the normative section is not enough.

---

### Task 4: SMOKE-RUN restructure + README checklist + contributor carve-out

**Goal:** The runbook's script can actually observe the new bar; README's checklist and workflow match (F-004/F-009 ops).

**Files:**
- Modify: `gems/alvar-tutor/SMOKE-RUN.md` (title, Chat A rows 4/8-11→restructured+renumbered, Chat B renumber 17-21→19-23, footer counts, Phase 0 count, Known-suspect spots)
- Modify: `gems/alvar-tutor/README.md` (checklist section 3; Contributors paragraph)

**Acceptance Criteria:**
- [ ] Chat A has 18 rows and the node-lock demonstration (row 9) requires exactly three corrects on three angles
- [ ] A near-miss row exists whose watch-for says **no** reprint
- [ ] A packed-reply row exists (two letters, one message → Gem scores one)
- [ ] `grep -c 'three correct letters on three' gems/alvar-tutor/README.md` → 1; `grep -c 'sanctioned exception' gems/alvar-tutor/README.md` → 1
- [ ] Row 4 observes the two-signal threshold: two questions against one named strand, credit acknowledged after each
- [ ] SMOKE-RUN Phase 0 and Known-suspect spots both cite the fresh count (3983)
- [ ] README checkbox count = 21 (18 current + exactly three net additions: near-miss, packed reply, credit-ledger visible) and SMOKE-RUN's footer count matches

**Verify:** `grep -c '^- \[ \]' gems/alvar-tutor/README.md` → 21; `grep -n '3983' gems/alvar-tutor/SMOKE-RUN.md` → 2 lines

**Steps:**

- [ ] **Step 1 — rewrite SMOKE-RUN.md** to exactly this content:

````markdown
# Alvar Tutor — smoke-test runbook (23 rows, 21 checkboxes, 2 chats, ~35–50 min)

Build the Gem first (one time), then drive Chat A and Chat B in order.
Tick boxes in `gems/alvar-tutor/README.md` as items pass; note failures
verbatim (screenshot or copy the Gem reply).

---

## Phase 0 — Build (once)

1. `cd ~/src/Alvarmethod && LC_ALL=C.UTF-8 wc -m gems/alvar-tutor/INSTRUCTIONS.md` → must print ≤ ~4000 (today: 3983; pin the locale — a C-locale wc counts bytes and would print ~4024). If it ever prints more, STOP and trim per the cut order before pasting.
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
| 4 | On the next TWO probe questions, answer correctly with JUST the letter, both against the SAME strand (pick one whose evidence cell is empty; ask the Gem to stay on that strand if it switches) | **Two-signal entry, observable**: after each answer the Gem acknowledges the new credit on that strand; the strand must NOT show `edge`/`known` after the first, and must show `edge` (not `known`) once the second lands |
| 5 | Keep answering until the map table appears | **Map**: printed as `strand / status / evidence` table; evidence cells show `correct·angle` / `near-miss` credits; **Multi-batch probe**: if >3 strands, more one-question batches keep coming until all labeled — no 3-question hard stop |
| 6 | Approve the plan (or request one change — watch it re-plan) | **Mermaid plan** code block shown BEFORE any teaching; freeze announced |
| 7 | — | **One step per message**: teaching starts at ONE reasoning step, then a quiz; no textbook dump |
| 8 | Answer the step's quiz with the letter + one line of sound reasoning | **First credit**: `correct·<angle>` appended to the strand's evidence cell (correct + reason counts as one credit, like any) |
| 9 | Answer the SAME node's next two quiz questions correctly, letter-only | **Negative check first**: after the FIRST credit the Gem keeps quizzing (no prerequisite insertion on thin positive evidence); after the second it is still quizzing — never advances on two. Then **letter-only lock-in**: third correct on a third distinct angle (meaning / application / nuance in some order) → node locks, teaching advances, map reprints |
| 10 | On the NEXT node's quiz, answer WRONG — pick an absurd option (foundation missing, not plausible) | **Demotion**: strand → `unknown`, its credits cleared, prerequisite node inserted, **map reprints** |
| 11 | After the prerequisite locks, answer the retried node's quiz plausibly-but-wrong (near-miss) TWICE on different questions; then answer further quiz questions correctly, letter-only, until it locks | **Near-miss**: each credit appended, no angle credited; after the FIRST the strand is still `unknown` (the demotion cleared everything — one signal ≠ `edge`); after the SECOND it shows `edge` with zero correct credits — never `known`. **No reprint** on the first (no status change); the second flips `unknown`→`edge` — that one **reprints**. Then normal lock-in at three angles |
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

- **Phase 0 count / 4000**: the instruction box is nearly full — if Gemini ever
  truncates, the canary in Chat B catches it, but also watch Chat A item
  18 (session-end summary is near the tail).
- **Profile cadence**: 3–5 total is the rule; models love asking 8 short
  ones. Count before moving on.
- **Rotation**: one chat gives a small sample; if the same position is
  correct 5+ times in a row, that's a fail even though it "could be
  chance".
- **Packed-reply anchor**: row 15 composes two Gem rules — invalid-token
  handling and never-two-per-message — keep both when editing
  INSTRUCTIONS.md.
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
````

- [ ] **Step 2 — README checklist.** In README section 3, apply these edits:
  - Replace the map-print checkbox:

```markdown
- [ ] Strand map printed as a table after probing; reprinted on request
     and after ANY status change or strand insertion (test with a wrong
     answer → retry/insert, then check the table)
```

with:

```markdown
- [ ] Strand map printed as a table after probing; evidence cells show
     `correct·angle` / `near-miss` credits; reprinted on request, after
     ANY status change or strand insertion, and the changed strand's
     evidence cell rewrites on every credit or pop (test with a
     foundation-missing wrong answer → demote + insert, then check the
     table; a near-miss must NOT reprint)
- [ ] **Near-miss**: plausible-but-wrong answer → one `near-miss` credit,
     strand holds (no status change, no reprint)
- [ ] **Credit ledger visible**: each credit or pop rewrites that strand's
     evidence cell in the same message — the cell is the running record
```

  - Replace the wrong-answer checkbox:

```markdown
- [ ] Wrong quiz answer → retry or inserted prerequisite, not advance
```

with:

```markdown
- [ ] Foundation-missing wrong → demote `unknown`, credits cleared,
     prerequisite inserted, not advance
```

  - Replace the letter-only checkbox:

```markdown
- [ ] **Letter-only learner**: answers correct with just the letter twice →
      the second answer locks the node and teaching advances
```

with:

```markdown
- [ ] **Letter-only learner**: three correct letters on three different
      angles lock the node and teaching advances; two correct answers
      never advance a node (negative check)
- [ ] **Packed reply**: two letters in one message → Gem scores one and
      asks for a single letter
```

  - Replace the D-answer checkbox:

```markdown
- [ ] **D answer**: answer "D. I don't know" once → strand marked `blocked`,
     no advance, no shame language, prerequisite inserted or strand skipped
```

with:

```markdown
- [ ] **D answer**: answer "D. I don't know" once → strand marked `blocked`,
     its credits cleared, no advance, no shame language, prerequisite
     inserted or strand skipped
```

- [ ] **Step 3 — README contributor carve-out.** Replace:

```markdown
Contributors: edit the source `skills/…`, then re-port per each knowledge
file's sidecar adaptation list (`knowledge/<name>.port.md` — maintainer-facing
only, never uploaded to the Gem). Never edit the files in
`gems/alvar-tutor/knowledge/` directly.
```

with:

```markdown
Contributors: edit the source `skills/…`, then re-port per each knowledge
file's sidecar adaptation list (`knowledge/<name>.port.md` — maintainer-facing
only, never uploaded to the Gem). Never edit the files in
`gems/alvar-tutor/knowledge/` directly — EXCEPT for Gem-only deltas
recorded in a sidecar adaptation list, which are the sanctioned exception;
when re-porting, re-apply them verbatim (the source still carries the pack
rubric).
```

- [ ] **Step 4: Run counts** — `grep -c '^- \[ \]' gems/alvar-tutor/README.md` → 21. If ≠ 21, recount and fix the SMOKE-RUN title/footer numbers to match reality (numbers must agree with the file, not with this plan).
- [ ] **Step 5: Commit**

```bash
hug a gems/alvar-tutor/SMOKE-RUN.md gems/alvar-tutor/README.md
hug c -F - <<'EOF'
docs(gem): runbook can now observe the bar it asserts; README workflow carve-out

The old script could never demonstrate a node locking: one credit, one
wrong, one retry left node 1 below three credits when the script jumped
to "the NEXT node" (roast F-004). The restructure makes the lock-in
observable (three angles), keys the reprint test to a foundation-missing
wrong (a near-miss no longer reprints — that's now its own negative
assertion), and adds the packed-reply probe. Checkbox count 18 -> 21.

README's "never edit knowledge files directly" forbade the very edit
this branch performs; the sanctioned-exception carve-out closes the
silent-revert-on-re-port hole (roast F-009).
EOF
```

---

### Task 5: Cross-file consistency sweep (mechanical, closes the branch)

**Goal:** Every §6 mechanical gate passes; no stale old-rubric identifiers anywhere outside the whitelisted surfaces.

**Files:** none modified (read-only sweep; fix-forward if a check fails)

**Acceptance Criteria:**
- [ ] `wc -m gems/alvar-tutor/INSTRUCTIONS.md` ≤ 4000
- [ ] Repo-wide stale sweep hits ONLY the whitelist (below)
- [ ] All five ring-fenced clauses match in INSTRUCTIONS.md (whitespace-tolerant)
- [ ] `hug ll` shows exactly 5 new commits on the branch (spec commits + Tasks 1-4)

**Verify:** run every command in Steps 1-3; each prints its expected result.

**Steps:**

- [ ] **Step 1 — budget + ring-fence:** re-run Task 1's Verify commands.
- [ ] **Step 2 — stale sweep:**

```bash
grep -rn --include='*.md' -i 'locks as .known.\|answered correct again\|correct + sound reason\|ask one tighter' \
  gems/ skills/ CONTRIBUTING.md docs/superpowers/specs/ | grep -v '2026-08-31-stricter'
```

Expected hits ONLY in: `skills/probe/SKILL.md`, `skills/alvar-learn/**`, `CONTRIBUTING.md` (pack baseline — deliberately untouched), `docs/superpowers/specs/2026-08-26-*` ONLY inside the rewritten delta-(a) sentence and delta-(c) description (they NAME the old rule to replace it). Any hit inside `gems/` other than those two spec lines is a miss — fix forward.
- [ ] **Step 3 — numeric agreement:** the three numbers (3 correct credits / 3 distinct angles; 2+ credits → edge; ≤4000 budget) appear consistently in INSTRUCTIONS.md rubric, spec §3 table, SMOKE-RUN rows 4/9, README checkboxes 9/11. Spot-check with `grep -n '3 correct credits\|three distinct angles\|2+ credits' gems/alvar-tutor/INSTRUCTIONS.md docs/superpowers/specs/2026-08-26-*.md gems/alvar-tutor/README.md`.
- [ ] **Step 4:** if every gate passed, no commit is needed (read-only task). If a check failed and was fixed, commit the fix as its own commit — never amend.

---

### Task 6: Rebuild the Gem and run SMOKE-RUN (USER-DRIVEN)

**Goal:** The rebuilt Gem passes the 23-row runbook — behavior verified against gemini.google.com.

**Files:** none in repo (manual verification; tick boxes in README as items pass)

**Acceptance Criteria:**
- [ ] Phase 0 re-paste done: new INSTRUCTIONS.md in the Gem's Instructions box, five knowledge files uploaded
- [ ] Chat A rows 1-18 pass — especially 4 (two-signal entry), 9 (three-angle lock-in incl. the negative check), 10 (demotion + clearing + reprint), 11 (near-miss holds, no reprint), 15 (packed reply)
- [ ] Chat B rows 19-23 pass (canary included)
- [ ] README checkboxes ticked or failures captured verbatim per the Recording section

**Verify:** manual — `gems/alvar-tutor/SMOKE-RUN.md` executed against a freshly built Gem.

**Steps:**

- [ ] **Step 1:** Follow SMOKE-RUN.md Phase 0 (rebuild the Gem — the running Gem keeps the OLD instructions until re-pasted).
- [ ] **Step 2:** Drive Chat A, then Chat B; capture failures verbatim.
- [ ] **Step 3:** Tick README checkboxes; bring failures back to this branch as fix commits.

```json:metadata
{"files": ["gems/alvar-tutor/SMOKE-RUN.md", "gems/alvar-tutor/README.md"], "verifyCommand": "manual: execute gems/alvar-tutor/SMOKE-RUN.md against a rebuilt Gem on gemini.google.com", "acceptanceCriteria": ["Phase 0 re-paste done (new instructions + 5 knowledge files)", "Chat A rows 1-18 pass incl. rows 4, 9, 10, 11, 15", "Chat B rows 19-23 pass incl. truncation canary", "README checkboxes ticked or failures captured verbatim"], "userGate": true, "tags": ["user-gate"], "gateScope": "full SMOKE-RUN against rebuilt Gem"}
```

---

## Execution notes

- Repo has NO Makefile → no `make sanitize`/`make check` targets exist; do not run or invent them. Verification is the per-task Verify commands.
- Every commit is a NEW commit (`hug c`); never `--amend`, never force-push (convergence record).
- Commit messages follow the repo's conventional style; the blocks above are ready to paste.
- The user-gate task (Task 6) is the owner's to run — it needs the Gemini web UI.
