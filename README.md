# dotfiles

## Getting Started

### Editor

```shell
# Neovim
ln -s $(pwd)/nvim $HOME/.config/nvim

# Vim
ln -s $(pwd)/vim/vimrc $HOME/.vimrc
./vim/install.sh
```

### Useful tools

```shell
# Git
ln -s $(pwd)/git $HOME/.config/git

# Tmux
## ~/.tmux.conf       Default tmux configuration file.
## /etc/tmux.conf     System-wide configuration file.
ln -s $(pwd)/tmux/tmux.conf $HOME/.tmux.conf
```

### Terminal emulator

```shell
# Alacritty
ln -s $(pwd)/alacritty $HOME/.config/alacritty
```

### Initalize macOS

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
