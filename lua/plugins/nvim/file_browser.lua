local M = {}

function M.cfile_browser()
  local dropdown = require('telescope.themes').get_dropdown
  local opts = dropdown {
    initial_mode = 'normal',
    sorting_strategy = 'ascending',
    layout_strategy = 'horizontal',
    layout_config = {
      height = 25,
      width = 100,
      preview_cutoff = 60,
    },
  }
  require('telescope').extensions.file_browser.file_browser(opts)
end

function M.notes_browser()
  local dropdown = require('telescope.themes').get_dropdown
  local opts = dropdown {
    hidden = true,
    path = vim.fn.expand '$HOME/Projects/Notes',
    initial_mode = 'normal',
    sorting_strategy = 'ascending',
    layout_strategy = 'horizontal',
    layout_config = {
      height = 25,
      width = 100,
      preview_cutoff = 0.8,
    },
  }
  require('telescope').extensions.file_browser.file_browser(opts)
end

function M.setup()
  require('telescope').load_extension 'file_browser'
  local nnoremap = require('utils').nnoremap
  nnoremap(
    '<leader>E',
    "<cmd>lua require('plugins.nvim.file_browser').cfile_browser()<cr>",
    true
  )
  nnoremap(
    '<leader>N',
    "<cmd>lua require('plugins.nvim.file_browser').notes_browser()<cr>",
    true
  )
end

return M
