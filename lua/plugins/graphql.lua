local extend = require('plugins.lsp').extend
local function graphqlls(lspconfig) lspconfig.graphql.setup(extend {}) end

return {
    ---@type LazyPluginSpec
    {
        'nvim-treesitter/nvim-treesitter',
        optional = true,
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(opts, 'ensure_installed', 'graphql')
        end,
    },
    ---@type LazyPluginSpec
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
    ---@type LazyPluginSpec
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
    ---@type LazyPluginSpec
    {
        'neovim/nvim-lspconfig',
        optional = true,
        opts = { servers = { graphqlls = graphqlls } },
    },
    ---@type LazyPluginSpec
    {
        'jparise/vim-graphql',
        ft = 'graphql',
    },
}
