local vim = vim

return {
  -- Lua functions
  { 'nvim-lua/plenary.nvim', version = 'v0.1.*' },

  -- Automatically highlighting other uses of the word
  {
    'RRethy/vim-illuminate',
    config = function()
      require('illuminate').configure({ delay = 200 })
    end,
  },

  -- Defaults everyone can agree on
  'tpope/vim-sleuth',

  ----------------------------------------
  -- User Interface
  ----------------------------------------

  -- Color scheme
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme catppuccin-macchiato]])
    end,
  },
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme tokyonight]])
    end,
  },

  -- File explorer tree
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    version = 'v1.*',
    config = function()
      require('plugins.configs.nvim-tree')
    end,
  },
  -- Buffer management
  {
    'akinsho/bufferline.nvim',
    version = 'v4.*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require('plugins.configs.bufferline')
    end,
  },
  -- Status line
  'arkav/lualine-lsp-progress',
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('plugins.configs.lualine')
    end,
  },
  -- Show LSP progress
  {
    'j-hui/fidget.nvim',
    dependencies = { 'nvim-lua/lsp-status.nvim' },
    config = function()
      require('fidget').setup({})
    end,
  },
  -- Show scroll bar for file progress
  {
    'dstein64/nvim-scrollview',
    config = function()
      require('scrollview').setup({ current_only = true })
    end,
  },
  -- Force mode
  {
    'folke/zen-mode.nvim',
    config = function()
      require('plugins.configs.zen-mode')
    end,
  },
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      require('toggleterm').setup()
    end,
  },

  ----------------------------------------
  -- Editor support
  ----------------------------------------

  -- GitHub Copilot
  { 'github/copilot.vim', enabled = false },

  -- Finder
  {
    'nvim-telescope/telescope.nvim',
    version = '0.1.*',
    dependencies = 'nvim-lua/plenary.nvim',
    config = function()
      require('plugins.configs.telescope')
    end,
  },
  'nvim-telescope/telescope-media-files.nvim',
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('plugins.configs.nvim-treesitter')
    end,
  },
  -- Move your cursor fast
  {
    'smoka7/hop.nvim',
    version = '*',
    config = function()
      require('plugins.configs.hop')
    end,
  },
  -- Git support
  'airblade/vim-gitgutter',
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('plugins.configs.gitsigns')
    end,
  },
  -- Comment
  {
    'numToStr/Comment.nvim',
    config = function()
      require('plugins.configs.comment')
    end,
  },
  -- Helpful editor support
  'tpope/vim-surround',
  'tpope/vim-abolish',
  'ntpeters/vim-better-whitespace',
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    config = function()
      require('ibl').setup({
        scope = { enabled = false },
      })
    end,
  },
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup({})
    end,
  },

  ----------------------------------------
  -- Language Server and Their Friends
  ----------------------------------------

  -- Ordering: mason.nvim -> mason-lspconfig.nvim -> nvim-lspconfig
  {
    'williamboman/mason.nvim',
    version = '1',
    config = function()
      require('plugins.configs.mason')
    end,
  },
  {
    -- `mason-lspconfig` bridges `mason.nvim` with the `lspconfig` plugin
    -- - making it easier to use both plugins together.
    'williamboman/mason-lspconfig.nvim',
    version = '1',
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
    config = function()
      require('plugins.configs.nvim-lspconfig')
    end,
  },
  -- Inject LSP diagnostics, code actions, and more via Lua
  {
    'nvimtools/none-ls.nvim',
    config = function()
      require('plugins.configs.null-ls') -- NOTE: keep the name
    end,
  },

  -- Go
  {
    'fatih/vim-go',
    build = ':GoUpdateBinaries',
    config = function()
      vim.g.go_def_mode = 'gopls'
      vim.g.go_info_mode = 'gopls'
    end,
  },

  -- Rust
  'rust-lang/rust.vim',
  {
    'mrcjkb/rustaceanvim',
    version = '^5',
    lazy = false, -- This plugin is already lazy
    config = function()
      vim.g.rustaceanvim = {
        -- LSP configuration
        server = {
          on_attach = require('plugins.share.lsp-keymappings').on_attach,
        },
      }
    end,
  },
  'mattn/webapi-vim',

  -- JavaScript & TypeScript
  'pangloss/vim-javascript',
  'leafgarland/typescript-vim',
  'MaxMEllon/vim-jsx-pretty',

  -- Markdown Preview
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = function()
      vim.fn['mkdp#util#install']()
    end,
  },

  ----------------------------------------
  -- Completion
  ----------------------------------------

  {
    'hrsh7th/nvim-cmp',
    event = { 'InsertEnter', 'CmdlineEnter' },
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-vsnip',
      'hrsh7th/vim-vsnip',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-emoji',
      'onsails/lspkind.nvim', -- icons
      'XiaoXiaoSN/cmp-kaomoji',
      -- { dir = '~/projects/lua/cmp-kaomoji' },
    },
    config = function()
      require('plugins.configs.nvim-cmp')
    end,
  },
}
