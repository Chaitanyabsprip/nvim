local misc = {}

misc.drop = {
  spec = {
    'folke/drop.nvim',
    lazy = false,
    config = function()
      require('drop').setup { theme = 'snow', interval = 150, max = 90, screensaver = 1000 * 10 }
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

misc.spec = { misc.drop.spec, misc.fish.spec, misc.startuptime.spec, misc.whichkey.spec }

return misc
