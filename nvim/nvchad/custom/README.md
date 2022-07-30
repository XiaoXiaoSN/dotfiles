## TODO:
- 我想要空格點點 `blankline` https://github.com/lukas-reineke/indent-blankline.nvim
- 還沒針對個別的 LSP 設定
- lua 的空格我希望是 2 格
- Auto format `autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 1000)`


Nvchard is still change:
16d5451 (HEAD -> main) Load nvimtree with alpha so ignore_ft_on_setup actually works

## Key mapping nots
- `` close buffer + hide terminal buffer

| Mode | ShortCut    | Description |
| ---- | ----------- | ----------- |
| n    | <leader>x   | close buffer + hide terminal buffer |
| n    | gb          | buffer pick, quick go to buffer |
