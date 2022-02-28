export HISTORY_IGNORE="(ls|cd|pwd|exit|cd|mv|rm|now)"

# History Settings (big history for use with many open shells and no dups)
# Different History files for root and standard user
if (( ! EUID )); then
    HISTFILE=$ZSH_CACHE/history_root
else
    HISTFILE=$ZSH_CACHE/history
fi
SAVEHIST=10000    # the default value is 1000
HISTSIZE=10000000 # the default value is 2000

# Documents Here:
# https://zsh.sourceforge.io/Doc/Release/Options.html#History

# If this is set, zsh sessions will append their history list to the history
# file, rather than replace it.
# Thus, multiple parallel zsh sessions will all have the new entries from their
# history lists added to the history file, in the order that they exit.
# The file will still be periodically re-written to trim it when the number of
# lines grows 20% beyond the value specified by $SAVEHIST
# (see also the HIST_SAVE_BY_COPY option).
setopt APPEND_HISTORY

# If a new command line being added to the history list duplicates an older one,
# the older command is removed from the list (even if it is not the previous event).
setopt HIST_IGNORE_ALL_DUPS

# Remove command lines from the history list when the first character on the
# line is a space, or when one of the expanded aliases contains a leading space.
# Note that the command lingers in the internal history until the next command
# is entered before it vanishes, allowing you to briefly reuse or edit the line.
# If you want to make it vanish right away without entering another command,
# type a space and press return.
setopt HIST_IGNORE_SPACE

# Remove superfluous blanks from each command line being added to the history list.
setopt HIST_REDUCE_BLANKS

history_all() { history -E 1 }
