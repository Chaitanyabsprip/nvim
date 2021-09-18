let SessionLoad = 1
let s:cpo_save=&cpo
set cpo&vim
inoremap <silent> <M-k> :m .-2==gi
inoremap <silent> <M-j> :m .+1==gi
nnoremap <silent>  :e!
nnoremap 	 gt
nnoremap <NL> ok
nnoremap  Oj
tnoremap <silent>  
nnoremap <silent>  z <Cmd>ZenMode
nnoremap  v ggVG
nnoremap  Y gvy
nnoremap  y gg"+yG
nnoremap <silent>  q :q
nnoremap <silent>  L :wincmd L
nnoremap <silent>  K :wincmd K
nnoremap <silent>  J :wincmd J
nnoremap <silent>  H :wincmd H
nnoremap <silent>  l :wincmd l
nnoremap <silent>  k :wincmd k
nnoremap <silent>  j :wincmd j
nnoremap <silent>  h :wincmd h
nnoremap <silent>  w :w!
nnoremap <silent>   <Nop>
omap <silent> % <Plug>(MatchitOperationForward)
xmap <silent> % <Plug>(MatchitVisualForward)
nmap <silent> % <Plug>(MatchitNormalForward)
nnoremap <silent> ( :vertical resize -5
nnoremap <silent> ) :vertical resize +5
nnoremap <silent> + :res +1
nnoremap <silent> - :res -1
nnoremap : ;
nnoremap ; :
vnoremap < <gv
vnoremap > >gv
xnoremap H ^
nnoremap H ^
nnoremap J mzJ`z
xnoremap L g_
nnoremap L g_
nnoremap N Nzzzv
nnoremap Y y$
omap <silent> [% <Plug>(MatchitOperationMultiBackward)
xmap <silent> [% <Plug>(MatchitVisualMultiBackward)
nmap <silent> [% <Plug>(MatchitNormalMultiBackward)
nnoremap \y gg"+yG
omap <silent> ]% <Plug>(MatchitOperationMultiForward)
xmap <silent> ]% <Plug>(MatchitVisualMultiForward)
nmap <silent> ]% <Plug>(MatchitNormalMultiForward)
xmap a% <Plug>(MatchitVisualTextObject)
nmap gc <Plug>kommentary_motion_default
xmap gc <Plug>kommentary_visual_default
nmap gcc <Plug>kommentary_line_default
vmap gx <Plug>NetrwBrowseXVis
nmap gx <Plug>NetrwBrowseX
omap <silent> g% <Plug>(MatchitOperationBackward)
xmap <silent> g% <Plug>(MatchitVisualBackward)
nmap <silent> g% <Plug>(MatchitNormalBackward)
nnoremap gF :tabe <cfile>
vnoremap gs :sort
tnoremap jk 
tnoremap kj 
nnoremap n nzzzv
nnoremap { {zzzv
nnoremap } }zzzv
xnoremap <silent> <Plug>kommentary_visual_decrease <Cmd>call v:lua.kommentary.go(2, 'kommentary.decrease_comment_level')
nnoremap <silent> <Plug>kommentary_line_decrease <Cmd>call v:lua.kommentary.go(1, 'kommentary.decrease_comment_level')
nnoremap <silent> <expr> <Plug>kommentary_motion_decrease v:lua.kommentary.go(4, 'kommentary.decrease_comment_level')
xnoremap <silent> <Plug>kommentary_visual_increase <Cmd>call v:lua.kommentary.go(2, 'kommentary.increase_comment_level')
nnoremap <silent> <Plug>kommentary_line_increase <Cmd>call v:lua.kommentary.go(1, 'kommentary.increase_comment_level')
nnoremap <silent> <expr> <Plug>kommentary_motion_increase v:lua.kommentary.go(4, 'kommentary.increase_comment_level')
xnoremap <silent> <Plug>kommentary_visual_default <Cmd>call v:lua.kommentary.go(2)
nnoremap <silent> <Plug>kommentary_line_default <Cmd>call v:lua.kommentary.go(1)
nnoremap <silent> <expr> <Plug>kommentary_motion_default v:lua.kommentary.go(4)
vnoremap <silent> <Plug>NetrwBrowseXVis :call netrw#BrowseXVis()
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#BrowseX(netrw#GX(),netrw#CheckIfRemote(netrw#GX()))
xmap <silent> <Plug>(MatchitVisualTextObject) <Plug>(MatchitVisualMultiBackward)o<Plug>(MatchitVisualMultiForward)
onoremap <silent> <Plug>(MatchitOperationMultiForward) :call matchit#MultiMatch("W",  "o")
onoremap <silent> <Plug>(MatchitOperationMultiBackward) :call matchit#MultiMatch("bW", "o")
xnoremap <silent> <Plug>(MatchitVisualMultiForward) :call matchit#MultiMatch("W",  "n")m'gv``
xnoremap <silent> <Plug>(MatchitVisualMultiBackward) :call matchit#MultiMatch("bW", "n")m'gv``
nnoremap <silent> <Plug>(MatchitNormalMultiForward) :call matchit#MultiMatch("W",  "n")
nnoremap <silent> <Plug>(MatchitNormalMultiBackward) :call matchit#MultiMatch("bW", "n")
onoremap <silent> <Plug>(MatchitOperationBackward) :call matchit#Match_wrapper('',0,'o')
onoremap <silent> <Plug>(MatchitOperationForward) :call matchit#Match_wrapper('',1,'o')
xnoremap <silent> <Plug>(MatchitVisualBackward) :call matchit#Match_wrapper('',0,'v')m'gv``
xnoremap <silent> <Plug>(MatchitVisualForward) :call matchit#Match_wrapper('',1,'v')m'gv``
nnoremap <silent> <Plug>(MatchitNormalBackward) :call matchit#Match_wrapper('',0,'n')
nnoremap <silent> <Plug>(MatchitNormalForward) :call matchit#Match_wrapper('',1,'n')
nnoremap <S-Tab> gT
vnoremap <silent> <M-k> :m '<-2gv=gv
vnoremap <silent> <M-j> :m '>+1gv=gv
nnoremap <silent> <M-k> :m .-2==
nnoremap <silent> <M-j> :m .+1==
tnoremap <M-[> 
inoremap ! !U
inoremap , ,U
inoremap . .U
inoremap ? ?U
inoremap jk 
inoremap kj 
let &cpo=s:cpo_save
unlet s:cpo_save
set backspace=eol,start,indent
set clipboard=unnamedplus
set expandtab
set foldlevelstart=99
set guifont=Victor\ Mono\ Nerd\ Font:h18
set helplang=en
set hidden
set nohlsearch
set inccommand=nosplit
set mouse=a
set pumheight=10
set pyxversion=3
set runtimepath=~/.config/nvim,/etc/xdg/nvim,~/.local/share/nvim/site,~/.local/share/nvim/site/pack/packer/start/snap,~/.local/share/nvim/site/pack/packer/start/rose-pine,~/.local/share/nvim/site/pack/packer/start/packer.nvim,~/.local/share/nvim/site/pack/packer/start/nvim-web-devicons,~/.local/share/nvim/site/pack/packer/start/nvim-tree.lua,~/.local/share/nvim/site/pack/packer/start/kommentary,/usr/local/share/nvim/site,/usr/share/nvim/site,/opt/homebrew/Cellar/neovim/0.5.0/share/nvim/runtime,/opt/homebrew/Cellar/neovim/0.5.0/share/nvim/runtime/pack/dist/opt/matchit,/opt/homebrew/Cellar/neovim/0.5.0/lib/nvim,/usr/share/nvim/site/after,/usr/local/share/nvim/site/after,~/.local/share/nvim/site/after,/etc/xdg/nvim/after,~/.config/nvim/after
set scrolloff=16
set sessionoptions=blank,buffers,curdir,folds,help,options,tabpages,winsize,resize,winpos,terminal
set shell=/usr/bin/env\ fish
set shiftwidth=2
set showbreak=↪
set smartcase
set softtabstop=2
set splitbelow
set splitright
set noswapfile
set tabstop=2
set termguicolors
set undodir=~/.tmp/undodir
set undofile
set updatetime=500
set window=45
set nowritebackup
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/.config/nvim
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +0 init.lua
badd +0 lua/plugins/init.lua
argglobal
%argdel
set lines=46 columns=192
edit init.lua
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe 'vert 1resize ' . ((&columns * 95 + 96) / 192)
exe 'vert 2resize ' . ((&columns * 96 + 96) / 192)
argglobal
balt lua/plugins/init.lua
setlocal keymap=
setlocal noarabic
setlocal autoindent
setlocal backupcopy=
setlocal nobinary
setlocal nobreakindent
setlocal breakindentopt=
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),0],:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
set colorcolumn=81
setlocal colorcolumn=81
setlocal comments=:--
setlocal commentstring=--%s
setlocal complete=.,w,b,u,t
setlocal concealcursor=
setlocal conceallevel=0
setlocal completefunc=
setlocal nocopyindent
setlocal nocursorbind
setlocal nocursorcolumn
setlocal nocursorline
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal expandtab
if &filetype != 'lua'
setlocal filetype=lua
endif
setlocal fillchars=
setlocal fixendofline
setlocal foldcolumn=0
setlocal foldenable
set foldexpr=nvim_treesitter#foldexpr()
setlocal foldexpr=nvim_treesitter#foldexpr()
setlocal foldignore=#
set foldlevel=99
setlocal foldlevel=99
setlocal foldmarker={{{,}}}
set foldmethod=expr
setlocal foldmethod=expr
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=jcroql
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal formatprg=
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=-1
setlocal include=
setlocal includeexpr=
setlocal indentexpr=GetLuaIndent()
setlocal indentkeys=0{,0},0),0],:,0#,!^F,o,O,e,0=end,0=until
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255
setlocal keywordprg=
setlocal nolinebreak
setlocal nolisp
setlocal lispwords=
setlocal nolist
setlocal listchars=
setlocal makeencoding=
setlocal makeprg=
setlocal matchpairs=(:),{:},[:]
setlocal modeline
setlocal modifiable
setlocal nrformats=bin,hex
set number
setlocal number
set numberwidth=1
setlocal numberwidth=1
setlocal omnifunc=
setlocal path=
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
set relativenumber
setlocal relativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal scrollback=-1
setlocal noscrollbind
setlocal scrolloff=16
setlocal shiftwidth=2
setlocal sidescrolloff=-1
set signcolumn=number
setlocal signcolumn=number
setlocal nosmartindent
setlocal softtabstop=2
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal spelloptions=
setlocal statusline=
setlocal suffixesadd=.lua
setlocal noswapfile
setlocal synmaxcol=3000
if &syntax != 'lua'
setlocal syntax=lua
endif
setlocal tagfunc=
setlocal tabstop=2
setlocal tagcase=
setlocal tags=
setlocal textwidth=0
setlocal thesaurus=
setlocal undofile
setlocal undolevels=-123456
setlocal varsofttabstop=
setlocal vartabstop=
setlocal winblend=0
setlocal winhighlight=
setlocal nowinfixheight
setlocal nowinfixwidth
set nowrap
setlocal nowrap
setlocal wrapmargin=0
let s:l = 14 - ((13 * winheight(0) + 22) / 44)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 14
normal! 026|
wincmd w
argglobal
if bufexists("lua/plugins/init.lua") | buffer lua/plugins/init.lua | else | edit lua/plugins/init.lua | endif
if &buftype ==# 'terminal'
  silent file lua/plugins/init.lua
endif
balt init.lua
setlocal keymap=
setlocal noarabic
setlocal autoindent
setlocal backupcopy=
setlocal nobinary
setlocal nobreakindent
setlocal breakindentopt=
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),0],:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
set colorcolumn=81
setlocal colorcolumn=81
setlocal comments=:--
setlocal commentstring=--%s
setlocal complete=.,w,b,u,t
setlocal concealcursor=
setlocal conceallevel=0
setlocal completefunc=
setlocal nocopyindent
setlocal nocursorbind
setlocal nocursorcolumn
setlocal nocursorline
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal expandtab
if &filetype != 'lua'
setlocal filetype=lua
endif
setlocal fillchars=
setlocal fixendofline
setlocal foldcolumn=0
setlocal foldenable
set foldexpr=nvim_treesitter#foldexpr()
setlocal foldexpr=nvim_treesitter#foldexpr()
setlocal foldignore=#
set foldlevel=99
setlocal foldlevel=99
setlocal foldmarker={{{,}}}
set foldmethod=expr
setlocal foldmethod=expr
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=jcroql
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal formatprg=
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=-1
setlocal include=
setlocal includeexpr=
setlocal indentexpr=GetLuaIndent()
setlocal indentkeys=0{,0},0),0],:,0#,!^F,o,O,e,0=end,0=until
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255
setlocal keywordprg=
setlocal nolinebreak
setlocal nolisp
setlocal lispwords=
setlocal nolist
setlocal listchars=
setlocal makeencoding=
setlocal makeprg=
setlocal matchpairs=(:),{:},[:]
setlocal modeline
setlocal modifiable
setlocal nrformats=bin,hex
set number
setlocal number
set numberwidth=1
setlocal numberwidth=1
setlocal omnifunc=
setlocal path=
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
set relativenumber
setlocal relativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal scrollback=-1
setlocal noscrollbind
setlocal scrolloff=-1
setlocal shiftwidth=2
setlocal sidescrolloff=-1
set signcolumn=number
setlocal signcolumn=number
setlocal nosmartindent
setlocal softtabstop=2
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal spelloptions=
setlocal statusline=
setlocal suffixesadd=.lua
setlocal noswapfile
setlocal synmaxcol=3000
if &syntax != 'lua'
setlocal syntax=lua
endif
setlocal tagfunc=
setlocal tabstop=2
setlocal tagcase=
setlocal tags=
setlocal textwidth=0
setlocal thesaurus=
setlocal undofile
setlocal undolevels=-123456
setlocal varsofttabstop=
setlocal vartabstop=
setlocal winblend=0
setlocal winhighlight=
setlocal nowinfixheight
setlocal nowinfixwidth
set nowrap
setlocal nowrap
setlocal wrapmargin=0
let s:l = 227 - ((27 * winheight(0) + 22) / 44)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 227
normal! 0
wincmd w
2wincmd w
exe 'vert 1resize ' . ((&columns * 95 + 96) / 192)
exe 'vert 2resize ' . ((&columns * 96 + 96) / 192)
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0&& getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToOF
let &winminheight = s:save_winminheight
let &winminwidth = s:save_winminwidth
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
