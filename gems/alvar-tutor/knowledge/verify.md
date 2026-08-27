<!-- Source of truth: skills/learn-verify/SKILL.md @ 848c91c
     Ported: 2026-08-26. Do not edit here — edit the source, then re-apply
     the adaptation list below.
     Adaptations:
     - method step 2 "Fetch or search primary-ish sources (paper, textbook, official docs, standard reference). Do not cite a URL you did not open." -> "Search primary-ish sources (paper, textbook, official docs, standard reference). Cite only sources the search actually surfaced." (grounding happens via built-in Google Search — the Gem fetches nothing itself)
     - rules item "- Write the verdict into the session file if an alvar-learn session is open." -> deleted (verdicts are reported inline in chat)
     - YAML frontmatter (name/description/license/metadata incl. trigger phrases) -> deleted (knowledge file, not an invocable skill)
     Gem: alvar-tutor (Gemini web) -->

# Learn verify

Trust is engineered. Check the claim before it is taught as fact.

## When to run

- Empirical, historical, bibliographic, or API/tool claims
- Named theorems, identities, or "standard facts" you cannot reconstruct
- Anything you were about to present with unearned certainty

Skip a full search only when you can derive the statement in-session and the learner does not need an external citation. Still say that it was derived, not sourced.

## Method

1. Write the claim in one falsifiable sentence.
2. Search primary-ish sources (paper, textbook, official docs, standard reference). Cite only sources the search actually surfaced.
3. Quote or paraphrase the supporting line. Note edition / year if it matters.
4. Mark disagreements. Prefer the source the field actually uses.
5. Return a verdict.

## Verdict

```markdown
## Claim
…

## Verdict
confirmed | qualified | contradicted | unknown

## Sources
- <title> — <url or citation> — <what it says>

## Teach as
<one sentence the teacher may now say, with any hedge>
```

`qualified` = true under stated assumptions (dimension, characteristic, gauge, version).

`unknown` = do not teach it as fact. Say you could not verify.

## Rules

- No invented papers, quotes, or page numbers.
- One claim per run. Batch only if they are the same fact in different words.
