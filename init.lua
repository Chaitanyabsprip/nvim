vim.cmd [[ source ~/.config/nvim/vimscript/init.vim ]]
vim.cmd [[ source ~/.config/nvim/vimscript/ginit.vim ]]

require 'settings'
require 'mappings'
require 'plugins'
require('theme').setup()
