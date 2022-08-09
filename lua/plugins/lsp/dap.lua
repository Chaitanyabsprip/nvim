local nnoremap = require('mappings').nnoremap
local M = {}

M.setup = function() end

M.python = function()
  local dappy = require 'dap-python'
  dappy.setup '~/.virtualenvs/debugpy/bin/python'
  dappy.test_runner = 'pytest'
  -- nnoremap <silent> <leader>dn :lua require('dap-python').test_method()<CR>
  -- nnoremap <silent> <leader>df :lua require('dap-python').test_class()<CR>
  -- vnoremap <silent> <leader>ds <ESC>:lua require('dap-python').debug_selection()<CR>
end

M.ui = function()
  require('dapui').setup {
    mappings = { expand = { '<CR>', '<2-LeftMouse>', 'l' } },
    layouts = {
      {
        elements = {
          { id = 'scopes', size = 0.25 },
          { id = 'breakpoints', size = 0.25 },
          { id = 'watches', size = 00.25 },
          { id = 'stacks', size = 0.25 },
        },
        size = 40,
        position = 'right',
      },
      {
        elements = { 'repl', 'console' },
        size = 10,
        position = 'bottom',
      },
    },
  }
  nnoremap '<A-D>'(require('dapui').toggle) {} 'Toggle debugger UI'
end

M.go = function()
  require('dap-go').setup()
  print 'this is working'
  vim.keymap.set('n', '<leader>gt', function()
    require('dap-go').debug_test()
  end)
end
return M
