local configure = require('plugins.lsp').configure
local function graphqlls() configure('graphql', {}) end

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
        ft = function(_, filetypes) return vim.list_extend(filetypes, { 'json' }) end,
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(
                opts,
                'sources',
                ---@param builtins NullBuiltin
                function(builtins)
                    return { builtins.formatting.prettierd.with { filetypes = { 'graphql' } } }
                end
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
