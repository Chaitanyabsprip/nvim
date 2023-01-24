local externals = {}

externals.toggleterm = {
  spec = {
    'akinsho/toggleterm.nvim',
    config = function() require('plugins.externals').toggleterm.setup() end,
    event = 'VeryLazy',
    keys = {
      {
        '<leader>tf',
        function() require('plugins.externals').terminal(true):toggle() end,
        noremap = true,
        desc = 'Toggle floating terminal',
      },
      {
        '<leader>tg',
        function() require('plugins.externals').gitui():toggle() end,
        noremap = true,
        desc = 'Toggle gitui in floating window',
      },
    },
  },
  setup = function()
    require('toggleterm').setup {
      size = 15,
      open_mapping = [[<c-t>]],
      shade_terminals = true,
      -- shading_factor = '-30',
      start_in_insert = true,
      persist_size = true,
      direction = 'horizontal',
      hide_numbers = true,
      shade_filetypes = {},
      shell = vim.o.shell,
      float_opts = {
        winblend = 3,
        highlights = { border = 'Normal', background = 'Normal' },
      },
    }

    -- local nnoremap = require('mappings.hashish').nnoremap
    -- nnoremap '<leader>tf' "<cmd>lua require('plugins.externals').terminal(true):toggle()<CR>" {
    --   silent = true,
    -- } 'Toggle floating terminal'
    -- nnoremap '<leader>tt' "<cmd>lua require('plugins.externals').terminal():toggle()<CR>" {
    --   silent = true,
    -- } 'Toggle terminal'
    -- nnoremap '<leader>tg' "<cmd>lua require('plugins.externals').gitui():toggle()<CR>" {
    --   silent = true,
    -- } 'Toggle gitui in floating window'
  end,
}

function externals.terminal(floating)
  floating = floating or false
  local Terminal = require('toggleterm.terminal').Terminal
  local float_opts = {}
  local direction = 'horizontal'
  if floating then
    float_opts = { border = 'double' }
    direction = 'float'
  end
  return Terminal:new {
    dir = 'git_dir',
    direction = direction,
    float_opts = float_opts,
    on_open = function(term)
      vim.cmd 'startinsert!'
      local nnoremap = require('mappings.hashish').nnoremap
      nnoremap 'q' '<cmd>close<cr>' { silent = true, bufnr = term.bufnr } 'Close Terminal Window'
    end,
    on_close = function()
      local tnoremap = require('mappings.hashish').tnoremap
      tnoremap 'jk' '<C-\\><C-N>' 'jk as escape'
      tnoremap 'kj' '<C-\\><C-N>' 'kj as escape'
    end,
  }
end

function externals.gitui()
  local Terminal = require('toggleterm.terminal').Terminal
  return Terminal:new {
    cmd = 'gitui',
    close_on_exit = true,
    dir = 'git_dir',
    direction = 'float',
    on_open = function(term)
      local nnoremap = require('mappings.hashish').nnoremap
      nnoremap 'q' '<cmd>close<cr>' { silent = true, bufnr = term.bufnr } 'Close Terminal Window'
      vim.api.nvim_del_keymap('t', 'jk')
      vim.api.nvim_del_keymap('t', 'kj')
    end,
    on_close = function()
      local tnoremap = require('mappings.hashish').tnoremap
      tnoremap 'jk' '<C-\\><C-N>' 'jk as escape'
      tnoremap 'kj' '<C-\\><C-N>' 'kj as escape'
    end,
  }
end

externals.spec = externals.toggleterm.spec
return externals
