local extend = require('plugins.lsp').extend

local function cssls(lspconfig) lspconfig.cssls.setup(extend {}) end

return {
    {
        'nvim-treesitter/nvim-treesitter',
        optional = true,
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(opts, 'ensure_installed', 'css', 'scss')
        end,
    },
    {
        'williamboman/mason.nvim',
        optional = true,
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(opts, 'ensure_installed', 'css-lsp')
        end,
    },
    { 'neovim/nvim-lspconfig', optional = true, opts = { servers = { cssls = cssls } } },
    { 'nvimtools/none-ls.nvim', optional = true, ft = { 'css', 'scss' } },
}
