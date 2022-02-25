# Golnag configurations
set -x GOPATH (go env GOPATH)
set -x GOBIN $GOPATH/bin
set -x GO111MODULE on
set PATH $GOPATH/bin $GOROOT/bin $PATH
