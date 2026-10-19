# Golnag configurations
if type "go" >/dev/null 2>&1; then
  if [[ -z "$GOPATH" ]]; then
    export GOPATH=$(go env GOPATH)
  fi
  export GOBIN=$GOPATH/bin
  export GO111MODULE=on

  path+=("${(@)^${(s.:.)GOPATH}}/bin")
  [[ -n "$GOROOT" ]] && path+=("$GOROOT/bin")
  export PATH
fi
