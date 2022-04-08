# Fig pre block. Keep at the top of this file.
if type direnv 2>&1 >>/dev/null; then
  export PATH="${PATH}:${HOME}/.local/bin"
  eval "$(fig init zsh pre)"
fi
