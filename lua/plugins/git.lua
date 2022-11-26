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
  nnoremap '<leader>gw' (
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

M.gitsigns = function()
  require('gitsigns').setup {
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map('n', ']c', function()
        if vim.wo.diff then
          return ']c'
        end
        vim.schedule(function()
          gs.next_hunk()
        end)
        return '<Ignore>'
      end, { expr = true })

      map('n', '[c', function()
        if vim.wo.diff then
          return '[c'
        end
        vim.schedule(function()
          gs.prev_hunk()
        end)
        return '<Ignore>'
      end, { expr = true })
      map({ 'n', 'v' }, '<leader>sh', ':Gitsigns stage_hunk<CR>')
      map({ 'n', 'v' }, '<leader>rh', ':Gitsigns reset_hunk<CR>')
      map('n', '<leader>SH', gs.stage_buffer)
      map('n', '<leader>uh', gs.undo_stage_hunk)
      map('n', '<leader>dh', gs.diffthis)
      map('n', '<leader>DH', function()
        gs.diffthis '~'
      end)
      map('n', '<leader>td', gs.toggle_deleted)

      -- Text object
      map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')

      -- map('n', '<leader>Rh', gs.reset_buffer)
      -- map('n', '<leader>hp', gs.preview_hunk)
      -- map('n', '<leader>hb', function()
      --   gs.blame_line { full = true }
      -- end)
      -- map('n', '<leader>tb', gs.toggle_current_line_blame)
    end,
    attach_to_untracked = false,
    current_line_blame = true,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
      delay = 700,
      ignore_whitespace = false,
    },
    current_line_blame_formatter_opts = { relative_time = true },
  }
end

M.conflict = function()
  require('git-conflict').setup {
    default_mappings = true, -- disable buffer local mapping created by this plugin
    disable_diagnostics = true, -- This will disable the diagnostics in a buffer whilst it is conflicted
    highlights = { -- They must have background color, otherwise the default color will be used
      incoming = 'DiffText',
      current = 'DiffAdd',
    },
  }
end

M.diffview = function()
  local cb = require('diffview.config').diffview_callback
  require('diffview').setup {
    diff_binaries = false, -- Show diffs for binaries
    file_panel = {
      width = 35,
      use_icons = true, -- Requires nvim-web-devicons
    },
    key_bindings = {
      view = {
        ['<tab>'] = cb 'select_next_entry', -- Open the diff for the next file
        ['<s-tab>'] = cb 'select_prev_entry', -- Open the diff for the previous file
        ['<leader>e'] = cb 'focus_files', -- Bring focus to the files panel
        ['<leader>b'] = cb 'toggle_files', -- Toggle the files panel.
      },
      file_panel = {
        ['j'] = cb 'next_entry', -- Bring the cursor to the next file entry
        ['<down>'] = cb 'next_entry',
        ['k'] = cb 'prev_entry', -- Bring the cursor to the previous file entry.
        ['<up>'] = cb 'prev_entry',
        ['<cr>'] = cb 'select_entry', -- Open the diff for the selected entry.
        ['o'] = cb 'select_entry',
        ['<2-LeftMouse>'] = cb 'select_entry',
        ['-'] = cb 'toggle_stage_entry', -- Stage / unstage the selected entry.
        ['S'] = cb 'stage_all', -- Stage all entries.
        ['U'] = cb 'unstage_all', -- Unstage all entries.
        ['R'] = cb 'refresh_files', -- Update stats and entries in the file list.
        ['<tab>'] = cb 'select_next_entry',
        ['<s-tab>'] = cb 'select_prev_entry',
        ['<leader>e'] = cb 'focus_files',
        ['<leader>b'] = cb 'toggle_files',
      },
    },
  }
end

return M
