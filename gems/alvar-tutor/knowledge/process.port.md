# Port provenance — process.md

**Maintainer-facing only — NEVER uploaded to the Gem.** The upload set is exactly the five sibling `.md` files; this sidecar exists outside the RAG-visible surface so provenance costs zero model tokens.

Source of truth: skills/alvar-learn/references/process.md @ 848c91c
Ported: 2026-08-26. Do not edit here — edit the source, then re-apply
the adaptation list below.
Adaptations:
- phase 1 quiz bullet -> chat letter protocol (see instructions): graded multiple-choice incl. "I don't know", one question per message (also removes the quiz-ui.md pointer, row 3)
- phase 1 "Ask 1–3 questions at a time. Wait for the tool." -> "Ask probe questions in batches of up to 3, one message each, pausing for each reply; update the map between batches and continue batching until every strand is labeled — stop on coverage, not on a count." (restores the source skill's explicit batch/stop loop that an earlier one-line pacing substitution dropped)
- quiz-ui.md pointer -> deleted (it lived inside row 1's replaced bullet)
- phase 1 ".alvar/maps/<topic>.md" write bullet -> print the map once in chat (reprint rule lives in the instructions' probe protocol)
- phase 2 ".alvar/sessions/<date>-<topic>.md" write bullet -> the chat transcript is the session log
- phase 3 "(or write an SVG and look at it)" -> offer the SVG as a code block and audit it as text (see the visuals rule); never claim to look
- "What the system absorbs" item "file logging" -> "transcript logging"
- phase 2 learn-verify reference -> the verify rule (see instructions), triggers carried through: verify when the domain is empirical, historical, or you are unsure
- phase 3 learn-visual reference -> apply the visuals rule (see instructions), keeping the mechanics: offer the SVG as a code block, audit it as text, never claim to look
- phase 3 "Persist what happened in the session file." -> "Log what happened in this chat (the transcript is the session log)."
- opening sentence "Load this after `philosophy.md`." -> deleted (knowledge-file load order is not a runtime concept)
- phase 1 skip bullet "If they already stated solid ground, skip those strands." -> evidence-test mirror of the instructions' probe protocol: skip only on shown work (derivation / correct usage / solved problem); a bare claim stays probe data
- phase 3 "Advance only on lock-in. Fail → stay, or insert a prerequisite node." -> "Advance only on lock-in — three correct credits on three distinct angles (the instructions' rubric)." GEM-ONLY DELTA (2026-08-31 graduation calibration): do not overwrite from source — when re-porting, re-apply this entry verbatim; the source still carries the pack rubric (correct + sound reason → known outright; letter alone → edge, retry locks)
- feedback rules "If they answer from vibe, ask one tighter question before advancing." -> "If they answer from vibe, rotate to a fresh angle before crediting." (same GEM-ONLY DELTA — do not overwrite from source)
Gem: alvar-tutor (Gemini web)
