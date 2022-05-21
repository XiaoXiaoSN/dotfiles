# Fig pre block. Keep at the top of this file.
FIGIO_PATH="$HOME/.fig/shell"

if [ -d "$FIGIO_PATH" ]; then
  . "$FIGIO_PATH/zshrc.pre.zsh"
fi
