# Fish Shell

## Notes

Before starting, review [fish for bash users](https://fishshell.com/docs/current/fish_for_bash_users.html) for the key differences from `bash`.

## Key Features

### 1. Modern CLI Experience

- **Smart Aliases**: Automatically uses `eza` (or `exa`) for `ls/ll/la` with Git integration.
- **Starship Prompt**: A fast, customizable cross-shell prompt.
- **Zoxide Integration**: Smart `cd` that learns your habits (`z`, `zi`).
- **Direnv**: Automatically load/unload environment variables in directories.

### 2. Powerful Search (fzf.fish)

We use [PatrickF1/fzf.fish](https://github.com/PatrickF1/fzf.fish) for an integrated search experience.

| Feature               | Key Binding                            |
| :-------------------- | :------------------------------------- |
| **Search Directory**  | `Ctrl + T` (default: `Ctrl + Alt + F`) |
| **Search History**    | `Ctrl + R`                             |
| **Search Processes**  | `Ctrl + Alt + P`                       |
| **Search Variables**  | `Ctrl + V`                             |
| **Search Git Log**    | `Ctrl + Alt + L`                       |
| **Search Git Status** | `Ctrl + Alt + S`                       |

### 3. Developer Tooling

- **Cloud/Infra**: Native aliases for `kubectl` (kc, kx, kn) and `terraform` (tf, tfa, tfp).
- **Language Support**: Pre-configured paths for Go, Rust, Haskell, .NET, and Nix.
- **Node.js**: Integrated `nvm` management.
- **Neovim**: `vim` is aliased to `nvim`; `vimdiff` is aliased to `nvim -d`.

### 4. Custom Functions

- **`x [file]`**: Smart extractor for all formats (`.tar.gz`, `.zip`, `.7z`, `.xz`, etc.).
- **`search` / `goo`**: Search the web directly from the terminal.
- **`cht`**: Access [cht.sh](http://cht.sh) for instant programming cheat sheets.
- **`zc` / `zv` / `zopen`**: Quickly jump to directories and open them in an editor/Neovim.
- **`hr`**: Draw a horizontal line across the terminal.

## Installation & Setup

### Prerequisites

Install these via Homebrew (macOS) or apt (Ubuntu):

- **Core**: `fzf`, `fd`, `bat`, `eza`, `starship`, `zoxide`, `direnv`.

### Quick Start

1. Ensure [fisher](https://github.com/jorgebucaran/fisher) is installed.
2. Install/Update plugins:
   ```shell
   fisher update
   ```
3. Restart fish (or open a new terminal) to pick up plugin changes.

## Debugging and Profiling

```shell
fish --profile ~/.config/fish/fish_profile.txt -c exit
sort -nrk 2 ~/.config/fish/fish_profile.txt | head -20
```
