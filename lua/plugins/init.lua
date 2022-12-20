return function()
  require('plugins.utils').bootstrap_packer()

  local status_ok, lazy = pcall(require, 'lazy')

  if not status_ok then return end

  local completion = require 'plugins.lsp.completion'
  local editing = require 'plugins.editing'
  local explorer = require 'plugins.explorer'
  local git = require 'plugins.git'
  local lsp = require 'plugins.lsp'
  local servers = require 'plugins.lsp.servers'
  local session = require 'plugins.session'
  local ui = require 'plugins.ui'
  local externals = require 'plugins.externals'

  local a = {
    completion.plug,
    editing.plug,
    explorer.plug,
    externals.plug,
    git.plug,
    { lsp.plug, servers.plug },
    session.plug,
    ui.plug,
    { 'dag/vim-fish', ft = 'fish' },
    {
      'dstein64/vim-startuptime',
      cmd = 'StartupTime',
      config = function() vim.g.startuptime_tries = 50 end,
    },
  }
  lazy.setup(a, {
    defaults = { lazy = true },
    rtp = {
      disabled_plugins = {
        'gzip',
        'matchit',
        'matchparen',
        'netrwPlugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  })
end
