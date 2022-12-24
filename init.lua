local start = vim.loop.hrtime()
require('plugins').setup()
local delta = vim.loop.hrtime() - start

vim.api.nvim_create_autocmd('User', {
  pattern = 'VeryLazy',
  callback = function()
    vim.notify('Lazy took ' .. (delta / 1e6) .. 'ms')
    require('settings').setup()
    require('mappings').setup()
    require('autocommands').setup()
    require('plugins.ui').setup()
  end,
})

-- vim.lsp.set_log_level 'TRACE'
