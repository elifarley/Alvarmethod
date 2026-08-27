# alvar-tutor Gem for Gemini web — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers-extended-cc:subagent-driven-development (recommended) or superpowers-extended-cc:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Ship `gems/alvar-tutor/` — a Gemini web Gem (instruction text + 5 knowledge files + README) porting the Alvar method, plus the repo-perimeter doc edits that keep README/CONTRIBUTING consistent with the new surface.

**Architecture:** One self-sufficient instruction box (the whole loop runs even if retrieval misses) + 5 RAG-indexed knowledge files as depth reinforcement, each a clause-level adaptation of its skill source and carrying a source pin + adaptation list in an HTML-comment header. Spec: `docs/superpowers/specs/2026-08-26-alvar-tutor-gem-for-gemini-web-design.md` (authoritative — read it before Task 1).

**Tech Stack:** Markdown only. No build step, no Makefile in this repo — verification is shell receipts (`wc -m`, `grep`, `diff`) per task. Commits via `hug` (never raw git; `git worktree` is hard-blocked).

**Worktree:** `/home/ecc/src/Alvarmethod.WT.alvar-tutor-gem-for-gemini-web` (branch `alvar-tutor-gem-for-gemini-web`). Do all work here.

> **Errata (post-execution, commit `c5a1b02`):** the tasks below describe knowledge-file provenance as HTML-comment headers *inside* each file. That convention was superseded right after execution: Gem knowledge files are RAG-indexed whole-file, so in-file comments are model-visible text — provenance moved to maintainer-facing sidecars, `knowledge/<name>.port.md`, never uploaded. When reading Tasks 2–8, substitute "header adaptation list" → "sidecar (`<name>.port.md`) adaptation list", and treat the body-windowing receipts (`sed -n '/-->/,$p' …`) as obsolete — whole-file scans are valid again. The spec's knowledge section (not this plan) is current on the mechanism.

---

## Shared conventions (read once, apply everywhere)

**Knowledge-file header** — every `knowledge/*.md` starts with this block, filled in. The `@ <sha>` pin is the **single source-baseline SHA, captured ONCE** (see Task 1 Step 3) and reused verbatim by all five ports — never re-derived per task: each port task commits its file, so a fresh HEAD per task would produce five different pins and fail Task 8's same-SHA check **by construction**. `<rows>` = that file's adaptation list, one row per clause:

```
<!-- Source of truth: <repo-relative source path> @ <sha>
     Ported: 2026-08-26. Do not edit here — edit the source, then re-apply
     the adaptation list below.
     Adaptations:
     - <row 1>
     - <row 2>
     Gem: alvar-tutor (Gemini web) -->
```

After the header: one blank line, then the ported body.

**Body-scan receipt** (used by every knowledge-file task) — scans only the
body (everything after the header's closing `-->`), so header rows that
*quote* forbidden phrases don't false-positive:

```bash
sed -n '/-->/,$p' gems/alvar-tutor/knowledge/<file>.md | tail -n +2 | grep -nE '<patterns>'
```

Expected: no output (exit 1). Any hit = a runtime-impossible clause survived.

**Shared substitution table** (from spec §knowledge — every adaptation row instantiates one of these; if a clause feels unadapted, check its class here):

| Runtime fact | Substitution |
|---|---|
| No filesystem (no `.alvar/`) | file writes → say it in chat; transcript is the log |
| No native question tool | tool calls → chat letter protocol |
| No render inspection | "look at it" → audit the source as text; never claim inspection |

**Spec's meta-commentary stays out of the Gem text.** Parentheticals in the spec like "(Deliberate strengthening of the pack's claim-trust rule, process.md:16…)" are port-engineer rationale — they belong in spec/header rows, never in `INSTRUCTIONS.md` or knowledge bodies.

---

### Task 1: `gems/alvar-tutor/INSTRUCTIONS.md` — the Gem's operating manual

**Goal:** Write the Gem instruction text: complete, self-sufficient, ≤ ~4000 characters.

**Files:**
- Create: `gems/alvar-tutor/INSTRUCTIONS.md`

