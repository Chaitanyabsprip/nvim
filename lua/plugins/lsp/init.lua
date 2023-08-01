local lsp = {}

lsp.database = require 'plugins.lsp.database'
lsp.servers = require 'plugins.lsp.servers'
lsp.debugger = require 'plugins.lsp.debugger'
lsp.completion = require 'plugins.lsp.completion'

lsp.code_actions = {
  'Chaitanyabsprip/lsp-fastaction.nvim',
  dev = true,
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

lsp.graphql = { 'jparise/vim-graphql', ft = 'graphql' }

lsp.lsp_lines = {
  url = 'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
  event = 'BufReadPost',
  opts = {},
}

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
  ft = lsp.servers.null.ft,
  opts = { automatic_installation = true },
}

lsp.mason_update = { 'RubixDev/mason-update-all', opts = {} }

lsp.navic = {
  'SmiteshP/nvim-navic',
  event = 'LspAttach',
  opts = { highlight = true, separator = '  ', depth_limit = 6 },
  config = function(_, opts)
    local navic = require 'nvim-navic'
    navic.setup(opts)
    vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
    require('lsp.capabilities').document_symbols.callback = navic.attach
  end,
}

lsp.refactoring = { 'ThePrimeagen/refactoring.nvim', opts = {} }

lsp.rename = {
  'smjonas/inc-rename.nvim',
  event = 'LspAttach',
  config = function()
    require('inc_rename').setup { preview_empty_name = true }
    local c = require 'lsp.capabilities'
    local nnoremap = require('hashish').nnoremap
    c.rename.callback = function()
      local opts = { bufnr = 0, silent = true, expr = true }
      nnoremap 'gr'(function() return ':IncRename ' .. vim.fn.expand '<cword> ' end)(opts) 'Rename symbol under cursor'
    end
  end,
}

lsp.spec = {
  lsp.code_actions,
  lsp.completion.spec,
  lsp.database.spec,
  lsp.debugger.spec,
  lsp.graphql,
  lsp.lsp_lines,
  lsp.mason,
  lsp.mason_lspconfig,
  lsp.mason_nulls,
  lsp.mason_update,
  lsp.navic,
  lsp.refactoring,
  lsp.rename,
  lsp.servers.spec,
}

return lsp.spec
