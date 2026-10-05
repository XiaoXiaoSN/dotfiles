#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage: bash macos/brew.sh [install|upgrade|check] [options]

Install the core CLI tools by default, without upgrading installed packages.
Actions apply to the core Brewfile and each explicitly selected profile.

  --desktop   Desktop apps, Docker Desktop and fonts
  --cloud     AWS, Google Cloud and ngrok
  --vpn       OpenVPN Connect
  --optional  Extra CLI tools, secondary apps and diagnostic GUIs
  --all       Include every profile
  -h, --help  Show this help without invoking Homebrew

Examples:
  bash macos/brew.sh
  bash macos/brew.sh --desktop --cloud
  bash macos/brew.sh check --all
  bash macos/brew.sh upgrade --desktop --cloud
USAGE
}

fail() {
  printf 'Error: %s\n' "$*" >&2
  exit 1
}

action=install
case "${1:-}" in
  install|upgrade|check)
    action=$1
    shift
    ;;
esac

desktop=false
cloud=false
vpn=false
optional=false
for arg in "$@"; do
  case "$arg" in
    --desktop) desktop=true ;;
    --cloud) cloud=true ;;
    --vpn) vpn=true ;;
    --optional) optional=true ;;
    --all) desktop=true; cloud=true; vpn=true; optional=true ;;
    -h|--help) usage; exit 0 ;;
    *) fail "Unknown argument: $arg (use --help)" ;;
  esac
done

[[ "$(uname -s)" == Darwin ]] || fail 'This installer is for macOS only.'
command -v brew >/dev/null 2>&1 || fail 'Install Homebrew and add it to PATH first: https://brew.sh/'

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
brewfiles=("$script_dir/Brewfile")
if "$desktop"; then brewfiles+=("$script_dir/Brewfile.desktop"); fi
if "$cloud"; then brewfiles+=("$script_dir/Brewfile.cloud"); fi
if "$vpn"; then brewfiles+=("$script_dir/Brewfile.vpn"); fi
if "$optional"; then brewfiles+=("$script_dir/Brewfile.optional"); fi
for brewfile in "${brewfiles[@]}"; do
  [[ -r "$brewfile" ]] || fail "Cannot read $brewfile"
done

# Never let a partial profile trigger uninstall/cleanup through the environment.
unset HOMEBREW_BUNDLE_INSTALL_CLEANUP
export HOMEBREW_NO_INSTALL_CLEANUP=1
export HOMEBREW_NO_ANALYTICS=1

case "$action" in
  install|check)
    export HOMEBREW_BUNDLE_NO_UPGRADE=1
    export HOMEBREW_NO_INSTALL_UPGRADE=1
    ;;
  upgrade)
    unset HOMEBREW_BUNDLE_NO_UPGRADE HOMEBREW_NO_INSTALL_UPGRADE
    ;;
esac
if [[ "$action" == check ]]; then
  export HOMEBREW_NO_AUTO_UPDATE=1
else
  brew analytics off
  if [[ "$action" == upgrade ]]; then
    brew update
  fi
fi

for brewfile in "${brewfiles[@]}"; do
  printf '%s: %s\n' "$action" "${brewfile##*/}"
  case "$action" in
    install) brew bundle install --file="$brewfile" --no-upgrade ;;
    upgrade) brew bundle upgrade --file="$brewfile" ;;
    check) brew bundle check --file="$brewfile" --no-upgrade --verbose ;;
  esac
done
