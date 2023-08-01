local externals = {}

function externals.terminal(floating)
  floating = floating or false
  local Terminal = require('toggleterm.terminal').Terminal
  local nnoremap = require('hashish').nnoremap
  local tnoremap = require('hashish').tnoremap
  local float_opts = {}
  local direction = 'horizontal'
  if floating then
    float_opts = { border = 'double' }
    direction = 'float'
  end
  local opts = {
    dir = 'git_dir',
    direction = direction,
    float_opts = float_opts,
    on_open = function(term)
      vim.cmd 'startinsert!'
      nnoremap 'q' '<cmd>close<cr>' { silent = true, bufnr = term.bufnr } 'Close Terminal Window'
    end,
    on_close = function()
      tnoremap 'jk' '<C-\\><C-N>' 'jk as escape'
      tnoremap 'kj' '<C-\\><C-N>' 'kj as escape'
    end,
  }
  return Terminal:new(opts)
end

function externals.gitui()
  local Terminal = require('toggleterm.terminal').Terminal
  local nnoremap = require('hashish').nnoremap
  local tnoremap = require('hashish').tnoremap
  return Terminal:new {
    cmd = 'gitui',
    close_on_exit = true,
    dir = 'git_dir',
    direction = 'float',
    on_open = function(term)
      nnoremap 'q' '<cmd>close<cr>' { silent = true, bufnr = term.bufnr } 'Close Terminal Window'
      vim.api.nvim_del_keymap('t', 'jk')
      vim.api.nvim_del_keymap('t', 'kj')
    end,
    on_close = function()
      tnoremap 'jk' '<C-\\><C-N>' 'jk as escape'
      tnoremap 'kj' '<C-\\><C-N>' 'kj as escape'
    end,
  }
end

externals.toggleterm = {
  'akinsho/toggleterm.nvim',
  keys = {
    {
      '<leader>tf',
      function() externals.terminal(true):toggle() end,
      noremap = true,
      desc = 'Toggle floating terminal',
    },
    {
      '<c-g>',
      function() externals.gitui():toggle() end,
      noremap = true,
      desc = 'Toggle gitui in floating window',
    },
  },
  opts = {
    size = 22,
    open_mapping = [[<c-t>]],
    on_open = function() vim.cmd [[setlocal statuscolumn=]] end,
    on_close = function() end,
    shade_terminals = true,
    shading_factor = '-30',
    start_in_insert = true,
    persist_size = true,
    direction = 'horizontal',
    hide_numbers = true,
    shade_filetypes = {},
    shell = vim.o.shell,
    float_opts = {
      highlights = { border = 'Normal', background = 'Normal' },
    },
  },
}

externals.spec = { externals.toggleterm }
return externals.spec
