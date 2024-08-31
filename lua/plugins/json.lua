local extend = require('plugins.lsp').extend

local function jsonls(lspconfig)
    local config = extend {
        settings = { json = { schemas = require('schemastore').json.schemas() } },
        commands = {
            Format = {
                function() vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line '$', 0 }) end,
            },
        },
    }
    lspconfig.jsonls.setup(config)
end

return {
    ---@type LazyPluginSpec
    {
        'nvim-treesitter/nvim-treesitter',
        optional = true,
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(opts, 'ensure_installed', 'json')
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
                'json-lsp',
                'prettierd'
            )
        end,
    },
    ---@type LazyPluginSpec
    {
        'neovim/nvim-lspconfig',
        optional = true,
        opts = { servers = { jsonls = jsonls } },
    },
    ---@type LazyPluginSpec
    {
        'nvimtools/none-ls.nvim',
        optional = true,
        ft = function(_, filetypes) return vim.list_extend(filetypes, { 'json' }) end,
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(
                opts,
                'sources',
                ---@param builtins NullBuiltin
                function(builtins)
                    return { builtins.formatting.prettierd.with { filetypes = { 'json', 'jsonc' } } }
                end
            )
        end,
    },
    ---@type LazyPluginSpec
    { 'b0o/schemastore.nvim', ft = { 'json' } },
}
