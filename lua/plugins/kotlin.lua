local configure = require('plugins.lsp').configure

local function kotlin_language_server()
    configure(
        'kotlin_language_server',
        { override_root = true, root = { '.git', 'gradlew', vim.fn.getcwd() } }
    )
end

return {
    ---@type LazyPluginSpec
    { 'udalov/kotlin-vim' },
    ---@type LazyPluginSpec
    {
        'nvim-treesitter/nvim-treesitter',
        optional = true,
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(opts, 'ensure_installed', 'kotlin')
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
                'kotlin-language-server'
            )
        end,
    },
    ---@type LazyPluginSpec
    {
        'neovim/nvim-lspconfig',
        optional = true,
        opts = { servers = { kotlin_language_server = kotlin_language_server } },
    },
}
