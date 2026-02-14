# code-quality

자동 린팅 & 코드 리뷰 Plugin.

## 기능

### 자동 린팅 (PostToolUse Hook)

파일을 수정하면 확장자에 맞는 린터를 자동 실행한다:

| 확장자 | 린터 | 비고 |
|--------|------|------|
| `.ts`, `.tsx`, `.js`, `.jsx` | ESLint / Prettier | 프로젝트에 설치된 것 우선 |
| `.py` | Ruff / py_compile | Ruff 미설치 시 문법 검사 |
| `.go` | gofmt | Go 표준 포맷터 |
| `.json` | python json.tool | 문법 검증 |
| `.yaml`, `.yml` | PyYAML | 문법 검증 |

린터가 설치되지 않은 경우 에러 없이 스킵한다.

### 코드 리뷰 Skill

```bash
/code-quality:review [파일경로]
```

보안, 성능, 가독성, 유지보수성 4가지 관점에서 코드를 리뷰한다.

### 코드 리뷰 Agent

`code-reviewer` Agent가 `git diff`로 변경 파일을 탐지하고 심층 리뷰를 수행한다.

### MCP (Context7)

코드 리뷰 시 사용된 라이브러리의 최신 문서를 Context7 MCP로 참조할 수 있다.

## 설치

```bash
/plugin install code-quality@cc-plugin-samples
```
