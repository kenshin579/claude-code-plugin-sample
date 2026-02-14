---
name: pr-create
description: 현재 브랜치의 변경사항을 분석하여 PR 제목과 본문을 생성하고 PR을 생성한다.
allowed-tools: Read, Grep, Glob, Bash
argument-hint: "[base-branch]"
---

# PR Creator

현재 브랜치의 변경사항을 분석하여 GitHub PR을 생성한다.

## 현재 상태

현재 브랜치:
!`git branch --show-current 2>/dev/null || echo "브랜치 정보 없음"`

커밋 히스토리 (base 대비):
!`git log main..HEAD --oneline 2>/dev/null || git log master..HEAD --oneline 2>/dev/null || echo "커밋 없음"`

변경 파일 요약:
!`git diff main...HEAD --stat 2>/dev/null || git diff master...HEAD --stat 2>/dev/null || echo "변경사항 없음"`

## 규칙

1. base 브랜치: $ARGUMENTS 로 지정하거나, 기본값은 main
2. PR 제목은 70자 이내로 간결하게
3. PR 본문은 다음 형식을 따른다:
   - ## Summary: 변경 요약 (1-3줄)
   - ## Test plan: 테스트 체크리스트
4. `gh pr create`를 HEREDOC 형식으로 실행한다
5. PR 생성 전에 사용자에게 제목과 본문을 확인받는다
