local vim = vim

------------------------------
-- Vim Abbreviations
------------------------------

vim.cmd('cnoreabbrev W! w!')
vim.cmd('cnoreabbrev Q! q!')
vim.cmd('cnoreabbrev Qall! qall!')
vim.cmd('cnoreabbrev Wq wq')
vim.cmd('cnoreabbrev Wa wa')
vim.cmd('cnoreabbrev wQ wq')
vim.cmd('cnoreabbrev WQ wq')
vim.cmd('cnoreabbrev W w')
vim.cmd('cnoreabbrev Q q')
vim.cmd('cnoreabbrev Qall qall')

----------------------------------------
-- Key Mappings
----------------------------------------

vim.keymap.set('n', '<ESC>', '<cmd> noh <CR>') -- no highlight
vim.keymap.set('n', '<C-s>', '<cmd> w <CR>') -- save file
vim.keymap.set('n', '<M-s>', '<cmd> w <CR>') -- save file
vim.keymap.set('n', '<C-c>', '<cmd> %y+ <CR>') -- copy whole file
vim.keymap.set('n', '<M-c>', '<cmd> %y+ <CR>') -- copy whole file

-- switch between windows
vim.keymap.set('n', '<C-h>', '<C-w>h') -- window left
vim.keymap.set('n', '<C-l>', '<C-w>l') -- window right
vim.keymap.set('n', '<C-j>', '<C-w>j') -- window down
vim.keymap.set('n', '<C-k>', '<C-w>k') -- window up

-- this will reselect and re-yank any text that is pasted in visual mode.
vim.keymap.set('x', 'p', 'pgvy')

-- navigate within insert mode
vim.keymap.set('i', '<C-h>', '<Left>')
vim.keymap.set('i', '<C-l>', '<Right>')
vim.keymap.set('i', '<C-j>', '<Down>')
vim.keymap.set('i', '<C-k>', '<Up>')
