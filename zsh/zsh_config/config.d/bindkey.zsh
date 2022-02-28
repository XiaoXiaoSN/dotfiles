# use `zle -al` to check all of registered commands in zsh (Zsh Line Edito)
# call `man zshzle` to learn more,
# or documents: https://web.cs.elte.hu/local/texinfo/zsh/zsh_10.html

# support use Option + arrowKey to forward or backward a work
bindkey '^[^[[D' backward-word
bindkey '^[^[[C' forward-word
bindkey '^[[5D' beginning-of-line
bindkey '^[[5C' end-of-line
bindkey '^[[3~' delete-char
bindkey '^?' backward-delete-char

# setup bindkey emacs to allow cursor use C-p, C-n, C-a, C-e to move
# https://stackoverflow.com/a/43087047
bindkey -e
