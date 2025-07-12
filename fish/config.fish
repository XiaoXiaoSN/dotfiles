set -x LANG en_US.UTF-8
set -x EDITOR nvim

# Aliases
source $HOME/.config/fish/aliases.fish

# Run local setting (Do not need to use git management)
if test -e $HOME/fish-profile.fish
  source $HOME/fish-profile.fish
end

# set fish colors
# run `set_color --print-colors` to get default colors
set fish_color_command brcyan
set fish_color_error '#ff6c6b'

# initial the Starship prompt
# reference: https://github.com/starship/starship/blob/v1.23.0/docs/advanced-config/README.md#transientprompt-and-transientrightprompt-in-fish
function starship_transient_prompt_func
  starship module directory
  starship module character
end
if command -q starship
  starship init fish | source
  enable_transience
end

# # >>> conda initialize >>>
# # !! Contents within this block are managed by 'conda init' !!
# if test -f /opt/homebrew/Caskroom/miniconda/base/bin/conda
#     eval /opt/homebrew/Caskroom/miniconda/base/bin/conda "shell.fish" "hook" $argv | source
# else
#     if test -f "/opt/homebrew/Caskroom/miniconda/base/etc/fish/conf.d/conda.fish"
#         . "/opt/homebrew/Caskroom/miniconda/base/etc/fish/conf.d/conda.fish"
#     else
#         set -x PATH "/opt/homebrew/Caskroom/miniconda/base/bin" $PATH
#     end
# end
# # <<< conda initialize <<<
