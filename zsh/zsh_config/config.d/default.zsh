# binding `bin` folder if it exist
if [ -d "${HOME}/.bin" ]; then
  path+=(${HOME}/.bin)
  export PATH
fi

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

# setup for gpg
# https://stackoverflow.com/a/42265848/6695274
export GPG_TTY=$(tty)

# no Beep on error in ZLE.
setopt NO_BEEP

# allowing the `#` sign comments in interactive zsh commands
setopt interactive_comments

# If a pattern for filename generation has no matches, print an error,
# instead of leaving it unchanged in the argument list.
# This also applies to file expansion of an initial ‘~’ or ‘=’.
# NOTE: It still is a good feature, but I just want the activity of zsh
# to be more like bash.
setopt NOMATCH

# Remove any right prompt from the display when accepting a command line.
# This may be useful with terminals with other cut/paste methods.
# NOTE: We LOST the feature to know when a command was executed :(
setopt TRANSIENT_RPROMPT
