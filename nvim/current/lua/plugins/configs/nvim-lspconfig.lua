-- nvim-lspconfig configuration
-- reference: https://github.com/neovim/nvim-lspconfig

local utils = require('core.utils')
local lspconfig = utils.require('lspconfig')
local cmp_nvim_lsp = utils.require('cmp_nvim_lsp')

-- Enable diagnostics
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<leader>f', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', function()
  vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.E })
end, opts)
vim.keymap.set('n', ']d', function()
  vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.E })
end, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Configure diagnostic display to show LSP source
vim.diagnostic.config({
  virtual_text = {
    source = true,  -- Show LSP source in virtual text
    format = function(diagnostic)
      return string.format("%s [%s]", diagnostic.message, diagnostic.source or "unknown")
    end,
  },
  signs = true,
  update_in_insert = true,
  float = {
    source = true,  -- Show LSP source in floating window
    border = "rounded",
  },
})


-- Start to setup LSP Configurations
local on_attach = require('plugins.share.lsp-keymappings').on_attach

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Setup servers
-- reference: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#gopls
local util = require('lspconfig/util')

-- https://github.com/golang/tools/blob/master/gopls/doc/vim.md#custom-configuration
lspconfig.gopls.setup({
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
  cmd = { 'gopls', 'serve' },
  filetypes = { 'go', 'gomod' },
  root_dir = util.root_pattern('go.work', 'go.mod', '.git'),
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

lspconfig.golangci_lint_ls.setup({
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
})

lspconfig.ts_ls.setup({
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx',
  },
  init_options = {
    hostInfo = 'neovim',
  },
  root_dir = lspconfig.util.root_pattern('package.json', 'tsconfig.json', 'jsconfig.json', '.git'),
})

lspconfig.lua_ls.setup({
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
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
          vim.api.nvim_get_runtime_file('', true),
        },
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
})
