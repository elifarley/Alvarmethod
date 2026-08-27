<!-- Source of truth: skills/learn-visual/SKILL.md @ 848c91c
     Ported: 2026-08-26. Do not edit here — edit the source, then re-apply
     the adaptation list below.
     Adaptations:
     - output section (both sentences) "Write `.alvar/visuals/<slug>-<n>.svg` (create the folder). Embed or link it in the session file." -> "Offer the SVG as a code block in chat." (no filesystem)
     - "Prefer SVG. Use another format only if the harness cannot preview SVG." -> "Prefer SVG (the learner renders it themselves)."
     - loop steps 3–5 (look at the file / fix / look again, stop after a clean pass) -> the text-audit paragraph in place; steps 1–2 kept with their numbering merged so the loop still reads coherently
     - failures heading "Failures to catch on the look pass" -> "Failures to catch on the text-audit pass" (look->text-audit substitution class — aligns with the added paragraph's pointer to the failure list)
     - YAML frontmatter (name/description/license/metadata incl. trigger phrases) -> deleted (knowledge file, not an invocable skill)
     Gem: alvar-tutor (Gemini web) -->

# Learn visual

One idea, one picture. The picture exists so the learner can accept the step — not as decoration.

## Output

Offer the SVG as a code block in chat.

Prefer SVG (the learner renders it themselves).

## Loop (do not skip)

1. State the claim the picture must make, in one sentence.
2. Draw the smallest picture that makes that claim.

**Text-audit pass (replaces the look pass):** You cannot view the render, ever. Keep every SVG simple enough to audit as text. Before offering it, re-read the SVG source against your prose and check the failure list below.

## Design

- One claim. No collage of the whole course.
- Large labels. High contrast. No tiny legend the learner needs a second lesson to read.
- If the idea is algebraic, show the objects (arrows, planes, machines), not a screenshot of the equation.
- Do not add decorative gradients, watermarks, or "AI art" backgrounds.

## Failures to catch on the text-audit pass

- Arrow direction disagrees with the prose
- Two symbols for the same object
- 3D that hides the relation
- Cropped text
- A picture of a *different* special case than the one just taught

## After

Tell the learner what to look at first ("the two arrows, then the pairing number"). Do not re-teach the whole node unless they ask.
