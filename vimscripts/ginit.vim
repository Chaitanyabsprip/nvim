  augroup sourceinit
    autocmd!
    autocmd! BufWritePost ~/.config/nvim/vimscripts/ginit.vim source ~/.config/nvim/vimscripts/ginit.vim
  augroup end


if exists('g:started_by_firenvim')
  set guifont=Victor\ Mono\ Nerd\ Font:h8
else
  set guifont=Victor\ Mono\ Nerd\ Font:h18 
endif

let g:neovide_cursor_animation_length=0.08
  " set guioptions+=T
  " set guioptions-=m
  " set guioptions+=d
  " set guioptions+=!
