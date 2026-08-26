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
| Knowledge files | max **10** | 5 files used, 5 spare; no pressure |
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
   runtime profiling and verification. The satellites fold in without loss:
   `probe`'s protocol into the instructions; `learn-profile` into the Turn 0
   interview + `knowledge/learner-profile.md`; `learn-verify` into the verify
   rule + `knowledge/verify.md`; `learn-visual` into the visuals rule +
   `knowledge/visual.md`.
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
    philosophy.md          # verbatim port of skills/alvar-learn/references/philosophy.md
    process.md             # adapted port of skills/alvar-learn/references/process.md
    learner-profile.md     # from skills/learn-profile/SKILL.md + assets/LEARNER.md
    verify.md              # adapted port of skills/learn-verify/SKILL.md
    visual.md              # adapted port of skills/learn-visual/SKILL.md
  README.md                # Gem creation steps + smoke-test checklist
```

Plus (all in the same PR as the Gem, so no shipped surface contradicts another):
- One new section in the repo root `README.md` ("Gemini web (Gem)") pointing to
  `gems/alvar-tutor/`.
- Qualify the README's picker claims as CLI-harness-scoped — one clause each at
  the "quiz picker (not A/B/C/D in chat)" promise and the "Quizzes must use the
  native picker" table (with its fix-it hint "If the agent pastes A/B/C/D, say
  'use the quiz tool'"): in the Gemini Gem, letters **are** the sanctioned
  protocol. Applied verbatim in a Gem chat, the unqualified hint wrongly
  instructs the user to complain about correct behavior.
- `CONTRIBUTING.md`: scope ground rule 2 ("Native quiz UI only … Never paste
  A/B/C/D in chat") and the Usually-skip entry ("Markdown A/B/C/D quizzes as a
  fallback") to skill runtimes that have a native question tool, naming the
  Gem's letter protocol as the sanctioned exception; scope the **sibling**
  Usually-skip entry ("A sixth copy of the philosophy in a new file") and
  ground rule 1 ("One home per fact … don't restate them") to copies outside
  `gems/` — ports under `gems/` carry the source pin and adaptation header,
  making them sanctioned ports, not sixth copies (a contributor applying the
  unscoped list would file a deletion PR against the Gem's knowledge files);
  add the `skills/`-is-source-of-truth port line; add `gems/` to the repo map.

### Single-source rule

Each mechanic is stated **once**, at its most specific site, and every other
mention is a pointer: quiz letters → the quiz protocol (§4); profiling shape →
Turn 0 step 2; solid ground → the probe protocol; verify → the verify rule.
Decisions above say "see" / "spec below", never restate. Parallel restatements
drift, and one already did during drafting — this rule is the fix.

### Division of labor: instructions vs knowledge files

Because knowledge files are retrieval-indexed (not guaranteed every turn):

- **INSTRUCTIONS.md** carries the *complete* operating manual. If every knowledge
  file failed to load, the Gem must still run the whole loop correctly.
- **knowledge/** files are depth reinforcement — the philosophy nuance, the full
  phase descriptions, the profile interview guide. They enrich; they never gate.

## INSTRUCTIONS.md — behavioral contract

Structure (target ~550–650 words, **≤ ~4k characters — measure the char
count before pasting**; the pessimistic report caps the box at ~4k, and
600 words ≈ 4.2k chars already breaches it). If over budget, cut in this
order: visuals rule → session-end summary → scope guard — the scope guard
**last**, because it is the truncation canary: deleting it first destroys
the only detector of the silent-truncation failure mode. If it must go,
re-key the canary checklist item to the new final section. **Never cut
the quiz, probe (including the scoring rubric), teach, or verify
protocols** — they are the method.

1. **Persona** — "You are one teacher for one mind. Not a course. Not a survey."
   Ported from `alvar-learn/SKILL.md`.
2. **Turn 0 (the opening phase — spans the first several exchanges; each
   numbered step is its own exchange, and nothing here happens in one
   message)** —
   1. Restate the goal in one sentence; confirm.
   2. Profile: 3–5 questions in total about how this mind wants to be taught
      (covering the profile clusters — solid ground, goal, pace, struggle,
      voice, visuals), asked conversationally — not a form. This step owns
      the cadence; `knowledge/learner-profile.md` points here.
   3. Probe (spec below).
   4. Plan: mermaid DAG shown **before** teaching; ask if they want changes;
      freeze until a quiz failure forces a new node (or the learner asks to
      replan).
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
   - On reply: score against the probe rubric (§5) → next node / retry /
     insert-prerequisite. "D" marks the strand `blocked` — do not guess, do
     not shame; it's map data. (Delta, advertised: the pack's scoring row
     allows `blocked` **or** `unknown` for D; the Gem hard-maps to `blocked`
     so D is always visible map data — and the pack's other blocked trigger,
     "the question needs a tool you don't have," never applies in a runtime
     with no tools.)
   - Applied questions over recap prompts; if they answer from vibe, ask one tighter
     question before advancing.
5. **Probe protocol** — start broad, binary-search every strand the lesson depends
   on, up to 3 probe questions in a row (one per message). Do not teach during
   a probe except a one-line correction after they answer. Skip a strand only
   when the learner **evidenced** solid ground on it — a bare claim is probe
   data, not skip data. (Deliberate strengthening of the pack's claim-trust
   rule, process.md:16: claims are cheap in chat and this runtime has no
   history to corroborate them. The same standard governs the huge-brief
   degradation path below — one rule, stated once, applied everywhere.)
   Invite a talk-through: a right letter with a wrong reason is `edge`, not
   `known`. Score every answer against the pack's rubric (ported verbatim
   from `skills/probe/SKILL.md` — this table IS what `edge` means; without
   it the map is improvised):

   | result | status move |
   |---|---|
   | correct + sound reason | `known` |
   | correct, thin reason | `edge` |
   | wrong, near-miss | `edge` |
   | wrong, foundation missing | `unknown` |
   | I don't know (D) | `blocked` |

   After probing, print the map **once** as a markdown table
   `| strand | status | evidence |` with statuses `known / edge / unknown /
   blocked`; reference it without reprinting — but reprint the current table
   on request and whenever **any** strand's status changes or a strand is
   added (a lock-in failure can flip `edge`→`unknown`; an inserted
   prerequisite adds a row), so the printed record never silently misstates
   where the learner stands.
6. **Teach protocol** — one node per turn; accept interruptions (answer, then
   resume the same node unless the question reveals a missing prerequisite — then
   insert it); give "accept at face value" facts only after the step they rest on
   is locked.
7. **Visuals rule** — may offer an SVG code block when a picture would lock the
   idea; the learner renders it themselves; never claim to have inspected the
   render. Before offering, audit the SVG source **as text** against the prose —
   arrow directions, one symbol per object, no cropped text (full design +
   failure rules in `knowledge/visual.md`). Sparingly.
8. **Verify rule** — when a claim is empirical, historical, bibliographic, or
   API-shaped — or you would otherwise present unearned certainty — state the
   claim in one falsifiable sentence, ground it with Google Search, and report
   an inline verdict in the pack's vocabulary: **confirmed / qualified /
   contradicted / unknown**. Cite only sources the search actually surfaced.
   If search fails or is inconclusive: mark the claim uncertain and proceed —
   never teach it as fact. What you can derive in-session may be taught, said
   to be **derived, not sourced**. (Full method: `knowledge/verify.md`.)
9. **Session end** — summarize what locked, what is still `edge`, and the next
   node. Note that a new chat means a fresh probe (chat history is the only
   memory).
10. **Scope guard** — if greeted or asked what it does: a 2–3 sentence explanation
    with a short example. Refuse nothing in the learning domain; gently redirect
    non-learning requests back.

### Repudiation: the pack's harness-era quiz rules do not carry over

`quiz-ui.md`'s "Never dump A/B/C/D in chat" and `process.md`'s "Wait for the
tool" exist because CLI harnesses **have** a native question tool — pasting
letters there degrades a better available mechanism. Gemini web chat has no
such tool; the chat letter protocol (decision 3) is not a tolerated fallback
but the sanctioned substitute, chosen at design time. Every port must
therefore **delete** those clauses, not preserve them: knowledge files are
RAG-surfaced mid-session, so a knowledge file that forbids letters while the
instructions mandate them makes the core interaction a per-retrieval coin
flip. If Gemini ever ships a native question tool, revisit decision 3 and
re-port.

## knowledge/ files

Each file starts with a header block (HTML comment, invisible in rendered
preview). The header carries its **own** source path (not a shared example),
the source commit pin **filled at port time** with the actual SHA being
ported from — never left as a placeholder — and the per-file adaptation
list, so the re-port ritual is mechanical instead of re-derived:

```
<!-- Source of truth: <this file's source path> @ <source commit SHA>
     Ported: 2026-08-26. Do not edit here — edit the source, then re-apply
     the adaptation list below.
     Adaptations:
     - <one line per clause-level change>
     Gem: alvar-tutor (Gemini web) -->
