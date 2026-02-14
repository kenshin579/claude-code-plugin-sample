---
name: commit-msg
description: 현재 staged 변경사항을 분석하여 Conventional Commits 형식의 커밋 메시지를 생성한다.
allowed-tools: Read, Grep, Glob, Bash
argument-hint: "[type: feat|fix|docs|refactor|test|chore]"
---

# Commit Message Generator

현재 staged 변경사항을 분석하여 커밋 메시지를 생성한다.

## 현재 상태

staged 변경사항:
!`git diff --cached --stat 2>/dev/null || echo "staged 변경사항 없음"`

최근 커밋 스타일 참조:
!`git log --oneline -5 2>/dev/null || echo "커밋 히스토리 없음"`

## 규칙

1. **Conventional Commits** 형식을 따른다: `type: 설명`
2. 타입: feat, fix, docs, style, refactor, test, chore
3. $ARGUMENTS 로 타입이 지정되면 해당 타입을 사용한다
4. 설명은 한국어로 작성한다
5. 50자 이내로 간결하게 작성한다
6. 필요시 body에 상세 변경사항을 추가한다

## 출력 형식

```
제안 커밋 메시지:

[type] 간결한 설명

* 변경사항 상세 1
* 변경사항 상세 2
```

메시지만 생성하고, 실제 커밋은 사용자에게 확인 후 실행한다.
