require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})


local lsp_installer = require "mason-lspconfig"

-- mason-lspconfig uses the `lspconfig` server names in the APIs it exposes - not `mason.nvim` package names
-- https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
-- Include the servers you want to have installed by default below
local servers = {
  "gopls",
  "tsserver",
  "vimls",
  -- rnix,
  "rust_analyzer",
  "html",
  "cssls",
  "jsonls",
  "pyright",
  "yamlls",
  "bashls",
  "dockerls",
  "clangd",
}

-- Start to install LanguageServers
lsp_installer.setup({
  ensure_installed = servers,
})
