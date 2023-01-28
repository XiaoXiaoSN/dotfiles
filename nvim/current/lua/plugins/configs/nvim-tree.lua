local present, nvimtree = pcall(require, 'nvim-tree')
if not present then
  return
end

-- reference: https://github.com/nvim-tree/nvim-tree.lua/blob/master/doc/nvim-tree-lua.txt
local options = {
  sort_by = 'case_sensitive', -- *name, case_sensitive, modification_time, extension
  filters = {
    dotfiles = false, -- show hidden files
    custom = {
      '.DS_Store',
      '.direnv',
      '.git',
      '.idea',
    },
    exclude = {},
  },
  disable_netrw = true,
  hijack_netrw = true,
  open_on_setup = false,
  hijack_cursor = true,
  hijack_unnamed_buffer_when_opening = false,
  update_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = false,
  },
  view = {
    adaptive_size = true,
    side = 'left',
    width = 30, -- default: 25
    hide_root_folder = false,
    number = false,
    mappings = {
      custom_only = false,
      list = {
        -- user mappings go here
      },
    },
  },
  git = {
    enable = true,
    ignore = false,
  },
  filesystem_watchers = {
    enable = true,
  },
  actions = {
    open_file = {
      resize_window = true,
    },
  },
  renderer = {
    add_trailing = false,
    group_empty = true, -- default: false
    highlight_git = false,
    highlight_opened_files = 'all', -- *none, icon, name, all

    indent_markers = {
      enable = false,
    },

    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = false,
      },
      glyphs = {
        default = '',
        symlink = '',
        folder = {
          default = '',
          empty = '',
          empty_open = '',
          open = '',
          symlink = '',
          symlink_open = '',
          arrow_open = '',
          arrow_closed = '',
        },
        git = {
          unstaged = '✗',
          staged = '✓',
          unmerged = '',
          renamed = '➜',
          untracked = '★',
          deleted = '',
          ignored = '◌',
        },
      },
    },
  },
}

nvimtree.setup(options)

----------------------------------------
-- Key Mappings
----------------------------------------
local vim = vim

vim.keymap.set('', '<C-b>', '<cmd>NvimTreeToggle<CR>')
vim.keymap.set('', '<M-b>', '<cmd>NvimTreeToggle<CR>')
vim.keymap.set('', '<leader>e', '<cmd>NvimTreeToggle<CR>')
vim.keymap.set('', 'zz', '<cmd>NvimTreeFocus<CR>')
