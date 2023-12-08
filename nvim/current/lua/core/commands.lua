local vim = vim
local user_cmd = vim.api.nvim_create_user_command

-- Power from tpope/vim-abolish
local change_case = function(keys)
  return function()
    vim.call('feedkeys', keys)
  end
end

user_cmd('Snake', change_case('crs'), { desc = 'change to snake_case' })
user_cmd('Pascal', change_case('crm'), { desc = 'change to PascalCase' })
user_cmd('Camel', change_case('crc'), { desc = 'change to camelCase' })
user_cmd('Upper', change_case('cru'), { desc = 'change to UPPER CASE' })
user_cmd('Kebab', change_case('cr-'), { desc = 'change to kebab-case' })
user_cmd('DotCase', change_case('cr.'), { desc = 'change to dot.case' })
user_cmd('SpaceCase', change_case('cr<space>'), { desc = 'change to space case' })

-- close buffer + hide terminal buffer (alias of <leader>x)
-- https://superuser.com/a/370121
user_cmd('Bd', function()
  vim.cmd([[bprevious | split | bnext | bdelete]])
end, {})
