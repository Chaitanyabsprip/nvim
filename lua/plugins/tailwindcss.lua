local configure = require('plugins.lsp').configure
local function tailwindcssls() configure 'tailwindcss' end

return {
    ---@type LazyPluginSpec
    {
        'williamboman/mason.nvim',
        optional = true,
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(
                opts,
                'ensure_installed',
                'tailwindcss-language-server'
            )
        end,
    },
    ---@type LazyPluginSpec
    {
        'neovim/nvim-lspconfig',
        optional = true,
        opts = { servers = { tailwindcssls = tailwindcssls } },
    },
    ---@type LazyPluginSpec
    {
        'Chaitanyabsprip/tailwind-tools.nvim',
        name = 'tailwind-tools',
        build = ':UpdateRemotePlugins',
        ft = {
            'css',
            'html',
            'javascript',
            'javascriptreact',
            'typescript',
            'typescriptreact',
            'astro',
        },
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'nvim-telescope/telescope.nvim',
            'neovim/nvim-lspconfig',
        },
        opts = { server = { override = false } },
    },
}
