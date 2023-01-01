vim.g.loaded_matchparen = 1
local plugin = require 'plugins'
plugin.setup()
local settings = require 'settings'
settings.setup()
require('mappings').setup()
vim.defer_fn(function()
  vim.api.nvim_create_autocmd('User', {
    pattern = 'VeryLazy',
    callback = function()
      plugin.startup()
      settings.lazy()
      require('autocommands').setup()
      require('plugins.ui').setup()
      vim.o.shadafile = ''
    end,
  })
  vim.api.nvim_exec_autocmds('User', { pattern = 'VeryLazy' })
  require('plugins.ui.greeter').setup()
end, 50)

-- vim.lsp.set_log_level 'TRACE'
