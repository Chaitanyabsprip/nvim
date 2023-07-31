local editing = {}

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
        mode = { 'n' },
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
        mode = { 'n' },
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
    opts = {},
  },
}

editing.mini_comment = {
  spec = {
    'echasnovski/mini.comment',
    version = '*',
    event = { 'BufReadPost' },
    config = function() require('plugs.editing').mini_comment.setup() end,
  },
  setup = function() require('mini.comment').setup {} end,
}

editing.surround = {
  spec = {
    'kylechui/nvim-surround',
    version = '*',
    event = 'BufReadPre',
    opts = { keymaps = { visual = 's' } },
  },
}

editing.ufo = {
  spec = {
    'kevinhwang91/nvim-ufo',
    event = 'BufReadPost',
    dependencies = { 'kevinhwang91/promise-async' },
    config = function(plugin, opts) require('plugs.editing').ufo.setup(plugin, opts) end,
    opts = { close_fold_kinds = { 'imports', 'comment' } },
  },
  setup = function(_, opts)
    local nnoremap = require('hashish').nnoremap
    local ufo = require 'ufo'
    nnoremap 'zR'(ufo.openAllFolds) 'Open all folds'
    nnoremap 'zM'(ufo.closeAllFolds) 'Close all folds'
    local fold_win
    local hover = function()
      if fold_win and vim.api.nvim_win_is_valid(fold_win) then
        vim.api.nvim_set_current_win(fold_win)
      end
      fold_win = ufo.peekFoldedLinesUnderCursor()
      if not fold_win then
        vim.lsp.buf.hover()
      else
        vim.api.nvim_set_option_value('winhl', 'Normal:Normal', { win = fold_win })
        vim.api.nvim_set_option_value('winblend', 0, { win = fold_win })
      end
    end
    require('lsp.capabilities').hover.callback = function(_, bufnr)
      nnoremap 'K'(hover) { bufnr = bufnr, silent = true } 'Show hover info of symbol under cursor'
    end
    local ftMap = {
      markdown = 'treesitter',
    }

    ---@param bufnr number
    ---@return Promise
    local function customizeSelector(bufnr)
      local function handleFallbackException(err, providerName)
        if type(err) == 'string' and err:match 'UfoFallbackException' then
          return require('ufo').getFolds(bufnr, providerName)
        else
          return require('promise').reject(err)
        end
      end

      return require('ufo')
        .getFolds(bufnr, 'lsp')
        :catch(function(err) return handleFallbackException(err, 'treesitter') end)
        :catch(function(err) return handleFallbackException(err, 'indent') end)
    end
    opts.provider_selector = function(_, filetype, _) return ftMap[filetype] or customizeSelector end
    ufo.setup(opts)
  end,
}

editing.comment = editing.mini_comment

editing.spec = {
  editing.comment.spec,
  editing.leap.spec,
  editing.matchparen.spec,
  editing.surround.spec,
  editing.ufo.spec,
}

return editing
