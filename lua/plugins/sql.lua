local extend = require('plugins.lsp').extend

local function sqlls(lspconfig) lspconfig.sqlls.setup(extend { root = { '.sqllsrc.json' } }) end

return {
    {
        'nvim-treesitter/nvim-treesitter',
        optional = true,
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(opts, 'ensure_installed', 'sql')
        end,
    },
    {
        'williamboman/mason.nvim',
        optional = true,
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(opts, 'ensure_installed', 'sqlls')
        end,
    },
    { 'neovim/nvim-lspconfig', optional = true, opts = { servers = { sqlls = sqlls } } },
}
