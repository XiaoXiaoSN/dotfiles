#!/usr/bin/env bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title gh
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🤖
# @raycast.argument1 { "type": "text", "placeholder": "Res" }
# @raycast.argument2 { "type": "text", "placeholder": "SubRes", "optional": true }
# @raycast.argument3 { "type": "text", "placeholder": "Option", "optional": true }

# Documentation:
# @raycast.description A quick GitHub web launcher
# @raycast.author XiaoXiao
# @raycast.authorURL https://github.com/xiaoxiaosn

# no case match sensitive
shopt -s nocasematch

GITHUB_URL="https://github.com"
DEFAULT_GITHUB_USER="xiaoxiaosn"

RES=$1
SUB_RES=$2
OPTION=$3

# Handling Repository Sub Resources
# Example:
#     gh magic-box pr close
#     gh dotfiles issue
handle_repository_sub_resources() {
  local GITHUB_URL=$1
  local SUB_RES=$2
  local OPTION=$3

  case $SUB_RES in
    pr*|pull*)
      GITHUB_URL+="/pulls"
      # Matching Option for Pull Request
      case $OPTION in
        me|my|openMe|meOpen)
          # same as q=is:open is:pr author:${DEFAULT_GITHUB_USER}
          GITHUB_URL+=${DEFAULT_GITHUB_USER}
        ;;

        closeMe|meClose|closedMe|meClosed|closedMy|myClosed)
          GITHUB_URL+="?q=is:pr is:closed author:${DEFAULT_GITHUB_USER}"
        ;;

        open)
          GITHUB_URL+="?is:pr q=is:open"
        ;;

        close|closed)
          GITHUB_URL+="?is:pr q=is:close"
        ;;
      esac
    ;;

    issue*)
      GITHUB_URL+="/issues"
    ;;

    action*)
      GITHUB_URL+="/actions"
    ;;

    setting*)
      GITHUB_URL+="/settings"
    ;;
  esac

  echo "$GITHUB_URL"
}


# Handling PR and Issue Sub Resources
# Example:
#     gh pr close
#     gh issue close
handle_pr_issue_sub_resources() {
  local GITHUB_URL=$1
  local SUB_RES=$2
  local OPTION=$3

  case $SUB_RES in
    open)
      # Default setting; Do nothing
    ;;

    close|closed)
      GITHUB_URL+="?q=is:closed author:${DEFAULT_GITHUB_USER}"
    ;;

    assign|assigned)
      GITHUB_URL+="?q=assignee:${DEFAULT_GITHUB_USER}"
      case $OPTION in
        close|closed)
          GITHUB_URL+=" is:closed"
        ;;
      esac
    ;;

    my|me)
      # same as q=is:open is:pr author:${DEFAULT_GITHUB_USER}
      GITHUB_URL+="?q=is:open author:${DEFAULT_GITHUB_USER}"
    ;;

    rr|review|review-requested)
      GITHUB_URL+="?q=is:open review-requested:${DEFAULT_GITHUB_USER}"
    ;;
  esac

  echo "$GITHUB_URL"
}

# load local settings
#
# example
# ```shell
# PRIVATE_REPOS["foo"]="https://github.com/XiaoXiaoSN"
# ```
PRIVATE_REPO_CONFIG="$HOME/.gh_private_repos"
if [[ -f "$PRIVATE_REPO_CONFIG" ]]; then
  source "$PRIVATE_REPO_CONFIG"
fi

# Matching Resource (Repo)
case $RES in
  # Shortcut for GitHub function pages
  search)
    open "$GITHUB_URL/search?q=$SUB_RES"
  ;;

  pr|pull|pulls)
    GITHUB_URL+="/pulls"
    GITHUB_URL=$(handle_pr_issue_sub_resources $GITHUB_URL $SUB_RES $OPTION)
  ;;

  issue|issues)
    GITHUB_URL+="/issues"
    GITHUB_URL=$(handle_pr_issue_sub_resources $GITHUB_URL $SUB_RES $OPTION)
  ;;

  notify|notification|notifications)
    GITHUB_URL+="/notifications"
  ;;

  trend*)
    # NOTE: $SUB_RES is the language here. e.g. go, ts, rust...
    # and it's optional
    GITHUB_URL+="/trending/$SUB_RES"
  ;;

  home|open)
    # Pass! Just open the GitHub home page
  ;;

  # Shortcut for GitHub Repositories
  mb|magicbox|magic-box)
    GITHUB_URL+="/XiaoXiaoSN/magic-box"
    GITHUB_URL=$(handle_repository_sub_resources $GITHUB_URL $SUB_RES $OPTION)
  ;;

  .|dotfile|dotfiles)
    GITHUB_URL+="/XiaoXiaoSN/dotfiles"
    GITHUB_URL=$(handle_repository_sub_resources $GITHUB_URL $SUB_RES $OPTION)
  ;;

  *)
    if [[ -n "${PRIVATE_REPOS[$RES]}" ]]; then
      GITHUB_URL="${PRIVATE_REPOS[$RES]}"
    else
      open "$GITHUB_URL/search?q=$RES"
      echo "No matches \"$RES\". Search it on GitHub..."
      exit 0
    fi
  ;;
esac

# Open URL Encoded GitHub link in the default browser
open "$GITHUB_URL"
echo "open $GITHUB_URL"
