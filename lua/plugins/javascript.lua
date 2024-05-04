local extend = require('plugins.lsp').extend

local function tsserverls(lspconfig) lspconfig.tsserver.setup(extend {}) end

return {
    {
        'nvim-treesitter/nvim-treesitter',
        optional = true,
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(
                opts,
                'ensure_installed',
                'javascript',
                'typescript',
                'jsdoc'
            )
        end,
    },
    {
        'williamboman/mason.nvim',
        optional = true,
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(
                opts,
                'ensure_installed',
                'typescript-language-server',
                'prettierd'
            )
        end,
    },
    { 'neovim/nvim-lspconfig', optional = true, opts = { servers = { tsserverls = tsserverls } } },
    {
        'nvimtools/none-ls.nvim',
        optional = true,
        ft = { 'json' },
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(
                opts,
                'sources',
                function(builtins) return { builtins.formatting.prettierd } end
            )
        end,
    },
}
