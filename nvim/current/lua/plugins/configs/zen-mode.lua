local present, zen = pcall(require, 'zen-mode')
if not present then
  return
end

local options = {
  window = {
    backdrop = 0.98,
    width = 100,
    height = 1,
    options = {
      -- signcolumn = 'no', -- disable signcolumn
      -- number = false, -- disable number column
      -- relativenumber = false, -- disable relative numbers
      -- cursorline = false, -- disable cursorline
      -- cursorcolumn = false, -- disable cursor column
      -- foldcolumn = '0', -- disable fold column
      -- list = false, -- disable whitespace characters
    },
  },
  plugins = {
    tmux = { enabled = true },
  },
}

zen.setup(options)
