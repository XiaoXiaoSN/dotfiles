local utils = require('core.utils')
local treesitter = utils.require('nvim-treesitter.configs')
local options = {
  -- A list of parser names, or 'all'
  -- supported languages:
  -- https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
  ensure_installed = {
    'bash',
    'css',
    'fish',
    'go',
    'html',
    'javascript',
    'json',
    'lua',
    'markdown',
    'nix',
    'rust',
    'swift',
    'toml',
    'typescript',
    'vim',
    'yaml',
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,
    use_languagetree = true,
  },
}

-- check for any override
treesitter.setup(options)
