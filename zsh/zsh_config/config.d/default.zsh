# set default editor
if type nvim >/dev/null 2>&1; then
  export EDITOR='nvim'
  alias vi='nvim'
  alias vim='nvim'
elif type vim >/dev/null 2>&1; then
  export EDITOR='vim'
  alias vi='vim'
elif type vi >/dev/null 2>&1; then
  export EDITOR='vi'
fi

# no Beep on error in ZLE.
setopt NO_BEEP

# allowing the `#` sign comments in interactive zsh commands
setopt interactive_comments
