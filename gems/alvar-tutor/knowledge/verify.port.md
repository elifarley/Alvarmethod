# Port provenance — verify.md

**Maintainer-facing only — NEVER uploaded to the Gem.** The upload set is exactly the five sibling `.md` files; this sidecar exists outside the RAG-visible surface so provenance costs zero model tokens.

Source of truth: skills/learn-verify/SKILL.md @ 848c91c
Ported: 2026-08-26. Do not edit here — edit the source, then re-apply
the adaptation list below.
Adaptations:
- method step 2 "Fetch or search primary-ish sources (paper, textbook, official docs, standard reference). Do not cite a URL you did not open." -> "Search primary-ish sources (paper, textbook, official docs, standard reference). Cite only sources the search actually surfaced." (grounding happens via built-in Google Search — the Gem fetches nothing itself)
- rules item "- Write the verdict into the session file if an alvar-learn session is open." -> deleted (verdicts are reported inline in chat)
- YAML frontmatter (name/description/license/metadata incl. trigger phrases) -> deleted (knowledge file, not an invocable skill)
Gem: alvar-tutor (Gemini web)
