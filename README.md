# Alvarmethod

One teacher. One mind. Portable agent skills that run Eero Alvar’s AI learning loop.

Credit: **[Eero Alvar — *How I Use AI to Learn Things*](https://youtu.be/kzcI5F4tGiU)** (2026-08-14). This repo implements that method as Agent Skills. It is not Eero’s original Pi setup (quiz extension, Obsidian MD-log). Captions: [`source/eero-alvar-how-i-use-ai-to-learn-things.md`](source/eero-alvar-how-i-use-ai-to-learn-things.md).

Works in **Codex**, **Claude Code**, **Grok**, **Pi**, and **OpenCode** (standard `SKILL.md`).

## The method

Many-to-many learning is leaky:

| Direction | Waste |
|-----------|--------|
| One outlet → many students | Never fitted to *your* edge |
| One student → many outlets | Switching cost + the brain hedges on sources it does not trust |

Fix: **one interface, many sources.** Trust is engineered (verify), not hoped for. Struggle stays in the material. The system eats logistics.

Then:

1. **Probe** — graded MCQ, start wide, binary-search every strand
2. **Plan** — mermaid DAG for *this* mind, shown before teaching (so the model cannot wing it)
3. **Teach** — one reasoning step, picture if needed, quiz to lock in, then the next node

## Skills

| Skill | Job |
|-------|-----|
| `teach` | Full loop: probe → plan → one-step teaching |
| `probe` | Understanding map only |
| `learn-profile` | Write `.alvar/LEARNER.md` (how you want to be taught) |
| `learn-visual` | One SVG, look at it, fix it |
| `learn-verify` | Fact-check a claim before it is taught as fact |

## Install

```bash
git clone git@github.com:vasanthsreeram/Alvarmethod.git
cd Alvarmethod
chmod +x install.sh
./install.sh
```

That copies the five skills into:

| Agent | Global path |
|-------|-------------|
| Codex | `~/.codex/skills` and `~/.agents/skills` |
| Claude Code | `~/.claude/skills` |
| Grok | `~/.grok/skills` |
| Pi | `~/.pi/agent/skills` |
| OpenCode | `~/.config/opencode/skills` |

Project-only:

```bash
cd /path/to/your/learning-folder
/path/to/Alvarmethod/install.sh --project
```

One harness:

```bash
./install.sh --claude
./install.sh --grok --pi
```

Remove copies (this repo stays):

```bash
./install.sh --uninstall
```

## Try it

Open a **learning folder** (not this repo). Stronger models teach this better.

```text
/learn-profile
/teach I want a solid introduction to <topic>
```

Same thing in chat: “Teach me X. Probe first.”

You should get: a few MCQs **in the harness quiz UI** (not letters in chat) → a mermaid plan → **one** step → a quiz on that step. If the agent dumps a textbook chapter, stop it and say “one node only.” If it pastes A/B/C/D instead of opening the picker, the skill is being ignored — say “use the quiz tool.”

| Agent | Quiz tool |
|-------|-----------|
| Grok | `ask_user_question` |
| Claude Code | `AskUserQuestion` |
| Codex | `ask_user_question` |
| OpenCode | `question` |
| Pi | `quiz` / `ask_user` / `askUserQuestion` |

Files it writes:

```text
.alvar/LEARNER.md
.alvar/maps/<topic>.md
.alvar/sessions/<date>-<topic>.md
.alvar/visuals/…
```

Commands if your agent uses them: `/teach`, `/probe`, `/skill:teach` (Pi), or the Skills menu.

## Not in this pack

Eero’s demo also used Pi-only quiz + markdown-log extensions and Obsidian as the UI. Here, quizzes are in the chat and the log is `.alvar/sessions/`. Point Obsidian at that folder if you want LaTeX preview.

## License

MIT for the skills, installer, and docs.

The video and spoken method are **Eero Alvar’s**. Watch the original: [youtu.be/kzcI5F4tGiU](https://youtu.be/kzcI5F4tGiU).
