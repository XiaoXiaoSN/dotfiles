local utils = require('core.utils')
local null_ls = utils.require('null-ls')

-- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting

-- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

-- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/completion
-- local completion = null_ls.builtins.completion

null_ls.setup({
  debug = true,

  -- NOTE: the list of builtin sources
  -- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md
  sources = {
    -- Common
    formatting.prettier,
    diagnostics.codespell.with({ extra_args = { '-L crate' } }), -- TODO: use a file as white list

    -- Go
    formatting.goimports,

    -- JavaScript
    -- formatting.deno_fmt,
    -- diagnostics.eslint,

    -- Lua
    formatting.stylua,

    -- Shell
    -- diagnostics.shfmt,
    -- diagnostics.shellcheck.with({ diagnostics_format = '#{m} [#{c}]' }),

    -- C-family
    formatting.clang_format,

    -- Python
    formatting.black.with({ extra_args = { '--fast' } }),
  },
})
