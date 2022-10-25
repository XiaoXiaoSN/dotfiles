set -x LANG en_US.UTF-8

# Aliases
source $HOME/.config/fish/aliases.fish

# Run local setting (Do not need to use git managment)
if test -e $HOME/fish-profile.fish
  source $HOME/fish-profile.fish
end

# set fish colors
# run `set_color --print-colors` to get default colors
set fish_color_command brcyan
set fish_color_error '#ff6c6b'
