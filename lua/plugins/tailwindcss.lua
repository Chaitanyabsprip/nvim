local extend = require('plugins.lsp').extend

local function tailwindcssls(lspconfig) lspconfig.tailwindcss.setup(extend {}) end

return {
    {
        'williamboman/mason.nvim',
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(
                opts,
                'ensure_installed',
                'tailwindcss-language-server'
            )
        end,
    },
    { 'neovim/nvim-lspconfig', opts = { servers = { tailwindcssls = tailwindcssls } } },
}
