alias cls=clear

alias now='date "+%Y-%m-%d %H:%M:%S %z"'
alias uuid=uuidgen
alias uuid-zero='echo -n 00000000-0000-0000-0000-000000000000'

# default ls is untouched, except coloring
if type -q exa
  alias ls='exa --classify --sort name'
  alias ll='exa -l --classify --sort name'
  alias la='exa -la --classify --sort name'
  alias l='ls'
else
  alias ls='ls --color=auto'
  alias ll='ls -l --time-style=long-iso'
  alias la='ls -lA --time-style=long-iso'
  alias l='ls --color=auto'
end

# for K8s
if type -q kubectl
  alias kc=kubectl
  alias kx=kubectx
  alias kn=kubens
end

# for terraform
if type -q terraform
  alias tf=terraform
  alias tfa=terraform apply
  alias tfp=terraform plan
end

# use NeoVim to replace Vim
if type -q nvim
  alias vim=nvim
end

# for custom function
alias sht=cht
