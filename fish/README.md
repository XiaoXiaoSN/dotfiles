# Fish Shell

## Notes

Before starting, you should know the difference between `fish` and `bash`.
[fish for bash users](https://fishshell.com/docs/current/fish_for_bash_users.html)

### Fish Shell Version

The script has used [fish_add_path](https://fishshell.com/docs/current/cmds/fish_add_path.html) command, so we need to upgrade fish version over `^3.2`

```shell
sudo apt-add-repository ppa:fish-shell/release-3
sudo apt update
sudo apt upgrade
```

### kubectl Version

The kubectl added official support of `fish` after version `^1.23`.

Before upgrading to the latest version.
We can also install [evanlucas/fish-kubectl-completions](https://github.com/evanlucas/fish-kubectl-completions) to help fish to set up autocompletion.

## Getting Started

Upgrade packages

```shell
fisher update
```

## Debugging and Profiling

```shell
fish --profile ~/.config/fish/fish_profile.txt
exit
```

```shell
cat ~/.config/fish/fish_profile.txt | sort -nrk 2 | head -20
```
