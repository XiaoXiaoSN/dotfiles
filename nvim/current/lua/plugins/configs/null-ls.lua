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

local sources = {
  -- Common
  formatting.prettier,
  diagnostics.codespell,

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
  diagnostics.shellcheck.with { diagnostics_format = '#{m} [#{c}]' },

  -- cpp
  formatting.clang_format,

  -- Python
  formatting.black.with { extra_args = { '--fast' } },
}

local unwrap = {
  method = null_ls.methods.DIAGNOSTICS,
  filetypes = { 'rust' },
  generator = {
    fn = function(params)
      local diagnostics = {}
      -- sources have access to a params object
      -- containing info about the current file and editor state
      for i, line in ipairs(params.content) do
        local col, end_col = line:find 'unwrap()'
        if col and end_col then
          -- null-ls fills in undefined positions
          -- and converts source diagnostics into the required format
          table.insert(diagnostics, {
            row = i,
            col = col,
            end_col = end_col,
            source = 'unwrap',
            message = 'hey ' .. os.getenv('USER') .. ", don't forget to handle this",
            severity = 2,
          })
        end
      end
      return diagnostics
    end,
  },
}

null_ls.setup({
  debug = false,
  sources = sources,
})
null_ls.register(unwrap)
