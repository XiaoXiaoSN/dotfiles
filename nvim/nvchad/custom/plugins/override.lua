-- overriding default plugin configs!

local M = {}

M.treesitter = {
  ensure_installed = {
    "bash",
    "css",
    "html",
    "lua",
    "javascript",
    "json",
    "toml",
    "markdown",
    "vim",
  },
}

M.nvimtree = {
  git = {
    enable = true,
  },
}

M.telescope = {
  extensions = {
    -- fd is needed
    media_files = {
      filetypes = { "png", "webp", "jpg", "jpeg" },
    },
  },
}

M.whichkey = {
  window = {
    border = "single", -- none/single/double/shadow
  },
}

M.bufferline = {
  options = {
    -- "none" | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
    numbers = "ordinal"
  }
}

return M
