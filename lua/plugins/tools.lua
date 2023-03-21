local tools = {}

tools.cellular_automation = {
  spec = { 'eandrju/cellular-automaton.nvim', cmd = 'CellularAutomation' },
}

tools.colorizer = {
  'NvChad/nvim-colorizer.lua',
  cmd = { 'ColorizerAttachToBuffer', 'ColorizerToggle' },
  config = {
    filetypes = { '*', '!lazy' },
    buftype = { '*', '!prompt', '!nofile' },
    user_default_options = {
      names = false,
      RRGGBBAA = true,
      AARRGGBB = true,
      css_fn = true,
      -- Available modes for `mode`: foreground, background,  virtualtext
      mode = 'background', -- Set the display mode.
      virtualtext = '███',
    },
  },
}

tools.drop = {
  spec = {
    'folke/drop.nvim',
    event = 'VeryLazy',
    config = function()
      require('drop').setup {
        theme = 'leaves',
        interval = 150,
        max = 90,
        screensaver = 1000 * 60 * 2,
        filetypes = { 'greeter' },
      }
    end,
  },
}

tools.fish = { spec = { 'dag/vim-fish', ft = 'fish' } }

tools.neotest = {
  spec = {
    'nvim-neotest/neotest',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-treesitter/nvim-treesitter' },
      { 'sidlatau/neotest-dart' },
      { 'nvim-neotest/neotest-go' },
      { 'antoinemadec/FixCursorHold.nvim' },
    },
    config = function() require('plugins.tools').neotest.setup() end,
    version = '2.*',
    event = 'VeryLazy',
  },
  setup = function()
    local nnoremap = require('hashish').nnoremap

    require('neotest').setup {
      quickfix = { open = false },
      status = { icons = true, virtual_text = false },
      icons = {
        running_animated = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
      },
      adapters = {
        require 'neotest-dart' { command = 'flutter', use_lsp = true },
        require 'neotest-go',
      },
    }
    local neotest_config = vim.api.nvim_create_augroup('NeotestConfig', { clear = true })
    for _, ft in ipairs { 'output', 'attach', 'summary' } do
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'neotest-' .. ft,
        group = neotest_config,
        callback = function(opts)
          nnoremap 'q'(function() pcall(vim.api.nvim_win_close, 0, true) end) { buffer = opts.buf }(
            'Quit ' .. ft
          )
        end,
      })
    end

    nnoremap '<leader>tn'(function() require('neotest').run.run() end) 'Run nearest test'
    nnoremap '<leader>tl'(function() require('neotest').run.run_last() end) 'Run nearest test'
    nnoremap '<leader>ta'(function() require('neotest').run.run(vim.fn.expand '%') end) 'Run test for file'
    nnoremap '<leader>ts'(function() require('neotest').summary.toggle() end) 'Toggle tests summary'
    nnoremap '<leader>to'(function() require('neotest').output.open { enter = true } end) 'Toggle tests summary'
  end,
}

tools.peek = {
  spec = {
    'toppair/peek.nvim',
    build = 'deno task --quiet build:fast',
    keys = {
      {
        '<leader>op',
        function()
          local peek = require 'peek'
          if peek.is_open() then
            peek.close()
          else
            peek.open()
          end
        end,
        desc = 'Peek (Markdown Preview)',
      },
    },
    opts = { app = 'browser' },
  },
}

tools.startuptime = {
  spec = {
    'dstein64/vim-startuptime',
    cmd = 'StartupTime',
    config = function() vim.g.startuptime_tries = 50 end,
  },
}

