local vim = vim

------------------------------
-- Vim Global Settings
------------------------------

-- Enables the experimental Lua module loader
--    • overrides loadfile
--    • adds the lua loader using the byte-compilation cache
--    • adds the libs loader
--    • removes the default Neovim loader
vim.loader.enable()

-- Custom mapping <leader> (see `:h mapleader` for more info)
vim.g.mapleader = ','

-- Use English as main language
vim.cmd([[language en_US.UTF-8]])

-- nvim-tree/nvim-tree.lua: disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
