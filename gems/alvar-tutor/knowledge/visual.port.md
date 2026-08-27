# Port provenance — visual.md

**Maintainer-facing only — NEVER uploaded to the Gem.** The upload set is exactly the five sibling `.md` files; this sidecar exists outside the RAG-visible surface so provenance costs zero model tokens.

Source of truth: skills/learn-visual/SKILL.md @ 848c91c
Ported: 2026-08-26. Do not edit here — edit the source, then re-apply
the adaptation list below.
Adaptations:
- output section (both sentences) "Write `.alvar/visuals/<slug>-<n>.svg` (create the folder). Embed or link it in the session file." -> "Offer the SVG as a code block in chat." (no filesystem)
- "Prefer SVG. Use another format only if the harness cannot preview SVG." -> "Prefer SVG (the learner renders it themselves)."
- loop steps 3–5 (look at the file / fix / look again, stop after a clean pass) -> the text-audit paragraph in place; steps 1–2 kept with their numbering merged so the loop still reads coherently
- failures heading "Failures to catch on the look pass" -> "Failures to catch on the text-audit pass" (look->text-audit substitution class — aligns with the added paragraph's pointer to the failure list)
- YAML frontmatter (name/description/license/metadata incl. trigger phrases) -> deleted (knowledge file, not an invocable skill)
Gem: alvar-tutor (Gemini web)
