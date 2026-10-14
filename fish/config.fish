# The following lines were added by Docker Desktop to add commands to your PATH.
export PATH="$PATH:$HOME/.docker/bin"
# End of Docker Desktop section.

set -gx LANG en_US.UTF-8
set -gx EDITOR nvim

# Aliases
source $__fish_config_dir/aliases.fish

# Run local setting (Do not need to use git management)
if test -e $HOME/fish-profile.fish
  source $HOME/fish-profile.fish
end

# set fish colors
# run `set_color --print-colors` to get default colors
set fish_color_command brcyan
set fish_color_error '#ff6c6b'

# initial the Starship prompt
# reference: https://starship.rs/advanced-config/#transientprompt-and-transientrightprompt-in-fish
function starship_transient_prompt_func
  starship module directory
  starship module character
end
if command -q starship
  starship init fish | source
  enable_transience
end

# fzf.fish key bindings
fzf_configure_bindings --directory=\ct

# Added by Antigravity IDE
fish_add_path $HOME/.antigravity-ide/antigravity-ide/bin

# >>> grok installer >>>
fish_add_path $HOME/.grok/bin
# <<< grok installer <<<

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish
