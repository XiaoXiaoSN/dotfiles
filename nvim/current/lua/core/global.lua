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

-- colorscheme
local success, error = pcall(function()
  vim.cmd.colorscheme('catppuccin-macchiato')
end)
if not success then
  print('The specified theme is not installed' .. error)
end
