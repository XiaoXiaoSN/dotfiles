-- overriding default plugin configs!

local M = {}

M.treesitter = {
  ensure_installed = {
    "bash",
    "css",
    "go",
    "html",
    "lua",
    "javascript",
    "json",
    "rust",
    "toml",
    "markdown",
    "vim",
  },
}

M.nvimtree = {
  view = {
    width = 30,
  },
  git = {
    enable = true,
  },
}

M.telescope = {
  defaults = {
    prompt_prefix = " 🔍 ",
  },
  extensions = {
    -- fd is needed
    media_files = {
      filetypes = { "png", "webp", "jpg", "jpeg" },
    },
  },
}

M.whichkey = {
  -- add `x` mode for key mappings
  mode_opts = {
    x = { mode = "x" },
  },

  window = {
    border = "single", -- none/single/double/shadow
  },
}

M.bufferline = {
  options = {
    -- "none" | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
    numbers = "ordinal",

    -- false | "nvim_lsp" | "coc"
    diagnostics = "nvim_lsp",
  }
}

return M
