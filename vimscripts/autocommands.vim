" Return to last edit position when opening a file
augroup resume_edit_position
    autocmd!
    autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit'
        \ | execute "normal! g`\"zvzz"
        \ | endif
augroup END

" Display a message when the current file is not in utf-8 format.
" Note that we need to use `unsilent` command here because of this issue:
" https://github.com/vim/vim/issues/4379
" augroup non_utf8_file_warn
"     autocmd!
"     autocmd BufRead * if &fileencoding != 'utf-8'
"                 \ | unsilent echomsg 'File not in UTF-8 format!' | endif
" augroup END

" Automatically reload the file if it is changed outside of Nvim, see
" https://unix.stackexchange.com/a/383044/221410. It seems that `checktime`
" command does not work in command line. We need to check if we are in command
" line before executing this command. See also http://tinyurl.com/y6av4sy9.
augroup auto_read
    autocmd!
    autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
                \ if mode() == 'n' && getcmdwintype() == '' | checktime | endif
    autocmd FileChangedShellPost * echohl WarningMsg
                \ | echo "File changed on disk. Buffer reloaded!" | echohl None
augroup END

augroup auto_format
  autocmd!
  autocmd BufWritePre * lua vim.lsp.buf.formatting_sync(nil, 1000)
augroup end

" Line number settings
" augroup numbertoggle
"     autocmd!
			" autocmd BufEnter,FocusGained,InsertLeave    * set relativenumber
			" autocmd BufEnter,FocusLost,InsertEnter      * set norelativenumber
" augroup end
"
"
" augroup nvim-lightbulb
  " autocmd! CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()
" augroup end
"
" augroup ranger
"   au!
"   autocmd Filetype rnvimr tnoremap <buffer><nowait> j j
"   autocmd Filetype rnvimr tnoremap <buffer><nowait> k k
" augroup end

augroup pythonindent
  autocmd!
  autocmd FileType python,java setlocal shiftwidth=4 softtabstop=4 
augroup end

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * lua require'vim.highlight'.on_yank({higroup = "Substitute", timeout = 500, on_macro = true})
augroup END

function! <SID>SynStack()
    if !exists("*synstack")
      return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunction
nmap <C-P> :call <SID>SynStack()<CR>

function! SynGroup()                                                            
    let l:s = synID(line('.'), col('.'), 1)                                       
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfunction
nmap <C-q> :call SynGroup()<CR>

nmap <leader>nn :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175

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
