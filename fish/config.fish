export LANG=en_US.UTF-8

# Aliases
source $HOME/.config/fish/aliases.fish

# Golnag configurations (TODO: move to conf.d)
set -x GOPATH (go env GOPATH)
set -x GOBIN $GOPATH/bin
set -x GO111MODULE on
set PATH $GOPATH/bin $GOROOT/bin $PATH

# Rust configurations (TODO: move to conf.d)
set PATH $HOME/.cargo/bin $PATH

# Terraform configurations
set -x TF_PLUGIN_CACHE_DIR $HOME/.terraform.d/plugin-cache
