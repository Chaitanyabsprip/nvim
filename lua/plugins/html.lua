local extend = require('plugins.lsp').extend

local function htmlls(lspconfig)
    local config = extend {
        filetypes = {
            'html',
            -- 'javascript',
            'javascriptreact',
            'javascript.jsx',
            -- 'typescript',
            'typescriptreact',
            'typescript.tsx',
        },
    }
    lspconfig.html.setup(config)
end

local function emmetls(lspconfig)
    local config = extend {
        -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
        init_options = { html = { options = { ['bem.enabled'] = true } } },
    }
    lspconfig.emmet_ls.setup(config)
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
            require('config.lazy').extend_opts_list(
                opts,
                'ensure_installed',
                'html-lsp',
                'emmet-ls'
            )
        end,
    },
    ---@type LazyPluginSpec
    {
        'neovim/nvim-lspconfig',
        optional = true,
        opts = { servers = { html = htmlls, emmet_ls = emmetls } },
    },
}
