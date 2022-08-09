local M = {}

M.mappings = function()
  local action = require('telescope').extensions.file_browser.actions
  return {
    ['n'] = {
      ['l'] = action.open,
      ['h'] = action.goto_parent_dir,
    },
  }
end

M.cfile_browser = function()
  local dropdown = require('telescope.themes').get_dropdown
  local opts = dropdown {
    borderchars = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
    initial_mode = 'normal',
    layout_config = { height = 25, width = 140, preview_width = 80 },
    layout_strategy = 'horizontal',
    sorting_strategy = 'ascending',
  }
  require('telescope').extensions.file_browser.file_browser(opts)
end

M.notes_browser = function()
  local dropdown = require('telescope.themes').get_dropdown
  local opts = dropdown {
    borderchars = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
    initial_mode = 'normal',
    layout_config = { height = 25, width = 120, preview_width = 80 },
    layout_strategy = 'horizontal',
    path = vim.fn.expand '$HOME/Projects/Notes',
    sorting_strategy = 'ascending',
  }
  require('telescope').extensions.file_browser.file_browser(opts)
end

function M.setup()
  require('telescope').load_extension 'file_browser'
  local nnoremap = require('mappings').nnoremap
  nnoremap '<leader>E'(function()
    require('plugins.nvim.file_browser').cfile_browser()
  end) {} 'Telescope File Browser'

  nnoremap '<leader>N'(function()
    require('plugins.nvim.file_browser').notes_browser()
  end) {} 'Notes Browser'
end

return M
