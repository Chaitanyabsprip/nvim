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
        theme = 'snow',
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

tools.startuptime = {
  spec = {
    'dstein64/vim-startuptime',
    cmd = 'StartupTime',
    config = function() vim.g.startuptime_tries = 50 end,
  },
}

tools.obsidian = {
  spec = { dir = '/Users/chaitanyasharma/Projects/Languages/Lua/obsidian.nvim', ft = 'markdown' },
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
  tools.startuptime.spec,
  -- tools.whichkey.spec,
}

return tools
