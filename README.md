# dotfiles

## Getting Started

```shell
git submodule init
git submodule update
```

```shell
# Neovim
ln -s $(pwd)/nvim $HOME/.config/nvim

# Git
ln -s $(pwd)/git $HOME/.config/git

# Tmux
ln -s $(pwd)/tmux $HOME/.config/tmux
tmux source-file $HOME/.config/tmux/tmux.conf

# Alacritty
ln -s $(pwd)/alacritty $HOME/.config/alacritty
```
