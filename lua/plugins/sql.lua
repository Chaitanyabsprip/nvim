local extend = require('plugins.lsp').extend

local function sqlls(lspconfig) lspconfig.sqlls.setup(extend { root = { '.sqllsrc.json' } }) end

return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'sql' } },
  },
  {
    'williamboman/mason.nvim',
    opts = { ensure_installed = { 'sqlls' } },
  },
  { 'neovim/nvim-lspconfig', opts = { servers = { sqlls = sqlls } } },
}
