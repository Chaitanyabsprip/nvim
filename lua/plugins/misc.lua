local misc = {}

misc.fish = {
  spec = { 'dag/vim-fish', ft = 'fish' },
}

misc.startuptime = {
  spec = {
    'dstein64/vim-startuptime',
    cmd = 'StartupTime',
    config = function()
      vim.g.startuptime_tries = 50
      vim.g.startuptime_exe_args = { '-i', 'NONE' }
    end,
  },
}

misc.obsidian = {
  spec = {
    dir = '/Users/chaitanyasharma/Projects/Languages/Lua/obsidian.nvim',
    ft = 'markdown',
  },
}

misc.spec = { misc.fish.spec, misc.startuptime.spec }

return misc
