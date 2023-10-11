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
            opts.ensure_installed = opts.ensure_installed or {}
            vim.list_extend(opts.ensure_installed, { 'yaml' })
        end,
    },
    {
        'williamboman/mason.nvim',
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            vim.list_extend(
                opts.ensure_installed,
                { 'yaml-language-server', 'prettierd', 'yamllint' }
            )
        end,
    },
    {
        'jose-elias-alvarez/null-ls.nvim',
        ft = { 'yaml', 'yaml.docker-compose' },
        opts = function(_, opts)
            opts.sources = opts.sources or {}
            vim.list_extend(opts.sources, {
                function(builtins)
                    return {
                        builtins.diagnostics.yamllint,
                        builtins.formatting.prettierd,
                    }
                end,
            })
        end,
    },
    { 'neovim/nvim-lspconfig', opts = { servers = { yamlls = yamlls } } },
}
