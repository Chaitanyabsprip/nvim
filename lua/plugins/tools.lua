local tools = {}

tools.colorizer = {
  'NvChad/nvim-colorizer.lua',
  cmd = { 'ColorizerAttachToBuffer', 'ColorizerToggle' },
  opts = {
    filetypes = { '*', '!lazy' },
    buftype = { '*', '!prompt', '!nofile' },
    user_default_options = {
      names = false,
      RRGGBBAA = true,
      AARRGGBB = true,
      css_fn = true,
      mode = 'background', -- Available modes for `mode`: foreground, background,  virtualtext
      virtualtext = '███',
    },
  },
}

tools.drop = {
  spec = {
    'folke/drop.nvim',
    event = 'VeryLazy',
    opts = {
      theme = 'leaves',
      interval = 150,
      max = 90,
      screensaver = 1000 * 60 * 2,
      filetypes = { 'greeter' },
    },
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
    config = function(_, opts) require('plugins.tools').neotest.setup(opts) end,
    version = '2.*',
    event = 'VeryLazy',
    opts = {
      quickfix = { open = false },
      status = { icons = true, virtual_text = false },
      icons = {
        running_animated = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
      },
    },
  },
  setup = function(config)
    config.adapters =
      { require 'neotest-dart' { command = 'flutter', use_lsp = true }, require 'neotest-go' }
    local nnoremap = require('hashish').nnoremap
    require('neotest').setup(config)
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

    local open_opts = { enter = true }
    nnoremap '<leader>tn'(function() require('neotest').run.run() end) 'Run nearest test'
    nnoremap '<leader>tl'(function() require('neotest').run.run_last() end) 'Run nearest test'
    nnoremap '<leader>ta'(function() require('neotest').run.run(vim.fn.expand '%') end) 'Run test for file'
    nnoremap '<leader>ts'(function() require('neotest').summary.toggle() end) 'Toggle tests summary'
    nnoremap '<leader>to'(function() require('neotest').output.open(open_opts) end) 'Toggle tests summary'
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

tools.hologram = {
  spec = {
    'edluffy/hologram.nvim',
    opts = { auto_display = true },
    ft = { 'markdown', 'md', 'rst', 'rmd' },
  },
}

tools.mkdnflow = {
  spec = {
    'jakewvincent/mkdnflow.nvim',
    ft = { 'md', 'markdown' },
    opts = {
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
    },
    config = function(_, opts)
      require('mkdnflow').setup(opts)
      local nnoremap = require('hashish').nnoremap
      nnoremap '<c-space>' '<cmd>MkdnToggleToDo<CR>' 'Toggle todo'
    end,
  },
}

tools.obsidian = {
  spec = {
    'epwalsh/obsidian.nvim',
    cmd = {
      'ObsidianNew',
      'ObsidianSearch',
      'Today',
      'Yesterday',
      'Notes',
      'SearchNotes',
    },
    ft = { 'md', 'markdown', 'rmd', 'rst' },
    opts = function()
      local command = vim.api.nvim_create_user_command
      command('Today', 'ObsidianToday', {})
      command('Yesterday', 'ObsidianYesterday', {})
      command('SearchNotes', 'ObsidianSemanticSearch', {})
      command('Notes', 'ObsidianSemanticSearch', {})
      return {
        dir = '~/Projects/Notes',
        -- Optional, if you keep notes in a specific subdirectory of your vault.
        notes_subdir = 'transient',
        completion = {
          nvim_cmp = true,
          min_chars = 2,
          new_notes_location = 'notes_subdir',
        },
        daily_notes = {
          folder = 'transient',
          date_format = '%Y-%m-%d',
        },
        -- Optional, alternatively you can customize the frontmatter data.
        follow_url_func = function(url) vim.fn.jobstart { 'open', url } end,
        use_advanced_uri = true,
        open_app_foreground = true,
        finder = 'telescope.nvim',
        note_frontmatter_func = function(note)
          -- This is equivalent to the default frontmatter function.
          local out = { id = note.id, aliases = note.aliases, tags = note.tags }
          -- `note.metadata` contains any manually added fields in the frontmatter.
          -- So here we just make sure those fields are kept in the frontmatter.
          if note.metadata ~= nil and require('obsidian').util.table_length(note.metadata) > 0 then
            for k, v in pairs(note.metadata) do
              out[k] = v
            end
          end
          return out
        end,
      }
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
  tools.colorizer,
  tools.drop.spec,
  tools.fish.spec,
  tools.neotest.spec,
  tools.obsidian.spec,
  tools.peek.spec,
}

return tools
