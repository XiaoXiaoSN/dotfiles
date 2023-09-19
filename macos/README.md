# Setup macOS

## Install Useful Staff and Setup System

### Install [Homebrew](https://docs.brew.sh/)

Check `brew.sh` and select which tools you want to install or don't want to install

```bash
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install tools and applications
./brew.sh
```

### Setup macOS System

Run `init.sh` to setup your macOS environment.

There is a optional line that clean all apps on Dock

```bash
# Wipe all (default) app icons from the Dock
# This is only really useful when setting up a new Mac, or if you don’t use
# the Dock to launch apps.
defaults write com.apple.dock persistent-apps -array
```

## Setup iTerm2

https://stackoverflow.com/a/23356086/6695274

1. iTerm2 > Preferences > General > Preferences
2. click `Load preferences from a custom folder or URL:`
   and set the value to `$(pwd)/macos/iterm2`

## Install Fonts

```bash
brew tap xiaoxiaosn/xiaoxiao
brew install font-noto-nerd
```

## Ref

[awesome macOS setting](https://github.com/mathiasbynens/dotfiles/blob/main/.macos)
[Mosky Preferences in macOS](https://paper.dropbox.com/doc/Moskys-Preferences-in-macOS--Bbfa5TyUBQ2SscGRgh6Q0KZeAg-dG5SIszlLEGT5DkFQv7yu)
[David O'Trakoun dotfiles](https://github.com/davidosomething/dotfiles/blob/dev/mac/README.md)
