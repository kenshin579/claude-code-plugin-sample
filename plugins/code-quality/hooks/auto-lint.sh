#!/bin/bash
set -euo pipefail

# auto-lint.sh
# PostToolUse Hook: Write/Edit 후 파일 확장자에 맞는 린터를 자동 실행한다.
# PostToolUse는 비차단 이벤트이므로 exit code 2를 반환해도 차단되지 않는다.
# stdout 출력이 Claude에게 컨텍스트로 전달된다.

input=$(cat)
file_path=$(echo "$input" | jq -r '.tool_input.file_path // .tool_input.path // empty')

if [ -z "$file_path" ] || [ ! -f "$file_path" ]; then
  exit 0
fi

extension="${file_path##*.}"

case "$extension" in
  ts|tsx|js|jsx)
    if command -v npx &>/dev/null; then
      if [ -f "$(dirname "$file_path")/node_modules/.bin/eslint" ] || [ -f "./node_modules/.bin/eslint" ]; then
        npx eslint --fix "$file_path" 2>/dev/null && echo "[code-quality] ESLint 적용: $file_path" || true
      elif [ -f "$(dirname "$file_path")/node_modules/.bin/prettier" ] || [ -f "./node_modules/.bin/prettier" ]; then
        npx prettier --write "$file_path" 2>/dev/null && echo "[code-quality] Prettier 적용: $file_path" || true
      fi
    fi
    ;;
  py)
    if command -v ruff &>/dev/null; then
      ruff check --fix "$file_path" 2>/dev/null && echo "[code-quality] Ruff 적용: $file_path" || true
    elif command -v python3 &>/dev/null; then
      python3 -m py_compile "$file_path" 2>/dev/null && echo "[code-quality] Python 문법 검사 통과: $file_path" || true
    fi
    ;;
  go)
    if command -v gofmt &>/dev/null; then
      gofmt -w "$file_path" 2>/dev/null && echo "[code-quality] gofmt 적용: $file_path" || true
    fi
    ;;
  json)
    if command -v python3 &>/dev/null; then
      python3 -m json.tool "$file_path" > /dev/null 2>&1 && echo "[code-quality] JSON 문법 검증 통과: $file_path" || echo "[code-quality] JSON 문법 오류 발견: $file_path"
    fi
    ;;
  yaml|yml)
    if command -v python3 &>/dev/null; then
      python3 -c "import yaml; yaml.safe_load(open('$file_path'))" 2>/dev/null && echo "[code-quality] YAML 문법 검증 통과: $file_path" || echo "[code-quality] YAML 문법 오류 발견: $file_path"
    fi
    ;;
esac

exit 0
