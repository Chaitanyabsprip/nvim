require("settings")
require("mappings")
require("plugins")
vim.cmd [[source ~/.config/nvim/vimscripts/ginit.vim]]

-- plugins configurations

require("plugins.lsp-fastaction")
require("plugins.nvim-autopairs")
require("plugins.nvim-bufferline")
require("plugins.nvim-compe")
require("plugins.nvim-dap")
require("plugins.nvim-tree")
require("plugins.nvim-treesitter")
require("plugins.startify")
require("plugins.telescope")
require("plugins.themes")
-- require("plugins.themes.indent-line")
require("plugins.themes.lualine")
require("plugins.toggleterm")
require("plugins.trouble")

-- LSP
require("lsp.lsp-settings")

require("lsp.bash-ls")
require("lsp.clangd-ls")
require("lsp.css-ls")
require("lsp.dart-ls")
require("lsp.efm-general-ls")
-- require("lsp.gopls")
-- require("lsp.emmet-ls")
require("lsp.html-ls")
require("lsp.java-ls")
require("lsp.js-ts-ls")
require("lsp.json-ls")
require("lsp.lua-ls")
require("lsp.nvim-lsp")
require("lsp.pyright-ls")

vim.cmd [[ source ~/.config/nvim/vimscripts/autocommands.vim ]]
vim.schedule(function()
  vim.cmd [[ hi! ColorColumn guibg=#211f2d ctermbg=235 ]]
end)
