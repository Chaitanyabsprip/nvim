---@diagnostic disable: no-unknown
local editing = {}

editing.bigfiles = {
  'LunarVim/bigfile.nvim',
  event = 'BufReadPre',
  opts = {},
}

editing.comment = {
  'echasnovski/mini.comment',
  version = '*',
  event = { 'BufReadPost' },
  opts = {},
}

editing.eyeliner = {
  'jinh0/eyeliner.nvim',
  event = 'BufReadPre',
  opts = {
    highlight_on_key = true,
    dim = true,
  },
}
editing.hfcc = {
  'huggingface/hfcc.nvim',
  opts = {
    api_token = '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',
    model = 'bigcode/starcoder',
    query_params = {
      max_new_tokens = 200,
    },
  },
  init = function()
    vim.api.nvim_create_user_command(
      'StarCoder',
      function() require('hfcc.completion').complete() end,
      {}
    )
  end,
}
editing.hop = {
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
}

editing.leap = {
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
            ---@param win number
            ---@return boolean
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
    -- config = function()
    --   require('leap').opts.labels =
    --     { 'n', 'e', 'p', 'o', 'i', 'h', 't', 'r', 's', 'a', 'd', "'", 'l', ',', 'c', 'x', 'u' }
    -- end,
  },
}

editing.matchparen = {
  'monkoose/matchparen.nvim',
  event = 'BufReadPost',
  opts = {},
}

editing.matchup = {
  'andymass/vim-matchup',
  event = 'BufReadPost',
  enabled = false,
  init = function() vim.o.matchpairs = '(:),{:},[:],<:>' end,
  config = function()
    vim.g.matchup_matchparen_deferred = 1
    vim.g.matchup_matchparen_offscreen = { method = 'status_manual' }
  end,
}

editing.miniai = {
  'echasnovski/mini.ai',
  keys = {
    { 'a', mode = { 'x', 'o' } },
    { 'i', mode = { 'x', 'o' } },
  },
  event = 'BufReadPre',
  dependencies = { 'nvim-treesitter-textobjects' },
  opts = function()
    local ai = require 'mini.ai'
    return {
      n_lines = 500,
      custom_textobjects = {
        o = ai.gen_spec.treesitter({
          a = { '@block.outer', '@conditional.outer', '@loop.outer' },
          i = { '@block.inner', '@conditional.inner', '@loop.inner' },
        }, {}),
        f = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }, {}),
        c = ai.gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }, {}),
      },
    }
  end,
  config = function(_, opts)
    require('mini.ai').setup(opts)

    -- add treesitter jumping
    ---@param capture string
    ---@param start boolean
    ---@param down boolean
    local function jump(capture, start, down)
      local rhs = function()
        local parser = vim.treesitter.get_parser()
        if not parser then
          return vim.notify('No treesitter parser for the current buffer', vim.log.levels.ERROR)
        end

        local query = vim.treesitter.query.get(vim.bo.filetype, 'textobjects')
        if not query then
          return vim.notify('No textobjects query for the current buffer', vim.log.levels.ERROR)
        end

        local cursor = vim.api.nvim_win_get_cursor(0)

        ---@type {[1]:number, [2]:number}[]
        local locs = {}
        for _, tree in ipairs(parser:trees()) do
          ---@diagnostic disable-next-line: missing-parameter
          for capture_id, node, _ in query:iter_captures(tree:root(), 0) do
            if query.captures[capture_id] == capture then
              local range = { node:range() } ---@type number[]
              local row = (start and range[1] or range[3]) + 1
              local col = (start and range[2] or range[4]) + 1
              if down and row > cursor[1] or (not down) and row < cursor[1] then
                table.insert(locs, { row, col })
              end
            end
          end
        end
        return pcall(vim.api.nvim_win_set_cursor, 0, down and locs[1] or locs[#locs])
      end

      local c = capture:sub(1, 1):lower()
      local lhs = (down and ']' or '[') .. (start and c or c:upper())
      local desc = (down and 'Next ' or 'Prev ')
        .. (start and 'start' or 'end')
        .. ' of '
        .. capture:gsub('%..*', '')
      vim.keymap.set('n', lhs, rhs, { desc = desc })
    end

    for _, capture in ipairs { 'function.outer', 'class.outer' } do
      for _, start in ipairs { true, false } do
        for _, down in ipairs { true, false } do
          jump(capture, start, down)
        end
      end
    end
  end,
}

editing.spider = {
  'chrisgrieser/nvim-spider',
  opts = {},
  keys = {
    {
      'w',
      "<cmd>lua require('spider').motion('w')<cr>",
      desc = 'Spider: w',
      mode = { 'n', 'o', 'x' },
    },
    {
      'e',
      "<cmd>lua require('spider').motion('e')<cr>",
      desc = 'Spider: e',
      mode = { 'n', 'o', 'x' },
    },
    {
      'b',
      "<cmd>lua require('spider').motion('b')<cr>",
      desc = 'Spider: b',
      mode = { 'n', 'o', 'x' },
    },
  },
}

editing.surround = {
  'kylechui/nvim-surround',
  version = '*',
  event = 'BufReadPre',
  opts = { keymaps = { visual = 's' } },
}

editing.ufo = {
  'kevinhwang91/nvim-ufo',
  event = 'BufReadPost',
  dependencies = { 'kevinhwang91/promise-async' },
  config = function(_, opts)
    local nnoremap = require('hashish').nnoremap
    local ufo = require 'ufo'
    nnoremap 'zR'(ufo.openAllFolds) 'Open all folds'
    nnoremap 'zM'(ufo.closeAllFolds) 'Close all folds'
    ---@type number?
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
  opts = { close_fold_kinds = { 'imports', 'comment' } },
}

editing.spec = {
  editing.comment,
  editing.eyeliner,
  editing.hfcc,
  editing.leap,
  editing.matchparen,
  editing.miniai,
  -- editing.spider,
  editing.surround,
  editing.ufo,
}

return editing.spec