**Acceptance Criteria:**
- [ ] `wc -m gems/alvar-tutor/INSTRUCTIONS.md` ≤ 4000
- [ ] All ten contract sections present (persona; Turn 0 as multi-exchange phase; hard rules; quiz protocol; probe protocol incl. scoring rubric; teach protocol; visuals rule; verify rule; session end; scope guard)
- [ ] Quiz protocol has: one question per message, A/B/C + "D. I don't know", position rotation, never reveal before reply, D → `blocked`
- [ ] Probe section carries the five-row rubric semantics (may be prose) + "no teaching during a probe" + the evidenced-solid-ground test + talk-through rule
- [ ] Verify section carries the four-word verdict vocabulary and the search-failure branch ("mark uncertain, never teach as fact")
- [ ] Degradation rules folded into host sections (prose/invalid-token → quiz section; huge-brief → probe section; second-learner + off-topic → scope guard; plan restatement → session end)
- [ ] No spec meta-commentary, no file writes, no tool references

**Verify:**
```bash
wc -m gems/alvar-tutor/INSTRUCTIONS.md          # ≤ 4000
grep -c 'I don.t know' gems/alvar-tutor/INSTRUCTIONS.md   # ≥ 1
grep -ci 'confirmed.*qualified\|qualified.*contradicted' gems/alvar-tutor/INSTRUCTIONS.md  # ≥ 1
grep -c 'known. edge. unknown. blocked\|`known`\|edge`' gems/alvar-tutor/INSTRUCTIONS.md   # ≥ 1 (status vocabulary present)
! grep -nE '\.alvar/|quiz-ui|harness|tool result|process\.md' gems/alvar-tutor/INSTRUCTIONS.md  # no runtime refs
```

**Steps:**

- [ ] **Step 1: Draft the file from this complete draft** (edit for flow only — do not drop any rule; re-verify `wc -m` after editing):

```markdown
You are one teacher for one mind. Not a course. Not a survey.

## Turn 0 — the opening phase (each step is its own exchange)

1. Restate the goal in one sentence. Confirm.
2. Profile: ask 3–5 questions in total about how this mind wants to be taught —
   solid ground, goal, pace, struggle, voice, visuals. Conversational, not a form.
3. Probe (below).
4. Show the plan as a mermaid code block BEFORE teaching. Ask if they want
   changes. Freeze until a quiz failure forces a new node, or they ask to replan.
5. Teach node 1.

## Hard rules

- Struggle stays in the material; you absorb logistics.
- Never reteach what they know; never start in `unknown` with no ramp.
- One reasoning step per message. Stop. Quiz it. Advance only on lock-in.
- Never dump the whole explanation in one message.
- No invented citations. Verify or mark uncertainty.

## Quiz protocol (chat letters)

- Exactly ONE question per message. Options A, B, C, plus D. I don't know.
- They reply with one letter; typed reasoning is scoring signal.
- Rotate the correct answer's position across A/B/C. Never mark or hint at it.
- Never reveal the answer before their reply. No second question in the same message.
- Reply in prose or an invalid token: score what you can, ask for a letter.
  Restate the protocol once; never nag.
- Score with the probe rubric → next node / retry / insert a prerequisite.
  D marks the strand `blocked` — never guess, never shame; it is map data.

## Probe protocol

- Start broad; binary-search every strand the lesson needs. Up to 3 probe
  questions in a row, one message each.
- Do not teach during a probe, except a one-line correction after they answer.
- Skip a strand only if their material shows work on it — a derivation, a
  correct usage, a solved problem — and you can name it in one sentence.
  A bare claim, or a pasted brief, is probe data, not skip data.
- Invite talk-through: a right letter with a wrong reason is `edge`, not `known`.
- Score: correct + sound reason → `known`; correct, thin reason → `edge`;
  wrong, near-miss → `edge`; wrong, foundation missing → `unknown`;
  I don't know → `blocked`.
- After probing, print the map once: | strand | status | evidence |.
  Reprint the current table on request and whenever any status changes
  or a strand is added.

## Teach protocol

- One node per message.
- Interruptions: answer, then resume the same node — unless the question
  reveals a missing prerequisite; insert it first.
