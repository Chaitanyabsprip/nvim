local lsp = {}

lsp.lsp_lines = {
  plug = {
    'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
    config = "require('lsp_lines').setup()",
    after = { 'nvim-lspconfig' },
  },
}

lsp.code_actions = {
  plug = {
    'windwp/lsp-fastaction.nvim',
    config = function()
      require('plugins.lsp').code_actions.setup()
    end,
    after = 'nvim-lspconfig',
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

lsp.plug = { lsp.code_actions.plug, lsp.lsp_lines.plug }

return lsp