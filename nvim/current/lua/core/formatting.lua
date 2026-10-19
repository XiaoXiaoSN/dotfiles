local M = {}

function M.format(bufnr, async)
  local selected
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr, method = 'textDocument/formatting' })) do
    -- prefer the configured external formatter over a language server's formatter
    if client.name == 'null-ls' then
      selected = client
      break
    end
    if not selected or client.id < selected.id then
      selected = client
    end
  end

  if selected then
    vim.lsp.buf.format({ bufnr = bufnr, id = selected.id, async = async or false, timeout_ms = 2000 })
  end
end

return M
