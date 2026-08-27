#!/usr/bin/env bash
# Install Alvarmethod skills into agent skill directories.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
SKILLS_SRC="$ROOT/skills"
SKILLS=(alvar-learn probe learn-visual learn-verify learn-profile)
# Pre-rename name of alvar-learn; removed from targets so a stale copy can't
# keep answering to /teach after the rename.
LEGACY_SKILLS=(teach)

usage() {
  cat <<'EOF'
Install Alvarmethod skills.

Usage:
  ./install.sh              global, all known agent dirs
  ./install.sh --project    project-local dirs in $PWD
  ./install.sh --list       show sources and targets
  ./install.sh --uninstall  remove installed copies (not this repo)

Optional filters (combine with default or --project):
  --agents --claude --grok --pi --opencode --codex
  If none of these are passed, all of them are used.
EOF
}

MODE="global"
DO_UNINSTALL=0
DO_LIST=0
FILTERS=()

while [[ $# -gt 0 ]]; do
  case "$1" in
    -h|--help) usage; exit 0 ;;
    --project) MODE="project" ;;
    --uninstall) DO_UNINSTALL=1 ;;
    --list) DO_LIST=1 ;;
    --agents|--claude|--grok|--pi|--opencode|--codex) FILTERS+=("${1#--}") ;;
    *) echo "unknown arg: $1" >&2; usage; exit 1 ;;
  esac
  shift
done

if [[ ${#FILTERS[@]} -eq 0 ]]; then
  FILTERS=(agents claude grok pi opencode codex)
fi

home_targets() {
  local f
  for f in "${FILTERS[@]}"; do
    case "$f" in
      agents)   echo "$HOME/.agents/skills" ;;
      claude)   echo "$HOME/.claude/skills" ;;
      grok)     echo "$HOME/.grok/skills" ;;
      pi)       echo "$HOME/.pi/agent/skills" ;;
      opencode) echo "$HOME/.config/opencode/skills" ;;
      codex)    echo "$HOME/.codex/skills" ;;
    esac
  done
}

project_targets() {
  local f
  for f in "${FILTERS[@]}"; do
    case "$f" in
      agents)   echo "$PWD/.agents/skills" ;;
      claude)   echo "$PWD/.claude/skills" ;;
      grok)     echo "$PWD/.grok/skills" ;;
      pi)       echo "$PWD/.pi/skills" ;;
      opencode) echo "$PWD/.opencode/skills" ;;
      codex)    echo "$PWD/.agents/skills" ;;
    esac
  done
}

targets() {
  if [[ "$MODE" == "project" ]]; then
    project_targets
  else
    home_targets
  fi | awk 'NF && !seen[$0]++'
}

if [[ "$DO_LIST" -eq 1 ]]; then
  echo "source: $SKILLS_SRC"
  echo "mode:   $MODE"
  echo "skills: ${SKILLS[*]}"
  echo "targets:"
  targets | sed 's/^/  /'
  exit 0
fi

copied=0
removed=0
while IFS= read -r dest; do
  [[ -z "$dest" ]] && continue
  for name in "${LEGACY_SKILLS[@]}"; do
    if [[ -e "$dest/$name" || -L "$dest/$name" ]]; then
      # Data safety: only remove copies provably ours. Every Alvarmethod
      # SKILL.md carries the Eero Alvar source link in its YAML frontmatter,
      # so the marker must appear INSIDE the frontmatter block (--- to ---):
      # an inspired-by skill citing the video in prose does not qualify.
      # Case-insensitive so URL-normalized copies still match. A `teach`
      # dir without the frontmatter marker belongs to another package and
      # stays in place with a warning instead of being destroyed.
      if [[ -f "$dest/$name/SKILL.md" ]] \
         && [[ "$(head -n1 "$dest/$name/SKILL.md")" == "--"* ]] \
         && sed -n '2,/^---[[:space:]]*$/{/^---/d;p}' "$dest/$name/SKILL.md" | grep -qi 'kzci5f4tgiu'; then
        rm -rf "$dest/$name"
        echo "removed stale $dest/$name (renamed to ${SKILLS[0]})"
      else
        echo "WARNING: keeping $dest/$name — not recognized as an Alvarmethod copy; remove it manually if it is yours" >&2
      fi
    fi
  done
  if [[ "$DO_UNINSTALL" -eq 1 ]]; then
    for name in "${SKILLS[@]}"; do
      if [[ -e "$dest/$name" || -L "$dest/$name" ]]; then
        rm -rf "$dest/$name"
        echo "removed $dest/$name"
        removed=$((removed + 1))
      fi
    done
    continue
  fi
  mkdir -p "$dest"
  for name in "${SKILLS[@]}"; do
    rm -rf "$dest/$name"
    cp -R "$SKILLS_SRC/$name" "$dest/$name"
    echo "installed $dest/$name"
    copied=$((copied + 1))
  done
done < <(targets)

if [[ "$DO_UNINSTALL" -eq 1 ]]; then
  echo "done. removed $removed skill dirs."
else
  echo "done. installed $copied skill dirs."
  echo "Open a learning folder (not this repo) and run /alvar-learn or ask to be taught something."
fi
