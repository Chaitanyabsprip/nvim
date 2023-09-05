local M = {}
local ns = vim.api.nvim_create_namespace 'dashboard'
local notes_path = os.getenv 'HOME' .. '/Projects/Notes/Transient/'
-- local get_note_name = function() return os.date '%Y-%m-%d' .. '.md' end
-- local new_note = function() return 'e ' .. notes_path .. get_note_name() end

function M.setup()
  if not M.dont_show() then
    vim.api.nvim_create_autocmd('User', {
      pattern = 'LazyVimStarted',
      callback = function() M.show() end,
    })
    M.show()
  end
end

-- function M.update_highlights()
--   local footer_fg = vim.api.nvim_get_hl(0, { name = 'DashboardFooter' }).fg
--   local header_fg = vim.api.nvim_get_hl(0, { name = 'DashboardHeader' }).fg
--   vim.api.nvim_set_hl(0, 'DashboardFooter', {fg= require('utils').darken(footer_fg, )})
-- end

---@param keymap_opts table<string, string>
---@return table<string, string>
function M.button(keymap_opts)
  if keymap_opts.shortcut then
    local opts = { noremap = true, silent = true, nowait = true }
    local action = keymap_opts.action
    vim.api.nvim_buf_set_keymap(0, 'n', keymap_opts.shortcut, action, opts)
  end
  return keymap_opts
end

function M.show()
  -- local theme = require('greeter.config').get_theme()

  local buf = vim.api.nvim_get_current_buf()
  vim.bo[buf].filetype = 'greeter'
  M.set_options()
  M.button { shortcut = 'f', action = '<cmd>Telescope find_files<cr>' }
  M.button { shortcut = 'm', action = '<cmd>Telescope oldfiles<cr>' }
  M.button { shortcut = 'r', action = "'0" }
  M.button { shortcut = 'q', action = '<cmd>quit<cr>' }

  local stats = require('lazy').stats()
  local sections = {
    { text = string.rep('\n', 18) },
    -- { text = theme.header .. string.rep('\n', 5), hl_group = 'DashboardHeader' },
    {
      text = {
        M.center('        NVIM v0.10.0-dev-780+g8afdc1f38        ', 0.47)[1],
        '\n',
        M.center('                                               ', 0.47)[1],
        '\n',
        M.center('  Nvim is open source and freely distributable ', 0.47)[1],
        '\n',
        M.center('            https://neovim.io/#chat            ', 0.47)[1],
        '\n',
        M.center('                                               ', 0.47)[1],
        '\n',
        M.center(' type  :help nvim<Enter>       if you are new! ', 0.47)[1],
        '\n',
        M.center(' type  :checkhealth<Enter>     to optimize Nvim', 0.47)[1],
        '\n',
        M.center(' type  :q<Enter>               to exit         ', 0.47)[1],
        '\n',
        M.center(' type  :help<Enter>            for help        ', 0.47)[1],
        '\n',
        M.center('                                               ', 0.47)[1],
        '\n',
        M.center('type  :help news<Enter> to see changes in v0.10', 0.47)[1],
        '\n',
        M.center('                                               ', 0.47)[1],
        '\n',
        M.center('            Sponsor Vim development!           ', 0.47)[1],
        '\n',
        M.center(' type  :help sponsor<Enter>    for information ', 0.47)[1],
        '\n',
      },
    },
    { text = string.rep('\n', 8) },
    {
      text = {
        '   Find File\n',
        '   Recent Files\n',
        '   Open Last File\n',
        '   Quit',
      },
      hl_group = 'LspInlayHint',
    },
    -- { text = string.rep('\n', 1) },
    {
      text = {
        '  Neovim loaded ',
        '' .. stats.loaded .. '',
        ' plugins in ',
        '' .. math.floor(stats.startuptime * 100 + 0.5) / 100 .. '',
        'ms',
      },
      hl_group = 'LspInlayHint',
    },
    -- { text = string.rep('\n', 1) },
  }

  vim.bo[buf].modifiable = true

  local start = 0
  for _, section in ipairs(sections) do
    local text = section.text
    if type(text) == 'table' then text = table.concat(text, '') end
    -- local lines = M.center(text)
    local lines = vim.split(text, '\n')
    vim.api.nvim_buf_set_lines(buf, start, start, false, lines)
    vim.api.nvim_buf_set_extmark(buf, ns, start, 0, {
      end_row = start + #lines,
      hl_group = section.hl_group,
    })
    start = start + #lines
  end

  vim.bo[buf].modifiable = false

  local cursor = vim.go.guicursor
  vim.api.nvim_set_hl(0, 'HiddenCursor', { blend = 100, nocombine = true })
  vim.go.guicursor = 'a:HiddenCursor/HiddenCursor'

  vim.api.nvim_create_autocmd('BufWipeout', {
    buffer = buf,
    once = true,
    callback = function()
      vim.go.guicursor = cursor
      vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
    end,
  })
end

function M.center(text, offset)
  local lines = vim.split(text, '\n')
  local width = 0
  for _, line in ipairs(lines) do
    width = math.max(width, vim.fn.strwidth(line))
  end

  local delta = math.floor((vim.go.columns - width) * (offset or 0.02) + 0.5)
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
    'statuscolumn=""',
  }
  -- Vim's `setlocal` is currently more robust comparing to `opt_local`
  vim.cmd(('silent! noautocmd setlocal %s'):format(table.concat(options, ' ')))
end

---Check whether table contains element
---@param table table<any, any>
---@param element any
---@return boolean
table.contains = function(table, element)
  for _, value in pairs(table) do
    if value == element then return true end
  end
  return false
end

function M.dont_show()
  local argv = require('utils').getargs()
  if (not table.contains(argv, '-i')) and #argv > 0 then return true end

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
