local M = {}

local flutter_init = function()
  local job = require 'plenary.job'
  job
    :new({
      command = 'fvm',
      args = { 'flutter', 'pub', 'get' },
      cwd = vim.fn.getcwd(),
      on_exit = function(_, return_val)
        if return_val == 0 then
          print "Successfully run 'flutter pub get'"
        end
      end,
    })
    :start() -- or start(){
end

M.git_worktree = function()
  local nnoremap = require('mappings').nnoremap
  local worktree = require 'git-worktree'
  worktree.setup {}
  worktree.on_tree_change(function(_, metadata)
    local path = metadata.path
    if string.find(path, 'ApplicationDevelopment') then
      flutter_init()
    end
  end)

  require('telescope').load_extension 'git_worktree'
  nnoremap '<leader>gw'(
    require('telescope').extensions.git_worktree.git_worktrees
  ) {} 'Open telescope git worktree extension'
  -- <Enter> - switches to that worktree
  -- <c-d> - deletes that worktree
  -- <c-f> - toggles forcing of the next deletion

  -- Creates a worktree.  Requires the path, branch name, and the upstream
  -- Example:
  -- require('git-worktree').create_worktree('feat-69', 'master', 'origin')

  -- switches to an existing worktree.  Requires the path name
  -- Example:
  -- require('git-worktree').switch_worktree 'feat-69'

  -- deletes to an existing worktree.  Requires the path name
  -- Example:
  -- require('git-worktree').delete_worktree 'feat-69'
end

return M
