local lsp = {}

lsp.database = require 'plugs.lsp.database'

lsp.code_actions = {
  spec = {
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
  },
}

lsp.lsp_lines = {
  spec = {
    url = 'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
    event = 'BufReadPost',
    opts = {},
  },
}

lsp.mason = {
  spec = {
    'williamboman/mason.nvim',
    dependencies = { 'RubixDev/mason-update-all' },
    opts = {},
  },
}

lsp.mason_update = { spec = { 'RubixDev/mason-update-all', opts = {} } }

lsp.mason_nullls = {
  spec = {
    'jay-babu/mason-null-ls.nvim',
    opts = { automatic_installation = true },
    config = function(_, opts)
      require 'mason'
      require('mason-null-ls').setup(opts)
    end,
  },
}

lsp.mason_lspconfig = {
  spec = {
    'williamboman/mason-lspconfig.nvim',
    opts = { automatic_installation = true },
    config = function(_, opts)
      require 'mason'
      require('mason-lspconfig').setup(opts)
    end,
  },
}

lsp.mason_dap = {
  spec = {
    'jay-babu/mason-nvim-dap.nvim',
    config = function()
      require 'mason'
      require('mason-nvim-dap').setup()
    end,
  },
}

lsp.navic = {
  spec = {
    'SmiteshP/nvim-navic',
    event = 'LspAttach',
    config = function()
      local navic = require 'nvim-navic'
      -- local get_location = function()
      --   local location = navic.get_location {}
      --   return (#location > 0 and ' ' or '~') .. location
      -- end
      navic.setup { highlight = true, separator = '  ', depth_limit = 6 }
      vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
      require('lsp.capabilities').document_symbols.callback = navic.attach
    end,
  },
}

lsp.refactoring = { spec = { 'ThePrimeagen/refactoring.nvim', opts = {} } }

lsp.rename = {
  spec = {
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
  },
}

lsp.graphql = { spec = { 'jparise/vim-graphql', ft = 'graphql' } }

lsp.spec = {
  lsp.code_actions.spec,
  lsp.database.spec,
  lsp.graphql.spec,
  lsp.lsp_lines.spec,
  lsp.mason.spec,
  lsp.mason_lspconfig.spec,
  lsp.mason_nullls.spec,
  lsp.mason_update.spec,
  lsp.navic.spec,
  lsp.refactoring.spec,
  lsp.rename.spec,
}

return lsp
