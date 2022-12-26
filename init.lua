local settings = require 'settings'
settings.setup()
require('plugins.ui.greeter').setup()
vim.defer_fn(function()
  local plugin = require 'plugins'
  plugin.setup()
  vim.api.nvim_create_autocmd('User', {
    pattern = 'VeryLazy',
    callback = function()
      plugin.startup()
      settings.lazy()
      require('mappings').setup()
      require('autocommands').setup()
      require('plugins.ui').setup()
      vim.o.shadafile = ''
    end,
  })
  vim.api.nvim_exec_autocmds('User', { pattern = 'VeryLazy' })
end, 50)

-- vim.lsp.set_log_level 'TRACE'
