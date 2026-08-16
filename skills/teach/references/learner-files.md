# Learner files

All session state lives in the **learner's working directory**, not in this skill repo.

```
.alvar/
  LEARNER.md                 # how this mind wants to be taught
  maps/<slug>.md             # probe results for one goal
  sessions/<date>-<slug>.md  # plan + steps + quizzes
  visuals/<slug>-<n>.svg     # diagrams from learn-visual
```

Create `.alvar/` on first use.

## LEARNER.md

If missing, run `learn-profile` or write a stub from `assets/LEARNER.md` and ask 3–5 questions to fill it. Do not invent a personality.

Read LEARNER.md at the start of every `teach` session. It controls:

- voice and density
- how they want struggle
- what they already treat as solid
- whether they want visuals, mermaid, LaTeX, or a long markdown log

## Map file

```markdown
# Map — <goal>

Updated: <ISO date>
Goal: <one sentence>

## Strands
| strand | status | evidence |
|--------|--------|----------|
| line integrals | known | Q2 correct, explained work |
| Stokes | edge | recognized statement, missed Faraday link |
| differential forms | unknown | said so |
| SR field mix | blocked | answered "I don't know" |

Status: `known` | `edge` | `unknown` | `blocked`

## Quiz log
- Q1 [line integrals] C — correct
```

## Session file

```markdown
# Session — <goal>
Date:
Model:
Goal:

## Plan
\`\`\`mermaid
graph TD
  A[covector] --> B[1-form]
  B --> C[wedge]
\`\`\`

## Log
### Node: covector
- taught:
- visual:
- quiz:
- result: lock-in | retry | insert-prereq
```

Keep these files updated as you go. They are the persistence layer (the portable stand-in for a markdown-log / Obsidian pane).
