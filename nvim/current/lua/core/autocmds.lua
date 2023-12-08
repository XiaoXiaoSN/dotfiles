local vim = vim
local autocmd = vim.api.nvim_create_autocmd

-- You can automatically close the tab/vim when nvim-tree is the last window in the tab.
-- WARNING: other plugins or automation may interfere with this:
vim.cmd([[
  autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
]])

-- format while saving
autocmd('BufWritePre', {
  pattern = {
    '*.rs',
    '*.c',
    '*.cpp',
    '*.cxx',
    '*.java',
    -- '*.go', -- it's provided by `go-vim`
    '*.lua',
    '*.py',
    '*.ts',
    '*.js',
    '*.css',
    '*.html',
    '*.htm',
    '*.json',
    '*.vim',
  },
  callback = function()
    -- exclude some paths that don't need formatting
    local home = os.getenv("HOME")
    local excluded_patterns = {
      '/opt/homebrew/Cellar/go',
      home .. '/.rustup/toolchains/'
    }
    local filepath = vim.fn.expand('%:p')
    for _, pattern in ipairs(excluded_patterns) do
      if string.find(filepath, pattern) then
        return
      end
    end

    -- https://neovim.io/doc/user/lsp.html#vim.lsp.buf.format()
    vim.lsp.buf.format({
      timeout_ms = 1000,
      async = true,
    })
  end,
})
