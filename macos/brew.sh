#!/usr/bin/env bash

# Install command-line tools using Homebrew.
# Install steps: https://brew.sh/

# Make sure we’re using the latest Homebrew.
brew update
# Upgrade any already-installed formulae.
brew upgrade

# Install necessary casks (GUI Application)

# Install more recent versions of some macOS tools.
brew install
  openssh \
  curl

# Install GnuPG to enable PGP-signing commits.
brew install gnupg

# Install other useful binaries.
brew install \
  nmap \
  tree \
  ripgrep

# Install font tools.
brew tap homebrew/cask-fonts
brew install font-hack

# Remove outdated versions from the cellar.
brew cleanup
