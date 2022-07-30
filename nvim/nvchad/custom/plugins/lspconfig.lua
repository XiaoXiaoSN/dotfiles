local M = {}

M.setup_lsp = function(attach, capabilities)
  local lspconfig = require "lspconfig"

  local servers = {
    "gopls",
    "tsserver",
    "rust_analyzer",
    "html",
    "cssls",
    "jsonls",
    "pyright",
    "yamlls",
    "bashls",
    "dockerls",
  }

  for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
      on_attach = attach,
      capabilities = capabilities
    }
  end
end

return M
