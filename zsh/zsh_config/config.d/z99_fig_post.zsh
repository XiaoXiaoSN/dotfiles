# NOTE: add a `z` prefix to ensure run in finalize stage

# Fig post block. Keep at the bottom of this file.
FIGIO_PATH="$HOME/.fig/shell"

if [ -d "$FIGIO_PATH" ]; then
  . "$FIGIO_PATH/zshrc.post.zsh"
fi
