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

--  command! Snake call feedkeys("crs")
--  command! Pascal call feedkeys("crm")
--  command! Camel call feedkeys("crc")
--  command! Upper call feedkeys("cru")
--  command! Kebab call feedkeys("cr-")
--  command! DotCase call feedkeys("cr.")
--  command! SpaceCase call feedkeys("cr<space>")