```

The adaptation lists below are the durable contract. They are exhaustive and
clause-level: executing them verbatim must never leave a runtime-impossible
instruction in a knowledge file. Anything not listed ports byte-identical —
and each list was produced by reading the source file line-by-line against
the runtime, so every entry corresponds to a real clause (a no-op entry is a
tell that the audit was not performed).

Before committing any port, run the cross-check the lists are built for:
re-read each ported file line-by-line against its source, **and** diff every
cadence/number that appears in both the instructions and a knowledge file —
they must match or point (the single-source rule). Round 2's cadence
conflict (3–5 questions in the instructions vs 2–3-per-turn in a knowledge
file) shipped because this cross-check existed on paper and was never
executed.

### Shared substitution table

Every runtime difference between the skill pack and a chat-only harness
reduces to three substitutions. The per-file lists apply them clause-by-
clause; this table is the class-level contract. Porting to a new harness
means rewriting these three rows — the per-file deltas then mostly write
themselves, and a clause the lists miss is still caught by its class:

| Runtime fact | Substitution |
|---|---|
| No filesystem — no `.alvar/`, no maps/sessions/visuals as files | file writes → say it in chat; the transcript is the log |
| No native question tool | tool calls → chat letter protocol (instructions §4) |
| No render inspection — the Gem can't see what it emits | "look at it" → audit the source as text; never claim inspection |

- **philosophy.md** — ports **verbatim**. The 36-line source contains zero
  runtime references (no harness, tool, `.alvar/`, or skill mentions; its
  only external reference is the youtu.be citation). Adaptation list: empty.
- **process.md** — port of `references/process.md` with these clause-level
  adaptations:
  - Phase 1 quiz bullet — replace the whole clause with: "Use graded
    multiple-choice (include 'I don't know') through the chat letter
    protocol (see instructions). One question per message." This deletes the
    source's "Never dump A/B/C/D in chat" (see the repudiation above).
  - Phase 1 "Ask 1–3 questions at a time. Wait for the tool." → "Ask up to
    3 probe questions in a row, one message each, pausing for each reply."
    (No tool exists to wait for.)
  - `quiz-ui.md` pointer → deleted (no such file in the Gem).
  - `.alvar/maps/<topic>.md` writes → "print the map once in chat" (the
    probe protocol in the instructions carries the reprint rule).
  - `.alvar/sessions/…` writes → "the chat transcript is the session log".
  - Phase 3 "`learn-visual` (or write an SVG and look at it)" → the visuals
    rule (see instructions) — the parenthetical's look-at-it is the
    no-render-inspection substitution: offer the code block, audit as text,
    never claim to look.
  - "What the system absorbs" list: "file logging" → "transcript logging"
    (no filesystem).
  - `learn-verify` reference → the verify rule (see instructions), carrying
    the source's trigger conditions through the substitution: "when the
    domain is empirical, historical, or you are unsure". The unconditional
    form would flatten the trigger and silently verify nothing or everything.
- **learner-profile.md** — merged from `skills/learn-profile/SKILL.md` +
  `skills/learn-profile/assets/LEARNER.md` (the **assets** copy is
  authoritative for porting; `templates/LEARNER.md` is the human-facing
  variant and differs at line 3). Adaptations:
  - Opening thesis "The file is the teacher" → "This profile is the teacher"
    (it lives in this chat's history, not a file).
  - "2–3 questions per turn, through the harness quiz UI in
    ../alvar-learn/references/quiz-ui.md — not as a markdown list" → "Ask
    3–5 questions in total, conversationally, woven into the opening
    exchanges — the instructions' Turn 0 step 2 governs the shape" (the
    instructions own the cadence per the single-source rule; the six
    clusters are coverage hints for those 3–5 questions, not a mandatory
    tour).
  - "Create `.alvar/LEARNER.md` from assets/LEARNER.md" → "hold the profile
    in this chat's history".
  - "If a file already exists, show a diff of proposed edits and wait" →
    deleted (no filesystem).
  - "Show the file. Tell them `alvar-learn` will read it every session." →
    "Restate the profile in one line. Tell them it lives only in this chat;
    a new chat starts fresh." (Sentence 1 displays a file that cannot
    exist; sentence 2 promises a persistence the Gem cannot deliver.)
  - Interview cluster 6 "Artifacts — Obsidian / markdown / no files" →
    "Artifacts — how do you want visuals offered: SVG code blocks, or
    none?" (the original's three destinations all require a filesystem).
  - In the merged assets template: "Write maps and sessions under
    `.alvar/`" → "Maps and plans live in this chat"; "I read session
    markdown in: editor / Obsidian / other" → deleted (no session
    markdown); keep "Visuals: SVG when a picture would lock the idea".
  - Keep unchanged: interview clusters 1–5 (solid ground, goal, pace,
    struggle, voice), "Use their words where you can", "Do not invent
    hobbies or a persona".
- **verify.md** — port of `skills/learn-verify/SKILL.md` with these clause-level
  adaptations:
  - "Do not cite a URL you did not open" → "cite only sources the search
    actually surfaced" (grounding replaces fetching; the Gem opens nothing).
  - "Write the verdict into the session file if an alvar-learn session is
    open" → deleted (no session file; the verdict is reported inline in chat).
  - Keep unchanged: the when-to-run triggers; the skip-when-derivable rule
    **with** its derived-not-sourced disclosure; the method (one falsifiable
    sentence, quote or paraphrase the supporting line, note edition/year,
    mark disagreements, prefer the source the field actually uses); the
    verdict vocabulary `confirmed / qualified / contradicted / unknown` with
    its meanings; and the rules (no invented papers, quotes, or page numbers;
    one claim per run).
- **visual.md** — port of `skills/learn-visual/SKILL.md` with these clause-level
  adaptations:
  - Output section, **both** sentences: "Write `.alvar/visuals/<slug>-<n>.svg`
    (create the folder). Embed or link it in the session file." → "Offer the
    SVG as a code block in chat." (no filesystem — the second sentence's
    session-file write is the same substitution).
  - "Prefer SVG. Use another format only if the harness cannot preview SVG."
    → "Prefer SVG (the learner renders it themselves)." (no harness exists
    to evaluate the conditional — dead code that reads as live logic).
  - Loop steps 3–5 (look at the file, fix, look again) → inverted default:
    "You cannot view the render, ever. Keep every SVG simple enough to audit
    as text; before offering, re-read the SVG source against the prose and
    check the failure list below." (A text-audit pass replaces the look pass —
    the design rules and failure list are what made pictures safe without
    eyes; an unaudited SVG with a wrong arrow is worse than no SVG.)
  - Keep unchanged: the design rules (one claim, no collage; large labels,
    high contrast; show the objects, not a screenshot of the equation; no
    decorative gradients, watermarks, or "AI art" backgrounds); the
    failures-to-catch list (arrow direction disagrees with the prose; two
    symbols for the same object; 3D that hides the relation; cropped text; a
    picture of a different special case than the one taught); and "tell the
    learner what to look at first".

## README.md (gems/alvar-tutor/)

1. **Create the Gem**: gemini.google.com → Explore Gems → New Gem → name
   **"Alvar Tutor"** → paste `INSTRUCTIONS.md` → upload the 5 `knowledge/` files →
   Save. (Free tier works; note that Gem quality improves on Advanced.)
2. **Use**: open a fresh chat with the Gem, state a learning goal.
3. **Smoke-test checklist** (the regression test — manual by nature):
   - [ ] **Turn-0 profiling**: fresh chat → 3–5 profile questions (covering
         the clusters: solid ground, goal, pace, struggle, voice, visuals)
         before the probe, and later teaching visibly honors them
         (voice/density/struggle)
   - [ ] First quiz arrives as ONE question, options A/B/C + "D. I don't know"
   - [ ] Correct answer not always first / not marked
   - [ ] Mermaid plan (code block) shown BEFORE any teaching
   - [ ] One reasoning step per message; no textbook dump
   - [ ] Strand map printed as a table after probing; reprinted on request
         and after ANY status change or strand insertion (test with a wrong
         answer → retry/insert, then check the table)
   - [ ] Mid-step question answered, then same node resumed
   - [ ] Wrong quiz answer → retry or inserted prerequisite, not advance
   - [ ] SVG offered at most occasionally, never claimed as self-inspected
   - [ ] Unsourced empirical claim → verdict reported inline in the
         confirmed / qualified / contradicted / unknown vocabulary, citing only
         surfaced sources; never taught as fact when unverified
   - [ ] Session end summary: locked / edge / next node
   - [ ] **D answer**: answer "D. I don't know" once → strand marked `blocked`,
         no advance, no shame language, prerequisite inserted or strand skipped
   - [ ] **Degradation — prose answer**: answer a quiz in prose instead of a
         letter → scored as signal, letter protocol restated once, no nagging
   - [ ] **Degradation — huge brief**: paste a large background brief → the
         probe still runs before any teaching
   - [ ] **Degradation — off-topic**: ask an off-topic question mid-session →
         redirected to the learning goal, not answered as a task
   - [ ] **Truncation canary**: ask "what can you do?" → the scope guard (the
         LAST instruction section) answers with the 2–3 sentence explanation —
         catches silent instruction-box truncation, which fails like a missing
         feature with no error anywhere. Precondition: valid while the scope
         guard is present; if it was cut for budget, re-key this item to the
         new final section

## Error handling & degradation

- **Knowledge file not retrieved** — instructions are self-sufficient; loop unaffected.
- **Long session, plan out of context** — on request, restate the current
  mermaid plan (the frozen DAG can fall out of the context window; the map
  reprint rule covers strands, not the graph).
- **Learner ignores letters and types prose** — treat as signal, score it, restate
  the letter protocol once, don't nag.
- **Learner replies with an invalid token** (E, an emoji, two letters) — treat as
  prose: score what you can from it, ask them to pick A/B/C/D.
- **Second learner joins mid-chat** — the profile and map belong to the first
  mind; offer a fresh chat rather than blending two learners into one map.
- **Learner pastes a huge brief** — probe still runs first; the brief counts as
  solid ground only for strands it actually evidences (same standard as the
  probe protocol).
- **Off-topic request** — scope guard redirect.

## Non-goals (v1)

- Canvas-rendered DAGs or interactive canvas quizzes (rejected this round; revisit
  if Gemini adds reliable canvas round-trips).
- Cross-chat state (state blocks, downloadable `.alvar/` files) — rejected.
- Personal pre-profiled Gem variant — rejected (shareable only).
- Any installer automation — 5 files + 1 paste is below the threshold.
- A port script generating the knowledge files from sources. The matrix is
  machine-shaped and the roast is right that generation would turn the
  exhaustiveness claim into a diff — but five files and one port don't
  justify a build step. Revisit when a second harness port exists (the
  shared substitution table keeps the ritual mechanical until then).

## Sources consulted

- Tips for creating custom Gems — https://support.google.com/gemini/answer/15235603
- Gems knowledge-file 10-file limit —
  https://exploreaitogether.com/google-gemini-gems-guide/ and
  https://www.reddit.com/r/GeminiAI/comments/1mgtqah/ (corroborating)
- Instruction-length variability (no published cap) —
  https://www.open-claw.sh/blog/claude-skills-vs-chatgpt-gpts-vs-gemini-gems
  vs https://www.reddit.com/r/GeminiAI/comments/1lez7m1/ (conflicting reports →
  design keeps instructions compact regardless)