- Facts to accept at face value come only after the step they rest on is locked.

## Visuals

Offer an SVG code block only when a picture would lock the idea; the learner
renders it themselves — you have not seen the render, never claim to. Before
offering, audit the SVG source as text against your prose: arrow directions,
one symbol per object, no cropped text. Sparingly.

## Verify

For empirical, historical, bibliographic, or API claims — or before any
unearned certainty: state the claim in one falsifiable sentence, ground it
with Google Search, report an inline verdict — confirmed / qualified /
contradicted / unknown. Cite only sources the search surfaced. If search
fails or is inconclusive: mark it uncertain and proceed; never teach it as
fact. What you derive in-session may be taught, labeled derived, not sourced.

## Session end

Summarize what locked, what is still `edge`, and the next node. A new chat
means a fresh probe. On request, restate the current mermaid plan.

## Scope

If greeted or asked what you do: explain in 2–3 sentences with one short
example. One chat, one learner — a second learner starts a fresh chat.
Redirect non-learning requests back, gently.
```

- [ ] **Step 2: Run the Verify block** — all receipts pass (`wc -m` first; if over 4000, cut visuals detail → session-end wording, never a rule).
- [ ] **Step 3: Commit** — `hug a gems/alvar-tutor/INSTRUCTIONS.md && hug c` with message `feat(gem): INSTRUCTIONS.md — self-sufficient operating manual (<=4k chars)` **plus a trailer line `source-pin: <sha>`, where `<sha>` is the short HEAD SHA from `hug sl` at this moment**. This one SHA is the source baseline every knowledge-file header (Tasks 2–5) reuses verbatim — it is the reproducible "commit being ported from" for the whole port, and Task 8 validates all five pins against it.

---

### Task 2: `knowledge/philosophy.md` — verbatim port

**Goal:** Philosophy ports byte-identical under its header (the source has zero runtime references).

**Files:**
- Create: `gems/alvar-tutor/knowledge/philosophy.md`
- Source (read-only): `skills/alvar-learn/references/philosophy.md`

**Acceptance Criteria:**
- [ ] Header present, adaptation list = `- ports verbatim (no runtime references in source)`
- [ ] Body byte-identical to the source

**Verify:**
```bash
diff <(sed -n '/-->/,$p' gems/alvar-tutor/knowledge/philosophy.md | tail -n +2 | sed '/^$/d') \
     <(sed '/^$/d' skills/alvar-learn/references/philosophy.md)   # no output
```

**Steps:**
- [ ] **Step 1:** Write the file: header block (conventions above) with source path `skills/alvar-learn/references/philosophy.md`, the **source-baseline SHA recorded in Task 1's `source-pin:` trailer** (do NOT take a fresh `hug sl`), adaptation row `- ports verbatim (no runtime references in source)`, then a blank line, then the source file's content copied exactly.
- [ ] **Step 2:** Run the Verify diff — empty.
- [ ] **Step 3:** Commit — `feat(gem): knowledge/philosophy.md — verbatim port + source pin`.

---

### Task 3: `knowledge/process.md` — the 8-row adaptation

**Goal:** Port the method's process with every runtime-impossible clause adapted.

**Files:**
- Create: `gems/alvar-tutor/knowledge/process.md`
- Source: `skills/alvar-learn/references/process.md`

**Acceptance Criteria:**
- [ ] Header carries all 8 adaptation rows (below)
- [ ] Body-scan clean of every forbidden pattern (below)

**Verify:**
```bash
sed -n '/-->/,$p' gems/alvar-tutor/knowledge/process.md | tail -n +2 | \
  grep -nE 'Never dump A/B/C/D|Wait for the tool|quiz-ui\.md|\.alvar/|look at it|file logging'
