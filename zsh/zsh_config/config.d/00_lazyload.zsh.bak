# https://github.com/SukkaW/dotfiles/blob/master/_zshrc/macos.zshrc

# Lazyload Function

## Setup a mock function for lazyload
## Usage:
## 1. Define function "_sukka_lazyload_command_[command name]" that will init the command
## 2. sukka_lazyload_add_command [command name]
## Notes:
## - The first parameter is main command another parameters are derived commands.
##   Once a commands be called, the lazyload function of main command will be trigger
##   and clean all of temporary command functions
sukka_lazyload_add_command() {
  local main_cmd="$1"
  local all_commands=("$@")

  for cmd in "${all_commands[@]}"; do
    eval "$cmd() { \
      for _cmd in "${all_commands[@]}"; do; \
        unfunction \$_cmd; \
      done; \

      _sukka_lazyload_command_$main_cmd; \

      $cmd \$@; \
    }"
  done
}

## Setup autocompletion for lazyload
## Usage:
## 1. Define function "_sukka_lazyload_completion_[command name]" that will init the autocompletion
## 2. sukka_lazyload_add_comp [command name]
sukka_lazyload_add_completion() {
    local comp_name="_sukka_lazyload__compfunc_$1"
    eval "${comp_name}() { \
        compdef -d $1; \
        _sukka_lazyload_completion_$1; \
    }"
    compdef $comp_name $1
}
