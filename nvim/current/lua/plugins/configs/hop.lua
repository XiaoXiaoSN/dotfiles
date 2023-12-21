local present, hop = pcall(require, 'hop')
if not present then
  print('Missing plugin `smoka7/hop.nvim`')
  return
end

hop.setup({
  keys = 'abcdefghijklmnopqrstuvwxyz',
})

----------------------------------------
-- Key Mappings
----------------------------------------

-- https://github.com/smoka7/hop.nvim/wiki/Commands
local directions = require('hop.hint').HintDirection

-- override default `f` mappings
-- stylua: ignore
vim.keymap.set(
  "", "f",
  function()
    hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
  end,
  { remap = true }
)

-- override default `F` mappings
-- stylua: ignore
vim.keymap.set(
  "", "F",
  function()
    hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
  end,
  { remap = true }
)

-- hop to any char in the current buffer
-- stylua: ignore
vim.keymap.set(
  'n', '<leader><leader>',
  function()
    hop.hint_char1({})
  end,
  { remap = true }
)
