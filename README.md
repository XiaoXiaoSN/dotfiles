# dotfiles

## Getting Started

### Editor

```shell
# Neovim
ln -s $(pwd)/nvim $HOME/.config/nvim
./nvim/setup.sh

# Vim
ln -s $(pwd)/vim/vimrc $HOME/.vimrc
./vim/setup.sh
```

### Terminal emulator

```shell
# Alacritty
ln -s $(pwd)/alacritty $HOME/.config/alacritty
```

### Shell

#### fish
```
ln -s $(pwd)/fish $HOME/.config/fish
fish -c "fisher update"
```

#### zsh

```shell
ln -s $(pwd)/zsh/zshrc $HOME/.zshrc
ln -s $(pwd)/zsh/zsh_config $HOME/.config/zsh
```

### Useful tools

```shell
# Git
ln -s $(pwd)/git $HOME/.config/git

# Tmux
## ~/.tmux.conf       Default tmux configuration file.
## /etc/tmux.conf     System-wide configuration file.
ln -s $(pwd)/tmux/tmux.conf $HOME/.tmux.conf
tmux source-file $HOME/.tmux.conf
```

### Initialize macOS

```shell
./macos/init.sh
```

### Setup Nix

#### Nix

```
ln -s $(pwd)/nix ~/.config/nix
```

#### Home Manager

Need to run `git add` after update

```shell
ln -s $(pwd)/nixpkgs $HOME/.config/nixpkgs
home-manager switch
```

## Editor Guide

