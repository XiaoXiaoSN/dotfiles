local vim = vim

local present, mason = pcall(require, 'mason')
if not present then
  return
end

local options = {
  -- Where Mason should put its bin location in your PATH. Can be one of:
  -- - 'prepend' (default, Mason's bin location is put first in PATH)
  -- - 'append' (Mason's bin location is put at the end of PATH)
  -- - 'skip' (doesn't modify PATH)
  ---@type ''prepend'' | ''append'' | ''skip''
  PATH = 'prepend',

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
}

mason.setup(options)

return options
