local extend = require('plugins.lsp').extend

local function tsserverls(lspconfig) lspconfig.tsserver.setup(extend {}) end

return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            vim.list_extend(opts.ensure_installed, { 'javascript', 'typescript', 'jsdoc' })
        end,
    },
    {
        'williamboman/mason.nvim',
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            vim.list_extend(opts.ensure_installed, { 'typescript-language-server', 'prettierd' })
        end,
    },
    { 'neovim/nvim-lspconfig', opts = { servers = { tsserverls = tsserverls } } },
    {
        'nvimtools/none-ls.nvim',
        ft = { 'json' },
        opts = function(_, opts)
            opts.sources = opts.sources or {}
            vim.list_extend(
                opts.sources, -- TODO(chaitanya): add eslint/eslintd
                { function(builtins) return { builtins.formatting.prettierd } end }
            )
        end,
    },
}
