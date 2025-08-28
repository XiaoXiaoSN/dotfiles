local utils = require('core.utils')
local comment = utils.require('Comment')

comment.setup()

----------------------------------------
-- Key Mappings
----------------------------------------
local commentAPI = require('Comment.api')

local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)

vim.keymap.set('n', '<leader>/', commentAPI.toggle.linewise.current)
vim.keymap.set('x', '<leader>/', function()
  vim.api.nvim_feedkeys(esc, 'nx', false)
  commentAPI.toggle.linewise(vim.fn.visualmode())
end)
