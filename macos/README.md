# macOS setup

Install [Homebrew](https://brew.sh/) and follow its instructions to add `brew` to
`PATH`. The installer uses the active Homebrew installation on Intel or Apple
Silicon; it does not install Homebrew, use Rosetta, or change your login shell.

## Install and maintain packages

Run these commands from the repository root. The script also works from another
working directory when invoked using its path.

```bash
# Install only the shared CLI environment. Do not upgrade installed packages.
bash macos/brew.sh

# Add the desktop environment and cloud tools.
bash macos/brew.sh --desktop --cloud

# Include every profile, including VPN and optional tools.
bash macos/brew.sh --all

# Check for missing packages without installing or upgrading anything.
bash macos/brew.sh check --all

# Explicit maintenance: refresh metadata and upgrade the selected environment.
bash macos/brew.sh upgrade --desktop --cloud
```

The core `Brewfile` is always included. Flags are additive and repeatable without
installing a profile twice. Selection is not persisted: pass the desired flags
again for subsequent installs, checks and upgrades.

- Core (default): Fish and its CLI dependencies, editors, Git/GitHub, Go, uv,
  Kubernetes and network diagnostics.
- `--desktop`: Primary apps, Docker Desktop and the custom Noto Nerd font.
- `--cloud`: AWS CLI, Google Cloud CLI and ngrok.
- `--vpn`: OpenVPN Connect.
- `--optional`: DuckDB, dust, grpcurl, hyperfine, websocat, secondary apps, Lens,
  Postman and diagnostic GUIs.

Installation uses `brew bundle install --no-upgrade`. This is not version
pinning: installing missing packages can still require newer dependencies.
Upgrade explicitly runs `brew update` and `brew bundle upgrade` for the selected
Brewfiles; it can also install missing entries. Homebrew still controls cask
compatibility and whether self-updating apps are upgraded.

Install and upgrade preserve the previous analytics opt-out (`brew analytics off`).
Check does not change that setting. The script stops on the first failure. It
never runs `brew upgrade` against the whole machine, `brew cleanup`, `brew bundle cleanup`, or uninstalls unselected
apps. It suppresses install-time cleanup, even when
`HOMEBREW_BUNDLE_INSTALL_CLEANUP` is inherited. Do not run
`brew bundle cleanup --force` against one of these partial Brewfiles: packages
from the other profiles would be considered unlisted.

See [Homebrew Bundle documentation](https://docs.brew.sh/Brew-Bundle-and-Brewfile)
for the upstream install, check and upgrade semantics.

## Package ownership and migration

Homebrew owns the shared macOS CLI packages. `nixpkgs/home.nix` retains the
existing CLI list on Linux but no longer duplicates it on Darwin. Nix-managed
configuration files are unchanged. On a Mac already using Home Manager, run
`bash macos/brew.sh` successfully **before** the next `home-manager switch`.
This installs the replacement commands, including `ranger`, `watch` and `wget`;
`eza` replaces `exa` on macOS. The installer does not run Home Manager or uninstall
Nix itself.

Node continues to use `jorgebucaran/nvm.fish` from `fish/fish_plugins`, not
Homebrew's Bash-oriented `nvm`. Install the Fish plugins with `fisher update`
after linking this repository's Fish configuration. A previously installed Brew
`nvm` is not removed automatically; check whether you still use it from Bash or
Zsh before uninstalling it manually.

Rust stays with `rustup` and each project's `rust-toolchain.toml`; no Brew `rust`
or global toolchain changes are introduced. Python projects and isolated tools
can use `uv`; installing it does not migrate existing environments.

Docker Desktop, Postman and Lens remain available rather than being silently
replaced with Colima, Bruno or another tool. GUI applications, fonts and VPN
clients may have macOS-version, architecture, licence or interactive setup
requirements; `--all` is not a compatibility guarantee for older Macs.

## Prefer Homebrew curl in Fish

Homebrew `curl` is keg-only, so installing it does not automatically override
macOS `curl`. Inspect the current choice with `type -a curl`. To prefer the Brew
version, run this in Fish or add it to your local `~/fish-profile.fish`:

```fish
fish_add_path --path (brew --prefix curl)/bin
```

This is opt-in; the installer does not globally rewrite `PATH` or shell startup
files. See the [curl formula](https://formulae.brew.sh/formula/curl).

## Tests

```bash
python3 -m unittest discover -s macos/tests -v
```

Tests use a mocked `brew` and `uname`; they do not install packages, start
services, change system settings or access the network. Ruby is used to validate
the Brewfile syntax and declarations. CI additionally parses the manifests with
real Homebrew Bundle on macOS, without installing their contents.

## System settings

Review `init.sh` before running it to change macOS settings. Package installation
never invokes this script. Its optional Dock reset is intended only for a new
Mac or a deliberate reset of the Dock:

```bash
# Remove all persistent app icons from the Dock only when explicitly desired.
defaults write com.apple.dock persistent-apps -array
```

To discover settings before customising `init.sh`:

```bash
defaults read > origin
# Adjust macOS settings, then inspect the difference.
defaults read | diff origin -
defaults find mru-spaces
```

## iTerm2

In iTerm2, open Preferences > General > Preferences, enable
`Load preferences from a custom folder or URL:`, and select this repository's
`macos/iterm2` directory. See the [original setup reference](https://stackoverflow.com/a/23356086/6695274).

The custom font is installed by `--desktop`. To install only the font:

```bash
brew tap xiaoxiaosn/xiaoxiao
brew install --cask xiaoxiaosn/xiaoxiao/font-noto-nerd
```

## References

- [macOS settings](https://github.com/mathiasbynens/dotfiles/blob/main/.macos)
- [Mosky Preferences in macOS](https://paper.dropbox.com/doc/Moskys-Preferences-in-macOS--Bbfa5TyUBQ2SscGRgh6Q0KZeAg-dG5SIszlLEGT5DkFQv7yu)
- [David O'Trakoun dotfiles](https://github.com/davidosomething/dotfiles/blob/dev/mac/README.md)
