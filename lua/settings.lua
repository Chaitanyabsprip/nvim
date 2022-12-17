local settings = {}

settings.setup = function()
  local disabled_built_ins = {
    'gzip',
    'man',
    'matchit',
    'matchparen',
    'shada_plugin',
    'tarPlugin',
    'tar',
    'zipPlugin',
    'zip',
    'netrwPlugin',
    'netrw',
  }

  for i = 1, #disabled_built_ins do
    vim.g['loaded_' .. disabled_built_ins[i]] = 1
  end

  -- Skip some remote provider loading
  vim.g.loaded_python3_provider = 0
  vim.g.loaded_node_provider = 0
  vim.g.loaded_perl_provider = 0
  vim.g.loaded_ruby_provider = 0

  vim.cmd [[
    set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
    set grepformat=%f:%l:%c:%m
  ]]

  vim.opt.termguicolors = true
  vim.g.filetype = 'plugin indent on'
  vim.g.syntax = true
  vim.o.clipboard = 'unnamedplus'
  vim.wo.signcolumn = 'yes'

  -- indent
  vim.o.autoindent = true
  vim.o.cindent = true
  vim.o.expandtab = true
  vim.o.shiftwidth = 2
  vim.o.smartindent = true
  vim.o.softtabstop = 2
  vim.o.tabstop = 2

  -- use undofile over swapfile
  vim.o.undodir = vim.fn.expand '~/.tmp/undodir'
  vim.o.undofile = true
  vim.o.swapfile = false
  vim.o.writebackup = false

  -- disable wrap
  vim.wo.wrap = false
  vim.o.cmdheight = 0
  vim.o.scrolloff = 8

  vim.o.sessionoptions = 'buffers,curdir,winsize,resize,winpos,folds,tabpages'
  vim.o.shell = '/usr/bin/env zsh'

  -- split options
  vim.g.splitbelow = true
  vim.g.splitright = true
  vim.o.laststatus = 3

  -- folding
  vim.wo.foldcolumn = '0'
  vim.wo.foldmethod = 'expr'
  vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
  vim.o.foldlevel = 99
  vim.o.foldlevelstart = 99

  -- search
  vim.o.hlsearch = false
  vim.o.incsearch = true
  vim.o.smartcase = true
end

return settings
