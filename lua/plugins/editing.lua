local editing = {}

editing.autoclose = {
  spec = {
    'm4xshen/autoclose.nvim',
    config = function() require('autoclose').setup {} end,
    event = { 'InsertEnter' },
  },
}

editing.matchparen = {
  spec = {
    'monkoose/matchparen.nvim',
    event = 'BufReadPost',
    config = function() require('matchparen').setup {} end,
  },
}

editing.mini_comment = {
  spec = {
    'echasnovski/mini.comment',
    branch = 'stable',
    event = { 'BufReadPost' },
    config = function() require('plugins.editing').mini_comment.setup() end,
  },
  setup = function() require('mini.comment').setup {} end,
}

editing.mini_autopairs = {
  spec = {
    'echasnovski/mini.pairs',
    branch = 'stable',
    event = { 'InsertEnter' },
    config = function() require('plugins.editing').mini_autopairs.setup() end,
  },
  setup = function() require('mini.pairs').setup { modes = { command = true, terminal = true } } end,
}

editing.ufo = {
  spec = {
    'kevinhwang91/nvim-ufo',
    event = 'BufReadPost',
    dependencies = { 'kevinhwang91/promise-async' },
    config = function() require('plugins.editing').ufo.setup() end,
  },
  setup = function()
    local nnoremap = require('mappings.hashish').nnoremap
    nnoremap 'zR'(require('ufo').openAllFolds) 'Open all folds'
    nnoremap 'zM'(require('ufo').closeAllFolds) 'Close all folds'
    require('ufo').setup()
  end,
}

editing.comment = editing.mini_comment
editing.autopairs = editing.autoclose

editing.spec = {
  editing.comment.spec,
  editing.autopairs.spec,
  editing.matchparen.spec,
  editing.ufo.spec,
}

return editing
