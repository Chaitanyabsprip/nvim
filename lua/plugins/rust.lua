---@type LazySpec[]
return {
    {
        'mrcjkb/rustaceanvim',
        version = '^5',
        lazy = false,
        init = function()
            vim.g.rustaceanvim = { server = { on_attach = require('lsp').on_attach } }
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter',
        optional = true,
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(opts, 'ensure_installed', 'rust')
        end,
    },
}
