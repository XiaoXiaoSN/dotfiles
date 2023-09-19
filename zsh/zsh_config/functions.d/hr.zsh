# ref: https://github.com/LuRsT/hr

# Print a horizontal line
hr() {
  DEFAULT_SYMBOL='-'
  COLS="$(tput cols)"
  if (( COLS <= 0 )) ; then
      COLS="${COLUMNS:-80}"
  fi

  _hr() {
      local WORD="$1"
      local LINE=''

      if [[ -z "$WORD" ]] ; then
          return;
      fi

      printf -v LINE '%*s' "$COLS"
      LINE="${LINE// /${WORD}}"
      echo "${LINE:0:${COLS}}"
  }

  _hrs() {
      local WORD

      for WORD in "${@:-$DEFAULT_SYMBOL}"
      do
          _hr "$WORD"
      done
  }

  _hrs "$@"
}

