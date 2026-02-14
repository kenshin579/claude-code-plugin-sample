# safe-guard

위험 명령 차단 및 민감 파일 보호 Plugin.

## 기능

### 위험 명령 차단 (PreToolUse + Bash)

Claude가 다음과 같은 위험한 명령을 실행하려 하면 자동으로 차단한다:

- `rm -rf /`, `rm -rf ~`, `rm -rf .` (시스템/홈/현재 디렉토리 삭제)
- `git push --force main|master` (메인 브랜치 force push)
- `git reset --hard` (커밋되지 않은 변경 삭제)
- `DROP TABLE`, `DROP DATABASE` (DB 파괴)
- `chmod 777` (과도한 권한 부여)
- `dd if=...of=/dev/` (디스크 직접 쓰기)

### 민감 파일 보호 (PreToolUse + Write|Edit)

다음 파일의 수정을 차단한다:

- `.env`, `.env.*` (환경변수)
- `*credentials*`, `*secret*`, `*token*` (인증 파일)
- `id_rsa`, `id_ed25519`, `*.pem`, `*.key` (SSH/인증서 키)
- `.git/` 디렉토리 내부 파일

## 설치

```bash
# Marketplace에서
/plugin install safe-guard@cc-plugin-samples

# 로컬 테스트
claude --plugin-dir ./plugins/safe-guard
```

## 커스터마이징

차단 패턴을 수정하려면 `hooks/block-dangerous-commands.sh`의 `dangerous_patterns` 배열을 편집한다.
보호 파일 패턴은 `hooks/protect-sensitive-files.sh`의 `protected_patterns` 배열을 편집한다.
