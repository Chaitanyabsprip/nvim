local lsp = {}

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

lsp.lsp_lines = {
  spec = {
    url = 'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
    event = 'BufReadPost',
    config = function() require('lsp_lines').setup() end,
  },
}

lsp.mason = {
  spec = {
    'williamboman/mason.nvim',
    config = function() require('mason').setup() end,
    dependencies = { 'RubixDev/mason-update-all' },
  },
}

lsp.mason_update = {
  spec = {
    'RubixDev/mason-update-all',
    config = function() require('mason-update-all').setup() end,
  },
}

lsp.mason_nullls = {
  spec = {
    'jay-babu/mason-null-ls.nvim',
    config = function()
      require 'mason'
      require('mason-null-ls').setup { automatic_installation = true }
    end,
  },
}

lsp.mason_lspconfig = {
  spec = {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require 'mason'
      require('mason-lspconfig').setup {
        automatic_installation = true,
      }
    end,
  },
}

lsp.navic = {
  spec = {
    'SmiteshP/nvim-navic',
    event = 'LspAttach',
    config = function()
      local navic = require 'nvim-navic'
      navic.setup { highlight = true, separator = '  ', depth_limit = 6 }
      require('lsp.capabilities').document_symbols.callback =
        function(client, bufnr) navic.attach(client, bufnr) end
    end,
  },
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
    config = true,
  },
}

lsp.rename = {
  spec = {
    'smjonas/inc-rename.nvim',
    cmd = 'IncRename',
    config = function()
      require('inc_rename').setup { preview_empty_name = true }
      local c = require 'lsp.capabilities'
      local nnoremap = require('mappings.hashish').nnoremap
      c.rename.callback = function()
        local opts = { bufnr = 0, silent = true, expr = true }
        nnoremap 'gr'(function() return ':IncRename ' .. vim.fn.expand '<cword> ' end)(opts) 'Rename symbol under cursor'
      end
    end,
  },
}

lsp.spec = {
  lsp.code_actions.spec,
  lsp.rename.spec,
  lsp.lsp_lines.spec,
  lsp.mason.spec,
  lsp.mason_lspconfig.spec,
  lsp.mason_nullls.spec,
  lsp.mason_update.spec,
  lsp.navic.spec,
  lsp.refactoring.spec,
}

return lsp
