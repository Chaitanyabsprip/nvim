local home = os.getenv 'HOME'
local project_path = home .. '/Projects/'

require('auto-session').setup {
  log_level = 'info',
  auto_session_enable_last_session = false,
  auto_session_root_dir = vim.fn.stdpath 'data' .. '/sessions/',
  auto_session_enabled = true,
  auto_save_enabled = nil,
  auto_restore_enabled = nil,
  auto_session_suppress_dirs = { home },
  auto_session_allowed_dirs = {
    project_path .. 'ApplicationDevelopment/crimson',
    project_path .. 'ApplicationDevelopment/yocket',
    project_path .. 'ApplicationDevelopment/flutter_clean_auth_architecture',
    project_path .. 'Languages/JavaScript/twitter-clone',
    project_path .. 'Languages/JavaScript/twitter-clone-backend',
    project_path .. 'Languages/Lua/arch.nvim',
    project_path .. 'Forks/auto-session',
    home .. '/.config/nvim',
    home .. '/.local/share/nvim/site/pack/*',
  },
}
