local git = {}

git.gitsigns = {
  spec = {
    'lewis6991/gitsigns.nvim',
    config = function() require('plugins.git').gitsigns.setup() end,
    event = 'BufReadPre',
  },
  setup = function()
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
          if vim.wo.diff then return ']c' end
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end, { expr = true })

        map('n', '[c', function()
          if vim.wo.diff then return '[c' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end, { expr = true })
        map({ 'n', 'v' }, '<leader>sh', ':Gitsigns stage_hunk<CR>')
        map({ 'n', 'v' }, '<leader>rh', ':Gitsigns reset_hunk<CR>')
        map('n', '<leader>SH', gs.stage_buffer)
        map('n', '<leader>uh', gs.undo_stage_hunk)
        map('n', '<leader>dh', gs.diffthis)
        map('n', '<leader>DH', function() gs.diffthis '~' end)
        map('n', '<leader>td', gs.toggle_deleted)
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
      end,
      -- attach_to_untracked = false,
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 700,
        ignore_whitespace = false,
      },
      current_line_blame_formatter_opts = { relative_time = true },
    }
  end,
}

git.git_conflict = {
  spec = {
    'akinsho/git-conflict.nvim',
    tag = 'v1.0.0',
    config = function() require('plugins.git').git_conflict.setup() end,
    cmd = { 'GitConflictListQf' },
  },
  setup = function()
    require('git-conflict').setup {
      default_mappings = true, -- disable buffer local mapping created by this plugin
      disable_diagnostics = true, -- This will disable the diagnostics in a buffer whilst it is conflicted
      highlights = { -- They must have background color, otherwise the default color will be used
        incoming = 'DiffText',
        current = 'DiffAdd',
      },
    }
  end,
}

git.spec = { git.git_conflict.spec, git.gitsigns.spec }

return git
