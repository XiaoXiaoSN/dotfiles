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

# case-insensitive matching
shopt -s nocasematch

GITHUB_URL="https://github.com"
DEFAULT_GITHUB_USER="xiaoxiaosn"

trim() {
  local s="$1"
  s="${s#"${s%%[![:space:]]*}"}"
  s="${s%"${s##*[![:space:]]}"}"
  printf '%s\n' "$s"
}

RES=$(trim "$1")
SUB_RES=$(trim "$2")
OPTION=$(trim "$3")

# Handling Repository Sub Resources
# Example:
#     gh magic-box pr close
#     gh dotfiles issue
handle_repository_sub_resources() {
  local url=$1
  local sub=$2
  local opt=$3

  case $sub in
    pr*|pull*)
      url+="/pulls"
      # Matching Option for Pull Request
      case $opt in
        me|my|openMe|meOpen)
          url+="?q=is:open+is:pr+author:${DEFAULT_GITHUB_USER}"
        ;;

        closeMe|meClose|closedMe|meClosed|closedMy|myClosed)
          url+="?q=is:pr+is:closed+author:${DEFAULT_GITHUB_USER}"
        ;;

        open)
          url+="?q=is:open+is:pr"
        ;;

        close|closed)
          url+="?q=is:closed+is:pr"
        ;;
      esac
    ;;

    issue*)
      url+="/issues"
    ;;

    action*)
      url+="/actions"
    ;;

    setting*)
      url+="/settings"
    ;;
  esac

  echo "$url"
}

# Handling PR and Issue Sub Resources
# Example:
#     gh pr close
#     gh issue close
handle_pr_issue_sub_resources() {
  local url=$1
  local sub=$2
  local opt=$3

  case $sub in
    open)
      # Default setting; Do nothing
    ;;

    close|closed)
      url+="?q=is:closed+author:${DEFAULT_GITHUB_USER}"
    ;;

    assign|assigned)
      url+="?q=assignee:${DEFAULT_GITHUB_USER}"
      case $opt in
        close|closed)
          url+="+is:closed"
        ;;
      esac
    ;;

    my|me)
      # same as q=is:open is:pr author:${DEFAULT_GITHUB_USER}
      url+="?q=is:open+author:${DEFAULT_GITHUB_USER}"
    ;;

    rr|review|review-requested)
      url+="?q=is:open+review-requested:${DEFAULT_GITHUB_USER}"
    ;;
  esac

  echo "$url"
}

# load local settings
#
# example
# ```shell
# PRIVATE_REPOS["foo"]="XiaoXiaoSN/dotfiles"
# ```
PRIVATE_REPO_CONFIG="$HOME/.gh_private_repos"
declare -A PRIVATE_REPOS || exit 1

if [[ -f "$PRIVATE_REPO_CONFIG" ]]; then
  # shellcheck source=/dev/null
  source "$PRIVATE_REPO_CONFIG"
fi

# Matching Resource (Repo)
case $RES in
  # Shortcut for GitHub function pages
  search)
    open "$GITHUB_URL/search?q=$SUB_RES"
    exit 0
  ;;

  pr|pull|pulls)
    GITHUB_URL+="/pulls"
    GITHUB_URL=$(handle_pr_issue_sub_resources "$GITHUB_URL" "$SUB_RES" "$OPTION")
  ;;

  issue|issues)
    GITHUB_URL+="/issues"
    GITHUB_URL=$(handle_pr_issue_sub_resources "$GITHUB_URL" "$SUB_RES" "$OPTION")
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
    GITHUB_URL=$(handle_repository_sub_resources "$GITHUB_URL" "$SUB_RES" "$OPTION")
  ;;

  .|dotfile|dotfiles)
    GITHUB_URL+="/XiaoXiaoSN/dotfiles"
    GITHUB_URL=$(handle_repository_sub_resources "$GITHUB_URL" "$SUB_RES" "$OPTION")
  ;;

  *)
    if [[ -n "${PRIVATE_REPOS[$RES]:-}" ]]; then
      GITHUB_URL+="/${PRIVATE_REPOS[$RES]}"
      GITHUB_URL=$(handle_repository_sub_resources "$GITHUB_URL" "$SUB_RES" "$OPTION")
    else
      open "$GITHUB_URL/search?q=$RES"
      echo "No matches \"$RES\". Search it on GitHub..."
      exit 0
    fi
  ;;
esac

# open URL in the default browser
open "$GITHUB_URL"
echo "open $GITHUB_URL"
