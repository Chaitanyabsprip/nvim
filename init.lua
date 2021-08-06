require("settings")
require("mappings")
require("plugins")
vim.cmd [[source /home/chaitanya/.config/nvim/vimscripts/ginit.vim]]

-- plugins configurations

require("plugin-config.nvim-autopairs")
require("plugin-config.telescope")
-- require("plugin-config.themes.indent-line")
require("plugin-config.toggleterm")
require("plugin-config.lsp-fastaction")
require("plugin-config.nvim-compe")
require("plugin-config.nvim-tree")
require("plugin-config.nvim-treesitter")
require("plugin-config.startify")
require("plugin-config.themes")
require("plugin-config.themes.lualine")
require("plugin-config.trouble")

-- LSP
require("lsp.lsp-settings")

require("lsp.bash-ls")
require("lsp.clangd-ls")
require("lsp.css-ls")
require("lsp.dart-ls")
require("lsp.efm-general-ls")
require("lsp.emmet-ls")
require("lsp.gopls")
require("lsp.haskell-ls")
require("lsp.html-ls")
require("lsp.java-ls")
require("lsp.js-ts-ls")
require("lsp.json-ls")
require("lsp.lua-ls")
require("lsp.nvim-lsp")
require("lsp.pyright-ls")

vim.cmd [[source /home/chaitanya/.config/nvim/vimscripts/autocommands.vim]]
