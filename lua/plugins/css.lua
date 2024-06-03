local extend = require('plugins.lsp').extend

local function cssls(lspconfig) lspconfig.cssls.setup(extend {}) end

return {
    ---@type LazyPluginSpec
    {
        'nvim-treesitter/nvim-treesitter',
        optional = true,
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(opts, 'ensure_installed', 'css', 'scss')
        end,
    },
    ---@type LazyPluginSpec
    {
        'williamboman/mason.nvim',
        optional = true,
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(opts, 'ensure_installed', 'css-lsp')
        end,
    },
    ---@type LazyPluginSpec
    {
        'neovim/nvim-lspconfig',
        optional = true,
        opts = { servers = { cssls = cssls } },
    },
    ---@type LazyPluginSpec
    {
        'nvimtools/none-ls.nvim',
        optional = true,
        ft = function(_, filetypes) return vim.list_extend(filetypes, { 'css', 'scss' }) end,
    },
}
