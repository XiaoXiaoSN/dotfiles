# Golang configurations
if command -q go
  if not set -q GOPATH
    set -x GOPATH (go env GOPATH)
  end
  set -x GOBIN $GOPATH/bin
  fish_add_path $GOPATH/bin $GOROOT/bin
end
