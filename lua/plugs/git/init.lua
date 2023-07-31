local git = {}

git.gitsigns = {
  spec = {
    'lewis6991/gitsigns.nvim',
    config = function() require('plugs.git').gitsigns.setup() end,
    cond = function() return vim.loop.fs_stat '.git' end,
    event = 'BufReadPre',
  },
  setup = function()
    local signs = { add = 'Add', change = 'Change', delete = 'Delete' }
    local get_sign_opts = function(sign, text)
      text = text or '▍'
      local hl = 'GitSigns' .. sign
      return { text = text, hl = hl, numhl = hl .. 'Nr', linehl = hl .. 'Ln' }
    end
    require('gitsigns').setup {
      signs = {
        add = get_sign_opts(signs.add),
        change = get_sign_opts(signs.change),
        delete = get_sign_opts(signs.delete, '▸'),
        topdelete = get_sign_opts(signs.delete, '▾'),
        changedelete = get_sign_opts(signs.change),
        untracked = get_sign_opts(signs.add),
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local function map(mode, l, r, opts)
          opts = opts or {}
          if type(opts) == 'string' then opts = { desc = opts } end
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', '<leader>nh', function()
          if vim.wo.diff then return '<leader>ph' end
          vim.schedule(gs.next_hunk)
          return '<Ignore>'
        end, { expr = true, desc = 'Jump to next hunk' })

        map('n', '<leader>ph', function()
          if vim.wo.diff then return '<leader>nh' end
          vim.schedule(gs.prev_hunk)
          return '<Ignore>'
        end, { expr = true, desc = 'Jump to prev hunk' })
        map({ 'n', 'v' }, '<leader>sh', '<cmd>Gitsigns stage_hunk<cr>', 'Stage hunk')
        map({ 'n', 'v' }, '<leader>rh', '<cmd>Gitsigns reset_hunk<cr>', 'Reset hunk')
        map('n', '<leader>SH', function() gs.stage_buffer() end, 'Stage all changes in buffer')
        map('n', '<leader>uh', function() gs.undo_stage_hunk() end, 'Undo stage hunk')
        map('n', '<leader>dh', function() gs.diffthis() end, 'Diff this')
        map('n', '<leader>DH', function() gs.diffthis '~' end, 'Diff this ~')
        map('n', '<leader>gtd', function() gs.toggle_deleted() end, 'Toggle view deletion changes')
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', 'Select hunk')
      end,
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
    version = '*',
    event = 'BufReadPre',
    cmd = 'GitConflictListQf',
    opts = {
      disable_diagnostics = true,
      highlights = { incoming = 'DiffText', current = 'DiffAdd' },
    },
  },
}

git.spec = { git.git_conflict.spec, git.gitsigns.spec }

return git
