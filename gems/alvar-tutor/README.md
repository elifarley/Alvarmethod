# Alvar Tutor — Gemini Gem

The Alvar learning loop as a [Gem](https://gemini.google.com) for Gemini web:
one teacher, one mind. Five knowledge files plus one instruction paste — no
skills runtime needed.

## 1. Create the Gem

Budget gate first. Before pasting anything, run:

```bash
wc -m gems/alvar-tutor/INSTRUCTIONS.md   # must print ≤ ~4000
```

If it prints more than ~4000, stop and trim upstream: community reports of
silent truncation near 4k chars mean the Gem ships with its tail missing and
no error anywhere.

Then:

1. Open [gemini.google.com](https://gemini.google.com) → **Explore Gems** → **New Gem**.
2. Name it **Alvar Tutor**.
3. Paste the full content of `gems/alvar-tutor/INSTRUCTIONS.md` into **Instructions**.
4. Upload all five files under **Knowledge**:

   ```text
   gems/alvar-tutor/knowledge/philosophy.md
   gems/alvar-tutor/knowledge/process.md
   gems/alvar-tutor/knowledge/learner-profile.md
   gems/alvar-tutor/knowledge/verify.md
   gems/alvar-tutor/knowledge/visual.md
   ```

5. Save.

Free tier works; Gem quality improves on Advanced.

## 2. Use

Open a fresh chat with the Gem and state a learning goal:

```text
I want a solid introduction to <topic>
```

Turn 0 profiles how you want to be taught, probes what you already know, then
shows the plan before teaching. A new chat means a fresh probe.

## 3. Smoke-test checklist

The regression test — manual by nature. Run every item against a fresh Gem
build before calling it done.

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
     new final section. Blind spot: detects tail truncation only — a
     mid-section cut inside a never-cut protocol leaves no signal; the
     protocol items above (quiz shape, one-step, verdicts) are the
     compensating control

Credit: the method is **Eero Alvar's** — [*How I Use AI to Learn Things*](https://youtu.be/kzcI5F4tGiU).
This repo implements it as agent skills plus this Gem: see [the source pack](../..).

Contributors: edit the source `skills/…`, then re-port per each knowledge
file's header adaptation list. Never edit the files in `gems/alvar-tutor/knowledge/`
directly.
