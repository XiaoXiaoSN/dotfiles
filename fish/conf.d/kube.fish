# Kubectl
if type -q kubectl
    # Sets the KUBECONFIG environment variable to a dynamic concatentation of everything
    # under ~/.kube/configs/config or ~/.kube/configs/*.conf
    if test -d ~/.kube
      export KUBECONFIG=~/.kube/config$(find ~/.kube -iname "*config" -or -iname "*.conf" -type f 2>/dev/null | xargs -I % echo -n ":%")
    end
end
