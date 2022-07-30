local user_cmd = vim.api.nvim_create_user_command

-- Power from tpope/vim-abolish
local change_case = function(keys)
  return function()
    vim.call('feedkeys', keys)
  end
end

user_cmd("Snake", change_case "crs", {})
user_cmd("Pascal", change_case "crm", {})
user_cmd("Camel", change_case "crc", {})
user_cmd("Upper", change_case "cru", {})
user_cmd("Kebab", change_case "cr-", {})
user_cmd("DotCase", change_case "cr.", {})
user_cmd("SpaceCase", change_case "cr<space>", {})

-- close buffer + hide terminal buffer (alias of <leader>x)
user_cmd("Bd", function ()
  nvchad.close_buffer()
end, {})
