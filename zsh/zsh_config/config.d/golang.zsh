# Golnag configurations
if type "go" >/dev/null 2>&1; then
  export GOPATH=$(go env GOPATH)
  export GOBIN=$GOPATH/bin
  export GO111MODULE=on

  path+=($GOPATH/bin $GOROOT/bin)
  export PATH
fi
