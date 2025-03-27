local vim = vim

local present, mason = pcall(require, 'mason')
if not present then
  return
end
local present2, mason_lspconfig = pcall(require, 'mason-lspconfig')
if not present2 then
  return
end

local options = {
  -- Where Mason should put its bin location in your PATH. Can be one of:
  -- - 'prepend' (default, Mason's bin location is put first in PATH)
  -- - 'append' (Mason's bin location is put at the end of PATH)
  -- - 'skip' (doesn't modify PATH)
  ---@type ''prepend'' | ''append'' | ''skip''
  PATH = 'skip',

  ui = {
    icons = {
      -- The list icon to use for packages that are installing, or queued for installation.
      package_pending = ' ',
      -- The list icon to use for installed packages.
      package_installed = '✓',
      -- The list icon to use for packages that are not installed.
      package_uninstalled = '✗',
    },

    keymaps = {
      -- Keymap to expand a package
      toggle_server_expand = '<CR>',
      -- Keymap to install the package under the current cursor position
      install_server = 'i',
      -- Keymap to reinstall/update the package under the current cursor position
      update_server = 'u',
      -- Keymap to check for new version for the package under the current cursor position
      check_package_version = 'c',
      -- Keymap to update all installed packages
      update_all_packages = 'U',
      -- Keymap to check which installed packages are outdated
      check_outdated_packages = 'C',
      -- Keymap to uninstall a package
      uninstall_package = 'X',
      -- Keymap to cancel a package installation
      cancel_installation = '<C-c>',
      -- Keymap to apply language filter
      apply_language_filter = '<C-f>',
    },
  },

  -- Limit for the maximum amount of packages to be installed at the same time. Once this limit is reached, any further
  -- packages that are requested to be installed will be put in a queue.
  max_concurrent_installers = 10,

  -- install_list is not a option for mason, it will be used in `MasonInstallAll` command
  install_list = {
    'bash-language-server',
    'clangd',
    'codespell',
    'css-lsp',
    'dockerfile-language-server',
    'gofumpt',
    'golangci-lint',
    'golangci-lint-langserver',
    'gopls',
    'html-lsp',
    'json-lsp',
    'lua-language-server',
    'pyright',
    'rust-analyzer',
    'stylua',
    'typescript-language-server',
    'vim-language-server',
    'yaml-language-server',
  },
}

local lspconfig_options = {
  -- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer@nightly", "lua_ls" }
  -- This setting has no relation with the `automatic_installation` setting.
  ---@type string[]
  ensure_installed = {
    'bashls',
    'clangd',
    'cssls',
    'dockerls',
    'docker_compose_language_service',
    'golangci_lint_ls',
    'gopls',
    'helm_ls',
    'html',
    'jsonls',
    'lua_ls',
    'pyright',
    'rust_analyzer',
    'ts_ls',
    'vimls',
    'yamlls',
    'autotools_ls', -- Makefile
    'typos_lsp',
  },

  -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
  -- This setting has no relation with the `ensure_installed` setting.
  -- Can either be:
  --   - false: Servers are not automatically installed.
  --   - true: All servers set up via lspconfig are automatically installed.
  --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
  --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
  ---@type boolean
  automatic_installation = true,
}

mason.setup(options)
mason_lspconfig.setup(lspconfig_options)

----------------------------------------
-- Key Mappings
----------------------------------------
vim.api.nvim_create_user_command('MasonInstallAll', function()
  print('Mason Install...')
  vim.cmd('MasonInstall ' .. table.concat(options.ensure_installed, ' '))
end, { desc = 'Install all registered plugins' })

return options
