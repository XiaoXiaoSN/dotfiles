local vim = vim

-- https://github.com/nvim-tree/nvim-tree.lua/wiki/Auto-Close
vim.api.nvim_create_autocmd('QuitPre', {
  callback = function()
    local tree_wins = {}
    local floating_wins = {}
    local wins = vim.api.nvim_list_wins()
    for _, w in ipairs(wins) do
      local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
      if bufname:match('NvimTree_') ~= nil then
        table.insert(tree_wins, w)
      end
      if vim.api.nvim_win_get_config(w).relative ~= '' then
        table.insert(floating_wins, w)
      end
    end
    if 1 == #wins - #floating_wins - #tree_wins then
      -- Should quit, so we close all invalid windows.
      for _, w in ipairs(tree_wins) do
        vim.api.nvim_win_close(w, true)
      end
    end
  end,
})

-- open nvim-tree when vim starts
vim.api.nvim_create_autocmd({ 'VimEnter' }, {
  callback = function(data)
    -- buffer is a directory
    local directory = vim.fn.isdirectory(data.file) == 1
    if directory then
      -- change to the directory
      vim.cmd.cd(data.file)

      -- open the tree
      require('nvim-tree.api').tree.open()
      return
    end

    -- buffer is a real file on the disk
    local real_file = vim.fn.filereadable(data.file) == 1
    -- buffer is a [No Name]
    local no_name = data.file == '' and vim.bo[data.buf].buftype == ''
    if real_file or no_name then
      require('nvim-tree.api').tree.toggle({ focus = false, find_file = true })
      return
    end
  end,
})

-- format while saving
vim.api.nvim_create_autocmd('BufWritePre', {
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
    local home = os.getenv('HOME')
    local excluded_patterns = {
      '/opt/homebrew/Cellar/go',
      home .. '/.rustup/toolchains/',
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
