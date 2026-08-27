# Port provenance — learner-profile.md

**Maintainer-facing only — NEVER uploaded to the Gem.** The upload set is exactly the five sibling `.md` files; this sidecar exists outside the RAG-visible surface so provenance costs zero model tokens.

Source of truth: skills/learn-profile/SKILL.md @ 848c91c (template: skills/learn-profile/assets/LEARNER.md @ 848c91c)
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
Gem: alvar-tutor (Gemini web)
