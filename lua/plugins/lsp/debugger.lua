local debugger = {}

debugger.dap = {
  spec = {
    'mfussenegger/nvim-dap',
    config = function() require('plugins.lsp.debugger').dap.setup() end,
    keys = {
      {
        '<leader>b',
        function() require('dap').toggle_breakpoint() end,
        silent = true,
        noremap = true,
        desc = 'Toggle debug breakpoint',
      },
      {
        '<leader>c',
        function() require('dap').continue() end,
        silent = true,
        noremap = true,
        desc = 'Continue or start debugging',
      },
      {
        '<leader>so',
        function() require('dap').step_over() end,
        silent = true,
        noremap = true,
        desc = 'dap: step over',
      },
      {
        '<leader>si',
        function() require('dap').step_into() end,
        silent = true,
        noremap = true,
        desc = 'dap: step into',
      },
      {
        '<leader>sO',
        function() require('dap').step_out() end,
        silent = true,
        noremap = true,
        desc = 'dap: step out',
      },
    },
  },
  setup = function()
    local icons = { bookmark = '', bug = '' } --   '󰠭'
    vim.fn.sign_define {
      {
        name = 'DapBreakpoint',
        texthl = 'DapBreakpoint',
        text = icons.bug,
        linehl = '',
        numhl = 'DapBreakpoint',
      },
      {
        name = 'DapStopped',
        texthl = 'DapStopped',
        text = icons.bookmark,
        linehl = '',
        numhl = 'DapStopped',
      },
    }
    local dap = require 'dap'
    local ui_ok, dapui = pcall(require, 'dapui')
    if not ui_ok then return end
    dap.listeners.before.event_exited['dapui_config'] = function()
      dapui.close()
      vim.keymap.del('n', '<leader>K')
    end
    dap.listeners.before.event_terminated['dapui_config'] = function() dapui.close() end
    dap.listeners.after.event_initialized['dapui_config'] = function()
      dapui.open()
      local opts = { silent = true, noremap = false }
      require('hashish').nnoremap '<leader>K' '<cmd>lua require("dap.ui.variables").hover() <cr>'(
        opts
      ) 'dap: Show variable value'
    end
  end,
}

debugger.ui = {
  spec = {
    'rcarriga/nvim-dap-ui',
    config = function() require('plugins.lsp.debugger').ui.setup() end,
  },
  setup = function()
    require('dapui').setup {
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
          elements = { { id = 'repl', size = 0.75 }, { id = 'console', size = 0.25 } },
          size = 16,
          position = 'bottom',
        },
      },
    }
  end,
}

debugger.spec = {
  debugger.dap.spec,
  debugger.ui.spec,
}

return debugger
