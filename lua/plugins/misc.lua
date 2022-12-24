local misc = {}

misc.fish = {
  spec = { 'dag/vim-fish', ft = 'fish' },
}

misc.startuptime = {
  spec = {
    'dstein64/vim-startuptime',
    cmd = 'StartupTime',
    config = function() vim.g.startuptime_tries = 50 end,
  },
}

misc.spec = { misc.fish.spec, misc.startuptime.spec }

return misc