# expected: no output
```

**Adaptation rows** (apply exactly; anything unlisted ports byte-identical):

1. Phase 1 quiz bullet → "Use graded multiple-choice (include 'I don't know') through the chat letter protocol (see instructions). One question per message." (deletes "Never dump A/B/C/D in chat")
2. Phase 1 "Ask 1–3 questions at a time. Wait for the tool." → "Ask up to 3 probe questions in a row, one message each, pausing for each reply."
3. `quiz-ui.md` pointer → deleted.
4. `.alvar/maps/<topic>.md` writes → "print the map once in chat" (+ "reprint on request or on any change").
5. `.alvar/sessions/…` writes → "the chat transcript is the session log".
6. Phase 3 "`learn-visual` (or write an SVG and look at it)" → "the visuals rule (see instructions): offer the code block, audit as text, never claim to look".
7. "What the system absorbs": "file logging" → "transcript logging".
8. `learn-verify` reference → "the verify rule (see instructions), when the domain is empirical, historical, or you are unsure" (trigger conditions carried through).

**Steps:**
- [ ] **Step 1:** Write header with the **Task 1 `source-pin:` SHA** (never a fresh `hug sl`) and the 8 rows; port the body applying each row to its clause.
- [ ] **Step 2:** Run the Verify body-scan — no output.
- [ ] **Step 3:** Commit — `feat(gem): knowledge/process.md — process ported under the 8-row adaptation`.

---

### Task 4: `knowledge/learner-profile.md` — merged + adapted port

**Goal:** The profiling interview, executable in a chat-only runtime.

**Files:**
- Create: `gems/alvar-tutor/knowledge/learner-profile.md`
- Sources: `skills/learn-profile/SKILL.md` + `skills/learn-profile/assets/LEARNER.md` (the **assets** copy is authoritative; `templates/LEARNER.md` differs and is NOT used)

**Acceptance Criteria:**
- [ ] All 8 adaptation rows applied (below)
- [ ] Body-scan clean (below)

**Verify:**
```bash
sed -n '/-->/,$p' gems/alvar-tutor/knowledge/learner-profile.md | tail -n +2 | \
  grep -nE 'harness quiz UI|quiz-ui\.md|\.alvar/|The file is the teacher|Show the file|will read it every session|Obsidian / markdown / no files|Write maps and sessions'
# expected: no output
grep -c '3–5 questions' gems/alvar-tutor/knowledge/learner-profile.md   # ≥ 1 (cadence points to instructions)
```

**Adaptation rows:**

1. "The file is the teacher" → "This profile is the teacher" (lives in this chat's history).
2. "2–3 questions per turn, through the harness quiz UI … not as a markdown list" → "Ask 3–5 questions in total, conversationally, woven into the opening exchanges — the instructions' Turn 0 governs the shape" (clusters are coverage hints, not a tour).
3. "Create `.alvar/LEARNER.md` from assets/LEARNER.md" → "hold the profile in this chat's history".
4. "If a file already exists, show a diff of proposed edits and wait" → deleted.
5. "Show the file. Tell them `alvar-learn` will read it every session." → "Restate the profile in one line. Tell them it lives only in this chat; a new chat starts fresh."
6. Cluster 6 "Artifacts — Obsidian / markdown / no files" → "Artifacts — how do you want visuals offered: SVG code blocks, or none?"
7. Template: "Write maps and sessions under `.alvar/`" → "Maps and plans live in this chat"; "I read session markdown in: editor / Obsidian / other" → deleted; keep "Visuals: SVG when a picture would lock the idea".
8. Keep unchanged: clusters 1–5 (solid ground, goal, pace, struggle, voice), "Use their words where you can", "Do not invent hobbies or a persona".

**Structure:** title (`# Learn profile`), adapted SKILL body (interview clusters, write→hold, after), then the adapted template as a fenced markdown block inside the body.

**Steps:**
- [ ] **Step 1:** Write header + ported body per the rows.
- [ ] **Step 2:** Run both Verify receipts.
- [ ] **Step 3:** Commit — `feat(gem): knowledge/learner-profile.md — interview ported to chat runtime`.

---

### Task 5: `knowledge/verify.md` + `knowledge/visual.md` — the two satellite ports

**Goal:** learn-verify and learn-visual port in full (method + design rules + failure list survive).

**Files:**
- Create: `gems/alvar-tutor/knowledge/verify.md`, `gems/alvar-tutor/knowledge/visual.md`
- Sources: `skills/learn-verify/SKILL.md`, `skills/learn-visual/SKILL.md`

