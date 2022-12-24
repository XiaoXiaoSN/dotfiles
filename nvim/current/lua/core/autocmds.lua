local vim = vim
local autocmd = vim.api.nvim_create_autocmd

-- You can automatically close the tab/vim when nvim-tree is the last window in the tab.
-- WARNING: other plugins or automation may interfere with this:
vim.cmd [[
  autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
]]

-- format while saving
autocmd("BufWritePre", {
  pattern = {
    "*.rs",
    "*.c",
    "*.cpp",
    "*.cxx",
    "*.java",
    "*.go",
    "*.lua",
    "*.py",
    "*.ts",
    "*.js",
    "*.css",
    "*.html",
    "*.htm",
    "*.json",
    "*.vim",
  },
  callback = function()
    vim.lsp.buf.formatting_sync(nil, 1000)
  end,
})
