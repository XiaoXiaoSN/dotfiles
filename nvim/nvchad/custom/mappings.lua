local M = {}

M.general = {
  -- Visual mode
  x = {
    -- this will reselect and re-yank any text that is pasted in visual mode.
    ["p"] = { "pgvy", "" },
  }
}

M.bufferline = {
  n = {
    -- cycle through buffers
    ["<leader>k"] = { "<cmd> BufferLineCycleNext <CR>", "  cycle next buffer" },
    ["<leader>l"] = { "<cmd> BufferLineCycleNext <CR>", "  cycle next buffer" },
    ["<leader>j"] = { "<cmd> BufferLineCyclePrev <CR>", "  cycle prev buffer" },
    ["<leader>h"] = { "<cmd> BufferLineCyclePrev <CR>", "  cycle prev buffer" },

    -- Quick buffer jumper
    -- https://github.com/akinsho/bufferline.nvim#bufferlinegotobuffer
    ["<leader>1"] = { "<cmd> BufferLineGoToBuffer 1<CR>", "  quick jump to buffer 1" },
    ["<leader>2"] = { "<cmd> BufferLineGoToBuffer 2<CR>", "  quick jump to buffer 2" },
    ["<leader>3"] = { "<cmd> BufferLineGoToBuffer 3<CR>", "  quick jump to buffer 3" },
    ["<leader>4"] = { "<cmd> BufferLineGoToBuffer 4<CR>", "  quick jump to buffer 4" },
    ["<leader>5"] = { "<cmd> BufferLineGoToBuffer 5<CR>", "  quick jump to buffer 5" },
    ["<leader>6"] = { "<cmd> BufferLineGoToBuffer 6<CR>", "  quick jump to buffer 6" },
    ["<leader>7"] = { "<cmd> BufferLineGoToBuffer 7<CR>", "  quick jump to buffer 7" },
    ["<leader>8"] = { "<cmd> BufferLineGoToBuffer 8<CR>", "  quick jump to buffer 8" },
    ["<leader>9"] = { "<cmd> BufferLineGoToBuffer 9<CR>", "  quick jump to buffer 9" },

    -- Buffer pick
    ["gb"] = { "<cmd> BufferLinePick<CR>", "  quick jump to buffer 9" },

    -- close buffer + hide terminal buffer
    ["Bd"] = {
      function()
        nvchad.close_buffer()
      end,
      "   close buffer",
    },
  }
}

M.nvimtree = {
  n = {
    -- toggle
    ["<C-b>"] = { "<cmd> NvimTreeToggle <CR>", "🌲  toggle nvimtree" },
  },
}

M.comment = {
  -- toggle comment in both modes
  -- NOTE: it's not work, be duplicate with `which-key`
  n = {
    ["<C-/><C-/>"] = {
      function()
        require("Comment.api").toggle_current_linewise()
      end,

      "蘒  toggle comment",
    },
  },

  v = {
    ["<C-/><C-/>"] = {
      "<ESC><cmd>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>",
      "蘒  toggle comment",
    },
  },
}

M.telescope = {
  n = {
    ["<leader>fg"] = { "<cmd> Telescope live_grep <CR>", "  find media" },
    ["<leader>fl"] = { "<cmd> Telescope live_grep <CR>", "🔍  live grep" },

    ["<leader>fp"] = { "<cmd> Telescope media_files <CR>", "  find media" }
  }
}

return M
