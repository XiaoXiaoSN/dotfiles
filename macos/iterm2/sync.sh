#!/usr/bin/env bash
# Commit the iTerm2 preferences that iTerm2 itself wrote into this folder.
#
# iTerm2 is configured to load and save preferences from macos/iterm2/, which
# makes this folder the live source of truth. This script normalizes the file
# (see normalize.py) and commits it when the settings actually changed.
#
# Safe to run at any time: it never rebases, never pushes, and exits while a
# rebase/merge is in progress.
set -euo pipefail

repo="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
rel="macos/iterm2/com.googlecode.iterm2.plist"
file="$repo/$rel"

[[ -f "$file" ]] || exit 0

# Do not create commits in the middle of an operation that owns the index.
for marker in rebase-merge rebase-apply MERGE_HEAD CHERRY_PICK_HEAD REVERT_HEAD; do
  if [[ -e "$repo/.git/$marker" ]]; then
    exit 0
  fi
done

# Let iTerm2 finish its write before touching the file.
sleep 2

python3 "$repo/macos/iterm2/normalize.py" "$file"

git -C "$repo" add -- "$rel"
if git -C "$repo" diff --cached --quiet -- "$rel"; then
  exit 0
fi

git -C "$repo" commit -q -m "chore(iterm2): sync preferences" -- "$rel"
