# Executed before each prompt. Learn more from documents 9.3.1 Hook Functions
# https://zsh.sourceforge.io/Doc/Release/Functions.html
autoload add-zsh-hook

# enable and configure vcs_info
autoload -Uz vcs_info
# prepare version control system information
add-zsh-hook precmd vcs_info

# learn more from documents 26.5.2 Configuration
# https://zsh.sourceforge.io/Doc/Release/User-Contributions.html#vcs_005finfo-Configuration
# git:
#   %s => The current version control system, like `git`, `svn`
#   %b => The current branch, like `master`, `main`
#   %a => The current action (rebase/merge). Only makes sense in mode `actionformats`
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' formats "%b%a "

# Prepare readable color setting
local START_BOLD_RED="%F{red}%B"
local START_BOLD_GREEN="%F{green}%B"
local START_BOLD_CYAN="%F{cyan}%B"
local START_RED="%F{red}"
local END_BOLD_COLOR="%b%f"
local END_COLOR="%f"
local END_BOLD="%b"

zstyle ':vcs_info:git*+set-message:*' hooks git-is-dirty
+vi-git-is-dirty(){
  # update branch in hook commisc dict
  if [[ -n $(git status -s --ignore-submodules=dirty 2> /dev/null) ]]; then
    hook_com[branch]="${START_BOLD_RED}[$hook_com[branch]]×$END_BOLD_COLOR"
  else
    hook_com[branch]="${START_BOLD_GREEN}[$hook_com[branch]]$END_BOLD_COLOR"
  fi
}

# Setup the prompt theme
#
# Prompt parameters
# https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html#Shell-state
# %F => The color dicT
# %f => reset color
# %B => Start boldface mode.
# %b => Stop boldface mode.
# %~ => current path
# %c => current dir
# %* => time
# %n => username
# %m => shortname host
function precmd_prompt_setup () {
  local NOCOLOR="%{$terminfo[sgr0]%}"

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

  # Prepare sign
  if [[ ! $THEME_GODFATHER_PROMPT_SIGN ]]; then
    local THEME_GODFATHER_PROMPT_SIGN="$"
  fi

  # Setup current user
  PS1+=$NOCOLOR
  PS1+="$START_BOLD_GREEN%n@%m$END_BOLD_COLOR: "

  # Setup current dir
  PS1+="$START_BOLD_CYAN%c$END_BOLD_COLOR "

  # Setup version control
  PS1+=$vcs_info_msg_0_

  # Setup return code if not zero
  RETURN_CODE="%(?.."$START_RED%"?$END_COLOR )"

  if [[ $THEME_GODFATHER_PROMPT_RETURN_CODE_LEFT ]]; then
    PS1+="$RETURN_CODE"
  fi
  PS1+="$THEME_GODFATHER_PROMPT_SIGN "

  # Setup right side prompt
  RPROMPT="[%*]"
  if [[ ! $THEME_GODFATHER_PROMPT_RETURN_CODE_LEFT ]]; then
    RPROMPT="${RETURN_CODE}[%*]"
  fi
}
add-zsh-hook precmd precmd_prompt_setup
