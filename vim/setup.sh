#!/usr/bin/env bash
set -euo pipefail

# install vim-plug if not present
VIMPLUG_URL="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
VIMPLUG_PATH="$HOME/.vim/autoload/plug.vim"

if [ ! -f "$VIMPLUG_PATH" ]; then
  echo "installing vim-plug..."
  curl -fLo "$VIMPLUG_PATH" --create-dirs "$VIMPLUG_URL"
fi

# create undodir for persistent undo history
mkdir -p "$HOME/.vim/undodir"

# detect OS for install hints
if [[ "$(uname)" == "Darwin" ]]; then
  PKG_FZF="brew install fzf"
  PKG_RG="brew install ripgrep"
else
  PKG_FZF="sudo apt install fzf"
  PKG_RG="sudo apt install ripgrep"
fi

# warn about missing optional tools (not required, but improve fzf experience)
warn_missing() {
  if ! command -v "$1" &>/dev/null; then
    echo "warning: '$1' not found — install with: $2"
  fi
}

warn_missing fzf "$PKG_FZF"
warn_missing rg  "$PKG_RG"

vim +PlugInstall +PlugUpdate +qa
echo "done."
