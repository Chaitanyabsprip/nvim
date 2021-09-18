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
augroup non_utf8_file_warn
    autocmd!
    autocmd BufRead * if &fileencoding != 'utf-8'
                \ | unsilent echomsg 'File not in UTF-8 format!' | endif
augroup END

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
augroup end

augroup rust_inlay_hints
  autocmd!
  autocmd CursorMoved,InsertChange,BufEnter,BufWinEnter,TabEnter,BufWritePost *.rs 
        \ lua require'lsp_extensions'.inlay_hints {
        \       highlight = "InlayHints",
        \       prefix = "",
        \       aligned = false,
        \       only_current_line = false,
        \       enabled = {"TypeHint", "ChainingHint", "ParameterHint"}
        \     }
augroup end
