#!/usr/bin/env bash

set -eu
set -o pipefail

if !type nvim >/dev/null 2>&1; then
    echo "Neovim not found!"
    return
fi

# https://github.com/junegunn/vim-plug
VIMPLUG_URL="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
VIMPLUG_PATH="$HOME/.local/share/nvim/site/autoload/plug.vim"

if [ ! -f $VIMPLUG_PATH ]; then
    echo "Downloading $VIMPLUG_URL"
    curl -fLo $VIMPLUG_PATH --create-dirs $VIMPLUG_URL
fi

nvim +PlugInstall +PlugUpdate +UpdateRemotePlugins +qa
