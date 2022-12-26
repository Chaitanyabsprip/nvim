local session = {}

session.auto_session = {
  spec = {
    'rmagatti/auto-session',
    init = function() vim.api.nvim_create_user_command('Continue', 'RestoreSession', { nargs = 0 }) end,
    config = function() require('plugins.session').auto_session.setup() end,
    cmd = { 'Continue' },
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

session.persistence = {
  spec = {
    'folke/persistence.nvim',
    init = function()
      vim.api.nvim_create_user_command(
        'Continue',
        function() require('persistence').load() end,
        { nargs = 0 }
      )
    end,
    config = function() require('plugins.session').persistence.setup() end,
    cmd = { 'Continue' },
  },
  setup = function()
    require('persistence').setup {
dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"),
      options = { 'buffers', 'curdir', 'winsize', 'resize', 'winpos', 'folds', 'tabpages', 'help' },
    }
  end,
}

session.spec = session.persistence.spec

return session
