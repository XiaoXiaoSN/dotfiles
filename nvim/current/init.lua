vim.defer_fn(function()
  pcall(require, "impatient")
end, 0)

require('plugins')
require('core')