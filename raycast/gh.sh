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
GITHUB_USER="xiaoxiaosn"

RES=$1
SUB_RES=$2
OPTION=$3

# Matching Resource (Repo)
case $RES in
  saffron|core)
    GITHUB_URL+="/fstnetwork/saffron" ;;

  plankton)
    GITHUB_URL+="/fstnetwork/plankton" ;;

  vanilla)
    GITHUB_URL+="/fstnetwork/vanilla" ;;

  notification*)
    GITHUB_URL+="/notifications" ;;

  trend*)
    # NOTE: $SUB_RES is the language here. e.g. go, ts, rust...
    # and it's optional
    GITHUB_URL+="/trending/$SUB_RES"
  ;;

  home|open)
    # Pass! Just open the GitHub home page
  ;;

  *)
    echo "No matches \"$RES\""
    return 0;;
esac

# Matching Sub Resource
case $SUB_RES in
  pr*|pull*)
    GITHUB_URL="${GITHUB_URL}/pulls"
    # Matching Option for Pull Request
    case $OPTION in
      me|my|openMe|meOpen)
        # same as q=is:open is:pr author:${GITHUB_USER}
        GITHUB_URL="${GITHUB_URL}/${GITHUB_USER}" ;;

      closeMe|meClose|closedMe|meClosed|closedMy|myClosed)
        GITHUB_URL="${GITHUB_URL}?q=is%3Apr+is%3Aclosed+author%3A${GITHUB_USER}" ;;

      open)
        GITHUB_URL="${GITHUB_URL}?q=is:open is:pr" ;;

      close|closed)
        GITHUB_URL="${GITHUB_URL}?q=is:close is:pr" ;;
    esac
  ;;

  issue*)
    GITHUB_URL="${GITHUB_URL}/issues" ;;

  action*)
    GITHUB_URL="${GITHUB_URL}/actions" ;;

  setting*)
    GITHUB_URL="${GITHUB_URL}/settings" ;;
esac

# Open URL Encoded GitHub link in the default browser
open "$GITHUB_URL"
echo "open $GITHUB_URL"
