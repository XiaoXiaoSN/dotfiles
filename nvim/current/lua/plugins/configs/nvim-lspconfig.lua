-- nvim-lspconfig configuration
-- reference: https://github.com/neovim/nvim-lspconfig

local utils = require('core.utils')
local cmp_nvim_lsp = utils.require('cmp_nvim_lsp')

-- Enable diagnostics
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<leader>f', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', function()
  vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR, float = true })
end, opts)
vim.keymap.set('n', ']d', function()
  vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR, float = true })
end, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Configure diagnostic display to show LSP source
vim.diagnostic.config({
  virtual_text = {
    source = true,
  },
  signs = true,
  update_in_insert = true,
  float = {
    source = true,
    border = 'rounded',
  },
})

-- share completion capabilities across Mason-managed servers and local configurations
vim.lsp.config('*', {
  capabilities = cmp_nvim_lsp.default_capabilities(),
})

-- https://github.com/golang/tools/blob/master/gopls/doc/vim.md#custom-configuration
vim.lsp.config('gopls', {
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      gofumpt = true,
      staticcheck = true,
    },
  },
})

vim.lsp.config('ts_ls', {
  root_dir = function(bufnr, on_dir)
    on_dir(vim.fs.root(bufnr, { 'package.json', 'tsconfig.json', 'jsconfig.json', '.git' }))
  end,
})

vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = {
          vim.env.VIMRUNTIME,
          '${3rd}/luv/library',
          '${3rd}/vim/library',
        },
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
})
