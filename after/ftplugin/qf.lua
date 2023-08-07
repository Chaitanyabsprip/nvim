vim.cmd 'syntax on'
vim.opt_local.number = false
vim.opt_local.relativenumber = false
vim.opt_local.buflisted = false
vim.o.statuscolumn = ' '

local nnoremap = require('hashish').nnoremap

nnoremap '<leader>f'(function()
  vim.ui.input({ prompt = 'Filter: ', completion = 'buffer' }, function(input)
    if input == nil or input == '' then return end
    vim.cmd([[:Cfilter ]] .. input)
  end)
end) { bufnr = 0 } 'Filter qf list'

nnoremap 'dd'(function()
  local qf = require 'quickfix'
  qf.delete_buf_from_qf()
  qf.delete_qf_entry()
end) { noremap = true, bufnr = 0 } 'Delete current entry from quickfix list'
