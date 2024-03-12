# Neovim Configuration

[Neovim](https://github.com/neovim/neovim) is a Vim-fork focused on extensibility and usability.

### Getting Started

```bash
# Link the config to `$HOME/.config/nvim` (or just copy it!)
ln -sh ./nvim/current $HOME/.config/nvim

# Install plugins and langue servers
nvim +MasonInstallAll
```

There is a [Vim tips](nvim/current/vim-tips.md) to record some basic commands.

## Key Mappings

First at all. The `<leader>` key is `,` and it is set in `core.global`.

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

| Mode | ShortCut    | Description                    |
| :--: | ----------- | ------------------------------ |
| all  | `<leader>b` | Toggle file explorer           |
| all  | `<C-b>`     | Toggle file explorer           |
| all  | `<M-b>`     | Toggle file explorer           |
| all  | `zz`        | Focus current file in explorer |

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
|  n   | `<leader>fl` | find line         |
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
|  n   | `gr`        | go references     |
|  n   | `<space>rn` | rename symbol     |
|  n   | `F2`        | rename symbol     |
|  n   | `<space>ca` | code action       |
|  n   | `<space>f`  | run format async  |

| Mode | ShortCut    | Description           |
| :--: | ----------- | --------------------- |
|  n   | `<space>e`  | open float diagnostic |
|  n   | `<leader>f` | open float diagnostic |

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

### Automatically Install

We can use `:Mason` to help us install them.

```
nvim +MasonInstallAll
```

### Manually Install

Or, install them manually

Rust

```
rustup +nightly component add rust-analyzer-preview
```

Go

```
go install golang.org/x/tools/gopls@latest
go install mvdan.cc/gofumpt@latest
go install github.com/nametake/golangci-lint-langserver@latest
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
```

TypeScript

```
npm install -g typescript-language-server typescript
```

Lua

```
# formatting
cargo install stylua
```
