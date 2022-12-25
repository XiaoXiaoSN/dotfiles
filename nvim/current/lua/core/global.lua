local vim = vim

------------------------------
-- Vim Global Settings
------------------------------

-- Custom mapping <leader> (see `:h mapleader` for more info)
vim.g.mapleader = ','

-- Use English as main language
vim.cmd [[language en_US.UTF-8]]

-- colorscheme
vim.cmd.colorscheme 'catppuccin-macchiato'
