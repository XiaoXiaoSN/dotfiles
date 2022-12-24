## TODO:
- 我想要空格點點 `blankline` https://github.com/lukas-reineke/indent-blankline.nvim
- 還沒針對個別的 LSP 設定
- lua 的空格我希望是 2 格
- Auto format `autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 1000)`
- use MasonInstall instead of LspInstall, press `i` to install

## Version logs
Note: Update NvChad by pressing <leader> + uu

Nvchard is still change:
dc66931 (HEAD -> main, origin/main, origin/HEAD) avoid flooding mason.nvim binaries path

## Key mapping nots
- close buffer + hide terminal buffer

| Mode | ShortCut  | Description                         |
| ---- | --------- | ----------------------------------- |
| n    | <leader>x | close buffer + hide terminal buffer |
| n    | gb        | buffer pick, quick go to buffer     |
