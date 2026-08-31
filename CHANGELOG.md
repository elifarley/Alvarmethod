# Changelog

All notable changes to this project are documented in this file.
Format based on Keep a Changelog; versions are MAJOR.MINOR.PATCH.MICRO
(VERSION file; package.json carries the 3-digit translation).

## [1.1.0.0] - 2026-08-31

### Changed
- **Alvar Tutor Gem: stricter graduation.** A strand now reaches `known`
  only after 3 correct answers on 3 different angles (meaning /
  application / nuance-or-edge-case); `edge` needs 2 signals; a wrong
  answer pops the newest credit; a foundation-missing wrong or "I don't
  know" clears the strand's record; every taught node starts a fresh
  credit record. Previously 1–2 correct picks graduated a strand.
- The scoring rubric lives in its own `## Rubric (probe and quiz)`
  section of INSTRUCTIONS.md (3983/4000 paste budget, was 3993).
- Smoke-test runbook restructured around the new bar: 23 rows / 21
  checkboxes, including two-signal entry, three-angle lock-in with a
  negative check, demotion-with-clearing, near-miss no-flip, and
  packed-reply probes. README checklist updated to match.
- 2026-08-26 design spec amended (delta (c)): rubric table replaced by
  the credit ledger, stale old-rubric passages repaired.
- Hard rule: only the Gem's own quizzes credit the map — pasted or
  self-reported answers never touch the strand ledger (injection guard).
- Budget gate is locale-pinned: the gem README and runbook now say
  `LC_ALL=C.UTF-8 wc -m` — a bare C-locale `wc -m` counts bytes, not
  characters, and would wrongly fail the 4000 gate.

### Added
- Gem-only-delta carve-out in the contributor workflow: knowledge-file
  edits recorded in a sidecar GEM-ONLY DELTA entry survive re-porting.
