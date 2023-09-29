local extend = require('plugins.lsp').extend
local function graphqlls(lspconfig) lspconfig.graphql.setup(extend {}) end

return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = { ensure_installed = { 'graphql' } },
    },
    {
        'williamboman/mason.nvim',
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            vim.list_extend(opts.ensure_installed, { 'graphql-language-service-cli', 'prettierd' })
        end,
    },
    {
        'jose-elias-alvarez/null-ls.nvim',
        ft = { 'json' },
        opts = function(_, opts)
            opts.sources = opts.sources or {}
            vim.list_extend(
                opts.sources,
                { function(builtins) return { builtins.formatting.prettierd } end }
            )
        end,
    },
    { 'neovim/nvim-lspconfig', opts = { servers = { graphqlls = graphqlls } } },
    { 'jparise/vim-graphql', ft = 'graphql' },
}
