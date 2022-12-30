local misc = {}

misc.cellular_automation = {
  spec = { 'eandrju/cellular-automaton.nvim', event = 'VeryLazy' },
}

misc.colorizer = {
  'NvChad/nvim-colorizer.lua',
  cmd = { 'ColorizerAttachToBuffer', 'ColorizerToggle' },
  config = {
    filetypes = { '*', '!lazy' },
    buftype = { '*', '!prompt', '!nofile' },
    user_default_options = {
      RGB = true, -- #RGB hex codes
      RRGGBB = true, -- #RRGGBB hex codes
      names = false, -- "Name" codes like Blue
      RRGGBBAA = true, -- #RRGGBBAA hex codes
      AARRGGBB = true, -- 0xAARRGGBB hex codes
      rgb_fn = true, -- CSS rgb() and rgba() functions
      hsl_fn = true, -- CSS hsl() and hsla() functions
      css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
      css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
      -- Available modes for `mode`: foreground, background,  virtualtext
      mode = 'virtualtext', -- Set the display mode.
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
        screensaver = 1000 * 30,
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
      require('which-key').setup {}
    end,
  },
}

misc.spec = {
  misc.cellular_automation.spec,
  misc.colorizer,
  misc.drop.spec,
  misc.fish.spec,
  misc.startuptime.spec,
  misc.whichkey.spec,
}

return misc
