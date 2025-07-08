local configure = require('plugins.lsp').configure

local function tailwindcssls() configure('tailwindcss', { autostart = false }) end

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
}
