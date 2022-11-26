local M = {}
local nnoremap = require('mappings').nnoremap

M.neotest = function()
  require('neotest').setup {
    icons = {
      child_indent = '│',
      child_prefix = '├',
      collapsed = '─',
      expanded = '╮',
      failed = 'x',
      final_child_indent = ' ',
      final_child_prefix = '╰',
      non_collapsible = '─',
      passed = '',
      running = '',
      running_animated = { '/', '|', '\\', '-', '/', '|', '\\', '-' },
      skipped = 'ﭡ',
      unknown = '',
    },
    adapters = {
      require 'neotest-vim-test' {
        ignore_filetypes = { 'python', 'lua', 'javascript' },
      },
      require 'neotest-dart' { command = 'fvm flutter' },
      require 'neotest-python' { runner = 'pytest' },
      require 'neotest-go',
      require 'neotest-jest',
    },
  }
  nnoremap '<leader>rn' '<cmd>lua require"neotest".run.run()<cr>' {} 'Run nearest test'
  nnoremap '<leader>ss' '<cmd>lua require"neotest".summary.toggle()<cr>' {} 'Run nearest test'
  nnoremap '<leader>ra' '<cmd>lua require"neotest".run.run(vim.fn.expand("%"))<cr>' {} 'Run test for file'
end

M.ultest = function()
  -- local nnoremap = require('utils').nnoremap
  -- local nmap = function(mode, key, cmd, silent)
  --   require('utils').map(mode, key, cmd, { silent = silent })
  -- end
  -- vim.g.ultest_output_on_run = 0
  -- vim.g.ultest_output_on_line = 0
  -- vim.g.ultest_max_threads = 4
  -- vim.g.ultest_virtual_text = 1
  -- vim.g.ultest_running_sign = ''
  -- vim.g.ultest_pass_text = '✔'
  -- vim.g.ultest_fail_text = '✖'
  -- nmap('n', '<leader>trf', '<Plug>(ultest-run-file)', true)
  -- nmap('n', '[t', '<Plug>(ultest-prev-fail)')
  -- nmap('n', ']t', '<Plug>(ultest-next-fail)')
  -- nnoremap('<A-S-t>', '<cmd>Ultest<cr>', true)
  -- nnoremap('<A-c>', '<cmd>UltestClear<cr>', true)
  -- nnoremap('<A-o>', '<cmd>UltestOutput<cr>', true)
  -- nnoremap('<A-s>', '<cmd>UltestSummary<cr>', true)
  -- nnoremap('<A-t>', '<cmd>UltestNearest<cr>', true)
end
return M
