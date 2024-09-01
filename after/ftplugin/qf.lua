vim.cmd 'syntax on'
vim.opt_local.number = false
vim.opt_local.relativenumber = false
vim.opt_local.buflisted = false
vim.o.statuscolumn = ''

vim.keymap.set('n', '<leader>f', function()
    vim.ui.input({ prompt = 'Filter: ', completion = 'buffer' }, function(input)
        if input == nil or input == '' then return end
        vim.cmd([[:Cfilter ]] .. input)
    end)
end, { noremap = true, buffer = 0, desc = 'Filter qf list' })

vim.keymap.set('n', 'dd', function()
    local qf = require 'quickfix'
    if vim.g.qf_source == 'buffers' then qf.delete_buf_from_qf() end
    qf.delete_qf_entry()
end, { noremap = true, buffer = 0, desc = 'Delete current entry from quickfix list' })
