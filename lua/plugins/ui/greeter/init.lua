local M = {}
local ns = vim.api.nvim_create_namespace 'dashboard'
local notes_path = '/Users/chaitanyasharma/Projects/Notes/Transient/'
local get_note_name = function() return os.date '%Y-%m-%d' .. '.md' end
local new_note = function() return 'e ' .. notes_path .. get_note_name() end

function M.setup()
  if not M.dont_show() then
    vim.api.nvim_create_autocmd('User', {
      pattern = 'LazyVimStarted',
      callback = function() M.show() end,
    })
    M.show()
  end
end

function M.button(keymap_opts)
  if keymap_opts.shortcut then
    local opts = { noremap = true, silent = true, nowait = true }
    local action = '<cmd>' .. keymap_opts.action .. '<cr>'
    vim.api.nvim_buf_set_keymap(0, 'n', keymap_opts.shortcut, action, opts)
  end
  return keymap_opts
end

function M.show()
  local theme = require('plugins.ui.greeter.config').get_theme()

  local buf = vim.api.nvim_get_current_buf()
  vim.bo[buf].filetype = 'greeter'
  M.set_options()
  M.button { shortcut = 'f', action = 'Telescope find_files' }
  M.button { shortcut = 'm', action = 'Telescope oldfiles' }
  M.button { shortcut = 'r', action = 'Continue' }
  M.button { shortcut = 'n', action = new_note() }
  M.button { shortcut = 'q', action = 'quit' }

  -- local plugins = require('lazy').stats().count
  local sections = {
    {
      text = string.rep('\n', 5),
    },
    {
      text = theme.header .. string.rep('\n', 5),
      hl_group = 'DashboardHeader',
    },
    {
      text = [[
 Find File                    f

 Recent Files                 m
             
 Restore Session              r
             
 New Note                     n
             
 Quit                         q
      ]],
      hl_group = 'DashboardFooter',
    },
    -- {
    --   text = '🎉 Neovim loaded ' .. plugins .. ' plugins ' .. theme.statusline,
    --   hl_group = 'DashboardFooter',
    -- },
  }

  vim.bo[buf].modifiable = true

  local start = 0
  for _, section in ipairs(sections) do
    local lines = M.center(section.text)
    vim.api.nvim_buf_set_lines(buf, start, start, false, lines)
    vim.api.nvim_buf_set_extmark(buf, ns, start, 0, {
      end_row = start + #lines,
      hl_group = section.hl_group,
    })
    start = start + #lines
  end

  vim.bo[buf].modifiable = false

  -- local cursor = vim.go.guicursor
  -- vim.api.nvim_set_hl(0, "HiddenCursor", { blend = 100, nocombine = true })
  -- vim.go.guicursor = "a:HiddenCursor/HiddenCursor"

  vim.api.nvim_create_autocmd('BufWipeout', {
    buffer = buf,
    once = true,
    callback = function()
      vim.cmd [[echo '']]
      -- vim.go.guicursor = cursor
      vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
    end,
  })
end

function M.center(text)
  local lines = vim.split(text, '\n')
  local width = 0
  for _, line in ipairs(lines) do
    width = math.max(width, vim.fn.strwidth(line))
  end

  local delta = math.floor((vim.go.columns - width) / 2 + 0.5)
  local left = string.rep(' ', delta)

  for l, line in ipairs(lines) do
    lines[l] = left .. line
  end
  return lines
end

function M.set_options()
  local options = {
    -- Taken from 'vim-startify'
    'bufhidden=wipe',
    'colorcolumn=',
    'foldcolumn=0',
    'matchpairs=',
    'nobuflisted',
    'nocursorcolumn',
    'nocursorline',
    'nolist',
    'nonumber',
    'noreadonly',
    'norelativenumber',
    'nospell',
    'noswapfile',
    'signcolumn=no',
    'synmaxcol&',
    -- Differ from 'vim-startify'
    'buftype=nofile',
    'nomodeline',
    'nomodifiable',
    'foldlevel=999',
  }
  -- Vim's `setlocal` is currently more robust comparing to `opt_local`
  vim.cmd(('silent! noautocmd setlocal %s'):format(table.concat(options, ' ')))
end

function M.dont_show()
  if #vim.v.argv > 1 then return true end

  -- taken from mini.starter
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, true)
  if #lines > 1 or (#lines == 1 and lines[1]:len() > 0) then return true end

  -- - Several buffers are listed (like session with placeholder buffers). That
  --   means unlisted buffers (like from `nvim-tree`) don't affect decision.
  local listed_buffers = vim.tbl_filter(
    function(buf_id) return vim.fn.buflisted(buf_id) == 1 end,
    vim.api.nvim_list_bufs()
  )
  if #listed_buffers > 1 then return true end

  -- - There are files in arguments (like `nvim foo.txt` with new file).
  if vim.fn.argc() > 0 then return true end

  return false
end

return M
