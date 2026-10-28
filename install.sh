#!/usr/bin/env bash
# WorkBuddy 技能安装脚本 (macOS / Linux / Git Bash)
# 用法: ./install.sh <技能名> [目标目录]
#   目标目录默认 ~/.workbuddy/skills
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL="${1:-}"
TARGET_ROOT="${2:-$HOME/.workbuddy/skills}"

list_skills() {
  echo "可用技能:"
  find "$SCRIPT_DIR" -mindepth 2 -maxdepth 2 -name SKILL.md 2>/dev/null \
    | sed "s|${SCRIPT_DIR}/||; s|/SKILL.md||" \
    | sort \
    | sed 's/^/  - /'
}

if [[ -z "$SKILL" ]]; then
  echo "用法: ./install.sh <技能名> [目标目录]"
  echo
  list_skills
  exit 1
fi

SRC="$SCRIPT_DIR/$SKILL"

if [[ ! -d "$SRC" ]]; then
  echo "错误: 技能目录不存在 -> $SRC"
  echo
  list_skills
  exit 1
fi

if [[ ! -f "$SRC/SKILL.md" ]]; then
  echo "错误: $SRC 下没有 SKILL.md，不是合法的技能目录"
  exit 1
fi

mkdir -p "$TARGET_ROOT"
DEST="$TARGET_ROOT/$SKILL"

if [[ -d "$DEST" ]]; then
  BAK="${DEST}.bak-$(date +%Y%m%d-%H%M%S)"
  mv "$DEST" "$BAK"
  echo "目标已存在，已备份为: $BAK"
fi

cp -R "$SRC" "$DEST"

echo
echo "已安装: $DEST"
echo "内容:"
find "$DEST" -maxdepth 2 -type f | sed "s|^|  |"
echo
echo "提示: 重启 WorkBuddy 会话后技能才会被加载。"
