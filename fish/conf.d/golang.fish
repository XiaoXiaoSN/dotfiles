# Golnag configurations
if type -q go
    set -x GOPATH (go env GOPATH)
    set -x GOBIN $GOPATH/bin
    set -x GO111MODULE on

    fish_add_path $GOPATH/bin $GOROOT/bin
end
