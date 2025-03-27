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
brew install --cask \
  1password \
  brave-browser \
  iterm2

# Install necessary packages binaries
echo "🟢 Install necessary packages binaries"
brew install \
  fish \
  htop \
  neovim \
  tmux

# Install other important GUI Applications
echo "🟢 Install other important GUI Applications"
brew install --cask \
  docker \
  go \
  google-chrome \
  google-cloud-sdk \ # for gcloud CLI
  hiddenbar \
  lens \
  itsycal \
  notion \
  raycast \
  slack \
  openvpn-connect \ # or tunnelblick
  visual-studio-code \

# Install other useful binaries.
echo "🟢 Install other useful binaries"
brew install \
  awscli \
  direnv \
  git-delta \
  gnupg \
  helm \
  httpie \
  iproute2mac \
  jq \
  kind \
  kubectx \
  kustomize \
  mtr \
  ngrok/ngrok/ngrok \
  nmap \
  nvm \
  protobuf \
  ripgrep \
  starship \
  tree \
  yq

# Install some optional funny tools
echo "🟢 Install other useful Applications"
brew install --cask \
  # unsafe app: https://github.com/qishibo/AnotherRedisDesktopManager/issues/820#issuecomment-1069757505
  another-redis-desktop-manager \
  discord \
  postman \
  telegram \
  obsidian \
  wireshark

# Install more recent versions of some macOS tools.
echo "🟢 Install more recent versions of some macOS tools"
brew install \
  curl \
  git

# Install font tools.
echo "🟢 Install font tools"
brew tap xiaoxiaosn/xiaoxiao
brew install font-noto-nerd

# Remove outdated versions from the cellar.
echo "🟢 Remove outdated versions from the cellar"
brew cleanup
