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
  'folke/drop.nvim',
  event = { 'BufReadPre' },
  ft = { 'greeter' },
  opts = {
    theme = 'leaves',
    interval = 150,
    max = 90,
    screensaver = 1000 * 60 * 2,
    filetypes = { 'greeter' },
  },
}

tools.fish = { 'dag/vim-fish', ft = 'fish' }

tools.hologram = {
  spec = {
    'edluffy/hologram.nvim',
    opts = { auto_display = true },
    ft = { 'markdown', 'md', 'rst', 'rmd' },
  },
}

tools.neotest = {
  'nvim-neotest/neotest',
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-treesitter/nvim-treesitter' },
    { 'sidlatau/neotest-dart' },
    { 'nvim-neotest/neotest-go' },
    { 'antoinemadec/FixCursorHold.nvim' },
  },
  version = '2.*',
  opts = function()
    local nnoremap = require('hashish').nnoremap
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
    return {
      quickfix = { open = false },
      status = { icons = true, virtual_text = false },
      adapters = {
        require 'neotest-dart' { command = 'flutter', use_lsp = false },
        require 'neotest-go',
      },
      icons = {
        running_animated = {
          '⠋',
          '⠙',
          '⠹',
          '⠸',
          '⠼',
          '⠴',
          '⠦',
          '⠧',
          '⠇',
          '⠏',
        },
      },
    }
  end,
  keys = {
    { '<leader>tn', function() require('neotest').run.run() end, desc = 'Run nearest test' },
    { '<leader>tl', function() require('neotest').run.run_last() end, desc = 'Run last test' },
    {
      '<leader>ta',
      function() require('neotest').run.run(vim.fn.expand '%') end,
      desc = 'Run test for file',
    },
    {
      '<leader>ts',
      function() require('neotest').summary.toggle() end,
      desc = 'Toggle tests summary',
    },
    {
      '<leader>to',
      function()
        local open_opts = { enter = true }
        require('neotest').output.open(open_opts)
      end,
      desc = 'Toggle tests output',
    },
  },
}

tools.obsidian = {
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
  keys = {
    {
      'gf',
      function()
        return require('obsidian').util.cursor_on_markdown_link() and '<cmd>ObsidianFollowLink<CR>'
          or 'gf'
      end,
      expr = true,
      desc = 'Notes: Open link or file under cursor',
    },
  },
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
      mappings = {},
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
}

tools.peek = {
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
}

tools.startuptime = {
  'dstein64/vim-startuptime',
  config = function() vim.g.startuptime_tries = 50 end,
  cmd = 'StartupTime',
}

tools.whichkey = {
  'folke/which-key.nvim',
  config = function()
    vim.o.timeoutlen = 500
    require('which-key').setup { plugins = { marks = false, registers = false } }
  end,
}

tools.spec = {
  tools.colorizer,
  tools.drop,
  tools.fish,
  tools.neotest,
  tools.obsidian,
  tools.peek,
  tools.startuptime,
}

return tools.spec
