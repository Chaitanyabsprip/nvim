local git = {}

git.gitsigns = {
  'lewis6991/gitsigns.nvim',
  cond = function() return vim.loop.fs_stat '.git' end,
  event = 'BufReadPre',
  opts = function()
    local signs = { add = 'Add', change = 'Change', delete = 'Delete' }
    ---@param sign string
    ---@param text string|nil
    ---@return table<string, string>
    local sign = function(sign, text)
      text = text or '▍'
      local hl = 'GitSigns' .. sign
      return { text = text, hl = hl, numhl = hl .. 'Nr', linehl = hl .. 'Ln' }
    end
    return {
      signs = {
        add = sign(signs.add),
        change = sign(signs.change),
        delete = sign(signs.delete, '_'),
        topdelete = sign(signs.delete, '‾'),
        changedelete = sign(signs.change),
        untracked = sign(signs.add, '▘'),
      },
      on_attach = function(bufnr)
        local gs = require 'gitsigns'
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
        end, { expr = true, desc = 'Git: Jump to next hunk' })

        map('n', '<leader>ph', function()
          if vim.wo.diff then return '<leader>nh' end
          vim.schedule(gs.prev_hunk)
          return '<Ignore>'
        end, { expr = true, desc = 'Git: Jump to prev hunk' })
        map({ 'n', 'v' }, ';s', '<cmd>Gitsigns stage_hunk<cr>', 'Git: Stage hunk')
        map({ 'n', 'v' }, ';r', '<cmd>Gitsigns reset_hunk<cr>', 'Git: Reset hunk')
        map('n', ';S', function() gs.stage_buffer() end, 'Git: Stage all changes in buffer')
        map('n', ';u', function() gs.undo_stage_hunk() end, 'Git: Undo stage hunk')
        map('n', ';d', function() gs.diffthis() end, 'Git: Diff this')
        map('n', ';p', function() gs.preview_hunk_inline() end, 'Git: Diff this')
        map('n', ';P', function() gs.preview_hunk() end, 'Git: Diff this')
        map('n', ';D', function() gs.diffthis '~' end, 'Git: Diff this against previous commit')
        map('n', ';td', function() gs.toggle_deleted() end, 'Git: Toggle view deletion changes')
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', 'Git: Select hunk')
      end,
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 700,
        ignore_whitespace = false,
        virt_text = true,
        virt_text_pos = 'eol',
      },
      current_line_blame_formatter_opts = { relative_time = true },
    }
  end,
}

git.git_conflict = {
  'akinsho/git-conflict.nvim',
  version = '*',
  event = 'BufReadPre',
  cmd = 'GitConflictListQf',
  opts = {
    disable_diagnostics = true,
    highlights = { incoming = 'DiffText', current = 'DiffAdd' },
  },
}

git.spec = { git.git_conflict, git.gitsigns }

return git.spec
