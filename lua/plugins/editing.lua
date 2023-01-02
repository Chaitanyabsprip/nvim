local editing = {}

editing.autoclose = {
  spec = {
    'm4xshen/autoclose.nvim',
    config = function() require('autoclose').setup {} end,
    event = { 'InsertEnter' },
  },
}

editing.hop = {
  spec = {
    'phaazon/hop.nvim',
    event = 'BufReadPost',
    branch = 'v2',
    keys = {
      {
        's',
        function() require('hop').hint_char2 { multi_windows = true } end,
        silent = true,
        noremap = true,
        desc = 'Initiate hop with 2 character search',
        mode = { 'n', 'x' },
      },
      {
        'S',
        function() require('hop').hint_words { multi_windows = true } end,
        silent = true,
        noremap = true,
        desc = 'Initiate hop to words',
        mode = { 'n', 'x' },
      },
      {
        'f',
        function() require('hop').hint_char1 { current_line_only = true } end,
        silent = true,
        noremap = true,
        desc = 'Initiate hop to letters in current line',
        mode = { 'n', 'x' },
      },
    },
    config = { jump_on_sole_occurrence = true, keys = 'nepoihufxbzyqjkcvlmwdasgrt' },
  },
}

editing.leap = {
  spec = {
    'ggandor/leap.nvim',
    event = 'BufReadPost',
    keys = {
      {
        's',
        function() require('leap').leap { target_windows = { vim.fn.win_getid() } } end,
        silent = true,
        noremap = true,
        desc = 'Initiate leap with 2 character search',
        mode = { 'n', 'x' },
      },
      {
        'S',
        function()
          require('leap').leap {
            target_windows = vim.tbl_filter(
              function(win) return vim.api.nvim_win_get_config(win).focusable end,
              vim.api.nvim_tabpage_list_wins(0)
            ),
          }
        end,
        silent = true,
        noremap = true,
        desc = 'Initiate leap to words',
        mode = { 'n', 'x' },
      },
      config = function()
        -- require('leap').opts.labels =
        --   { 'n', 'e', 'p', 'o', 'i', 'h', 't', 'r', 's', 'a', 'd', "'", 'l', ',', 'c', 'x', 'u' }
      end,
    },
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
  editing.autopairs.spec,
  editing.comment.spec,
  -- editing.hop.spec,
  editing.leap.spec,
  editing.matchparen.spec,
  editing.ufo.spec,
}

return editing
