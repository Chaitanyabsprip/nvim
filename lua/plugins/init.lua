local packer_bootstrap, _ = require('plugins.utils').bootstrap_packer()

local status_ok, packer = pcall(require, 'packer')

if not status_ok then
  return
end

local use = packer.use

return packer.startup(function()
  local completion = require 'plugins.lsp.completion'
  local editing = require 'plugins.editing'
  local explorer = require 'plugins.explorer'
  local git = require 'plugins.git'
  local lsp = require 'plugins.lsp'
  local servers = require 'plugins.lsp.servers'
  local session = require 'plugins.session'
  local ui = require 'plugins.ui'
  local externals = require 'plugins.externals'

  use 'wbthomason/packer.nvim' -- packer manages itself

  use(completion.plug)
  use(editing.plug)
  use(explorer.plug)
  use(externals.plug)
  use(git.plug)
  use { lsp.plug, servers.plug }
  use(session.plug)
  use(ui.plug)
  use { 'dag/vim-fish', ft = 'fish' }
  use {
    'dstein64/vim-startuptime',
    cmd = 'StartupTime',
    config = [[vim.g.startuptime_tries = 50]],
  }
  if packer_bootstrap then
    packer.sync()
  end
end)
