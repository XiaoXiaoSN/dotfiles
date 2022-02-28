export HISTORY_IGNORE="(ls|cd|pwd|exit|cd|mv|rm|now)"

# if (( ! EUID )); then
#     HISTFILE="$ZSH_CACHE/history_root"
# else
#     HISTFILE="$ZSH_CACHE/history"
# fi
#
# SAVEHIST=10000
# HISTSIZE=10000000
# export HISTORY_IGNORE="(ls|cd|pwd|exit|cd|mv|rm|now)"
#
# # same as HIST_EXPAND
# setopt BANG_HIST
#
# setopt HIST_FCNTL_LOCK
# setopt HIST_IGNORE_ALL_DUPS
# setopt HIST_IGNORE_SPACE
# setopt HIST_NO_STORE
# setopt HIST_REDUCE_BLANKS
#
# # INC_APPEND_HISTORY + EXTENDED_HISTORY
# setopt SHARE_HISTORY
#
# history_all() { history -E 1}
