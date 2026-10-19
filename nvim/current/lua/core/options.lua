------------------------------
-- Vim Options
------------------------------

vim.opt.encoding = 'UTF-8'
vim.opt.guifont = 'NotoSansMono Nerd Font:h16'
vim.opt.mouse = 'a'

vim.opt.showmode = false
vim.opt.showcmd = true
vim.opt.cursorline = true
vim.opt.laststatus = 3 -- global statusline
if vim.fn.has('clipboard') == 1 then
  vim.opt.clipboard = 'unnamedplus'
end

-- Indenting
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.tabstop = 4 -- The width of a TAB is set to 4
vim.opt.softtabstop = 4 -- Indents will have a width of 4

vim.opt.fillchars = { eob = ' ' }
vim.opt.ignorecase = true
vim.opt.smartcase = true -- Smart deciding search case
vim.opt.signcolumn = 'yes'
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.termguicolors = true
vim.opt.timeoutlen = 500
local legacy_undodir = vim.fn.expand('~/.vim/undodir')
local undodir = vim.fn.isdirectory(legacy_undodir) == 1 and legacy_undodir or vim.fn.stdpath('state') .. '/undo'
vim.fn.mkdir(undodir, 'p')
vim.opt.undodir = undodir
vim.opt.undofile = true

-- Numbers
vim.opt.number = true
vim.opt.numberwidth = 2
vim.opt.ruler = false

-- interval for writing swap file to disk, also used by gitsigns
vim.opt.updatetime = 250

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menu,menuone,noselect'

-- Auto-reload files when they change externally
vim.o.autoread = true
