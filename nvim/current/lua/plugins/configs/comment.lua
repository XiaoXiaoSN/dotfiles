local present, comment = pcall(require, 'Comment')
if not present then
  print('Missing plugin `numToStr/Comment.nvim`')
  return
end

comment.setup()

----------------------------------------
-- Key Mappings
----------------------------------------
local vim = vim
local commentAPI = require('Comment.api')

local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)

vim.keymap.set('n', '<leader>/', commentAPI.toggle.linewise.current)
vim.keymap.set('x', '<leader>/', function()
  vim.api.nvim_feedkeys(esc, 'nx', false)
  commentAPI.toggle.linewise(vim.fn.visualmode())
end)
