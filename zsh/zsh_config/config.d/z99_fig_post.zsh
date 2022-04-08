# NOTE: add a `z` prefix to ensure run in finalize stage

# Fig post block. Keep at the bottom of this file.
if type direnv 2>&1 >>/dev/null; then
  eval "$(fig init zsh post)"
fi
