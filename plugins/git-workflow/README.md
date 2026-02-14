# git-workflow

Git 워크플로우 자동화 Plugin.

## 기능

### 커밋 메시지 생성

```bash
/git-workflow:commit [feat|fix|docs|refactor|test|chore]
```

staged 변경사항을 분석하여 Conventional Commits 형식의 커밋 메시지를 생성한다.
한국어 커밋 메시지를 지원하며, 최근 커밋 스타일을 참조한다.

### PR 생성

```bash
/git-workflow:pr [base-branch]
```

현재 브랜치의 커밋 히스토리를 분석하여 PR 제목과 본문을 생성하고 `gh pr create`로 PR을 생성한다.

### 프로젝트 상태

```bash
/git-workflow:status
```

브랜치, 커밋, 변경사항, 원격 동기화 상태를 한눈에 확인한다.

### MCP (GitHub)

GitHub MCP 서버를 통해 PR 생성, Issue 조회 등 GitHub API를 활용한다.
`GITHUB_TOKEN` 환경변수 설정이 필요하다.

## 설치

```bash
/plugin install git-workflow@cc-plugin-samples
```

## 요구사항

- `gh` CLI (PR 생성에 필요)
- `GITHUB_TOKEN` 환경변수 (GitHub MCP 사용 시)
