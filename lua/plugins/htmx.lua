local extend = require('plugins.lsp').extend

local function htmxls(lspconfig)
    local config = extend {
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
    lspconfig.htmx.setup(config)
end

return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(opts, 'ensure_installed', 'html')
        end,
    },
    {
        'williamboman/mason.nvim',
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(opts, 'ensure_installed', 'htmx-lsp')
        end,
    },
    {
        'neovim/nvim-lspconfig',
        opts = { servers = { htmx = htmxls } },
    },
}
