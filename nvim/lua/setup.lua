-- https://github.com/williamboman/nvim-lsp-installer/wiki/Advanced-Configuration#automatically-install-lsp-servers

local lsp_installer = require "nvim-lsp-installer"

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
for _, name in pairs(servers) do
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found and not server:is_installed() then
    print("Installing " .. name)
    server:install()
  end
end

