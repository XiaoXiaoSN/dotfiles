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
  itsycal \
  notion \
  slack \
  openvpn-connect \ # or tunnelblick
  visual-studio-code

# Install other useful binaries.
echo "🟢 Install other useful binaries"
brew install \
  awscli \
  kind \
  kubectx \
  gnupg \
  ngrok/ngrok/ngrok \
  nmap \
  tree \
  ripgrep

# Install more recent versions of some macOS tools.
echo "🟢 Install more recent versions of some macOS tools"
brew install curl

# Install font tools.
echo "🟢 Install font tools"
brew tap homebrew/cask-fonts
brew install font-hack

# Remove outdated versions from the cellar.
echo "🟢 Remove outdated versions from the cellar"
brew cleanup
