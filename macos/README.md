# macOS Install

## macOS setting
### Install useful staff

1. Install [Homebrew](https://docs.brew.sh/)

   ```bash
   # Install Homebrew
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

   # Turn off analytics Thttps://docs.brew.sh/Analytics
   brew analytics off
   ```

2. Install necessary casks (GUI Application)

   ```bash
   brew install --cask \
   	1password \
   	brave-browser \
   	iterm2
   ```

3. Install other important applications

   ```bash
   brew install --cask \
   	discord \
   	google-chrome \
   	itsycal \
   	notion \
   	postman \
   	slack \
   	telegram \
   	visual-studio-code
   ```

4. Download XiaoXiao dotfiles to setup environment

   ```bash
   mkdir -p $HOME/projects
   cd $HOME/projects

   git clone https://github.com/xiaoxiaosn/dotfiles
   ```

## Setup iTerm2
https://stackoverflow.com/a/23356086/6695274

1. iTerm2 > Preferences > General > Preferences
2. click `Load preferences from a custom folder or URL:`
    and set the value to `$(pwd)/macos/iterm2`

## Install Fonts

```bash
brew tap homebrew/cask-fonts
brew install font-hack
```

## Ref

[awsome macOS setting](https://github.com/mathiasbynens/dotfiles/blob/main/.macos)
[Moskys Preferences in macOS](https://paper.dropbox.com/doc/Moskys-Preferences-in-macOS--Bbfa5TyUBQ2SscGRgh6Q0KZeAg-dG5SIszlLEGT5DkFQv7yu)`