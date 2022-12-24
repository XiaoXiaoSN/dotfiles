# Neovim config

[Neovim](https://github.com/neovim/neovim) is a Vim-fork focused on extensibility and usability.

## Key mappings

First at all. The `<leader>` key is `,` and it is set in `core.global`.

<details>
<summary>
  <h4>📁 File Explorer (nvim-tree)</h4>
</summary>

| Mode | ShortCut    | Description                    |
| ---- | ----------- | ------------------------------ |
| all  | `<leader>b` | Toggle file explorer           |
| all  | `<C-b>`     | Toggle file explorer           |
| all  | `<M-b>`     | Toggle file explorer           |
| all  | `zz`        | Focus current file in explorer |

Commonly used mappings in nvim-tree

| Mode | ShortCut | Description                           |
| ---- | -------- | ------------------------------------- |
| --   | `g?`     | show help                             |
| --   | `o`      | open file                             |
| --   | `<C-v>`  | vsplit file                           |
| --   | `TAB`    | preview file                          |
| --   | `s`      | open in system                        |
| --   | `a`      | create                                |
| --   | `x`      | cut                                   |
| --   | `c`      | copy                                  |
| --   | `p`      | paste                                 |
| --   | `y`      | copy name                             |
| --   | `Y`      | copy path                             |
| --   | `gy`     | copy absolute path                    |
| --   | `r`      | rename file                           |
| --   | `<C-r>`  | full rename file (change directory)   |
| --   | `d`      | remove file                           |
| --   | `R`      | Refresh nvim-tree                     |
| --   | `E`      | expand all                            |
| --   | `W`      | collapse all                          |
| --   | `q`      | quit nvim-tree                        |
| --   | `H`      | toggle dot files (ex: hide/show .git) |
| --   | `I`      | toggle git ignore                     |

</details>

<details>
<summary>
  <h4>📚 Buffer (buferline)</h4>
</summary>

| Mode | ShortCut    | Description                                         |
| ---- | ----------- | --------------------------------------------------- |
| n    | `<leader>k` | cycle next buffer                                   |
| n    | `<leader>l` | cycle next buffer                                   |
| n    | `<leader>j` | cycle prev buffer                                   |
| n    | `<leader>h` | cycle prev buffer                                   |
| n    | `<leader>1` | quick jump to buffer 1, same mappings util number 9 |
| n    | `<leader>2` | quick jump to buffer 2                              |
| n    | `<leader>9` | quick jump to buffer 9                              |
| n    | `gb`        | quick jump to picked buffer                         |
| n    | `<leader>x` | delete current buffer                               |

</details>

## Language Servers

```
npm install -g typescript-language-server typescript
```
