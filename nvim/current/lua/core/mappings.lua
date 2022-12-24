local vim = vim

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


----------------------------------------
-- Key Mappings
----------------------------------------

-- this will reselect and re-yank any text that is pasted in visual mode.
vim.keymap.set('x', 'p', 'pgvy')
