local extend = require('plugins.lsp').extend

local function cssls(lspconfig) lspconfig.cssls.setup(extend {}) end

return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(opts, 'ensure_installed', 'css', 'scss')
        end,
    },
    {
        'williamboman/mason.nvim',
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(opts, 'ensure_installed', 'css-lsp')
        end,
    },
    { 'neovim/nvim-lspconfig', opts = { servers = { cssls = cssls } } },
    {
        'nvimtools/none-ls.nvim',
        ft = { 'json' },
    },
}
