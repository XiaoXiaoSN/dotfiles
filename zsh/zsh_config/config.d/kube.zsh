if type "kubectl" >/dev/null 2>&1; then
  autoload add-zsh-hook

  # Cache kubectl completion to speed up startup
  local KUBECTL_COMPLETION="$ZSH_CACHE/kubectl_completion.zsh"
  if [[ ! -f "$KUBECTL_COMPLETION" ]]; then
    kubectl completion zsh > "$KUBECTL_COMPLETION" 2>/dev/null
  fi
  source "$KUBECTL_COMPLETION"

  # If you have an alias for kubectl, you can extend shell completion to work with that alias
  compdef __start_kubectl k
  compdef __start_kubectl kc

  # Cache for kubeconfig path to avoid frequent disk scans
  LAST_KUBE_MTIME=0

  function set-kubeconfig {
    local kube_dir="$HOME/.kube"
    [ -d "$kube_dir" ] || return

    # Only rescan if the directory modification time has changed
    local current_mtime
    if [[ "$OSTYPE" == "darwin"* ]]; then
      current_mtime=$(stat -f %m "$kube_dir" 2>/dev/null)
    else
      current_mtime=$(stat -c %Y "$kube_dir" 2>/dev/null)
    fi

    if [[ "$current_mtime" != "$LAST_KUBE_MTIME" ]]; then
      local config_files=($(find "$kube_dir" \( -iname "*.config" -or -iname "*.conf" \) -type f 2>/dev/null))
      if [[ ${#config_files} -gt 0 ]]; then
        export KUBECONFIG="$kube_dir/config:$(paste -sd ":" - <<< "${config_files[@]}")"
      else
        export KUBECONFIG="$kube_dir/config"
      fi
      LAST_KUBE_MTIME="$current_mtime"
    fi
  }
  add-zsh-hook precmd set-kubeconfig
fi
