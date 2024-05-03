local extend = require('plugins.lsp').extend

local function sqlls(lspconfig) lspconfig.sqlls.setup(extend { root = { '.sqllsrc.json' } }) end

return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(opts, 'ensure_installed', 'sql')
        end,
    },
    {
        'williamboman/mason.nvim',
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(opts, 'ensure_installed', 'sqlls')
        end,
    },
    { 'neovim/nvim-lspconfig', opts = { servers = { sqlls = sqlls } } },
}
