# Contributing Guide

새로운 Plugin을 기여하는 방법을 안내한다.

## Plugin 구조

새 Plugin은 `plugins/` 디렉토리 아래에 생성한다:

```
plugins/my-plugin/
├── .claude-plugin/
│   └── plugin.json          # 필수: 매니페스트
├── commands/                # 슬래시 커맨드 (마크다운)
├── skills/                  # Agent Skills (SKILL.md)
│   └── my-skill/
│       └── SKILL.md
├── agents/                  # 커스텀 서브에이전트
├── hooks/
│   ├── hooks.json           # Hook 설정
│   └── *.sh                 # Hook 스크립트
├── .mcp.json                # MCP 서버 설정 (선택)
└── README.md                # 필수: 사용법 문서
```

## plugin.json 필수 필드

```json
{
  "name": "my-plugin",
  "description": "Plugin이 해결하는 문제를 설명",
  "version": "1.0.0",
  "author": { "name": "작성자" },
  "license": "MIT"
}
```

## Best Practice 체크리스트

### Hook 스크립트
- [ ] `#!/bin/bash` shebang 포함
- [ ] `set -euo pipefail` 사용
- [ ] stdin JSON 파싱에 `jq` 사용, `// empty`로 안전 처리
- [ ] exit code: 0=허용, 2=차단
- [ ] stderr에 사용자 친화적 메시지 출력
- [ ] 외부 도구 미설치 시 graceful 스킵 (exit 0)
- [ ] `${CLAUDE_PLUGIN_ROOT}` 환경변수로 경로 참조

### Skills
- [ ] `description`에 충분한 설명 (Claude 자동 호출 판단용)
- [ ] `allowed-tools`로 최소 권한 적용
- [ ] `argument-hint` 제공

### Agents
- [ ] `tools` 필드로 최소 권한 적용
- [ ] `model` 지정 (비용 최적화)
- [ ] 구조화된 출력 형식 정의

## 기여 절차

1. Fork 후 feature 브랜치 생성
2. `plugins/` 하위에 새 Plugin 디렉토리 생성
3. 위 체크리스트 확인
4. `claude --plugin-dir ./plugins/my-plugin`으로 테스트
5. `.claude-plugin/marketplace.json`에 Plugin 엔트리 추가
6. PR 생성
