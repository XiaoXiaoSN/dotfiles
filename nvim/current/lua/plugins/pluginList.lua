local plugins = function(use)
  -- Improve startup time for Neovim
  -- It is recommended to put impatient.nvim before any other plugins
  use 'lewis6991/impatient.nvim'

  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Lua functions
  use 'nvim-lua/plenary.nvim'

  ----------------------------------------
  -- User Interface
  ----------------------------------------

  -- Color scheme
  use { 'catppuccin/nvim', as = 'catppuccin' }

  -- File explorer tree
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly', -- optional, updated every week. (see issue #1193)
    config = function()
      require 'plugins.configs.nvim-tree'
    end,
  }
  -- Buffer management
  use({
    "akinsho/bufferline.nvim",
    tags = "v3.*",
    requires = "nvim-tree/nvim-web-devicons",
    config = function()
      require 'plugins.configs.bufferline'
    end,
  })
  use {
    -- Status line
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true },
    config = function()
      require 'plugins.configs.lualine'
    end,
  }


  ----------------------------------------
  -- Editor support
  ----------------------------------------

  -- Finder
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ":TSUpdate",
    config = function()
      require 'plugins.configs.nvim-treesitter'
    end,
  }
  use 'nvim-telescope/telescope-media-files.nvim'

  -- Move your cursor fast
  use { 'easymotion/vim-easymotion' }

  -- Git support
  use "tpope/vim-fugitive"
  use "airblade/vim-gitgutter"
  use 'lewis6991/gitsigns.nvim'

  -- Helpful editor support
  use 'tpope/vim-surround'
  use 'tpope/vim-abolish'
  use 'ntpeters/vim-better-whitespace'
  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require("indent_blankline").setup {
        show_end_of_line = true,
      }
    end,
  }
  use 'windwp/nvim-autopairs'


  ----------------------------------------
  -- Language Server and His Friends
  ----------------------------------------

  use {
    'williamboman/mason.nvim',
    config = function()
      require "plugins.configs.mason"
    end,
  }
  use {
    'neovim/nvim-lspconfig',
    config = function()
      require "plugins.configs.nvim-lspconfig"
    end,
  }
  use 'jose-elias-alvarez/null-ls.nvim'

  -- Go language
  use {
    'fatih/vim-go',
    { run = ':GoUpdateBinaries' }
  }
  -- Rust
  use 'rust-lang/rust.vim'
  use 'simrat39/rust-tools.nvim'

  ----------------------------------------
  -- Completion
  ----------------------------------------
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
end

return plugins
