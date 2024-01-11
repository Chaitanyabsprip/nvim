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
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            vim.list_extend(opts.ensure_installed, { 'kotlin' })
        end,
    },
    {
        'williamboman/mason.nvim',
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            vim.list_extend(opts.ensure_installed, { 'kotlin_language_server' })
        end,
    },
    {
        'neovim/nvim-lspconfig',
        opts = { servers = { kotlin_language_server = kotlin_language_server } },
    },
}