**Acceptance Criteria:**
- [ ] verify.md keeps: when-to-run triggers, derived-not-sourced disclosure, one-falsifiable-sentence method, verdict block with `confirmed / qualified / contradicted / unknown` + meanings, no-invented-citations rules
- [ ] visual.md keeps: design rules (one claim, large labels, objects-not-equations, no decorations) and the five-item failure list, and "tell the learner what to look at first"
- [ ] Body-scans clean (below)

**Verify:**
```bash
sed -n '/-->/,$p' gems/alvar-tutor/knowledge/verify.md | tail -n +2 | grep -nE 'did not open|session file'      # no output
sed -n '/-->/,$p' gems/alvar-tutor/knowledge/visual.md | tail -n +2 | grep -nE '\.alvar/|session file|harness'  # no output
grep -c 'qualified' gems/alvar-tutor/knowledge/verify.md        # ≥ 2 (vocabulary + meaning)
grep -c 'arrow' gems/alvar-tutor/knowledge/visual.md            # ≥ 2 (design + failure list)
```

**verify.md adaptation rows:**
1. "Do not cite a URL you did not open" → "cite only sources the search actually surfaced".
2. "Write the verdict into the session file if an alvar-learn session is open" → deleted (verdict reported inline in chat).
3. Everything else ports unchanged (drop only the YAML frontmatter and the `/learn-verify` invocation phrases from the description — this is a knowledge file, not an invocable skill).

**visual.md adaptation rows:**
1. Output section, both sentences ("Write `.alvar/visuals/<slug>-<n>.svg` (create the folder). Embed or link it in the session file.") → "Offer the SVG as a code block in chat."
2. "Prefer SVG. Use another format only if the harness cannot preview SVG." → "Prefer SVG (the learner renders it themselves)."
3. Loop steps 3–5 (look at the file, fix, look again) → inverted default: "You cannot view the render, ever. Keep every SVG simple enough to audit as text; before offering, re-read the SVG source against the prose and check the failure list below."
4. Everything else ports unchanged (frontmatter dropped as above).

**Steps:**
- [ ] **Step 1:** Write both files (headers carrying the **Task 1 `source-pin:` SHA** + rows; bodies per rows).
- [ ] **Step 2:** Run all four Verify receipts.
- [ ] **Step 3:** Commit — `feat(gem): knowledge/verify.md + visual.md — satellite protocols ported`.

---

### Task 6: `gems/alvar-tutor/README.md` — install steps + smoke checklist

**Goal:** A stranger creates the Gem from the repo and regression-tests it.

**Files:**
- Create: `gems/alvar-tutor/README.md`

**Acceptance Criteria:**
- [ ] Create-the-Gem steps (gemini.google.com → Explore Gems → New Gem → name "Alvar Tutor" → paste INSTRUCTIONS.md → upload the 5 knowledge files → Save) with the `wc -m` ≤ 4000 pre-paste gate
- [ ] All 16 smoke items from spec §README (gems/alvar-tutor/) — Turn-0 profiling, one-question quiz, rotation, mermaid-before-teaching, one-step, map print/reprint (any change/insertion), mid-step resume, wrong-answer branch, SVG sparingly, verdict vocabulary, session-end summary, D-answer, prose degradation, huge-brief degradation, off-topic degradation, truncation canary (+ precondition + blind spot)
- [ ] Credit line: method is Eero Alvar's (link the video); this repo implements

**Verify:**
```bash
grep -c '\- \[ \]' gems/alvar-tutor/README.md   # ≥ 16 (the spec's checklist holds 16 items — an earlier "17" was a plan-time miscount)
grep -c 'Alvar Tutor' gems/alvar-tutor/README.md  # ≥ 1
grep -ci 'eero alvar' gems/alvar-tutor/README.md # ≥ 1
```

**Steps:**
- [ ] **Step 1:** Write the README: 3 numbered sections (Create the Gem / Use / Smoke-test checklist) transcribing the checklist items from spec §"README.md (gems/alvar-tutor/)" verbatim.
- [ ] **Step 2:** Run the Verify receipts.
- [ ] **Step 3:** Commit — `feat(gem): gems/alvar-tutor/README.md — install + 16-item smoke checklist`.

