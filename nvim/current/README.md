# Neovim Configuration

[Neovim](https://github.com/neovim/neovim) is a Vim-fork focused on extensibility and usability.

### Getting Started

macOS is the primary environment; Ubuntu uses the same configuration with the
platform dependencies below.

Requires Neovim **0.11.3 or newer** (tested with 0.11.5), Git, `curl`, `unzip`,
`ripgrep`, a C compiler and Tree-sitter CLI for parsers, and Node.js **22 or newer** for
Copilot and JavaScript-based language servers. Language tools must be on `PATH`.

On macOS:

```sh
brew install neovim git ripgrep fd node
```

On Ubuntu:

```sh
sudo apt update
sudo apt install git curl unzip build-essential ripgrep fd-find python3-venv
```

Install a recent Neovim from the [official Linux archives](https://github.com/neovim/neovim/blob/master/INSTALL.md#linux)
if Ubuntu's package is below 0.11.3. Choose the archive for your CPU (`x86_64` or
`arm64`). Install Node.js separately and check `nvim --version` and `node --version`.
Telescope supports Ubuntu's `fdfind` executable; no `fd` alias is required.

Install the Tree-sitter CLI after Node.js (needed to generate the Swift parser):

```sh
npm install -g tree-sitter-cli@0.25.8
```

From the repository root, with no existing `nvim` directory at the destination:

```sh
mkdir -p "${XDG_CONFIG_HOME:-$HOME/.config}"
ln -s "$PWD/nvim/current" "${XDG_CONFIG_HOME:-$HOME/.config}/nvim"

# install plugins and language servers
nvim +Lazy
nvim +Mason
```

The kaomoji source uses `~/projects/lua/cmp-kaomoji` when that development checkout
exists, and otherwise installs the GitHub version pinned in `lazy-lock.json`.
An existing `~/.vim/undodir` is retained so previous undo history remains available.
New installations use Neovim's `stdpath('state')/undo` directory, which is created
automatically. No additional locale needs to be generated.

System clipboard integration is enabled when Neovim finds a provider: macOS uses
`pbcopy`/`pbpaste`; Ubuntu desktops need `wl-clipboard` on Wayland or `xclip`/`xsel`
on X11. A headless Ubuntu session can edit files without a clipboard provider.
See [Neovim's clipboard providers](https://neovim.io/doc/user/provider.html#clipboard).
Select a Nerd Font in your terminal for plugin icons; `guifont` only affects GUIs.

Install Go for Go tooling, and Rust with `rust-analyzer` and `rustfmt` for Rust.
The none-ls formatters also need their executables: `prettier`, `goimports`,
`stylua`, `clang-format`, and `black`. Install them with Mason or their respective
toolchains; missing tools can be diagnosed with `:checkhealth` and `:NullLsInfo`.

A reference sheet for [Vim tips](vim-tips.md) records some basic commands.

## Key Mappings

First of all. The `<leader>` key is `,` and it is customized in `core.global`.

<details>
<summary> <b>🐾 Common</b> </summary>

| Mode | ShortCut    | Description          |
| :--: | ----------- | -------------------- |
|  n   | `<leader>/` | comment current line |
|  x   | `<leader>/` | comment select lines |
|  n   | `<C-s>`     | write file           |

</details>

<details>
<summary> <b>📁 File Explorer (nvim-tree)</b> </summary>

| Mode | ShortCut    | Description                      |
| :--: | ----------- | -------------------------------- |
| all  | `<leader>e` | Toggle file explorer             |
| all  | `<C-b>`     | Toggle file explorer             |
| all  | `<M-b>`     | Toggle file explorer             |
| all  | `zz`        | Focus current file in explorer   |
| all  | `C`         | Toggle Git clean (changed files) |
| all  | `I`         | Toggle Git ignore                |

Commonly used mappings in nvim-tree

| Mode | ShortCut | Description                           |
| :--: | -------- | ------------------------------------- |
|  --  | `g?`     | show help                             |
|  --  | `o`      | open file                             |
|  --  | `<C-v>`  | vsplit file                           |
|  --  | `TAB`    | preview file                          |
|  --  | `s`      | open in system                        |
|  --  | `a`      | create                                |
|  --  | `x`      | cut                                   |
|  --  | `c`      | copy                                  |
|  --  | `p`      | paste                                 |
|  --  | `y`      | copy name                             |
|  --  | `Y`      | copy path                             |
|  --  | `gy`     | copy absolute path                    |
|  --  | `r`      | rename file                           |
|  --  | `<C-r>`  | full rename file (change directory)   |
|  --  | `d`      | remove file                           |
|  --  | `R`      | Refresh nvim-tree                     |
|  --  | `E`      | expand all                            |
|  --  | `W`      | collapse all                          |
|  --  | `q`      | quit nvim-tree                        |
|  --  | `H`      | toggle dot files (ex: hide/show .git) |
|  --  | `I`      | toggle git ignore                     |

</details>

<details>
<summary> <b>📚 Buffer (buferline)</b> </summary>

| Mode | ShortCut    | Description                                         |
| :--: | ----------- | --------------------------------------------------- |
|  n   | `<leader>k` | cycle next buffer                                   |
|  n   | `<leader>l` | cycle next buffer                                   |
|  n   | `<leader>j` | cycle prev buffer                                   |
|  n   | `<leader>h` | cycle prev buffer                                   |
|  n   | `<leader>1` | quick jump to buffer 1, same mappings util number 9 |
|  n   | `<leader>2` | quick jump to buffer 2                              |
|  n   | `<leader>9` | quick jump to buffer 9                              |
|  n   | `gb`        | quick jump to picked buffer                         |
|  n   | `<leader>x` | delete current buffer                               |

</details>

<details>
<summary> <b>🔍 Finder (Telescope)</b> </summary>

| Mode | ShortCut     | Description       |
| :--: | ------------ | ----------------- |
|  n   | `<leader>ff` | find files        |
|  n   | `<leader>fl` | live grep (alias) |
|  n   | `<leader>fg` | live grep         |
|  n   | `<leader>fb` | find buffers      |
|  n   | `<leader>fh` | find help tags    |
|  n   | `<leader>tk` | show key mappings |
|  n   | `<leader>cm` | show git commits  |
|  n   | `<leader>gs` | show git status   |

</details>

<details>
<summary> <b>🛠 Language Servers (nvim-lspconfig)</b> </summary>

| Mode | ShortCut    | Description       |
| :--: | ----------- | ----------------- |
|  n   | `gD`        | go declaration    |
|  n   | `gd`        | go definition     |
|  n   | `gh`        | show hover hint   |
|  n   | `K`         | show hover hint   |
|  n   | `gi`        | go implementation |
|  n   | `<space>k`  | signature help    |
|  n   | `gr`        | go references     |
|  n   | `<space>rn` | rename symbol     |
|  n   | `F2`        | rename symbol     |
|  n   | `<leader>a` | code action       |
|  n   | `<space>ca` | code action       |
|  n   | `<space>f`  | run format async  |

| Mode | ShortCut    | Description           |
| :--: | ----------- | --------------------- |
|  n   | `<space>e`  | open float diagnostic |
|  n   | `<leader>f` | open float diagnostic |

</details>

<details>
<summary> <b>🖥️ Terminal</b> </summary>

| Mode | ShortCut     | Description        |
| :--: | ------------ | ------------------ |
| n, i | `<C-t>`      | toggle terminal    |
|  t   | `<Esc><Esc>` | exit terminal mode |

</details>

<details>
<summary> <b>🐱 Other Stuff</b> </summary>

| Mode | ShortCut     | Description                        |
| :--: | ------------ | ---------------------------------- |
|  n   | `<leader>tb` | Git toggle line blame              |
|  n   | `<leader>hd` | Git diff for current file          |
|  n   | `<leader>hp` | Preview hunk (a block of changes?) |
|  n   | `<leader>hr` | Reset hunk                         |

</details>

## Language Servers

Mason enables installed language servers through Neovim's native `vim.lsp.config()` /
`vim.lsp.enable()` APIs. Rust is managed by rustaceanvim. Common LSP key mappings
are installed on `LspAttach`; `<C-h/j/k/l>` always remain window navigation keys.

Normal file buffers are formatted synchronously before saving. The shared formatter
prefers none-ls when it has an available formatter, otherwise it uses one attached
language server that supports formatting. Buffers without a formatter are skipped.
Manual formatting with `<space>f` uses the same selection and runs asynchronously.
Go's separate vim-go format-on-save hook is disabled to avoid formatting twice.
Sources under `GOROOT/src` and Rust toolchains (`RUSTUP_HOME` is respected) are
excluded from automatic formatting on both platforms.

### Installation with Mason

We can use `:Mason` to help us install them.

```
nvim +Mason
```

### Manual Installation

Or, install them manually

Rust

```
rustup component add rust-analyzer rustfmt
```

Go

```
go install golang.org/x/tools/gopls@latest
go install mvdan.cc/gofumpt@latest
go install github.com/nametake/golangci-lint-langserver@latest
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
```

TypeScript

The configured `ts_ls` uses the JavaScript `tsserver` supplied by TypeScript 5.x.

```
npm install -g typescript-language-server typescript@5
```

Lua

```
# formatting
cargo install stylua
```
