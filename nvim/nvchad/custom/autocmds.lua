-- local autocmd = vim.api.nvim_create_autocmd

-- You can automatically close the tab/vim when nvim-tree is the last window in the tab.
-- WARNING: other plugins or automation may interfere with this:
vim.cmd [[
  autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
]]

