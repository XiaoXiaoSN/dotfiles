# iTerm2

iTerm2 loads its preferences **from this folder** and writes them back here, so
`com.googlecode.iterm2.plist` in this directory is the live settings file, not
an export. Git history is therefore the settings history.

> This repository is public. The plist contains machine specifics such as
> profile `Command` values (`ssh user@host`), `Working Directory` and AI model
> settings. Do not move secrets into a profile; keep credentials in Keychain.
>
> Because the folder is live, `git checkout`, `git stash` or resolving a
> conflict here changes iTerm2's settings on the next launch. A snapshot is
> kept in `~/Library/Application Support/iTerm2Backups/` before big changes.

## Files

| File                               | Description                                          |
| ---------------------------------- | ---------------------------------------------------- |
| `com.googlecode.iterm2.plist`      | Live preferences (iTerm2 reads and writes this)      |
| `normalize.py`                     | Strips machine state and sorts keys before commit    |
| `sync.sh`                          | Normalizes and commits changes made by iTerm2        |
| `com.xiaoxiaosn.iterm2-sync.plist` | LaunchAgent that runs `sync.sh` on change and hourly |
| `XiaoXiaoSN.profile.json`          | Portable profile for import on another machine       |
| `default.itermcolors`              | Portable color preset                                |

## Setup on a machine

1. Settings → General → Preferences
2. Enable `Load preferences from a custom folder or URL:`
3. Set the path to this directory (`macos/iterm2`)
4. Choose how often iTerm2 saves changes back to the folder
5. Install the sync agent so saves become commits:

```bash
sed "s|__REPO__|$PWD|g" macos/iterm2/com.xiaoxiaosn.iterm2-sync.plist \
  > "$HOME/Library/LaunchAgents/com.xiaoxiaosn.iterm2-sync.plist"
launchctl bootout "gui/$(id -u)/com.xiaoxiaosn.iterm2-sync" 2>/dev/null || true
launchctl bootstrap "gui/$(id -u)" "$HOME/Library/LaunchAgents/com.xiaoxiaosn.iterm2-sync.plist"
```

Commits stay local; review and push manually. Logs: `/tmp/com.xiaoxiaosn.iterm2-sync.err`.

Run it by hand at any time:

```bash
bash macos/iterm2/sync.sh
```

## What is deliberately not tracked

`normalize.py` drops `NSWindow Frame*`, `NSSplitView Subview Frames*`,
`NSToolbar Configuration*`, `NoSync*` (iTerm2's own "do not synchronise" prefix)
and `SU*` updater state, then sorts keys. Without this every save would produce
a diff full of window coordinates and counters.

## Export / import the portable subset

**Profile:** Settings → Profiles → Other Actions… (bottom-left) → Save Profile as JSON…

**Color theme:** Settings → Profiles → Colors → Color Presets… (bottom-right) → Export…

On another machine: `Import JSON Profiles…` and `Import…` in the same menus.

## Useful Shortcuts

| ShortCut      | Description       |
| ------------- | ----------------- |
| `Cmd Shift h` | open copy history |
