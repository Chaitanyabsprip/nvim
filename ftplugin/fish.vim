" Set up :make to use fish for syntax checking.
" compiler "/usr/bin/env fish"

" Set this to have long lines wrap inside comments.
setlocal textwidth=80

" Enable folding of block structures in fish.
setlocal foldmethod=expr

setlocal commentstring=#\ %s
