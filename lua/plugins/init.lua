local plugin = {}

local completion = require 'plugins.lsp.completion'
local editing = require 'plugins.editing'
local explorer = require 'plugins.explorer'
local externals = require 'plugins.externals'
local git = require 'plugins.git'
local lsp = require 'plugins.lsp'
local misc = require 'plugins.misc'
local servers = require 'plugins.lsp.servers'
local session = require 'plugins.session'
local ui = require 'plugins.ui'

plugin.spec = {
  completion.spec,
  editing.spec,
  explorer.spec,
  externals.spec,
  git.spec,
  misc.spec,
  session.spec,
  ui.spec,
  { lsp.spec, servers.spec },
}

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

plugin.setup = function()
  require('plugins.utils').bootstrap_packer()
  require('lazy').setup(plugin.spec, {
    defaults = { lazy = true },
    dev = { path = '~/Projects/Languages/Lua' },
    performance = { rtp = { disabled_plugins = plugin.disabled_builtins } },
    readme = { files = { 'README.md', 'readme.md', 'README.rst', 'readme.rst' } },
  })
end
return plugin
