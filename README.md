# SecondBrain

Obsidian 기반 개인 지식 관리 볼트입니다.

## 자동 백업

macOS LaunchAgent를 통해 **1시간마다** 자동으로 GitHub에 푸시됩니다.

### 수동 푸시

터미널에서 아래 명령어를 실행하면 즉시 커밋 & 푸시됩니다.

```bash
vault-push
```

> 변경사항이 없으면 커밋 없이 종료됩니다.

### 자동 푸시 주기 변경

`~/Library/LaunchAgents/com.secondbrain.auto-push.plist` 파일의 `StartInterval` 값을 수정합니다 (초 단위).

| 주기 | 값 |
|------|------|
| 30분 | 1800 |
| 1시간 | 3600 |
| 3시간 | 10800 |
| 6시간 | 21600 |

수정 후 재등록:

```bash
launchctl unload ~/Library/LaunchAgents/com.secondbrain.auto-push.plist
launchctl load ~/Library/LaunchAgents/com.secondbrain.auto-push.plist
```

### 자동 푸시 중지 / 재시작

```bash
# 중지
launchctl unload ~/Library/LaunchAgents/com.secondbrain.auto-push.plist

# 재시작
launchctl load ~/Library/LaunchAgents/com.secondbrain.auto-push.plist
```

### 로그 확인

```bash
cat /Users/sonjunhyeong/Documents/SecondBrain/.scripts/auto-push.log
```

## 구조

| 경로 | 설명 |
|------|------|
| `.scripts/auto-push.sh` | 자동 푸시 스크립트 |
| `.scripts/auto-push.log` | 푸시 로그 (git 추적 제외) |
| `.obsidian/` | Obsidian 설정 |
