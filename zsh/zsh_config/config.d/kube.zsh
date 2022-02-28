autoload add-zsh-hook
autoload -Uz compinit
compinit

# Prepare auto complete
source <(kubectl completion zsh)

# If you have an alias for kubectl, you can extend shell completion to work with that alias
compdef __start_kubectl k
compdef __start_kubectl kc

function set-kubeconfig {
  # Sets the KUBECONFIG environment variable to a dynamic concatentation of everything
  # under ~/.kube/configs/config or ~/.kube/configs/*.conf
  if [ -d ~/.kube ]; then
    export KUBECONFIG=~/.kube/config$(find ~/.kube -iname "*config" -or -iname "*.conf" -type f 2>/dev/null | xargs -I % echo -n ":%")
  fi
}
add-zsh-hook precmd set-kubeconfig