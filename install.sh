#!/bin/bash
# Usage: ./install.sh --tool kilo --skill agentic-python-dockerfirst

set -e

show_usage() {
  echo "Usage: $0 --tool <kilo|claude|opencode> --skill <skill-name>"
  echo ""
  echo "Options:"
  echo "  --tool   AI tool to install skill for (required)"
  echo "  --skill  Skill name from skills/ directory (required)"
  echo ""
  echo "Examples:"
  echo "  $0 --tool kilo --skill agentic-python"
  echo "  $0 --tool claude --skill agentic-python"
  echo ""
  echo "Available skills:"
  if command -v column &>/dev/null; then
    ls -1 skills/*/SKILL.md 2>/dev/null | sed 's|skills/||; s|/SKILL.md||' | column -t
  else
    ls -1 skills/*/SKILL.md 2>/dev/null | sed 's|skills/||; s|/SKILL.md||'
  fi || echo "  (none found)"
  exit 1
}

[[ $# -eq 0 ]] && show_usage

while [[ $# -gt 0 ]]; do
  case $1 in
    --tool)
      [[ -z "$2" || "$2" == --* ]] && echo "Error: --tool requires a value" && exit 1
      TOOL="$2"
      shift 2
      ;;
    --skill)
      [[ -z "$2" || "$2" == --* ]] && echo "Error: --skill requires a value" && exit 1
      SKILL="$2"
      shift 2
      ;;
    -h|--help)
      show_usage
      ;;
    *)
      echo "Error: unknown option $1"
      show_usage
      ;;
  esac
done

[[ -z "$TOOL" ]] && echo "Error: --tool is required" && show_usage
[[ -z "$SKILL" ]] && echo "Error: --skill is required" && show_usage
[[ ! -d "skills/$SKILL" ]] && echo "Error: skill '$SKILL' not found in skills/" && exit 1
[[ ! -f "skills/$SKILL/SKILL.md" ]] && echo "Error: skills/$SKILL/SKILL.md not found" && exit 1

case $TOOL in
  kilo)
    DEST_DIR="./.kilo/skills/$SKILL"
    ;;
  claude)
    DEST_DIR="$HOME/.claude/skills/$SKILL"
    ;;
  opencode)
    DEST_DIR="$HOME/.config/opencode/skill/$SKILL"
    ;;
  *)
    echo "Error: unknown tool '$TOOL'. Supported: kilo, claude, opencode"
    exit 1
    ;;
esac

mkdir -p "$DEST_DIR"
rm -f "$DEST_DIR/SKILL.md"
ln -sf "$PWD/skills/$SKILL/SKILL.md" "$DEST_DIR/SKILL.md"
echo "✅ $SKILL linked to $TOOL ($DEST_DIR)"