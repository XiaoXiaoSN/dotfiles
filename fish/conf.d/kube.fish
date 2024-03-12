# Kubectl
if type -q kubectl
    # Sets the KUBECONFIG environment variable to a dynamic concatenation of everything
    # under ~/.kube/configs/config or ~/.kube/configs/*.conf
    if test -d $HOME/.kube
      export KUBECONFIG=$HOME/.kube/config(find $HOME/.kube -iname "*.config" -or -iname "*.conf" -type f 2>/dev/null | xargs -I % echo -n ":%")
    end
end

# krew is the kubectl plugin manager: https://krew.sigs.k8s.io/
if test -d "$HOME/.krew/bin"
  fish_add_path $HOME/.krew/bin
end

# K9s is Kubernetes TUI tool
if type -q k9s
  export K9S_CONFIG_DIR=$HOME/.config/k9s
end

