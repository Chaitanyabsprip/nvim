local extend = require('plugins.lsp').extend

local function yamlls(lspconfig)
    local config = extend {
        settings = {
            redhat = { telemetry = false },
            yaml = {
                schemaStore = {
                    enable = true,
                    url = 'https://www.schemastore.org/api/json/catalog.json',
                },
                format = { singleQuote = true },
            },
        },
    }
    lspconfig.yamlls.setup(config)
end

return {
    ---@type LazyPluginSpec
    {
        'nvim-treesitter/nvim-treesitter',
        optional = true,
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(opts, 'ensure_installed', 'yaml')
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
                'yaml-language-server',
                'prettierd',
                'yamllint'
            )
        end,
    },
    ---@type LazyPluginSpec
    {
        'nvimtools/none-ls.nvim',
        ft = { 'yaml', 'yaml.docker-compose' },
        optional = true,
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(
                opts,
                'sources',
                function(builtins)
                    return { builtins.diagnostics.yamllint, builtins.formatting.prettierd }
                end
            )
        end,
    },
    ---@type LazyPluginSpec
    {
        'neovim/nvim-lspconfig',
        optional = true,
        opts = { servers = { yamlls = yamlls } },
    },
}
