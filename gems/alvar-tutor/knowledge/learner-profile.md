<!-- Source of truth: skills/learn-profile/SKILL.md @ 848c91c (template: skills/learn-profile/assets/LEARNER.md @ 848c91c)
     Ported: 2026-08-26. Do not edit here — edit the source, then re-apply
     the adaptation list below.
     Adaptations:
     - opening "Install **how this mind wants to be taught**. The file is the teacher." -> "This profile is the teacher — held in this chat's history, not a file."
     - interview cadence line ("Do not ask all six in one message. 2–3 questions per turn, through the harness quiz UI in ../alvar-learn/references/quiz-ui.md — not as a markdown list.") -> "Ask 3–5 questions in total, conversationally, woven into the opening exchanges — the instructions' Turn 0 step 2 governs the cadence. The six clusters below are coverage hints for those questions, not a mandatory tour." (removes the quiz-ui.md pointer)
     - write step "Create `.alvar/LEARNER.md` from assets/LEARNER.md. Use their words where you can." -> "Hold the profile in this chat's history. Use their words where you can."
     - "If a file already exists, show a diff of proposed edits and wait." -> deleted
     - After section "Show the file. Tell them `alvar-learn` will read it every session." -> "Restate the profile in one line when the interview ends, and tell them it lives only in this chat — a new chat starts fresh." (probe offer kept)
     - cluster 6 "**Artifacts** — Obsidian / markdown / no files" -> "**Artifacts** — how do you want visuals offered: SVG code blocks, or none?"
     - merged template (assets copy, authoritative; fenced block below): line 3 -> "Fill this in during Turn 0 — or answer and I hold it for you."; "- Write maps and sessions under `.alvar/`" -> "- Maps and plans live in this chat"; "- I read session markdown in: editor / Obsidian / other" -> deleted; "- Visuals: SVG when a picture would lock the idea" kept
     - YAML frontmatter (name/description/license/metadata incl. trigger phrases) -> deleted (knowledge file, not an invocable skill)
     Gem: alvar-tutor (Gemini web) -->

# Learn profile

This profile is the teacher — held in this chat's history, not a file. Do not cram style rules into every later prompt.

## Interview (one cluster at a time)

1. **Solid ground** — what they already hold thoroughly (subjects, notations).
2. **Goal** — what "done" looks like for the next stretch.
3. **Pace** — default is one reasoning step, then a quiz. Only change if they insist.
4. **Struggle** — they keep the hard thinking; you keep logistics. Ask what kind of problems they want.
5. **Voice** — density, tone, hated LLM habits, language.
6. **Artifacts** — how do you want visuals offered: SVG code blocks, or none?

Ask 3–5 questions in total, conversationally, woven into the opening exchanges — the instructions' Turn 0 step 2 governs the cadence. The six clusters below are coverage hints for those questions, not a mandatory tour.

## Write

Hold the profile in this chat's history. Use their words where you can. Do not invent hobbies or a persona.

## After

Restate the profile in one line when the interview ends, and tell them it lives only in this chat — a new chat starts fresh. Offer to start a probe on the current goal.

```markdown
# Learner

Fill this in during Turn 0 — or answer and I hold it for you.

## How I learn
- Pace: one reasoning step at a time
- Struggle: keep it in the material; I will do the problems
- Explanations I want: _
- Explanations I do not want: rushed surveys, unearned "now you know"

## Voice
- Density: compact
- Tone: _
- Notation I already use: _

## Solid ground
- Topics I hold thoroughly: _

## Goals
- Current: _

## Artifacts
- Maps and plans live in this chat
- Visuals: SVG when a picture would lock the idea
```
