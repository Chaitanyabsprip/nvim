vim.g.loaded_matchparen = 1
local config = require 'config'
config.options.disable_builtins()
vim.g.mapleader = ' '
require('plugins').setup()
config.options.setup()
require('config.mappings').setup()
vim.api.nvim_create_autocmd('User', {
  group = vim.api.nvim_create_augroup('init', { clear = true }),
  pattern = 'VeryLazy',
  callback = function()
    config.autocommands()
    config.options.lazy()
  end,
})
-- vim.lsp.set_log_level 'debug'
