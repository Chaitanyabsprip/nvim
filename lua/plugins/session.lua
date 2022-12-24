local session = {}

session.auto_session = {
  spec = {
    'rmagatti/auto-session',
    config = function() require('plugins.session').auto_session.setup() end,
    cmd = { 'RestoreSession' },
  },
  setup = function()
    local home = os.getenv 'HOME'

    require('auto-session').setup {
      log_level = 'info',
      auto_session_enable_last_session = false,
      auto_session_root_dir = vim.fn.stdpath 'data' .. '/sessions/',
      auto_session_enabled = true,
      auto_save_enabled = nil,
      auto_restore_enabled = false,
      auto_session_suppress_dirs = { home },
      auto_session_use_git_branch = true,
    }
  end,
}

session.spec = session.auto_session.spec

return session
