# Kubectl
if type -q kubectl
    # Sets the KUBECONFIG environment variable to a dynamic concatentation of everything
    # under ~/.kube/configs/config or ~/.kube/configs/*.conf
    if test -d $HOME/.kube
      export KUBECONFIG=$HOME/.kube/config(find $HOME/.kube -iname "*.config" -or -iname "*.conf" -type f 2>/dev/null | xargs -I % echo -n ":%")
    end
end
