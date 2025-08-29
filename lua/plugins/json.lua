local configure = require('plugins.lsp').configure

local function jsonls()
    local config = {
        settings = { json = { schemas = require('schemastore').json.schemas() } },
        commands = {
            Format = {
                function() vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line '$', 0 }) end,
            },
        },
    }
    configure('jsonls', config)
end

---@type LazyPluginSpec[]
return {
    {
        'nvim-treesitter/nvim-treesitter',
        optional = true,
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(opts, 'ensure_installed', 'json')
        end,
    },
    {
        'williamboman/mason.nvim',
        optional = true,
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(
                opts,
                'ensure_installed',
                -- 'prettierd',
                'json-lsp'
            )
        end,
    },
    {
        'neovim/nvim-lspconfig',
        optional = true,
        opts = { servers = { jsonls = jsonls } },
    },
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
                    return { builtins.formatting.prettier.with { filetypes = { 'json', 'jsonc' } } }
                end
            )
        end,
    },
    { 'b0o/schemastore.nvim', ft = { 'json' } },
}