---

### Task 7: Repo perimeter — root `README.md` + `CONTRIBUTING.md`

**Goal:** No shipped surface contradicts another; contributors aren't steered to damage the Gem.

**Files:**
- Modify: `README.md` (root)
- Modify: `CONTRIBUTING.md`

**Acceptance Criteria:**
- [ ] Root README gains a "Gemini web (Gem)" section pointing to `gems/alvar-tutor/`
- [ ] README:29-area promise qualified: the "quiz picker (not A/B/C/D in chat)" line gains "(CLI harnesses — in the Gemini Gem, letters are the sanctioned protocol)"
- [ ] README picker-table section (~:128) + fix-it hint (~:137) qualified the same way
- [ ] CONTRIBUTING ground rule 2 scoped to runtimes with a native question tool, naming the Gem's letter protocol as the sanctioned exception
- [ ] CONTRIBUTING Usually-skip entries ("Markdown A/B/C/D quizzes as a fallback" AND "A sixth copy of the philosophy in a new file") scoped to non-`gems/` copies
- [ ] CONTRIBUTING ground rule 1 ("One home per fact") scoped: ports under `gems/` carry source pin + adaptation header
- [ ] CONTRIBUTING gains the port line ("`skills/` is the source of truth; edit there, then port to `gems/alvar-tutor/knowledge/`") and the repo map gains a `gems/` line

**Verify:**
```bash
grep -c 'Gemini web (Gem)' README.md                       # ≥ 1
grep -c 'sanctioned' README.md CONTRIBUTING.md             # ≥ 1 each file
grep -c 'gems/' CONTRIBUTING.md                            # ≥ 3 (port line + map + scoping)
```

**Steps:**
- [ ] **Step 1:** Edit root README — insert the Gemini section after the Skills table; add the two qualifier clauses at the named lines.
- [ ] **Step 2:** Edit CONTRIBUTING — the six changes above, minimal clauses, no rewrites of untouched text.
- [ ] **Step 3:** Run the Verify receipts.
- [ ] **Step 4:** Commit — `docs: scope README/CONTRIBUTING claims around the Gemini Gem surface`.

---

### Task 8: Cross-check sweep — the spec's own audit, executed

**Goal:** Run the cross-check the round-2 roast proved was skipped on paper: matrix vs shipped files, budget gate, cadence diff.

**Files:**
- Read-only: everything shipped in Tasks 1–7 + the spec.

**Acceptance Criteria:**
- [ ] Every knowledge file's body-scans from Tasks 2–5 still clean (re-run all five)
- [ ] `wc -m INSTRUCTIONS.md` still ≤ 4000
- [ ] No cadence/number appears in both INSTRUCTIONS.md and a knowledge file with conflicting values (`grep -n 'questions'` across all six files; every hit must agree or point)
- [ ] The header pins in all 5 knowledge files name the same SHA — exactly the `source-pin:` value recorded in Task 1's commit message
- [ ] Spec §knowledge adaptation rows ↔ shipped headers: row-for-row identical

**Verify:**
```bash
for f in gems/alvar-tutor/knowledge/*.md; do echo "== $f"; sed -n '/-->/,$p' "$f" | tail -n +2 | grep -cE '\.alvar/|quiz-ui|harness quiz UI|session file|Wait for the tool|Never dump'; done
# every count must be 0
wc -m gems/alvar-tutor/INSTRUCTIONS.md
grep -rn 'questions' gems/alvar-tutor/ | grep -v README
grep -c '@ ' gems/alvar-tutor/knowledge/*.md
```

**Steps:**
- [ ] **Step 1:** Run the Verify block; fix any hit at its source file and amend nothing — a new commit `fix(gem): cross-check sweep residuals` only if something fired.
- [ ] **Step 2:** Record the sweep result in the commit body (all-zero receipts) — or an empty `chore(gem): cross-check sweep clean` commit carrying the receipts as proof.

---

## Dependencies

Task 1 independent. Tasks 2–5 independent of each other (each its own source). Task 6 blocked by 1–5 (references all files). Task 7 independent. Task 8 blocked by 1–7.
