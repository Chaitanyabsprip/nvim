if vim.g.vscode ~= nil then
  require('vscode').load()
end
vim.cmd [[ source ~/.config/nvim/vimscript/init.vim ]]
vim.cmd [[ source ~/.config/nvim/vimscript/ginit.vim ]]

require 'settings'
require('mappings').setup_keymaps()
require 'plugins'
require('theme').setup()
vim.cmd [[ imap <silent><script><expr> <C-L> copilot#Accept("") ]]
vim.g.copilot_no_tab_map = true
