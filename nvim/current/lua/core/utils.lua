-- Utility functions for Neovim configuration
local M = {}

---Require a module with proper error handling and type casting
---This function is designed to work better with LSP type inference
---@param module_name string The name of the module to require
---@param error_message? string Custom error message (optional)
---@return any module The required module
function M.require(module_name, error_message)
  local success, module = pcall(require, module_name)

  if not success then
    local msg = error_message or string.format('Failed to load module: %s', module_name)
    vim.notify(msg, vim.log.levels.ERROR, {
      title = 'Plugin Error',
      timeout = 5000,
    })
    error(msg)
  end

  return module
end

return M
