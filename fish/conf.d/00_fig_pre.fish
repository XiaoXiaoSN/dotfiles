# Fig pre block. Keep at the top of this file.
if type -q fig
  set -Ua fish_user_paths $HOME/.local/bin
  eval (fig init fish pre | string split0)
end
