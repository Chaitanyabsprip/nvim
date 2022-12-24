local lsp = {}

lsp.lsp_lines = {
  spec = {
    url = 'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
    event = 'BufReadPost',
    config = function() require('lsp_lines').setup() end,
  },
}

lsp.code_actions = {
  spec = {
    'Chaitanyabsprip/lsp-fastaction.nvim',
    config = function() require('plugins.lsp').code_actions.setup() end,
    dev = true,
  },
  setup = function()
    local fastaction = require 'lsp-fastaction'
    local opts = {
      hide_cursor = true,
      action_data = {
        dart = {
          { order = 1, pattern = 'import library', key = 'i' },
          { order = 1, pattern = 'organize imports', key = 'o' },
          { order = 1, pattern = 'relative imports everywhere', key = 'l' },
          { order = 2, pattern = 'sort member', key = 's' },
          { order = 2, pattern = 'wrap with widget', key = 'w' },
          { order = 3, pattern = 'extract widget', key = 'x' },
          { order = 4, pattern = 'column', key = 'c' },
          { order = 4, pattern = 'extract method', key = 'e' },
          { order = 4, pattern = 'padding', key = 'p' },
          { order = 4, pattern = 'remove', key = 'r' },
          { order = 4, pattern = 'wrap with padding', key = 'p' },
          { order = 5, pattern = 'add', key = 'a' },
          { order = 5, pattern = 'extract local', key = 'v' },
        },
      },
    }

    fastaction.setup(opts)
  end,
}

lsp.refactoring = {
  spec = {
    'ThePrimeagen/refactoring.nvim',
    init = function()
      vim.keymap.set(
        'v',
        '<leader>r',
        function() require('refactoring').select_refactor() end,
        { noremap = true, silent = true, expr = false }
      )
    end,
    config = function() require('refactoring').setup {} end,
  },
}

lsp.spec = {
  lsp.code_actions.spec,
  lsp.lsp_lines.spec,
  lsp.refactoring.spec,
}

return lsp
