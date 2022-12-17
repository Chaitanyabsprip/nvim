local editing = {}

editing.mini_comment = {
  plug = {
    'echasnovski/mini.comment',
    branch = 'stable',
    event = { 'BufReadPost' },
    config = function() require('plugins.editing').mini_comment.setup() end,
  },
  setup = function() require('mini.comment').setup() end,
}

editing.commaround = {
  plug = {
    'gennaro-tedesco/nvim-commaround',
    event = { 'BufReadPost' },
    config = function() require('plugins.editing').commaround.setup() end,
  },
  setup = function()
    local nmap = require('mappings.hashish').nmap
    local vmap = require('mappings.hashish').vmap
    nmap 'gcc' '<Plug>ToggleCommaround' {} 'Toggle Comment'
    vmap 'gcc' '<Plug>ToggleCommaround' {} 'Toggle Comment'
    vim.g.toggle_commaround = 'gcc'
  end,
}

editing.plug = editing.mini_comment.plug

return editing
