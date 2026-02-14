프로젝트의 보안 취약점을 스캔한다.

$ARGUMENTS 가 지정되면 해당 경로를 스캔한다.
지정되지 않으면 프로젝트 전체를 대상으로 한다.

다음 항목을 검사해줘:

1. **시크릿 탐지**: 코드에 하드코딩된 API 키, 토큰, 비밀번호, Private Key
2. **OWASP Top 10**: SQL 인젝션, XSS, 인증 실패, 민감 데이터 노출 패턴
3. **의존성 보안**: package.json, go.mod, requirements.txt의 취약 패키지

결과를 Critical / High / Medium / Low 심각도로 분류하고 요약 통계를 포함해줘.
