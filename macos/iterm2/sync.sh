#!/usr/bin/env bash
# Commit the portable iTerm2 export after iTerm2 wrote new preferences.
#
# iTerm2 loads and saves preferences from macos/iterm2/. That live plist is
# untracked on purpose: it is mostly machine state. This script derives the two
# reviewable files (profile JSON, colour preset) and commits them when they
# actually changed.
#
# Safe to run at any time: it never rebases, never pushes, and exits while a
# rebase/merge is in progress.
set -euo pipefail

repo="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
dir="$repo/macos/iterm2"
plist="$dir/com.googlecode.iterm2.plist"

[[ -f "$plist" ]] || exit 0

# Do not create commits in the middle of an operation that owns the index.
for marker in rebase-merge rebase-apply MERGE_HEAD CHERRY_PICK_HEAD REVERT_HEAD; do
  if [[ -e "$repo/.git/$marker" ]]; then
    exit 0
  fi
done

# Let iTerm2 finish its write before reading the file.
sleep 2

python3 "$dir/export.py" "$plist" "$dir"

# Keep the tracked JSON formatted the way the repo's pre-commit hook expects.
if command -v prettier >/dev/null 2>&1; then
  prettier --write --log-level warn "$dir"/*.json >/dev/null
fi

git -C "$repo" add -- macos/iterm2/*.json macos/iterm2/*.itermcolors
if git -C "$repo" diff --cached --quiet -- macos/iterm2; then
  exit 0
fi

git -C "$repo" commit -q -m "chore(iterm2): sync portable profile export" -- macos/iterm2
