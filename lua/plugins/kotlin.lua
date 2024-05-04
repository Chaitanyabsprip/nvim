local extend = require('plugins.lsp').extend

local function kotlin_language_server(lspconfig)
    lspconfig.kotlin_language_server.setup(
        extend { override_root = true, root = { '.git', 'gradlew', vim.fn.getcwd() } }
    )
end

return {
    { 'udalov/kotlin-vim' },
    {
        'nvim-treesitter/nvim-treesitter',
        optional = true,
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(opts, 'ensure_installed', 'kotlin')
        end,
    },
    {
        'williamboman/mason.nvim',
        optional = true,
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(
                opts,
                'ensure_installed',
                'kotlin_language_server'
            )
        end,
    },
    {
        'neovim/nvim-lspconfig',
        optional = true,
        opts = { servers = { kotlin_language_server = kotlin_language_server } },
    },
}
