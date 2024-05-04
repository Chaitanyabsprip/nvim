local extend = require('plugins.lsp').extend
local function graphqlls(lspconfig) lspconfig.graphql.setup(extend {}) end

return {
    {
        'nvim-treesitter/nvim-treesitter',
        optional = true,
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(opts, 'ensure_installed', 'graphql')
        end,
    },
    {
        'williamboman/mason.nvim',
        optional = true,
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(
                opts,
                'ensure_installed',
                'graphql-language-service-cli',
                'prettierd'
            )
        end,
    },
    {
        'nvimtools/none-ls.nvim',
        optional = true,
        ft = { 'json' },
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(
                opts,
                'sources',
                function(builtins) return { builtins.formatting.prettierd } end
            )
        end,
    },
    { 'neovim/nvim-lspconfig', optional = true, opts = { servers = { graphqlls = graphqlls } } },
    { 'jparise/vim-graphql', ft = 'graphql' },
}
