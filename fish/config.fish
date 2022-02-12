export LANG=en_US.UTF-8

# Aliases
source $HOME/.config/fish/aliases.fish

# Golnag configurations (TODO: move to conf.d)
set -x GOPATH $HOME/gocode
set -x GOBIN $GOPATH/bin
set -x GOROOT /usr/local/opt/go/libexec
set PATH $GOPATH/bin $GOROOT/bin $PATH
export GO111MODULE=on

# Rust configurations
set PATH $HOME/.cargo/bin $PATH

# Terraform configurations
set -x TF_PLUGIN_CACHE_DIR $HOME/.terraform.d/plugin-cache
