staged 변경사항을 분석하여 Conventional Commits 형식의 커밋 메시지를 생성하고 커밋한다.

$ARGUMENTS 로 커밋 타입을 지정할 수 있다 (feat, fix, docs, refactor, test, chore).

1. `git diff --cached`로 staged 변경사항 확인
2. `git log --oneline -5`로 최근 커밋 스타일 참조
3. 적절한 커밋 메시지 생성 (한국어, 50자 이내)
4. 사용자에게 메시지 확인 후 커밋 실행
