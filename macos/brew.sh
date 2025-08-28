#!/usr/bin/env bash

# Install command-line tools using Homebrew.
# Install steps: https://brew.sh/

# Turn off analytics https://docs.brew.sh/Analytics
brew analytics off

# Make sure we’re using the latest Homebrew.
brew update
# Upgrade any already-installed formulae.
brew upgrade

# Install necessary casks (GUI Applications)
echo "🟢 Install necessary casks (GUI Applications)"
casks=(
  1password
  brave-browser
  iterm2
)
brew install --cask "${casks[@]}"

# Install necessary packages binaries
echo "🟢 Install necessary packages binaries"
pkgs=(
  fish
  htop
  neovim
  tmux
)
brew install "${pkgs[@]}"

# Install other important GUI Applications
echo "🟢 Install other important GUI Applications"
casks=(
  docker
  go
  google-chrome
  google-cloud-sdk  # for gcloud CLI
  hiddenbar
  lens
  itsycal
  notion
  raycast
  slack
  openvpn-connect  # or tunnelblick
  visual-studio-code
)
brew install --cask "${casks[@]}"

# Install other useful binaries.
echo "🟢 Install other useful binaries"
pkgs=(
  awscli
  direnv
  fx  # Terminal JSON viewer
  git-delta
  gnupg
  helm
  httpie
  iproute2mac
  jq
  kind
  kubectx
  kustomize
  mtr
  ngrok
  nmap
  nvm
  protobuf
  ripgrep
  starship
  tree
  yq
)
brew install "${pkgs[@]}"

# Install some optional funny tools
echo "🟢 Install other useful Applications"
optional_casks=(
  # unsafe app: https://github.com/qishibo/AnotherRedisDesktopManager/issues/820#issuecomment-1069757505
  another-redis-desktop-manager
  discord
  postman
  telegram
  obsidian
  wireshark
)
brew install --cask "${optional_casks[@]}"

# Install more recent versions of some macOS tools.
echo "🟢 Install more recent versions of some macOS tools"
brew install \
  curl \
  git

# Install font tools.
echo "🟢 Install font"
brew tap xiaoxiaosn/xiaoxiao
brew install font-noto-nerd

# Remove outdated versions from the cellar.
echo "🟢 Remove outdated versions from the cellar"
brew cleanup
