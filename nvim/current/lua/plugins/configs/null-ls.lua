local present, null_ls = pcall(require, 'null-ls')
if not present then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/completion
-- local completion = null_ls.builtins.completion

-- NOTE: the list of buildin sources
-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
local sources = {
  -- Common
  formatting.prettier,
  formatting.codespell,

  -- Go
  formatting.goimports,

  -- Rust
  formatting.rustfmt,

  -- JavaScript
  formatting.deno_fmt,
  diagnostics.eslint,

  -- Lua
  formatting.stylua,

  -- Shell
  formatting.shfmt,
  diagnostics.shellcheck.with({ diagnostics_format = '#{m} [#{c}]' }),

  -- C-family
  formatting.clang_format,

  -- Python
  formatting.black.with({ extra_args = { '--fast' } }),
}

null_ls.setup({
  debug = false,
  sources = sources,
})
