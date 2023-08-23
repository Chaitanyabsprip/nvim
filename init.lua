local config = require 'config'
config.disable_builtins()
vim.g.mapleader = ' '
require('config.lazy').setup()
config.options.setup()
require('config.keymap').setup()
vim.api.nvim_create_autocmd('User', {
  group = vim.api.nvim_create_augroup('init', { clear = true }),
  pattern = 'VeryLazy',
  callback = function()
    config.autocommands()
    config.lazy()
  end,
})
-- vim.lsp.set_log_level 'debug'
