local lsp = {}

lsp.code_actions = {
  'Chaitanyabsprip/lsp-fastaction.nvim',
  opts = {
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
  },
}

lsp.diagflow = {
  'dgagn/diagflow.nvim',
  event = 'LspAttach',
  opts = { scope = 'line', padding_top = 1 },
}

lsp.file_operations = {
  'antosha417/nvim-lsp-file-operations',
  dependencies = { 'nvim-lua/plenary.nvim', 'nvim-tree/nvim-tree.lua' },
  opts = {},
  event = 'LspAttach',
}

lsp.graphql = { 'jparise/vim-graphql', ft = 'graphql' }

lsp.mason = {
  'williamboman/mason.nvim',
  dependencies = { 'RubixDev/mason-update-all' },
  opts = {},
}

lsp.mason_dap = {
  'jay-babu/mason-nvim-dap.nvim',
  dependencies = { 'williamboman/mason.nvim' },
  opts = {},
}

lsp.mason_lspconfig = {
  'williamboman/mason-lspconfig.nvim',
  dependencies = { 'williamboman/mason.nvim' },
  opts = { automatic_installation = true },
}

lsp.mason_nulls = {
  'jay-babu/mason-null-ls.nvim',
  dependencies = { 'williamboman/mason.nvim', 'jose-elias-alvarez/null-ls.nvim' },
  ft = require('plugins.lsp.null').ft,
  opts = { automatic_installation = true },
}

lsp.mason_update = { 'RubixDev/mason-update-all', opts = {} }

lsp.refactoring = { 'ThePrimeagen/refactoring.nvim', opts = {} }

lsp.spec = {
  lsp.code_actions,
  lsp.diagflow,
  lsp.file_operations,
  lsp.graphql,
  lsp.mason,
  lsp.mason_lspconfig,
  lsp.mason_nulls,
  lsp.mason_update,
  lsp.refactoring,
}

return lsp.spec
