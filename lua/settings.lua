vim.api.nvim_set_option('termguicolors', true)
vim.cmd [[ filetype plugin indent on ]]
vim.cmd [[com! W w]]

vim.bo.autoindent = true
vim.bo.cindent = true
vim.bo.expandtab = true
vim.bo.fileformat = 'unix'
vim.bo.shiftwidth = 2
vim.bo.smartindent = true
vim.bo.softtabstop = 2
vim.bo.swapfile = false
vim.bo.tabstop = 2
vim.bo.textwidth = 80
vim.bo.undofile = true

vim.g.filetype = 'plugin on'
vim.g.instant_username = "Chaitanya Sharma"
vim.g.syntax = true
vim.g.python3_host_prog = "/opt/homebrew/bin/python3"

vim.o.background = 'dark'
vim.o.backspace = 'eol,start,indent'
vim.o.backup = false
vim.o.belloff = 'all'
vim.o.clipboard = 'unnamedplus'
vim.o.cmdheight = 1
vim.o.encoding = 'UTF-8'
vim.o.errorbells = false
vim.o.expandtab = true
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.hidden = true
vim.o.hlsearch = false
vim.o.inccommand = "nosplit"
vim.o.incsearch = true
vim.o.mouse = 'a'
vim.o.pumheight = 10
vim.o.pyxversion = 3
vim.o.scrolloff = 16
vim.o.sessionoptions =
    "blank,buffers,curdir,folds,help,options,tabpages,winsize,resize,winpos,terminal"
vim.o.shell = '/usr/bin/env fish'
vim.o.shiftwidth = 2
vim.o.showbreak = '↪'
vim.o.smartcase = true
vim.o.softtabstop = 2
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.swapfile = false
vim.o.tabstop = 2
vim.o.undodir = vim.fn.expand("~/.tmp/undodir")
vim.o.undofile = true
vim.o.updatetime = 500
vim.o.wildmenu = true
vim.o.writebackup = false

vim.wo.colorcolumn = '81'
vim.wo.conceallevel = 0
vim.wo.cursorcolumn = false
vim.wo.cursorline = false
vim.wo.foldcolumn = "0"
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
vim.wo.foldnestmax = 20
vim.wo.number = true
vim.wo.numberwidth = 1
vim.wo.relativenumber = true
vim.wo.signcolumn = "number"
vim.wo.wrap = false
