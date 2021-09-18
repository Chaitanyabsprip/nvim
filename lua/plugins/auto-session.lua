local u = require("utils")
require('auto-session').setup {
  log_level = 'info',
  auto_session_enable_last_session = false,
  auto_session_root_dir = vim.fn.stdpath('data') .. "/sessions/",
  auto_session_enabled = true,
  auto_save_enabled = nil,
  auto_restore_enabled = nil,
  auto_session_suppress_dirs = {"/Users/chaitanyasharma"},
  auto_session_allowed_dirs = {
    "/Users/chaitanyasharma/Projects/ApplicationDevelopment/crimson",
    "/Users/chaitanyasharma/Projects/ApplicationDevelopment/yocket",
    "/Users/chaitanyasharma/Projects/ApplicationDevelopment/flutter_clean_auth_architecture",
    "/Users/chaitanyasharma/.config/nvim"
  }
}

require('session-lens').setup {
  path_display = {'shorten'},
  -- theme_conf = {border = false},
  previewer = true
}

require("telescope").load_extension("session-lens")

u.kmap('n', '<leader>s',
       '<CMD>lua require("session-lens").search_session()<CR>',
       {noremap = true, silent = true})
