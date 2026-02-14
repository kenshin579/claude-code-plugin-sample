---
name: security-scan
description: 프로젝트 전체 또는 특정 디렉토리의 보안 취약점을 스캔한다.
context: fork
agent: security-auditor
argument-hint: "[target-path]"
---

# Security Scan

프로젝트의 보안 취약점을 스캔한다.

## 스캔 대상

$ARGUMENTS 가 지정되면 해당 경로를 스캔한다.
지정되지 않으면 프로젝트 전체를 스캔한다.

## 검사 항목

1. **시크릿 탐지**: API 키, 토큰, 비밀번호, Private Key
2. **OWASP Top 10**: 인젝션, XSS, 인증 실패, 민감 데이터 노출
3. **의존성 보안**: package.json, go.mod, requirements.txt