tools.mkdnflow = {
  spec = {
    'jakewvincent/mkdnflow.nvim',
    ft = { 'md', 'markdown' },
    config = function()
      require('mkdnflow').setup {
        modules = {
          bib = false,
          buffers = false,
          conceal = true,
          cursor = true,
          folds = true,
          links = false,
          lists = true,
          maps = false,
          paths = false,
          tables = true,
          yaml = false,
        },
        create_dirs = false,
        perspective = {
          priority = 'first',
          fallback = 'current',
          root_tell = false,
          nvim_wd_heel = false,
          update = false,
        },
        links = {
          style = 'wiki',
          name_is_source = false,
          conceal = false,
          context = 0,
          implicit_extension = nil,
          transform_implicit = false,
          transform_explicit = function(text)
            text = text:gsub(' ', '-')
            text = text:lower()
            text = os.date '%Y-%m-%d_' .. text
            return text
          end,
        },
        to_do = {
          symbols = { ' ', 'x' },
          update_parents = true,
          not_started = ' ',
          in_progress = '-',
          complete = 'x',
        },
        tables = {
          trim_whitespace = true,
          format_on_move = true,
          auto_extend_rows = false,
          auto_extend_cols = false,
        },
        yaml = {
          bib = { override = false },
        },
        mappings = {
          MkdnEnter = { { 'n', 'v' }, '<CR>' },
          MkdnTab = false,
          MkdnSTab = false,
          MkdnNextLink = { 'n', '<Tab>' },
          MkdnPrevLink = { 'n', '<S-Tab>' },
          MkdnNextHeading = { 'n', ']]' },
          MkdnPrevHeading = { 'n', '[[' },
          MkdnGoBack = { 'n', '<BS>' },
          MkdnGoForward = { 'n', '<Del>' },
          MkdnCreateLink = false, -- see MkdnEnter
          MkdnCreateLinkFromClipboard = { { 'n', 'v' }, '<leader>p' }, -- see MkdnEnter
          MkdnFollowLink = false, -- see MkdnEnter
          MkdnDestroyLink = { 'n', '<M-CR>' },
          MkdnTagSpan = { 'v', '<M-CR>' },
          MkdnMoveSource = { 'n', '<F2>' },
          MkdnYankAnchorLink = { 'n', 'ya' },
          MkdnYankFileAnchorLink = { 'n', 'yfa' },
          MkdnIncreaseHeading = { 'n', '+' },
          MkdnDecreaseHeading = { 'n', '-' },
          MkdnToggleToDo = { { 'n', 'v' }, '<C-Space>' },
          MkdnNewListItem = false,
          MkdnNewListItemBelowInsert = { 'n', 'o' },
          MkdnNewListItemAboveInsert = { 'n', 'O' },
          MkdnExtendList = false,
          MkdnUpdateNumbering = { 'n', '<leader>nn' },
          MkdnTableNextCell = { 'i', '<Tab>' },
          MkdnTablePrevCell = { 'i', '<S-Tab>' },
          MkdnTableNextRow = false,
          MkdnTablePrevRow = { 'i', '<M-CR>' },
          MkdnTableNewRowBelow = { 'n', '<leader>ir' },
          MkdnTableNewRowAbove = { 'n', '<leader>iR' },
          MkdnTableNewColAfter = { 'n', '<leader>ic' },
          MkdnTableNewColBefore = { 'n', '<leader>iC' },
          MkdnFoldSection = { 'n', '<leader>f' },
          MkdnUnfoldSection = { 'n', '<leader>F' },
        },
      }
      local nnoremap = require('hashish').nnoremap
      nnoremap '<c-space>' '<cmd>MkdnToggleToDo<CR>' 'Toggle todo'
    end,
  },
}

tools.obsidian = {
  spec = {
    'epwalsh/obsidian.nvim',
    dependencies = {
      {
        'preservim/vim-markdown',
        ft = { 'md', 'markdown', 'rmd', 'rst' },
        config = function() vim.g.vim_markdown_no_default_key_mappings = 1 end,
      },
      { 'godlygeek/tabular', ft = { 'md', 'markdown', 'rmd', 'rst' } },
    },
    ft = { 'md', 'markdown', 'rmd', 'rst' },
    config = function()
      local nnoremap = require('hashish').nnoremap
      local obsidian = require 'obsidian'
      obsidian.setup {
        dir = '~/Projects/Notes',
        notes_subdir = 'Transient',
        completion = { nvim_cmp = true },
      }
      nnoremap 'gf'(
        function()
          return obsidian.util.cursor_on_markdown_link() and '<cmd>ObsidianFollowLink<CR>' or 'gf'
        end
      ) { expr = true } 'Jump to file under cursor'
    end,
  },
}

tools.whichkey = {
  spec = {
    'folke/which-key.nvim',
    config = function()
      vim.o.timeoutlen = 500
      require('which-key').setup { plugins = { marks = false, registers = false } }
    end,
  },
}

tools.spec = {
  tools.cellular_automation.spec,
  tools.colorizer,
  tools.drop.spec,
  tools.fish.spec,
  tools.neotest.spec,
  -- tools.mkdnflow.spec,
  -- tools.obsidian.spec,
  tools.peek.spec,
  tools.startuptime.spec,
  -- tools.whichkey.spec,
}

return tools
