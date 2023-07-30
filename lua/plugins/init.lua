local plugin = {}

plugin.setup = function()
  local completion = require 'plugins.lsp.completion'
  local debugger = require 'plugins.lsp.debugger'
  local editing = require 'plugins.editing'
  local explorer = require 'plugins.explorer'
  local externals = require 'plugins.externals'
  local git = require 'plugins.git'
  local lsp = require 'plugins.lsp'
  local tools = require 'plugins.tools'
  local servers = require 'plugins.lsp.servers'
  local session = require 'plugins.session'
  local ui = require 'plugins.ui'

  plugin.spec = {
    completion.spec,
    editing.spec,
    explorer.spec,
    externals.spec,
    git.spec,
    tools.spec,
    session.spec,
    ui.spec,
    { debugger.spec, lsp.spec, servers.spec },
  }

  require('plugins.utils').bootstrap_packer()
  local lazy = require 'lazy'
  lazy.setup(plugin.spec, {
    defaults = { lazy = true },
    dev = { path = '~/Projects/Languages/Lua' },
    performance = {
      rtp = {
        disabled_plugins = plugin.disabled_builtins,
        paths = { '/usr/local/share/nvim/runtime/pack/dist/opt/cfilter' },
      },
    },
    install = { colorscheme = { 'rose-pine', 'tokyonight', 'habamax' } },
    checker = { enabled = true, notify = false },
    readme = { files = { 'README.md', 'readme.md', 'README.rst', 'readme.rst' } },
  })
end

plugin.disabled_builtins = {
  '2html_plugin',
  'getscript',
  'getscriptPlugin',
  'gzip',
  'logiPat',
  'man',
  'matchit',
  'matchparen',
  'netrw',
  'netrwFileHandlers',
  'netrwPlugin',
  'netrwSettings',
  'rrhelper',
  'shada_plugin',
  'tar',
  'tarPlugin',
  'tohtml',
  'tutor',
  'vimball',
  'vimballPlugin',
  'zip',
  'zipPlugin',
}

return plugin
