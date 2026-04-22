if type zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

zc() {
  local target
  if type zoxide >/dev/null 2>&1; then
    target=$(zoxide query "$1")
  else
    target=$(z -e "$1")
  fi

  if [ -n "$target" ]; then
    code "$target"
  fi
}

zv() {
  local target
  if type zoxide >/dev/null 2>&1; then
    target=$(zoxide query "$1")
  else
    target=$(z -e "$1")
  fi

  if [ -n "$target" ]; then
    ${EDITOR:-vim} "$target"
  fi
}

zopen() {
  local target
  if type zoxide >/dev/null 2>&1; then
    target=$(zoxide query "$1")
  else
    target=$(z -e "$1")
  fi

  if [ -n "$target" ]; then
    open "$target"
  fi
}
