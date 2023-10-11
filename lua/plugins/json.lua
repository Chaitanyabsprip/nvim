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
    {
        'nvim-treesitter/nvim-treesitter',
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            vim.list_extend(opts.ensure_installed, { 'json' })
        end,
    },
    {
        'williamboman/mason.nvim',
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            vim.list_extend(opts.ensure_installed, { 'json-lsp', 'prettierd' })
        end,
    },
    { 'neovim/nvim-lspconfig', opts = { servers = { jsonls = jsonls } } },
    {
        'jose-elias-alvarez/null-ls.nvim',
        ft = { 'json' },
        opts = function(_, opts)
            opts.sources = opts.sources or {}
            vim.list_extend(
                opts.sources,
                { function(builtins) return { builtins.formatting.prettierd } end }
            )
        end,
    },
    { 'b0o/schemastore.nvim', ft = { 'json' } },
}
