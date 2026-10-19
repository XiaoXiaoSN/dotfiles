# Vim

Traditional Vim configuration focused on macOS, with Ubuntu compatibility,
using vim-plug. Homebrew Vim is recommended on macOS for native clipboard support.

## Install

macOS:

```sh
brew install vim git curl fzf ripgrep
```

Ubuntu:

```sh
sudo apt update
sudo apt install vim-nox git curl fzf ripgrep
```

For desktop clipboard integration on Ubuntu, install `vim-gtk3` instead of
`vim-nox`. Its clipboard requires an available X display, including XWayland on
Wayland desktops. Builds without clipboard support use Vim's internal registers
for `,c` and `,v`. SSH sessions do not automatically share the local clipboard.

From the repository root, install and link the configuration:

```sh
make vim
```

When Go is installed, vim-go uses `goimports` if available, otherwise `gofmt`.
Run `:GoInstallBinaries` to install the additional Go tools when needed.

## Behavior

- `,c` copies the current line or Visual selection; `,v` pastes.
- Leaving Insert mode saves changed Go, shell, PHP, and Rust files. Read-only and
  special buffers are skipped, and normal save hooks run before and after writing.
- NERDTree hides the `.git` directory while retaining `.gitignore` and `.github`.
- Uppercase command corrections apply to the Ex command, preserving searches and
  command arguments.
- Unmodified buffers reload external changes on focus and buffer entry. There is
  no additional idle polling; unsaved local edits retain Vim's conflict handling.

## Shortcuts shared with Neovim

These use the existing Vim plugins. The leader key is `,`.

| Shortcut          | Action                                   |
| ----------------- | ---------------------------------------- |
| `Ctrl-h/j/k/l`    | Switch split windows in Normal mode      |
| `Esc`             | Clear search highlighting in Normal mode |
| `Ctrl-s`, `Alt-s` | Save in Normal mode                      |
| `,h`, `,j`        | Previous buffer                          |
| `,k`, `,l`        | Next buffer                              |
| `,ff`             | Find files                               |
| `,fg`             | Search file contents with ripgrep        |
| `,fb`             | Find buffers                             |
| `,fh`             | Find help tags                           |
| `,tk`, `,km`      | Find mappings                            |
| `,cm`             | Find Git commits                         |
| `,/`              | Toggle comments on the line or selection |
| `,gs`             | Git status                               |
| `,hp`, `,hr`      | Preview or undo the current Git hunk     |
| `,hb`, `,hd`      | Git blame or diff split                  |

Existing `,fl` / `,fbl` line searches, `,fr` content search, and `,1`–`,0` tab
shortcuts are retained. NERDTree also hides macOS `.DS_Store` files.

In iTerm2, `Alt-s` requires Option to send Esc+; `Ctrl-s` requires terminal flow
control to be disabled (`stty -ixon`). Standard `:w` remains available.

## Verification

After installing the plugins, run from the repository root:

```sh
vim -Nu vim/vimrc -i NONE -n -es -S vim/tests/regression.vim
```

The checks use temporary files and private registers to verify copying, search
and command abbreviations, autosave hooks, repeated sourcing, NERDTree filtering,
and airline integration without changing the desktop clipboard.
When Go is installed, they also verify actual autosave formatting with `gofmt`
while `goimports` and `gopls` are unavailable.
