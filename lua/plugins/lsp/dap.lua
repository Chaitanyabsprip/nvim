local prequire = require('utils').preq
local nnoremap = require('mappings').nnoremap
local M = {}

M.setup = function()
  local dap = prequire 'dap'

  dap.set_log_level 'DEBUG'

  dap.listeners.after.event_initialized['dapui_config'] = function()
    prequire('dapui').open()
  end
  dap.listeners.before.event_terminated['dapui_config'] = function()
    prequire('dapui').close()
  end

  nnoremap '<leader>dcm' "<CMD>lua require('telescope').extensions.dap.commands {}<CR>" {
    silent = true,
  } 'Show debugger commands'
  nnoremap '<leader>dcf' "<CMD>lua require('telescope').extensions.dap.configurations {}<CR>" {
    silent = true,
  } 'Show debugger configurations'
  nnoremap '<leader>dcb' "<CMD>lua require('telescope').extensions.dap.list_breakpoints {}<CR>" {
    silent = true,
  } 'Show debugger breakpoints'
  nnoremap '<leader>dv' "<CMD>lua require('telescope').extensions.dap.variables {}<CR>" {
    silent = true,
  } 'Show debugger variables'
  nnoremap '<leader>df' "<CMD>lua require('telescope').extensions.dap.frames {}<CR>" {
    silent = true,
  } 'Show debugger frames'
  nnoremap '<leader>b' "<CMD>lua require('dap').toggle_breakpoint()<CR>" {
    silent = true,
  } 'Add a breakpoint'
  nnoremap '<leader>B' "<CMD>lua require('dap').set_breakpoint(vim.fn.input 'Breakpoint Condition: ')<CR>" {
    silent = true,
  } 'Add a breakpoint with condition'
  nnoremap '<leader>c' "<CMD>lua require('dap').continue()<CR>" { silent = true } 'Continue debugging'
  nnoremap '<C-u>' "<CMD>lua require('dap').step_over()<CR>" { silent = true } 'Step Over'
  nnoremap '<C-x>' "<CMD>lua require('dap').step_out()<CR>" { silent = true } 'Step Out'
  nnoremap '<C-i>' "<CMD>lua require('dap').step_into()<CR>" { silent = true } 'Step Into'
  nnoremap '<leader>ro' "<CMD>lua require'dap'.repl.open()<CR>" { silent = true } 'Open REPL'
end

M.python = function()
  local dappy = prequire 'dap-python'
  dappy.setup '~/.virtualenvs/debugpy/bin/python'
  dappy.test_runner = 'pytest'
  -- nnoremap <silent> <leader>dn :lua require('dap-python').test_method()<CR>
  -- nnoremap <silent> <leader>df :lua require('dap-python').test_class()<CR>
  -- vnoremap <silent> <leader>ds <ESC>:lua require('dap-python').debug_selection()<CR>
end

M.ui = function()
  prequire('dapui').setup {
    mappings = {
      expand = { '<CR>', '<2-LeftMouse>', 'l' },
      open = 'o',
      remove = 'd',
      edit = 'e',
      repl = 'r',
      toggle = 't',
    },
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
  -- vim.keymap.set('n', '<A-D>', function()
  --   require('dapui').toggle()
  -- end, { silent = true, desc = 'Toggle debugger UI' })
  nnoremap '<A-D>' (function()
    require('dapui').toggle()
  end) { silent = true } 'Toggle debugger UI'
end

M.go = function()
  prequire('dap-go').setup()
  vim.keymap.set('n', '<leader>gt', function()
    require('dap-go').debug_test()
  end)
end
return M
