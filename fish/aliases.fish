alias cls=clear

alias now='date "+%Y-%m-%d %H:%M:%S %z"'
alias uuid=uuidgen
alias uuid-zero='echo -n 00000000-0000-0000-0000-000000000000'

# default ls is untouched, except coloring
if command -q eza
  alias ls='eza --classify --sort name'
  alias ll='eza -l --classify --sort name --git'
  alias la='eza -la --classify --sort name --git'
  alias l='ls'
else if command -q exa
  alias ls='exa --classify --sort name'
  alias ll='exa -l --classify --sort name'
  alias la='exa -la --classify --sort name'
  alias l='ls'
else
  if ls --color=auto >/dev/null 2>&1
    # GNU ls
    alias ls='ls --color=auto'
    alias ll='ls -l --time-style=long-iso'
    alias la='ls -lA --time-style=long-iso'
    alias l='ls --color=auto'
  else
    # BSD ls (macOS)
    alias ls='ls -G'
    alias ll='ls -lG'
    alias la='ls -lAG'
    alias l='ls -G'
  end
end

# for K8s
if command -q kubectl
  alias kc=kubectl
  alias kx=kubectx
  alias kn=kubens
end

# for terraform
if command -q terraform
  alias tf=terraform
  alias tfa=terraform apply
  alias tfp=terraform plan
end

# use NeoVim to replace Vim
if command -q nvim
  alias vim=nvim
  alias vimdiff='nvim -d'
end

# for custom function
alias sht=cht
alias goo=search
alias google=search
