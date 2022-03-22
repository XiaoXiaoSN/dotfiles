# default ls is untouched, except coloring
if type exa >/dev/null 2>&1; then
  alias ls='exa --classify --sort name'
  alias la='exa -la --classify --sort name'
  alias l='ls'
else
  alias ls='ls --color=auto'
  alias la='ls -lA --time-style=long-iso'
  alias l='ls --color=auto'
fi

# Easier navigation: .., ..., ...., ....., ~ and -
alias ..=' cd ..'
alias ...=' cd ..; cd ..; pwd; ls'
alias ....=' cd ..; cd ..; cd ..; pwd; ls'
alias cd..='..'
alias cd...='...'
alias cd....='....'
alias ~="cd ~" # `cd` is probably faster to type though

alias rmrf="rf -rf"

alias grep="grep --color"

alias cls='clear' # Good 'ol Clear Screen command

alias now='date "+%Y-%m-%d %H:%M:%S %z"'

alias ra=ranger

# Enable aliases to be sudo’ed
# http://askubuntu.com/questions/22037/aliases-not-available-when-using-sudo
alias sudo='sudo '
