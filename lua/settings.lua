local settings = {}

settings.setup = function()
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

  vim.go.grepprg = 'rg --vimgrep --no-heading --smart-case'
  vim.go.grepformat = '%f:%l:%c:%m'

  vim.opt.termguicolors = true
  vim.o.clipboard = 'unnamedplus'
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
  vim.wo.colorcolumn = 81
  vim.o.conceallevel = 3

  vim.o.sessionoptions = 'buffers,curdir,winsize,resize,winpos,folds,tabpages'
  vim.o.shell = '/usr/bin/env zsh'

  -- split options
  vim.o.splitbelow = true
  vim.o.splitright = true
  vim.o.laststatus = 3

  -- folding
  vim.wo.foldcolumn = '0'
  vim.wo.foldmethod = 'expr'
  -- vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
  vim.o.foldlevel = 99
  vim.o.foldlevelstart = 99

  -- search
  vim.o.hlsearch = false
  vim.o.incsearch = true
  vim.o.smartcase = true
  vim.o.ignorecase = true

  -- popup
  vim.opt.pumblend = 10
  vim.opt.pumheight = 10

  vim.o.shortmess = 'filnxtToOFWIcC'
end

settings.lazy = function() vim.cmd 'syntax on' end

return settings
