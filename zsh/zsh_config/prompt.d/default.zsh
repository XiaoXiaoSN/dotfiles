autoload add-zsh-hook

# enable and configure vcs_info
autoload -Uz vcs_info
add-zsh-hook precmd vcs_info
zstyle ':vcs_info:*' enable hg git cvs svn
zstyle ':vcs_info:*' formats '%s|%b|%a|%i|%R|%r|%S|%m'

# my prompt theme
function promptSetup () {
  setopt prompt_subst
  local TERMWIDTH
  (( TERMWIDTH = ${COLUMNS} - 1 ))

  NOCOLOR="%{$terminfo[sgr0]%}"
  # PS1 – Default interaction prompt
  PS1=''; RPS1=''
  # PS2 – Continuation interactive prompt, The default is `>`
  # A very long unix command can be broken down to multiple line by giving \
  # at the end of the line. The default interactive prompt for a multi-line command is $PS2.
  PS2="↷ %_>"; RPS2=''
  # PS3 – The value of this parameter is used as the prompt for the select command
  # The default is `#?`
  PS3="↷ ?#"; RPS3=''
  # PS4 – Used by `set -x` to prefix tracing output. The default is `+`
  PS4="↷ +i>"; RPS3=''

  # prepare vcs info
  VCS_LINE=''
  VCS=$vcs_info_msg_0_
  VCS_TYPE=$VCS[(ws:|:)1]
  VCS_BRANCH=$VCS[(ws:|:)2]
  VCS_CHANGES=''

  # setup the prompt sign
  if [[ $VCS_TYPE != '' ]]; then
    VCS_LINE+=$NOCOLOR
    VCS_LINE+='➜ '
    case $VCS_TYPE in
      'hg')
        VCS_LINE+='☿ '
        VCS_CHANGES=`hg st 2>/dev/null | wc -l`
        ;;
      'git')
        VCS_LINE+='± '
        ;;
      *)
        VCS_LINE+="$VCS_TYPE "
        ;;
    esac
  fi

  if [[ $VCS_BRANCH > 0 ]]; then
    VCS_LINE+="$VCS_BRANCH "
  fi

  if [[ $VCS_CHANGES > 0 ]]; then
    VCS_LINE+="%F{166}%B"
    VCS_LINE+='★ '
    VCS_LINE+="$VCS_CHANGES "
  fi

  if [[ $VCS_PROJECTNAME != "" ]]; then
    VCS_LINE+="($VCS_PROJECTNAME) "
  fi

  # PR_SIGN=$NOCOLOR
  PR_SIGN=""
  PR_SIGN+="%F{cyan}%B"
  PR_SIGN+="%n"
  PR_SIGN+="%F{reset}%B@"

  # prepend the hostname if we are outside
  if [[ "$MYHOSTEXPRESSION" == "" ]]; then
    # if not set, home is nowhere
    MYHOSTEXPRESSION="^$"
  fi
  if [[ "`hostname`" =~ "$MYHOSTEXPRESSION" ]]; then
    # we are on our home desktop
  else
    # we are outside on a server
    PR_SIGN+="%F{green}`hostname`"
  fi

  PR_SIGN+="%F{reset}:%F{reset}%~ "

  # rootshell gets another prompt sign
  CURRENT_USER=`whoami`

  # setup the main sign
  if [[ $CURRENT_USER == 'root' ]]; then
    PR_SIGN+="☠"
  elif [[ $CURRENT_USER == 'vagrant' ]]; then
    PR_SIGN+="𝓥"
  else
    PR_SIGN+="%F{red}➔"
  fi

  PR_SIGN+="%F{reset}%b"

  # http://unix.stackexchange.com/questions/1022/is-it-possible-to-display-stuff-below-the-prompt-at-a-prompt
  terminfo_down_sc=$terminfo[cud1]$terminfo[cuu1]$terminfo[sc]$terminfo[cud1]

  # Finally, the prompt.
  PS1=$'\n'  # newline (specially quotet, see zsh FAQ 3.13)
  PS1+="%{$terminfo_down_sc$VCS_LINE$terminfo[rc]%}"    # the second line
  PS1+=$PR_STITLE         # tmux title if present
  PS1+=$PR_VCSSIGN        # version control part if present
  PS1+=%(?..'%F{136}%B%'?)    # output last error number if present
  PS1+=$PR_SIGN         # the user sign
  PS1+=' '            # an additional space

  # reset the tmux title
  promptSetMultiplexerTabTitle "zsh"
}
add-zsh-hook precmd promptSetup

# set a tmux / screen 'tabulator' title if needed
function promptSetMultiplexerTabTitle () {
  if [[ "$TERM" == "screen" ]]; then
    if [[ "$1" == "" ]]; then
      local CMD=${1[(wr)^(*=*|sudo|-*)]}
      echo -n "\ekttt$CMD\e\\"
    else
      local title="$1 ttt" # I dont know how to prevent errors on one word strings
      title=$title[(w)1]
      echo -n "\ek$title\e\\"
    fi
  fi
}
add-zsh-hook preexec promptSetMultiplexerTabTitle


# remove the line after the prompt on execution
# http://unix.stackexchange.com/questions/1022/is-it-possible-to-display-stuff-below-the-prompt-at-a-prompt
function eraseSecondLine () {
  print -rn -- $terminfo[el];
  #echo; # this would keep the second line
}
add-zsh-hook preexec eraseSecondLine

