#!/bin/bash
set -euo pipefail
restore_pref() {
  key="$1"
  value="$2"
  if [ "$value" = "__ABSENT__" ]; then
    /usr/bin/defaults delete NSGlobalDomain "$key" 2>/dev/null || true
  elif [ "$value" = "1" ]; then
    /usr/bin/defaults write NSGlobalDomain "$key" -bool true
  elif [ "$value" = "0" ]; then
    /usr/bin/defaults write NSGlobalDomain "$key" -bool false
  else
    /usr/bin/defaults write NSGlobalDomain "$key" "$value"
  fi
}
restore_pref NSAutomaticPeriodSubstitutionEnabled "1"
restore_pref NSAutomaticTextCompletionEnabled "__ABSENT__"
restore_pref NSAutomaticSpellingCorrectionEnabled "__ABSENT__"
restore_pref NSAutomaticCapitalizationEnabled "1"
/usr/bin/killall cfprefsd 2>/dev/null || true
printf 'rollback complete\n'
