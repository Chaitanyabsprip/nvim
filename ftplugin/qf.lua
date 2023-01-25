vim.cmd 'syntax on'
local nnoremap = require('hashish').nnoremap

nnoremap '<leader>f'(function()
  vim.ui.input({ prompt = 'Filter: ', completion = 'buffer' }, function(input)
    if input == nil or input == '' then return end
    vim.cmd([[:Cfilter ]] .. input)
  end)
end) { buffer = 0 } 'Filter qf list'
