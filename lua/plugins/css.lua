local extend = require('plugins.lsp').extend

local function cssls(lspconfig) lspconfig.cssls.setup(extend {}) end

return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            vim.list_extend(opts.ensure_installed, { 'css', 'sass' })
        end,
    },
    {
        'williamboman/mason.nvim',
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            vim.list_extend(opts.ensure_installed, { 'css-lsp' })
        end,
    },
    { 'neovim/nvim-lspconfig', opts = { servers = { cssls = cssls } } },
    {
        'jose-elias-alvarez/null-ls.nvim',
        ft = { 'json' },
        opts = function(_, opts)
            opts.sources = opts.sources or {} -- TODO(chaitanya): add formatting and other sources
            -- vim.list_extend(
            --     opts.sources,
            --     { function(builtins) return { builtins.formatting.prettierd } end }
            -- )
        end,
    },
}
