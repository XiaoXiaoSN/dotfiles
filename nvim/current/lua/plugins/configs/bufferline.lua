local present, bufferline = pcall(require, 'bufferline')
if not present then
  return
end

local options = {
  options = {
    offsets = { { filetype = 'NvimTree', text = '', padding = 1 } },
    buffer_close_icon = '',
    modified_icon = '',
    close_icon = '',
    show_close_icon = false,
    left_trunc_marker = ' ',
    right_trunc_marker = ' ',
    max_name_length = 14,
    max_prefix_length = 13,
    tab_size = 20,
    show_tab_indicators = true,
    enforce_regular_tabs = false,
    view = 'multiwindow',
    show_buffer_close_icons = true,
    separator_style = 'thin',
    always_show_bufferline = true,
    diagnostics = 'nvim_lsp', -- *false | 'nvim_lsp' | 'coc'
    themable = true,
    numbers = 'ordinal', -- *'none' | 'ordinal' | 'buffer_id' | 'both' | function({ ordinal, id, lower, raise }): string,

    custom_areas = {
      right = function()
        return {
          { text = '%@Toggle_theme@' .. vim.g.toggle_theme_icon .. '%X' },
          { text = '%@Quit_vim@ %X' },
        }
      end,
    },

    custom_filter = function(buf_number)
      -- Func to filter out our managed/persistent split terms
      local present_type, type = pcall(function()
        return vim.api.nvim_buf_get_var(buf_number, 'term_type')
      end)

      if present_type then
        if type == 'vert' then
          return false
        elseif type == 'hori' then
          return false
        end
        return true
      end

      return true
    end,
  },
}

bufferline.setup(options)

----------------------------------------
-- Key Mappings
----------------------------------------
local vim = vim

-- cycle through buffers
vim.keymap.set('n', '<leader>k', '<cmd> BufferLineCycleNext <CR>') -- cycle next buffer
vim.keymap.set('n', '<leader>l', '<cmd> BufferLineCycleNext <CR>') -- cycle next buffer
vim.keymap.set('n', '<leader>j', '<cmd> BufferLineCyclePrev <CR>') -- cycle prev buffer
vim.keymap.set('n', '<leader>h', '<cmd> BufferLineCyclePrev <CR>') -- cycle prev buffer

-- Quick buffer jumper
-- https://github.com/akinsho/bufferline.nvim#bufferlinegotobuffer
vim.keymap.set('n', '<leader>1', '<cmd> BufferLineGoToBuffer 1<CR>') -- quick jump to buffer 1
vim.keymap.set('n', '<leader>2', '<cmd> BufferLineGoToBuffer 2<CR>') -- quick jump to buffer 2
vim.keymap.set('n', '<leader>3', '<cmd> BufferLineGoToBuffer 3<CR>') -- quick jump to buffer 3
vim.keymap.set('n', '<leader>4', '<cmd> BufferLineGoToBuffer 4<CR>') -- quick jump to buffer 4
vim.keymap.set('n', '<leader>5', '<cmd> BufferLineGoToBuffer 5<CR>') -- quick jump to buffer 5
vim.keymap.set('n', '<leader>6', '<cmd> BufferLineGoToBuffer 6<CR>') -- quick jump to buffer 6
vim.keymap.set('n', '<leader>7', '<cmd> BufferLineGoToBuffer 7<CR>') -- quick jump to buffer 7
vim.keymap.set('n', '<leader>8', '<cmd> BufferLineGoToBuffer 8<CR>') -- quick jump to buffer 8
vim.keymap.set('n', '<leader>9', '<cmd> BufferLineGoToBuffer 9<CR>') -- quick jump to buffer 9

-- Buffer pick
vim.keymap.set('n', 'gb', '<cmd> BufferLinePick<CR>') -- quick jump to picked buffer

-- Close buffer
vim.keymap.set('n', '<leader>x', '<cmd> Bd<CR>') -- delete current buffer
