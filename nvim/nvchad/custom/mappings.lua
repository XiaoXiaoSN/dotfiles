local M = {}

M.general = {
  --
}

M.bufferline = {
  n = {
    -- cycle through buffers
    ["<leader>k"] = { "<cmd> BufferLineCycleNext <CR>", "  cycle next buffer" },
    ["<leader>l"] = { "<cmd> BufferLineCycleNext <CR>", "  cycle next buffer" },
    ["<leader>j"] = { "<cmd> BufferLineCyclePrev <CR>", "  cycle prev buffer" },
    ["<leader>h"] = { "<cmd> BufferLineCyclePrev <CR>", "  cycle prev buffer" },
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
