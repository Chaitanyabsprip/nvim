if vim.g.vscode ~= nil then
  require('vscode').load()
end
vim.cmd [[ source ~/.config/nvim/vimscript/init.vim ]]
vim.cmd [[ source ~/.config/nvim/vimscript/ginit.vim ]]

require('autocommands').call()
require('settings').call()
require('mappings').call()
require('mappings').setup_keymaps()
require 'plugins.init'
require('theme').setup()
vim.cmd [[ imap <silent><script><expr> <C-L> copilot#Accept("") ]]
vim.g.copilot_no_tab_map = true
-- vim.lsp.set_log_level(vim.lsp.log_levels.DEBUG)
