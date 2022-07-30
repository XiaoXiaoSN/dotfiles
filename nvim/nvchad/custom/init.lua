-- load your globals, autocmds here or anything .__.

------------------------------
-- Vim Global Settings
------------------------------

vim.g.mapleader = ","

vim.g.nvim_tree_highlight_opened_files = 1

------------------------------
-- Vim Options
------------------------------

vim.opt.tabstop = 4 -- The width of a TAB is set to 4
vim.opt.shiftwidth = 4 -- Indents will have a width of 4

vim.opt.showcmd = true
vim.opt.cursorline = true

vim.opt.encoding = "UTF-8"
vim.opt.guifont = "NotoSansMono Nerd Font:h16"

------------------------------
-- Vim Abbreviations
------------------------------

vim.cmd 'cnoreabbrev W! w!'
vim.cmd 'cnoreabbrev Q! q!'
vim.cmd 'cnoreabbrev Qall! qall!'
vim.cmd 'cnoreabbrev Wq wq'
vim.cmd 'cnoreabbrev Wa wa'
vim.cmd 'cnoreabbrev wQ wq'
vim.cmd 'cnoreabbrev WQ wq'
vim.cmd 'cnoreabbrev W w'
vim.cmd 'cnoreabbrev Q q'
vim.cmd 'cnoreabbrev Qall qall'

------------------------------
-- Import Custom Settings
------------------------------

require "custom.autocmds"
require "custom.commands"
