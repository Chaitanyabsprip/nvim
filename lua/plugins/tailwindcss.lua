local extend = require('plugins.lsp').extend

local function tailwindcssls(lspconfig) lspconfig.tailwindcss.setup(extend { autostart = false }) end

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
