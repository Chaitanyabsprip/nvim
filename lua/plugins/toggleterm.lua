local toggleterm = {}
local Terminal = require('toggleterm.terminal').Terminal
local nnoremap = require('utils').nnoremap

toggleterm.setup = function()
  require('toggleterm').setup {
    size = 15,
    open_mapping = [[<c-t>]],
    shade_terminals = false,
    shading_factor = '3',
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
  nnoremap(
    '<leader>tf',
    "<cmd>lua require('plugins.toggleterm').float:toggle()<CR>",
    true
  )
  nnoremap(
    '<leader>tt',
    "<cmd>lua require('plugins.toggleterm').horizontal:toggle()<CR>",
    true
  )
  nnoremap(
    '<leader>tg',
    "<cmd>lua require('plugins.toggleterm').gitui:toggle()<CR>",
    true
  )
  nnoremap(
    '<leader>tr',
    "<cmd>lua require('plugins.toggleterm').ranger:toggle()<CR>",
    true
  )
end

toggleterm.float = Terminal.new {
  dir = 'git_dir',
  direction = 'float',
  float_opts = { border = 'double' },
  -- function to run on opening the terminal
  on_open = function(term)
    vim.cmd 'startinsert!'
    vim.api.nvim_buf_set_keymap(
      term.bufnr,
      'n',
      'q',
      '<cmd>close<CR>',
      { noremap = true, silent = true }
    )
  end,
}

toggleterm.horizontal = Terminal:new {
  dir = 'git_dir',
  direction = 'horizontal',
  on_open = function(term)
    vim.cmd 'startinsert!'
    vim.api.nvim_buf_set_keymap(
      term.bufnr,
      'n',
      'q',
      '<cmd>close<CR>',
      { noremap = true, silent = true }
    )
  end,
  on_close = function()
    vim.api.nvim_set_keymap('t', 'jk', '<C-\\><C-n>', { noremap = true })
    vim.api.nvim_set_keymap('t', 'kj', '<C-\\><C-n>', { noremap = true })
  end,
}

toggleterm.gitui = Terminal:new {
  cmd = 'gitui',
  close_on_exit = true,
  dir = 'git_dir',
  direction = 'float',
  on_open = function(term)
    vim.api.nvim_del_keymap('t', 'jk')
    vim.api.nvim_del_keymap('t', 'kj')
    vim.api.nvim_buf_set_keymap(
      term.bufnr,
      'n',
      'q',
      '<cmd>close<CR>',
      { noremap = true, silent = true }
    )
  end,
  on_close = function()
    vim.api.nvim_set_keymap('t', 'jk', '<C-\\><C-n>', { noremap = true })
    vim.api.nvim_set_keymap('t', 'kj', '<C-\\><C-n>', { noremap = true })
  end,
}

toggleterm.ranger = Terminal:new {
  cmd = 'ranger',
  close_on_exit = true,
  dir = 'git_dir',
  direction = 'float',
  on_open = function(term)
    vim.api.nvim_buf_set_keymap(
      term.bufnr,
      'n',
      'q',
      '<cmd>close<CR>',
      { noremap = true, silent = true }
    )
  end,
}

return toggleterm
