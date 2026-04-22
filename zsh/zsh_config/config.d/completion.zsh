# zsh completion system (compinit)
# Load it with cache to speed up startup time
autoload -Uz compinit

# create zsh cache if not exist
[ -d "$ZSH_CACHE" ] || mkdir -p "$ZSH_CACHE"

# use zcompdump in cache directory
if [[ -n "$ZSH_COMPDUMP" ]]; then
  # If the dump file is older than 24 hours, rebuild it
  if [[ -s "$ZSH_COMPDUMP" && (! "$ZSH_COMPDUMP" -nt "$ZSH_CONFIG") ]]; then
    compinit -d "$ZSH_COMPDUMP"
  else
    compinit -C -d "$ZSH_COMPDUMP"
  fi
else
  compinit
fi

# Configuration for completion
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:*:*:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:*:*:*:warnings' format ' %F{red}-- no matches found --%f'
