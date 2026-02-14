# security-scanner

보안 취약점 스캐너 Plugin.

## 기능

### 시크릿 탐지 Hook (PreToolUse + Write|Edit)

파일 작성/수정 시 다음 시크릿 패턴이 포함되면 자동으로 차단한다:

- AWS Access Key (`AKIA...`)
- GitHub Token (`ghp_...`, `gho_...`, `ghs_...`)
- OpenAI API Key (`sk-...`)
- Slack Token (`xoxb-...`, `xoxp-...`)
- Private Key (`-----BEGIN ... PRIVATE KEY-----`)

### 보안 스캔 Skill

```bash
/security-scanner:scan [target-path]
```

security-auditor Agent에게 위임하여 다음을 검사한다:
- 시크릿 탐지 (정규식 기반)
- OWASP Top 10 패턴 검사
- 의존성 보안 확인

### Security Auditor Agent

`security-auditor` Agent가 코드를 읽고 체계적으로 보안 취약점을 분석한다.

## 설치

```bash
/plugin install security-scanner@cc-plugin-samples
```

## 출력 형식

스캔 결과는 심각도별로 분류된다: Critical > High > Medium > Low
