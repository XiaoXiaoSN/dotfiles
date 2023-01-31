local vim = vim

-- reference: https://github.com/jdhao/nvim-config/blob/master/lua/plugins.lua

--- Install Packer if it has not been installed.
--- Return:
--- true: if this is a fresh install of packer
--- false: if packer has been installed
local function packer_ensure_install()
  -- Where to install packer.nvim
  -- $HOME/.local/share/nvim/site/pack/packer/start/packer.nvim
  local packer_dir = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if vim.fn.glob(packer_dir) ~= '' then
    return false
  end

  -- Auto-install packer in case it hasn't been installed.
  vim.api.nvim_echo({ { 'Installing packer.nvim', 'Type' } }, true, {})

  local packer_repo = 'https://github.com/wbthomason/packer.nvim'
  local install_cmd = string.format('!git clone --depth=1 %s %s', packer_repo, packer_dir)
  vim.cmd(install_cmd)

  return true
end

local fresh_install = packer_ensure_install()

-- Load packer.nvim
vim.cmd('packadd packer.nvim')
local packer = require('packer')
local packer_util = require('packer.util')

packer.init({
  auto_clean = true,
  compile_on_sync = true,
  git = { clone_timeout = 6000 },
})
packer.startup({
  require('plugins.pluginList'),
  config = {
    max_jobs = 16,
    compile_path = packer_util.join_paths(vim.fn.stdpath('data'), 'site', 'lua', 'packer_compiled.lua'),
  },
})

-- For fresh install, we need to install plugins. Otherwise, we just need to require `packer_compiled.lua`.
if fresh_install then
  -- We run packer.sync() here, because only after packer.startup, can we know which plugins to install.
  -- So plugin installation should be done after the startup process.
  packer.sync()
else
  local status, _ = pcall(require, 'packer_compiled')
  if not status then
    local msg = 'File packer_compiled.lua not found: run PackerSync to fix!'
    vim.notify(msg, vim.log.levels.ERROR, { title = 'nvim-config' })
  end
end
