# zsh

## Getting Started

1. Link or copy the `zshrc` to `~/.zshrc`.
2. Ensure your configurations are in `~/.config/zsh/`.
3. Put the local script on `$HOME/zsh-profile.zsh` for machine-specific settings.

## Dependencies

To get the full experience, please install the following tools:

### macOS (Homebrew)

```bash
brew install eza zoxide fzf kubectl curl
```

### Ubuntu / Debian

```bash
# eza (Modern replacement for ls)
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install -y eza

# Other tools
sudo apt install -y zoxide fzf kubectl curl
```

## Extended Tools

- [iTerm2 integration](https://iterm2.com/documentation-shell-integration.html) a powerful integration tool for macOS

## TODO

- Select a plugin manager
- Implement a before/after script (be used on zprof, fig.io...)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md)
