require('persisted').setup {
  dir = vim.fn.expand(vim.fn.stdpath 'data' .. '/sessions/'), -- directory where session files are saved
  use_git_branch = true, -- create session files based on the branch of the git enabled repository
  autosave = true,
  options = {
    'buffers',
    'curdir',
    'winsize',
    'resize',
    'winpos',
    'folds',
    'tabpages',
  }, -- session options used for saving
}
