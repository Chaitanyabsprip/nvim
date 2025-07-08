local configure = require('plugins.lsp').configure

local function htmxls()
    local config = {
        filetypes = {
            'html',
            'javascriptreact',
            'javascript.jsx',
            'typescriptreact',
            'typescript.tsx',
            'gohtml',
            'gohtmltmpl',
        },
    }
    configure('htmx', config)
end

return {
    ---@type LazyPluginSpec
    {
        'nvim-treesitter/nvim-treesitter',
        optional = true,
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(opts, 'ensure_installed', 'html')
        end,
    },
    ---@type LazyPluginSpec
    {
        'williamboman/mason.nvim',
        optional = true,
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(opts, 'ensure_installed', 'htmx-lsp')
        end,
    },
    ---@type LazyPluginSpec
    {
        'neovim/nvim-lspconfig',
        optional = true,
        opts = { servers = { htmx = htmxls } },
    },
}
