local externals = {}

function externals.terminal(direction)
  direction = direction or 'horizontal'
  local Terminal = require('toggleterm.terminal').Terminal
  local nnoremap = require('hashish').nnoremap
  local tnoremap = require('hashish').tnoremap
  local float_opts = {}
  if direction == 'float' then float_opts = { border = 'double' } end
  local opts = {
    dir = 'git_dir',
    direction = direction,
    float_opts = float_opts,
    display_name = 'Terminal',
    on_open = function(term)
      vim.cmd 'startinsert!'
      vim.opt_local.statuscolumn = ''
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
    display_name = 'GitUI',
    on_open = function(term)
      nnoremap 'q' '<cmd>close<cr>' { silent = true, bufnr = term.bufnr } 'Close Terminal Window'
      vim.opt_local.statuscolumn = ''
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
    { '<c-t>', '<cmd>ToggleTerm<cr>', desc = 'Toggle terminal', noremap = true },
    {
      '<leader>tf',
      function() externals.terminal('float'):toggle() end,
      noremap = true,
      desc = 'Toggle floating terminal',
    },
    {
      '<leader>tt',
      function() externals.terminal('tab'):toggle() end,
      noremap = true,
      desc = 'Toggle terminal in new tab',
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
    shade_terminals = false,
    start_in_insert = true,
    persist_size = true,
    hide_numbers = true,
    shell = vim.o.shell,
    float_opts = { highlights = { border = 'Normal', background = 'Normal' } },
  },
}

externals.spec = { externals.toggleterm }
return externals.spec
