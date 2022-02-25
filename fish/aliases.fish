alias l=ls
alias cls=clear

alias now='date "+%Y-%m-%d %H:%M:%S %z"'

# for K8s
if type -q kubectl
  alias kc=kubectl
  alias kx=kubectx
  kubectl completion fish | source
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

