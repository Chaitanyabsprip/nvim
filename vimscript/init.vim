source ~/.config/nvim/vimscript/autocommands.vim
source ~/.config/nvim/vimscript/plugins/folds.vim

set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait100-blinkoff400-blinkon1000
" set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50

augroup autoload_session
  autocmd!
  autocmd VimEnter * SessionLoad
augroup end
