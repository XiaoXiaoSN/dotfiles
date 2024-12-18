local vim = vim

-- reference: https://github.com/neovim/nvim-lspconfig
local present, lspconfig = pcall(require, 'lspconfig')
if not present then
  return
end
-- reference: https://github.com/hrsh7th/cmp-nvim-lsp
local present2, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not present2 then
  return
end

-- Enable diagnostics
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<leader>f', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = true,
  signs = true,
  update_in_insert = true,
})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'rounded',
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

-- NOTE: We will use `rustaceanvim.mason` instead, see `:h rustaceanvim.mason`
-- lspconfig.rust_analyzer.setup({
--   on_attach = on_attach,
--   flags = lsp_flags,
--   capabilities = capabilities,
--   cmd = { 'rustup', 'run', '--install', 'nightly', 'rust-analyzer' },
--   settings = {
--     ['rust-analyzer'] = {
--       cargo = {
--         loadOutDirsFromCheck = true,
--       },
--       procMacro = {
--         enable = true,
--       },
--     },
--   },
-- })
