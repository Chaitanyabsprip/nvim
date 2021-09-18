let g:ultest_use_pty = 1

let g:ultest_output_on_line = 0
let g:ultest_max_threads = 4
let g:ultest_virtual_text = 1
let g:ultest_running_sign = ""
let g:ultest_pass_text = "✔"
let g:ultest_fail_text = "✖"

" augroup UltestRunner
"     au!
"     au BufWritePost * UltestNearest
" augroup END

nmap <silent> <leader>trf <Plug>(ultest-run-file)
nmap [t <Plug>(ultest-prev-fail)
nmap ]t <Plug>(ultest-next-fail)
nnoremap <silent> <A-S-t> <CMD>Ultest<CR>
nnoremap <silent> <A-c> <CMD>UltestClear<CR>
nnoremap <silent> <A-o> <CMD>UltestOutput<CR>
nnoremap <silent> <A-s> <CMD>UltestSummary<CR>
nnoremap <silent> <A-t> <CMD>UltestNearest<CR>
