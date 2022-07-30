-- https://github.com/siduck/dotfiles/blob/master/nvchad/custom/chadrc.lua as reference

local M = {}

local override = require "custom.plugins.override"
local userPlugins = require "custom.plugins"

-- make sure you maintain the structure of `core/default_config.lua` here,

M.ui = {
  theme = "monekai",
  -- theme = "onedark",
}

M.mappings = require "custom.mappings"

M.plugins = {
  options = {
    lspconfig = {
      setup_lspconf = "custom.plugins.lspconfig",
    },
    statusline = {
      -- default/round/slant/block/arrow
      separator_style = "slant",
    },
  },

  override = {
    ["kyazdani42/nvim-tree.lua"] = override.nvimtree,
    ["nvim-treesitter/nvim-treesitter"] = override.treesitter,
    ["nvim-telescope/telescope.nvim"] = override.telescope,
    ["folke/which-key.nvim"] = override.whichkey,
    ["akinsho/bufferline.nvim"] = override.bufferline,
  },

  remove = {},

  user = userPlugins,
}

return M
