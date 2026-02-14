현재 브랜치의 변경사항을 분석하여 GitHub PR을 생성한다.

$ARGUMENTS 로 base 브랜치를 지정할 수 있다 (기본: main).

1. 현재 브랜치와 base 브랜치의 차이점 분석
2. PR 제목과 본문 생성
3. 사용자에게 확인 후 `gh pr create` 실행

PR 본문은 HEREDOC을 사용하여 줄바꿈이 정상적으로 표시되도록 한다.
