local misc = {}

misc.cellular_automation = {
  spec = { 'eandrju/cellular-automaton.nvim', cmd = 'CellularAutomation' },
}

misc.colorizer = {
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

misc.drop = {
  spec = {
    'folke/drop.nvim',
    lazy = false,
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

misc.fish = { spec = { 'dag/vim-fish', ft = 'fish' } }

misc.startuptime = {
  spec = {
    'dstein64/vim-startuptime',
    cmd = 'StartupTime',
    config = function() vim.g.startuptime_tries = 50 end,
  },
}

misc.obsidian = {
  spec = { dir = '/Users/chaitanyasharma/Projects/Languages/Lua/obsidian.nvim', ft = 'markdown' },
}

misc.whichkey = {
  spec = {
    'folke/which-key.nvim',
    config = function()
      vim.o.timeoutlen = 500
      require('which-key').setup { plugins = { marks = false, registers = false } }
    end,
  },
}

misc.spec = {
  misc.cellular_automation.spec,
  misc.colorizer,
  misc.drop.spec,
  misc.fish.spec,
  misc.startuptime.spec,
  -- misc.whichkey.spec,
}

return misc
