#!/usr/bin/env fish

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title List Used Ports
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon 🛠️

# Documentation:
# @raycast.author XiaoXiaoSN
# @raycast.authorURL https://github.com/XiaoXiaoSN

# Set color variables using ANSI escape sequences
set set_color_yellow (set_color -o yellow)
set set_color_grey (printf '\033[90m')   # Grey for USER column
set set_bold (printf '\033[1m')          # Bold for COMMAND column
set reset_color (printf '\033[0m')

# Output used TCP ports on macOS with colored headers
echo "Used TCP Ports:"
echo ""

# Print headers in bold yellow
printf "%s%-15s %-7s %-8s %-4s %-6s %s%s\n" $set_color_yellow "COMMAND" "PID" "USER" "NODE" "TYPE" "NAME" $reset_color

# Print the actual listening ports
lsof -i -P -n \
  | grep LISTEN \
  | sort -k5 \
  | awk \
    -v grey="$set_color_grey" \
    -v bold="$set_bold" \
    -v reset="$reset_color" \
    '{printf "%s%-15s%s %-7s %s%-8s%s %-4s %-6s %s\n", bold, $1, reset, $2, grey, $3, reset, $8, $5, $9}' \
  | uniq
