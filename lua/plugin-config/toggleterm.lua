local Terminal = require('toggleterm.terminal').Terminal
local u = require 'utils'

require'toggleterm'.setup {
  size = 15,
  open_mapping = [[<c-t>]],
  shade_terminals = false,
  shading_factor = '3',
  start_in_insert = true,
  persist_size = true,
  direction = 'horizontal',
  hide_numbers = true, -- hide the number column in toggleterm buffers
  shade_filetypes = {},
  -- direction = 'vertical' | 'horizontal' | 'window' | 'float',
  shell = vim.o.shell, -- change the default shell
  -- This field is only relevant if direction is set to 'float'
  float_opts = {
    -- The border key is *almost* the same as 'nvim_win_open'
    -- see :h nvim_win_open for details on borders however
    -- the 'curved' border is a custom border type
    -- not natively supported but implemented in this plugin.
    -- border = 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
    -- width = <value>,
    -- height = <value>,
    winblend = 3,
    highlights = {border = "Normal", background = "Normal"}
  }
}

local floaterm = Terminal:new({
  dir = "git_dir",
  direction = "float",
  float_opts = {border = "double"},
  -- function to run on opening the terminal
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>",
                                {noremap = true, silent = true})
  end
  -- function to run on closing the terminal
})

local general = Terminal:new({
  dir = "git_dir",
  direction = "horizontal",
  -- function to run on opening the terminal
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>",
                                {noremap = true, silent = true})
  end
  -- function to run on closing the terminal
})

function Floaterm_toggle()
  floaterm:toggle()
end

function General_Toggle()
  general:toggle()
end

u.keymap("n", "<leader>tf", "<cmd>lua Floaterm_toggle()<CR>",
         {noremap = true, silent = true})
u.keymap("n", "<leader>tt", "<cmd>lua General_Toggle()<CR>",
         {noremap = true, silent = true})
