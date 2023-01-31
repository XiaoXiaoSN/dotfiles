local vim = vim

local plugins = function(use)
  -- Improve startup time for Neovim
  -- It is recommended to put impatient.nvim before any other plugins
  use('lewis6991/impatient.nvim')

  -- Packer can manage itself
  use('wbthomason/packer.nvim')

  -- Lua functions
  use('nvim-lua/plenary.nvim')

  -- Defaults everyone can agree on
  use('tpope/vim-sleuth')

  ----------------------------------------
  -- User Interface
  ----------------------------------------

  -- Color scheme
  use({ 'catppuccin/nvim', as = 'catppuccin' })

  -- File explorer tree
  use({
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly', -- optional, updated every week. (see issue #1193)
    config = function()
      require('plugins.configs.nvim-tree')
    end,
  })
  -- Buffer management
  use({
    'akinsho/bufferline.nvim',
    tags = 'v3.*',
    requires = 'nvim-tree/nvim-web-devicons',
    config = function()
      require('plugins.configs.bufferline')
    end,
  })
  -- Status line
  use('arkav/lualine-lsp-progress')
  use({
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true },
    config = function()
      require('plugins.configs.lualine')
    end,
  })

  -- Show LSP progress
  use({
    'j-hui/fidget.nvim',
    requires = {
      'nvim-lua/lsp-status.nvim', -- optional, for file icons
    },
    config = function()
      require('fidget').setup({})
    end,
  })

  -- Show scroll bar for file progress
  use({
    'dstein64/nvim-scrollview',
    config = function()
      require('scrollview').setup({
        current_only = true,
      })
    end,
  })

  -- Force mode
  use({
    'folke/zen-mode.nvim',
    config = function()
      require('plugins.configs.zen-mode')
    end,
  })

  ----------------------------------------
  -- Editor support
  ----------------------------------------

  -- Finder
  use({
    'nvim-telescope/telescope.nvim',
    tag = '0.1.0',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require('plugins.configs.telescope')
    end,
  })
  use('nvim-telescope/telescope-media-files.nvim')

  use({
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('plugins.configs.nvim-treesitter')
    end,
  })

  -- Move your cursor fast
  -- TODO: replace easymotion with `phaazon/hop.nvim`
  use('easymotion/vim-easymotion')

  -- Git support
  use('airblade/vim-gitgutter')
  use({
    'lewis6991/gitsigns.nvim',
    config = function()
      require('plugins.configs.gitsigns')
    end,
  })

  -- Comment
  use({
    'numToStr/Comment.nvim',
    config = function()
      require('plugins.configs.comment')
    end,
  })

  -- Helpful editor support
  use('tpope/vim-surround')
  use('tpope/vim-abolish')
  use('ntpeters/vim-better-whitespace')
  use({
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('indent_blankline').setup({
        show_end_of_line = true,
      })
    end,
  })
  use({
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup({})
    end,
  })

  ----------------------------------------
  -- Language Server and Their Friends
  ----------------------------------------

  use({
    'williamboman/mason.nvim',
    config = function()
      require('plugins.configs.mason')
    end,
  })

  use({
    'neovim/nvim-lspconfig',
    config = function()
      require('plugins.configs.nvim-lspconfig')
    end,
  })
  -- use({
  --   'glepnir/lspsaga.nvim',
  --   branch = 'main',
  --   config = function()
  --     require('lspsaga').setup({})
  --   end,
  --   requires = { { 'nvim-tree/nvim-web-devicons' } },
  -- })

  -- Inject LSP diagnostics, code actions, and more via Lua
  use({
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      require('plugins.configs.null-ls')
    end,
  })

  -- Go language
  use({
    'fatih/vim-go',
    { run = ':GoUpdateBinaries' },
    config = function()
      vim.g.go_def_mode = 'gopls'
      vim.g.go_info_mode = 'gopls'
    end,
  })

  -- Rust
  use('rust-lang/rust.vim')
  use({
    'simrat39/rust-tools.nvim',
    requires = {
      'neovim/nvim-lspconfig',
    },
    config = function()
      require('rust-tools').setup({})
    end,
  })
  use('mattn/webapi-vim') -- for RustPlay command

  -- JavaScript & TypeScript
  use('pangloss/vim-javascript')
  use('leafgarland/typescript-vim')
  use('MaxMEllon/vim-jsx-pretty')

  ----------------------------------------
  -- Completion
  ----------------------------------------

  use('hrsh7th/nvim-cmp')
  use('hrsh7th/cmp-nvim-lsp')
end

return plugins
