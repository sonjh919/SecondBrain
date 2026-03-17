#!/bin/bash
# Obsidian Vault 자동 푸시 스크립트
# 주기 변경: ~/Library/LaunchAgents/com.secondbrain.auto-push.plist 의
#            StartInterval 값을 수정 후 아래 명령 실행
#   launchctl unload ~/Library/LaunchAgents/com.secondbrain.auto-push.plist
#   launchctl load ~/Library/LaunchAgents/com.secondbrain.auto-push.plist

VAULT_DIR="/Users/sonjunhyeong/Documents/SecondBrain"
LOG_FILE="$VAULT_DIR/.scripts/auto-push.log"

cd "$VAULT_DIR" || exit 1

# 변경사항 없으면 종료
if git diff --quiet && git diff --cached --quiet && [ -z "$(git ls-files --others --exclude-standard)" ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') No changes" >> "$LOG_FILE"
    exit 0
fi

# 커밋 & 푸시
git add -A
git commit -m "vault backup: $(date '+%Y-%m-%d %H:%M:%S')"
git push origin main

echo "$(date '+%Y-%m-%d %H:%M:%S') Pushed successfully" >> "$LOG_FILE"
