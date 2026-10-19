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

-- keep messages in English without requiring a generated locale
vim.cmd('language messages C')

-- nvim-tree/nvim-tree.lua: disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
