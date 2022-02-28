#!/usr/bin/env bash

set -eu
set -o pipefail

# https://github.com/junegunn/vim-plug
VIMPLUG_URL="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
VIMPLUG_PATH="$HOME/.vim/autoload/plug.vim"

if [ ! -f $VIMPLUG_PATH ]; then
  echo "Downloading $VIMPLUG_URL"
  curl -fLo $VIMPLUG_PATH --create-dirs $VIMPLUG_URL
fi

vim +PlugInstall +PlugUpdate +UpdateRemotePlugins +qa
