local plugin = {}

plugin.setup = function()
  local completion = require 'plugs.lsp.completion'
  local debugger = require 'plugs.lsp.debugger'
  local editing = require 'plugs.editing'
  local explorer = require 'plugs.explorer'
  local externals = require 'plugs.externals'
  local git = require 'plugs.git'
  local lsp = require 'plugs.lsp'
  local tools = require 'plugs.tools'
  local servers = require 'plugs.lsp.servers'
  local session = require 'plugs.session'
  local ui = require 'plugs.ui'

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

  plugin.disabled_builtins = {
    '2html_plugin',
    'getscript',
    'getscriptPlugin',
    'editorconfig',
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

  require('plugs.utils').bootstrap_packer()
  require('lazy').setup(plugin.spec, {
    defaults = { lazy = true },
    dev = { path = '~/Projects/Languages/Lua' },
    performance = {
      rtp = {
        disabled_plugins = plugin.disabled_builtins,
        -- paths = { '/usr/local/share/nvim/runtime/pack/dist/opt/cfilter' },
      },
    },
    install = { colorscheme = { 'rose-pine', 'tokyonight', 'habamax' } },
    checker = { enabled = true, notify = false },
    readme = { files = { 'README.md', 'readme.md', 'README.rst', 'readme.rst' } },
  })
end

return plugin
