local config = {}
local M = {}
_G.Status = M

function M.fold()
  local line = vim.v.lnum

  if vim.fn.foldlevel(line) > 1 then return ' ' end
  if vim.fn.foldlevel(line) <= vim.fn.foldlevel(line - 1) then return ' ' end

  return vim.fn.foldclosed(line) > 0 and '' or ''
end

M.show_foldcolumn = true

function config.toggle_foldcolumn()
  M.show_foldcolumn = not M.show_foldcolumn
  vim.o.statuscolumn = M.status_column()
end

function M.status_column()
  local folds = ''
  if M.show_foldcolumn then folds = [[%#FoldColumn#%{v:lua.Status.fold()} ]] end
  local components = {
    [[%=]],
    [[%{v:virtnum < 1 ? (v:relnum ? v:relnum : v:lnum < 10 ? v:lnum . '  ' : v:lnum) : ''}]],
    [[%=]],
    [[%s]],
    folds,
  }
  return table.concat(components, '')
end

config.autocommands = function()
  local augroup = function(group) vim.api.nvim_create_augroup(group, { clear = true }) end
  local autocmd = function(event, opts)
    if not opts.disable then vim.api.nvim_create_autocmd(event, opts) end
  end

  autocmd('FileType', {
    group = augroup 'quit_mapping',
    pattern = { 'help', 'lspinfo', 'man', 'notify', 'qf', 'startuptime' },
    command = 'nnoremap <buffer> <silent> q <cmd>close<CR>',
  })

  autocmd('TextYankPost', {
    group = augroup 'higlight_yank',
    callback = function()
      require('vim.highlight').on_yank { higroup = 'Substitute', timeout = 500, on_macro = true }
    end,
  })

  local restore_fold = augroup 'restore fold state'
  autocmd('BufWinLeave', { group = restore_fold, pattern = '*.*', command = 'mkview 1' })
  autocmd('BufWinEnter', { group = restore_fold, pattern = '*.*', command = 'silent! loadview 1' })

  autocmd('User', {
    group = augroup 'startuptime',
    pattern = 'VeryLazy',
    command = "lua vim.notify('Startuptime ' .. require('lazy').stats().startuptime, vim.log.levels.INFO)",
  })
  autocmd({ 'FileType' }, {
    group = augroup 'fix_conceal',
    pattern = { 'json', 'jsonc' },
    callback = function()
      vim.wo.spell = false
      vim.wo.conceallevel = 0
    end,
  })
end

config.options = {}

config.options.disable_builtins = function()
  vim.cmd [[
    syntax off
    filetype off
  ]]
  local disabled_built_ins = {
    '2html_plugin',
    -- 'fzf',
    'getscript',
    'getscriptPlugin',
    'gzip',
    'logiPat',
    'man',
    'matchit',
    'matchparen',
    'netrw',
    'netrwFileHandlers',
    'netrwPlugin',
    'netrwSettings',
    'rrhelper',
    'shada_plugin',
    'tar',
    'tarPlugin',
    'vimball',
    'vimballPlugin',
    'zip',
    'zipPlugin',
  }

  for i = 1, #disabled_built_ins do
    vim.g['loaded_' .. disabled_built_ins[i]] = 1
  end

  -- Skip some remote provider loading
  vim.g.loaded_python3_provider = 0
  vim.g.loaded_node_provider = 0
  vim.g.loaded_perl_provider = 0
  vim.g.loaded_ruby_provider = 0
end

config.options.setup = function()
  vim.go.grepprg = 'rg --vimgrep --no-heading --smart-case'
  vim.go.grepformat = '%f:%l:%c:%m'

  vim.opt.termguicolors = true
  vim.o.clipboard = 'unnamedplus'
  vim.o.number = true
  vim.o.numberwidth = 3
  vim.o.relativenumber = true
  vim.wo.signcolumn = 'yes'

  -- indent
  vim.o.autoindent = true
  vim.o.cindent = true
  vim.o.smarttab = true
  vim.o.expandtab = true
  vim.o.shiftwidth = 2
  vim.o.smartindent = true
  vim.o.softtabstop = 2
  vim.o.tabstop = 2

  -- use undofile over swapfile
  vim.o.undodir = vim.fn.expand '~/.tmp/undodir'
  vim.o.undofile = true
  vim.o.swapfile = false
  vim.o.backup = false
  vim.o.writebackup = false

  -- disable wrap
  vim.wo.wrap = false
  vim.o.cmdheight = 0
  vim.o.scrolloff = 8
  vim.o.colorcolumn = '81'
  vim.o.conceallevel = 3

  vim.o.sessionoptions = 'buffers,curdir,winsize,resize,winpos,folds,tabpages'
  vim.o.shell = '/usr/bin/env zsh'

  -- split options
  vim.o.splitbelow = true
  vim.o.splitright = true
  vim.o.laststatus = 3

  -- folding
  vim.wo.foldmethod = 'expr'
  vim.o.foldlevel = 99
  vim.o.foldlevelstart = 99

  vim.o.statuscolumn = M.status_column()

  -- search
  vim.o.hlsearch = false
  vim.o.incsearch = true
  vim.o.smartcase = true
  vim.o.ignorecase = true

  -- autocomplete popup
  vim.opt.pumblend = 10
  vim.opt.pumheight = 10

  vim.o.shortmess = 'filnxtToOFIcCs'
  vim.opt.fillchars = {
    foldopen = '',
    foldclose = '',
    fold = ' ',
    foldsep = ' ',
    diff = '╱',
    eob = ' ',
  }
end

config.options.lazy = function()
  vim.cmd 'syntax on'
  require('plugins.ui').setup()
  require('plugins.ui.greeter').setup()
  vim.api.nvim_create_user_command('ToggleFoldcolumn', M.toggle_foldcolumn, { nargs = 0 })
end

return config
