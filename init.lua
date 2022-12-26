local settings = require 'settings'
settings.setup()
local plugin = require 'plugins'
plugin.setup()
require('plugins.ui.greeter').setup()

vim.api.nvim_create_autocmd('User', {
  pattern = 'VeryLazy',
  callback = function()
    plugin.startup()
    settings.lazy()
    require('mappings').setup()
    require('autocommands').setup()
    require('plugins.ui').setup()
  end,
})

vim.defer_fn(function() vim.api.nvim_exec_autocmds('User', { pattern = 'VeryLazy' }) end, 500)

-- vim.lsp.set_log_level 'TRACE'
