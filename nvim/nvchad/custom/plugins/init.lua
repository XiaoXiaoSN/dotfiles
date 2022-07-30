return {
  -- Helpful editor support
  ["tpope/vim-surround"] = {},
  ["tpope/vim-abolish"] = {
    -- defind some extended commands on `commands.lua`
  },
  ["ntpeters/vim-better-whitespace"] = {},

  -- GitHub Copilot is an AI pair programmer
  ["github/copilot.vim"] = {},

  -- move your cursor fast
  ["easymotion/vim-easymotion"] = {},

  -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua.
  ["jose-elias-alvarez/null-ls.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require("custom.plugins.null-ls").setup()
    end
  },

  -- Telescope media file extension
  ["nvim-telescope/telescope-media-files.nvim"] = {
    after = "telescope.nvim",
    config = function()
      require("telescope").load_extension "media_files"
    end
  },
}
