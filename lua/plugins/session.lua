local session = {}

session.auto_session = {}

session.auto_session.setup = function()
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
end

session.auto_session.plug = {
  'rmagatti/auto-session',
  config = session.auto_session.setup,
  cmd = { 'RestoreSession' },
}

session.plug = session.auto_session.plug

return session
