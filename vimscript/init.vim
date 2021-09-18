source ~/.config/nvim/vimscript/autocommands.vim
source ~/.config/nvim/vimscript/plugins/vim-ultest.vim

set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175

function! CreateCenteredFloatingWindow()
    let width = min([&columns - 4, max([80, &columns - 20])])
    let height = min([&lines - 4, max([20, &lines - 10])])
    let top = ((&lines - height) / 2) - 1
    let left = (&columns - width) / 2
    let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}

    let top = "╭" . repeat("─", width - 2) . "╮"
    let mid = "│" . repeat(" ", width - 2) . "│"
    let bot = "╰" . repeat("─", width - 2) . "╯"
    let lines = [top] + repeat([mid], height - 2) + [bot]
    let s:buf = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
    call nvim_open_win(s:buf, v:true, opts)
    set winhl=Normal:Floating
    let opts.row += 1
    let opts.height -= 2
    let opts.col += 2
    let opts.width -= 4
    call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
    au BufWipeout <buffer> exe 'bw '.s:buf
endfunction

" function! WorkmanLayoutBinds()
"     "(O)pen line -> (L)ine
"     nnoremap l o
"     nnoremap o l
"     nnoremap L O
"     nnoremap O L
"     "Search (N)ext -> (J)ump
"     nnoremap j n
"     nnoremap n j
"     nnoremap J N
"     nnoremap N J
"     nnoremap gn gj
"     nnoremap gj gn
"     "(E)nd of word -> brea(K) of word
"     nnoremap k e
"     nnoremap e k
"     nnoremap K E
"     nnoremap E <nop>
"     nnoremap gk ge
"     nnoremap ge gk
"     "(Y)ank -> (H)aul
"     nnoremap h y
"     onoremap h y
"     nnoremap y h
"     nnoremap H Y
"     nnoremap Y H
"   endfunction

function! ApplyColorTweaks()
    let g:colorscheme = g:colors_name

    hi! LspDiagnosticsDefaultError gui=bold
    hi! LspDiagnosticsDefaultWarning gui=bold
    hi! LspDiagnosticsDefaultHint gui=bold
    hi! LspDiagnosticsDefaultInformation gui=bold

    if g:colorscheme ==# "horizon"
        hi NonText      ctermfg=233 ctermbg=233   guifg=#414559 guibg=NONE
        hi VertSplit    cterm=bold  ctermfg=233   ctermbg=NONE  gui=bold      guifg=#0f1117 guibg=NONE
        hi Pmenu        ctermfg=255 ctermbg=236   guibg=#272c42 guifg=#eff0f4
        hi PmenuSel     ctermfg=255 ctermbg=240   guibg=#5b6389
        hi PmenuSbar    ctermbg=236 guibg=#3d425b
        hi PmenuThumb   ctermbg=233 guibg=#0f1117
        hi CursorLineNr cterm=bold  gui=bold      ctermfg=48    guifg=#09f7a0 ctermbg=NONE  guibg=NONE
        hi QuickFixLine ctermbg=235 ctermfg=NONE  guibg=#335172 guifg=NONE
        hi link         vimVar      NONE
        hi link         vimFuncVar  NONE
        hi link         vimUserFunc NONE
        hi link         jsonQuote   NONE
        call SaneDiffDefaults()

    elseif g:colorscheme ==# "tokyonight"
        hi! link ColorColumn CursorLine
        hi! link NvimTreeFolderIcon NormalFloat
        hi! link NvimTreeFolderName Directory
        hi DiffAdd    guibg=#283B4D guifg=NONE
        hi DiffChange guibg=#283B4D guifg=NONE
        hi DiffDelete guibg=#3C2C3C guifg=#725272 gui=bold
        hi DiffText   guibg=#365069 guifg=NONE
        hi! link DiffviewNormal NormalSB
        " hi! BufferlineFill guibg=#131620
        " call SaneDiffDefaults()
    endif
endfunction

" function! <SID>SynStack()
"     if !exists("*synstack")
"       return
"     endif
"     echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
" endfunction
" nmap <C-P> :call <SID>SynStack()<CR>

" function! SynGroup()                                                            
"     let l:s = synID(line('.'), col('.'), 1)                                       
"     echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
" endfunction
" nmap <C-q> :call SynGroup()<CR>

" nmap <leader>nn :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
" \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
" \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
