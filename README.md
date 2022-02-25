# dotfiles

## Getting Started

### Editor

```shell
# Neovim
ln -sh $(pwd)/nvim $HOME/.config/nvim
./nvim/setup.sh

# Vim
ln -sh $(pwd)/vim/vimrc $HOME/.vimrc
./vim/setup.sh
```

### Terminal emulator

```shell
# Alacritty
ln -sh $(pwd)/alacritty $HOME/.config/alacritty
```

### Shell

#### fish
```
ln -sh $(pwd)/fish $HOME/.config/fish
fish -c "fisher update"
```

#### zsh

```shell
ln -sh $(pwd)/zsh/zshrc $HOME/.zshrc
ln -sh $(pwd)/zsh/zsh_config $HOME/.config/zsh
```

### Useful tools

```shell
# Git
ln -sh $(pwd)/git $HOME/.config/git

# Tmux
## ~/.tmux.conf       Default tmux configuration file.
## /etc/tmux.conf     System-wide configuration file.
ln -sh $(pwd)/tmux/tmux.conf $HOME/.tmux.conf
tmux source-file $HOME/.tmux.conf
```

### Initialize macOS

```shell
./macos/init.sh
```

### Setup Nix

#### Nix

```
ln -sh $(pwd)/nix ~/.config/nix
```

#### Home Manager

Need to run `git add` after update

```shell
ln -sh $(pwd)/nixpkgs $HOME/.config/nixpkgs
home-manager switch
```

## Editor Guide

