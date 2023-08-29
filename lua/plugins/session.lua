local session = {}

session.auto_session = {
  'rmagatti/auto-session',
  init = function() vim.api.nvim_create_user_command('Continue', 'SessionRestore', { nargs = 0 }) end,
  dependencies = { { 'tiagovla/scope.nvim' } },
  opts = {
    log_level = 'error',
    auto_session_enable_last_session = false,
    auto_session_root_dir = vim.fn.stdpath 'data' .. '/sessions/',
    auto_session_enabled = true,
    auto_save_enabled = nil,
    auto_restore_enabled = false,
    auto_session_suppress_dirs = { os.getenv 'HOME' },
    auto_session_use_git_branch = true,
    pre_save_cmds = { 'ScopeSaveState' },
    post_restore_cmds = { 'ScopeLoadState' },
  },
  event = 'BufReadPre',
  cmd = { 'Continue', 'SessionRestore' },
}

session.persistence = {
  'folke/persistence.nvim',
  init = function()
    vim.api.nvim_create_user_command(
      'Continue',
      function() require('persistence').load() end,
      { nargs = 0 }
    )
  end,
  event = 'BufReadPre',
  cmd = { 'Continue' },
  opts = {
    dir = vim.fn.expand(vim.fn.stdpath 'data' .. '/sessions/'),
    options = { 'buffers', 'curdir', 'winsize', 'resize', 'winpos', 'folds', 'tabpages', 'help' },
  },
}

session.spec = {}

return session.spec
