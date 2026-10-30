-- reference: https://github.com/nvim-tree/nvim-tree.lua/wiki/Auto-Close
vim.api.nvim_create_autocmd('QuitPre', {
  callback = function()
    if vim.bo.filetype == 'NvimTree' then
      return
    end
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

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspMappings', { clear = true }),
  callback = function(data)
    require('plugins.share.lsp-keymappings').on_attach(vim.lsp.get_client_by_id(data.data.client_id), data.buf)
  end,
})

local go_source_root
local rust_toolchains = (vim.env.RUSTUP_HOME or vim.fn.expand('~/.rustup')) .. '/toolchains'
rust_toolchains = vim.uv.fs_realpath(rust_toolchains) or rust_toolchains

-- finish formatting before writing the buffer to disk
vim.api.nvim_create_autocmd('BufWritePre', {
  group = vim.api.nvim_create_augroup('UserFormatOnSave', { clear = true }),
  callback = function(data)
    if vim.bo[data.buf].buftype ~= '' then
      return
    end
    -- resolve Go's toolchain once, on the first Go save rather than at startup
    if go_source_root == nil and vim.bo[data.buf].filetype:match('^go') then
      go_source_root = ''
      if vim.fn.executable('go') == 1 then
        local result = vim.system({ 'go', 'env', 'GOROOT' }, { text = true }):wait(1000)
        if result.code == 0 then
          local source_path = vim.trim(result.stdout) .. '/src'
          go_source_root = vim.uv.fs_realpath(source_path) or source_path
        end
      end
    end

    local filepath = vim.api.nvim_buf_get_name(data.buf)
    filepath = vim.uv.fs_realpath(filepath) or filepath
    if
      vim.startswith(filepath, rust_toolchains .. '/')
      or (go_source_root and go_source_root ~= '' and vim.startswith(filepath, go_source_root .. '/'))
    then
      return
    end

    require('core.formatting').format(data.buf)
  end,
})

-- reload externally changed files when focus is gained or the cursor is idle
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold' }, {
  command = 'checktime',
})
