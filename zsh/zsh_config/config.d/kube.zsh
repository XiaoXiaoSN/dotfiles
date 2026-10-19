if type "kubectl" >/dev/null 2>&1; then
  autoload add-zsh-hook
  zmodload zsh/stat

  # Cache kubectl completion to speed up startup
  local KUBECTL_COMPLETION="$ZSH_CACHE/kubectl_completion.zsh"
  if [[ ! -f "$KUBECTL_COMPLETION" ]]; then
    kubectl completion zsh > "$KUBECTL_COMPLETION" 2>/dev/null
  fi
  source "$KUBECTL_COMPLETION"

  # If you have an alias for kubectl, you can extend shell completion to work with that alias
  compdef k=kubectl kc=kubectl

  LAST_KUBE_MTIME=''

  function set-kubeconfig {
    local kube_dir="$HOME/.kube"
    [ -d "$kube_dir" ] || return

    # keep the directory cache without spawning stat on every prompt
    local -a kube_mtime
    zstat -A kube_mtime +mtime "$kube_dir" || return
    [[ "$kube_mtime[1]" == "$LAST_KUBE_MTIME" ]] && return 0

    local -a config_files=("$kube_dir/config" "$kube_dir"/**/(#i)*.(config|conf)(N.D))
    export KUBECONFIG="${(j.:.)config_files}"
    LAST_KUBE_MTIME="$kube_mtime[1]"
  }
  add-zsh-hook precmd set-kubeconfig
fi
