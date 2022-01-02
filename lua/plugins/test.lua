local nnoremap = require('utils').nnoremap
local nmap = function(mode, key, cmd, silent)
  require('utils').map(mode, key, cmd, { silent = silent })
end
vim.g.ultest_output_on_run = 0
vim.g.ultest_output_on_line = 0
vim.g.ultest_max_threads = 4
vim.g.ultest_virtual_text = 1
vim.g.ultest_running_sign = ''
vim.g.ultest_pass_text = '✔'
vim.g.ultest_fail_text = '✖'
nmap('n', '<leader>trf', '<Plug>(ultest-run-file)', true)
nmap('n', '[t', '<Plug>(ultest-prev-fail)')
nmap('n', ']t', '<Plug>(ultest-next-fail)')
nnoremap('<A-S-t>', '<cmd>Ultest<cr>', true)
nnoremap('<A-c>', '<cmd>UltestClear<cr>', true)
nnoremap('<A-o>', '<cmd>UltestOutput<cr>', true)
nnoremap('<A-s>', '<cmd>UltestSummary<cr>', true)
nnoremap('<A-t>', '<cmd>UltestNearest<cr>', true)
