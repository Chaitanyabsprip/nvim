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
    {
        'nvim-treesitter/nvim-treesitter',
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(opts, 'ensure_installed', 'yaml')
        end,
    },
    {
        'williamboman/mason.nvim',
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
    {
        'nvimtools/none-ls.nvim',
        ft = { 'yaml', 'yaml.docker-compose' },
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
    { 'neovim/nvim-lspconfig', opts = { servers = { yamlls = yamlls } } },
}
