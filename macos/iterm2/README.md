# iTerm2

iTerm2 loads its preferences **from this folder** and saves them back here, so
`com.googlecode.iterm2.plist` in this directory is the live settings file. That
file is **not tracked**: it is mostly machine state (window frames, counters,
updater bookkeeping) that would drown every commit.

What is tracked is the portable subset, regenerated automatically:

| File                               | Description                                          |
| ---------------------------------- | ---------------------------------------------------- |
| `XiaoXiaoSN.profile.json`          | Default profile, current settings                    |
| `default.itermcolors`              | Colour preset                                        |
| `export.py`                        | Derives both files from the live preferences         |
| `sync.sh`                          | Runs `export.py` and commits when the export changed |
| `com.xiaoxiaosn.iterm2-sync.plist` | LaunchAgent that runs `sync.sh` on change and hourly |

`com.googlecode.iterm2.plist` lives in this folder but is git-ignored.

> This repository is public. The exported profile contains `Working Directory`
> (`/Users/<name>`). Keep credentials in Keychain, never in a profile.
>
> The folder is live: `git checkout`, `git stash` or resolving a conflict here
> changes iTerm2's settings on the next launch. Snapshots are kept in
> `~/Library/Application Support/iTerm2Backups/`.

## Setup on a machine

1. Settings → General → Preferences
2. Enable `Load preferences from a custom folder or URL:` and set the path to
   this directory (`macos/iterm2`)
3. Choose how often iTerm2 saves changes back to the folder
4. Install the sync agent:

```bash
sed "s|__REPO__|$PWD|g" macos/iterm2/com.xiaoxiaosn.iterm2-sync.plist \
  > "$HOME/Library/LaunchAgents/com.xiaoxiaosn.iterm2-sync.plist"
launchctl bootout "gui/$(id -u)/com.xiaoxiaosn.iterm2-sync" 2>/dev/null || true
launchctl bootstrap "gui/$(id -u)" "$HOME/Library/LaunchAgents/com.xiaoxiaosn.iterm2-sync.plist"
```

Commits stay local; review and push manually. Logs:
`/tmp/com.xiaoxiaosn.iterm2-sync.err`.

Run it by hand at any time:

```bash
bash macos/iterm2/sync.sh
```

The export is deterministic (sorted keys, no machine state), so unchanged
settings produce no diff and no commit.

## Import on another machine

Settings → Profiles → Other Actions… (bottom-left) → `Import JSON Profiles…`,
then Settings → Profiles → Colors → Color Presets… (bottom-right) → `Import…`.
