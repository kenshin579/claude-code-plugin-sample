# Claude Code Plugin Samples

실용적인 Claude Code Plugin 모음. 누구나 Marketplace로 추가하여 바로 설치할 수 있다.

## 설치

### Marketplace로 설치 (권장)

```bash
# Claude Code에서 Marketplace 추가
/plugin marketplace add kenshin579/claude-code-plugin-sample

# 원하는 Plugin 개별 설치
/plugin install safe-guard@cc-plugin-samples
/plugin install code-quality@cc-plugin-samples
/plugin install git-workflow@cc-plugin-samples
/plugin install security-scanner@cc-plugin-samples
```

### 로컬 테스트

```bash
git clone https://github.com/kenshin579/claude-code-plugin-sample.git
cd claude-code-plugin-sample

# 개별 Plugin 로드
claude --plugin-dir ./plugins/safe-guard
claude --plugin-dir ./plugins/code-quality
```

## Plugins

| Plugin | 설명 | 활용 기능 |
|--------|------|-----------|
| [safe-guard](./plugins/safe-guard/) | 위험 명령 차단 & 민감 파일 보호 | Hooks |
| [code-quality](./plugins/code-quality/) | 자동 린팅 & 코드 리뷰 | Hooks, Skills, Agents, MCP |
| [git-workflow](./plugins/git-workflow/) | Git 커밋/PR/상태 자동화 | Skills, Commands, MCP |
| [security-scanner](./plugins/security-scanner/) | 보안 취약점 스캔 & 시크릿 탐지 | Agents, Skills, Hooks |

### safe-guard

`rm -rf /`, `git push --force main`, `DROP TABLE` 등 위험한 명령을 **PreToolUse Hook**으로 차단한다. `.env`, 인증서 키 등 민감 파일의 수정도 방지한다.

```bash
claude --plugin-dir ./plugins/safe-guard
```

### code-quality

파일 수정 후 **자동 린팅**(PostToolUse Hook), 체계적인 **코드 리뷰 Skill**, 리뷰 전문 **Agent**를 제공한다. Context7 MCP로 라이브러리 문서를 참조한 리뷰가 가능하다.

```bash
claude --plugin-dir ./plugins/code-quality
# /code-quality:review [파일경로]
```

### git-workflow

Conventional Commits 형식의 **커밋 메시지 생성**, **PR 생성**, **프로젝트 상태 확인**을 자동화한다. GitHub MCP로 PR/Issue API를 연동한다.

```bash
claude --plugin-dir ./plugins/git-workflow
# /git-workflow:commit [feat|fix|docs]
# /git-workflow:pr [base-branch]
# /git-workflow:status
```

### security-scanner

코드베이스의 **시크릿 탐지**(AWS Key, GitHub Token 등), **OWASP Top 10 검사**, **의존성 보안 확인**을 수행한다. 파일 작성 시 시크릿이 포함되면 Hook으로 차단한다.

```bash
claude --plugin-dir ./plugins/security-scanner
# /security-scanner:scan [target-path]
```

## 요구사항

- Claude Code v1.0.33 이상
- `jq` (Hook 스크립트에서 JSON 파싱에 사용)
- 린터는 선택사항 (미설치 시 자동 스킵)

## License

MIT
