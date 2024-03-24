---@diagnostic disable: no-unknown
local lsp = {}

lsp.code_actions = {
    'Chaitanyabsprip/lsp-fastaction.nvim',
    opts = {
        hide_cursor = true,
        action_data = {
            dart = {
                { order = 1, pattern = 'import library', key = 'i' },
                { order = 1, pattern = 'organize imports', key = 'o' },
                { order = 1, pattern = 'relative imports everywhere', key = 'l' },
                { order = 2, pattern = 'sort member', key = 's' },
                { order = 2, pattern = 'wrap with widget', key = 'w' },
                { order = 3, pattern = 'extract widget', key = 'x' },
                { order = 4, pattern = 'column', key = 'c' },
                { order = 4, pattern = 'extract method', key = 'e' },
                { order = 4, pattern = 'padding', key = 'p' },
                { order = 4, pattern = 'remove', key = 'r' },
                { order = 4, pattern = 'wrap with padding', key = 'p' },
                { order = 5, pattern = 'add', key = 'a' },
                { order = 5, pattern = 'extract local', key = 'v' },
            },
        },
    },
}

lsp.diagflow = {
    'dgagn/diagflow.nvim',
    event = 'LspAttach',
    opts = { scope = 'line', padding_top = 1 },
}

lsp.mason = {
    'williamboman/mason.nvim',
    dependencies = { 'RubixDev/mason-update-all' },
}

lsp.mason_dap = {
    'jay-babu/mason-nvim-dap.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    opts = {},
}

lsp.mason_lspconfig = {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    opts = { automatic_installation = true },
}

lsp.mason_nulls = {
    'jay-babu/mason-null-ls.nvim',
    dependencies = { 'williamboman/mason.nvim', 'nvimtools/none-ls.nvim' },
    ft = function(_, __) return {} end,
    opts = { automatic_installation = true },
    config = function(plugin, opts)
        vim.defer_fn(function() vim.notify(vim.inspect(plugin.ft)) end, 500)
        require('mason-null-ls').setup(opts)
    end,
}

lsp.mason_update = { 'RubixDev/mason-update-all', opts = {} }

lsp.null = {
    'nvimtools/none-ls.nvim',
    config = function(_, opts)
        local get_capabilities = require('plugins.completion').get_capabilities
        local builtins = require('null-ls').builtins
        local sources = {}
        for _, source_fn in pairs(opts.sources) do
            vim.list_extend(sources, source_fn(builtins))
        end
        local config = {
            on_attach = require('lsp').on_attach,
            capabilities = get_capabilities(),
            sources = sources,
        }
        require('null-ls').setup(config)
    end,
}

lsp.lspconfig = {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        { 'folke/neodev.nvim', opts = {} },
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
    },
    config = function(_, opts)
        local lspconfig = require 'lspconfig'
        ---@diagnostic disable-next-line: no-unknown
        for i, server in pairs(opts.servers) do
            server(lspconfig)
        end
    end,
}

---@return table
local function extend(config)
    local get_capabilities = require('plugins.completion').get_capabilities
    local def_root = { '.git', '.gitignore', vim.fn.getcwd() }
    local roots
    if config.override_root then
        roots = config.root
    else
        roots = vim.list_extend(def_root, config.root or {})
    end
    config.root = nil
    local lsp = require 'lsp'
    local lspconfig = require 'lspconfig'
    local defaults = {
        on_attach = lsp.on_attach,
        capabilities = get_capabilities(),
        root_dir = lspconfig.util.root_pattern(unpack(roots)),
    }
    local updated_config = vim.tbl_deep_extend('force', config, defaults)
    return updated_config
end

lsp.spec = {
    extend = extend,
    lsp.code_actions,
    lsp.diagflow,
    lsp.mason,
    lsp.mason_lspconfig,
    lsp.mason_nulls,
    lsp.mason_update,
    lsp.null,
    lsp.lspconfig,
}

return lsp.spec
