#!/bin/bash
set -euo pipefail

# protect-sensitive-files.sh
# PreToolUse Hook: Write/Edit 도구 호출 전 민감한 파일 수정을 차단한다.
# exit 0 = 허용, exit 2 = 차단

input=$(cat)
file_path=$(echo "$input" | jq -r '.tool_input.file_path // .tool_input.path // empty')

if [ -z "$file_path" ]; then
  exit 0
fi

# 파일명만 추출
filename=$(basename "$file_path")

# 보호 대상 패턴
protected_patterns=(
  '\.env$'
  '\.env\.'
  'credentials'
  'secret'
  'token'
  'id_rsa'
  'id_ed25519'
  '\.pem$'
  '\.key$'
  '\.p12$'
  '\.pfx$'
  '\.jks$'
)

for pattern in "${protected_patterns[@]}"; do
  if echo "$filename" | grep -qEi "$pattern"; then
    echo "[safe-guard] 민감 파일 보호: $file_path" >&2
    echo "이 파일은 민감한 정보를 포함할 수 있어 수정이 차단되었습니다." >&2
    echo "파일 유형: $(echo "$pattern" | sed 's/\\//g')" >&2
    exit 2
  fi
done

# .git/ 디렉토리 내부 파일 보호
if echo "$file_path" | grep -qE '(^|/)\.git/'; then
  echo "[safe-guard] Git 내부 파일 보호: $file_path" >&2
  echo ".git/ 디렉토리 내부 파일의 직접 수정은 차단됩니다." >&2
  exit 2
fi

exit 0
