#!/bin/bash
set -euo pipefail

# block-dangerous-commands.sh
# PreToolUse Hook: Bash 도구 호출 전 위험한 명령을 차단한다.
# exit 0 = 허용, exit 2 = 차단 (stderr가 Claude에게 피드백)

input=$(cat)
command=$(echo "$input" | jq -r '.tool_input.command // empty')

if [ -z "$command" ]; then
  exit 0
fi

# 위험 명령 패턴 목록
dangerous_patterns=(
  'rm\s+-rf\s+/'
  'rm\s+-rf\s+~'
  'rm\s+-rf\s+\.'
  'rm\s+-fr\s+/'
  'git\s+push\s+.*--force.*\s+(main|master)'
  'git\s+push\s+-f\s+.*\s+(main|master)'
  'git\s+reset\s+--hard'
  'DROP\s+TABLE'
  'DROP\s+DATABASE'
  'TRUNCATE\s+TABLE'
  'chmod\s+777'
  '>\s*/dev/sd[a-z]'
  'mkfs\.'
  'dd\s+if=.*of=/dev/'
  ':\(\)\{\s*:\|:\s*&\s*\};:'
)

for pattern in "${dangerous_patterns[@]}"; do
  if echo "$command" | grep -qEi "$pattern"; then
    echo "[safe-guard] 위험 명령 차단: $command" >&2
    echo "이 명령은 시스템에 치명적인 영향을 줄 수 있어 차단되었습니다." >&2
    echo "정말 실행이 필요하면 safe-guard Plugin을 비활성화하세요." >&2
    exit 2
  fi
done

exit 0
