#!/bin/bash
set -euo pipefail
BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
LOG="$BASE_DIR/apply_log.txt"
: > "$LOG"
log() { printf '[%s] %s\n' "$(date '+%Y-%m-%d %H:%M:%S %z')" "$*" | tee -a "$LOG" >/dev/null; }

log "Disable double-space period substitution"
/usr/bin/defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

log "Disable automatic text completion"
/usr/bin/defaults write NSGlobalDomain NSAutomaticTextCompletionEnabled -bool false

log "Disable automatic spelling correction"
/usr/bin/defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

log "Disable automatic capitalization"
/usr/bin/defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

log "Refresh preference daemon"
/usr/bin/killall cfprefsd 2>/dev/null || true
log "Done"
