  augroup sourceinit
    autocmd!
    autocmd! BufWritePost vim.expand('~')./.config/nvim/vimscripts/ginit.vim source ~/.config/nvim/vimscripts/ginit.vim
  augroup end


" set guioptions+=T
" set guioptions-=m
" set guioptions+=d
" set guioptions+=!

" neovide
lua << EOF
vim.g.neovide_cursor_animation_length = 0.007
vim.opt.guifont = "VictorMono Nerd Font:h14:w8"
EOF
set linespace=10
