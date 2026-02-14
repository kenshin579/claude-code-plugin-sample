#!/bin/bash
set -euo pipefail

# check-secrets.sh
# PreToolUse Hook: Write/Edit 시 작성될 내용에 시크릿이 포함되어 있는지 검사한다.
# exit 0 = 허용, exit 2 = 차단

input=$(cat)

# Write 도구의 content 또는 Edit 도구의 new_string에서 내용 추출
content=$(echo "$input" | jq -r '.tool_input.content // .tool_input.new_string // empty')

if [ -z "$content" ]; then
  exit 0
fi

# 시크릿 패턴 목록 (패턴:설명)
secret_patterns=(
  'AKIA[0-9A-Z]{16}:AWS Access Key'
  'ASIA[0-9A-Z]{16}:AWS Temporary Access Key'
  'ghp_[a-zA-Z0-9]{36}:GitHub Personal Access Token'
  'gho_[a-zA-Z0-9]{36}:GitHub OAuth Token'
  'ghs_[a-zA-Z0-9]{36}:GitHub Server Token'
  'github_pat_[a-zA-Z0-9_]{22,}:GitHub Fine-grained Token'
  'sk-[a-zA-Z0-9]{20,}:OpenAI API Key'
  'sk-proj-[a-zA-Z0-9]{20,}:OpenAI Project API Key'
  'xoxb-[0-9]{10,}-[a-zA-Z0-9]{20,}:Slack Bot Token'
  'xoxp-[0-9]{10,}-[a-zA-Z0-9]{20,}:Slack User Token'
  '-----BEGIN (RSA|EC|DSA|OPENSSH) PRIVATE KEY-----:Private Key'
)

found_secrets=()

for entry in "${secret_patterns[@]}"; do
  pattern="${entry%%:*}"
  description="${entry##*:}"
  
  if echo "$content" | grep -qE "$pattern"; then
    found_secrets+=("$description")
  fi
done

if [ ${#found_secrets[@]} -gt 0 ]; then
  echo "[security-scanner] 시크릿 탐지! 파일에 민감한 정보가 포함되어 있습니다." >&2
  for secret in "${found_secrets[@]}"; do
    echo "  - $secret" >&2
  done
  echo "" >&2
  echo "시크릿을 환경변수로 대체하거나 .env 파일을 사용하세요." >&2
  echo "오탐지인 경우 security-scanner Plugin을 비활성화하세요." >&2
  exit 2
fi

exit 0
