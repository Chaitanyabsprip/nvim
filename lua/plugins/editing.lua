local editing = {}

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

editing.comment = editing.mini_comment
editing.autopairs = editing.mini_autopairs

editing.spec = { editing.comment.spec, editing.autopairs.spec }

return editing
