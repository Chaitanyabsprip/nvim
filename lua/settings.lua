vim.api.nvim_set_option('termguicolors', true)
vim.cmd [[ filetype plugin indent on ]]

vim.bo.autoindent = true
vim.bo.cindent = true
vim.bo.expandtab = true
vim.bo.fileformat = 'unix'
vim.bo.shiftwidth = 2
vim.bo.smartindent = true
vim.bo.softtabstop = 2
vim.bo.swapfile = false
vim.bo.tabstop = 2
vim.bo.undofile = true

vim.g.filetype = 'plugin on'
vim.g.instant_username = 'Chaitanya Sharma'
vim.g.syntax = true
vim.g.python3_host_prog = '/opt/homebrew/bin/python3'
vim.g.timoutlen = 500
vim.g.showmode = false

vim.o.background = 'dark'
vim.o.backspace = 'eol,start,indent'
vim.o.backup = false
vim.o.belloff = 'all'
vim.o.clipboard = 'unnamedplus'
vim.o.cmdheight = 1
vim.o.encoding = 'UTF-8'
vim.o.errorbells = false
vim.o.expandtab = true
-- vim.o.fillchars = vim.o.fillchars .. 'eob: ,fold: '
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.hlsearch = false
vim.o.incsearch = true
vim.o.mouse = 'a'
vim.o.pumheight = 25
vim.o.pyxversion = 3
vim.o.scrolloff = 8
vim.o.sessionoptions = 'buffers,curdir,winsize,resize,winpos,folds,tabpages'
vim.o.shell = '/usr/bin/env zsh'
vim.o.shiftwidth = 2
vim.o.showbreak = '↪'
vim.o.smartcase = true
vim.o.softtabstop = 2
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.swapfile = false
vim.o.tabstop = 2
vim.o.textwidth = 80
vim.o.undodir = vim.fn.expand '~/.tmp/undodir'
vim.o.undofile = true
vim.o.updatetime = 200
vim.o.wildmenu = true
vim.o.writebackup = false

vim.opt.completeopt = { 'menuone', 'menu', 'noselect' }
vim.opt.pumblend = 20

vim.wo.colorcolumn = '81'
vim.wo.conceallevel = 2
vim.wo.concealcursor = 'n'
vim.wo.cursorcolumn = false
vim.wo.cursorline = true
vim.wo.foldcolumn = '0'
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
vim.wo.number = true
vim.wo.numberwidth = 1
vim.wo.relativenumber = false
vim.wo.signcolumn = 'yes'
vim.wo.wrap = false

-- vim.cmd [[ set langmap=qq,dw,re,wr,bt,jy,fu,ui,po,\\;p,aa,ss,hd,tf,gg,yh,nj,ek,ol,i\\;,zz,xx,mc,cv,vb,kn,lm,QQ,DW,RE,WR,BT,JY,FU,UI,PO,:P,AA,SS,HD,TF,GG,YH,NJ,EK,OL,I:,ZZ,XX,MC,CV,VB,KN,LM ]]
-- vim.g.langremap = false
