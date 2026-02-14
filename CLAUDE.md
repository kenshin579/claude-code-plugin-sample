# CLAUDE.md

## Project Overview

Claude Code Plugin 모음 레포. 4개의 독립적인 Plugin을 Marketplace 형태로 제공한다.

## Structure

```
plugins/
├── safe-guard/          # 위험 명령 차단 & 파일 보호 (Hooks)
├── code-quality/        # 자동 린팅 & 코드 리뷰 (Hooks + Skills + Agents + MCP)
├── git-workflow/        # Git 워크플로우 자동화 (Skills + Commands + MCP)
└── security-scanner/    # 보안 취약점 스캐너 (Agents + Skills + Hooks)
```

## Testing

```bash
# 개별 Plugin 로컬 테스트
claude --plugin-dir ./plugins/safe-guard
claude --plugin-dir ./plugins/code-quality
```

## Conventions

- Hook 스크립트: `set -euo pipefail` 사용
- 경로: `${CLAUDE_PLUGIN_ROOT}` 환경변수 사용 (절대경로 금지)
- exit code: 0=허용, 2=차단
- JSON 파싱: `jq` 사용, 필드 없을 때 `// empty`
