alias l="ls --color=auto"
alias ls="ls --color=auto"
alias ll="ls -l"
alias la="ls -al"

alias grep="grep --color"

# Easier navigation: .., ..., ...., ....., ~ and -
alias ..=' cd ..'
alias ...=' cd ..; cd ..; pwd; ls'
alias ....=' cd ..; cd ..; cd ..; pwd; ls'
alias cd..='..'
alias cd...='...'
alias cd....='....'
alias ~="cd ~" # `cd` is probably faster to type though

alias cls='clear' # Good 'ol Clear Screen command

alias now='date "+%Y-%m-%d %H:%M:%S %z"'
