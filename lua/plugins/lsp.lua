---@diagnostic disable: no-unknown
local lsp = {}

---@type LazyPluginSpec
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

---@type LazyPluginSpec
lsp.mason = {
    'williamboman/mason.nvim',
    dependencies = { 'RubixDev/mason-update-all' },
}

---@type LazyPluginSpec
lsp.mason_dap = {
    'jay-babu/mason-nvim-dap.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    opts = {},
}

---@type LazyPluginSpec
lsp.mason_lspconfig = {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    opts = { automatic_installation = false },
}

---@type LazyPluginSpec
lsp.mason_nulls = {
    'jay-babu/mason-null-ls.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    opts = { ensure_installed = nil, automatic_installation = true },
}

---@type LazyPluginSpec
lsp.mason_update = { 'RubixDev/mason-update-all', opts = {} }

---@type LazyPluginSpec
lsp.null = {
    'nvimtools/none-ls.nvim',
    dependencies = { 'jay-babu/mason-null-ls.nvim' },
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

local function resolve_package(pkg_name)
    local Optional = require 'mason-core.optional'
    local registry = require 'mason-registry'

    return Optional.of_nilable(pkg_name):map(function(package_name)
        local ok, pkg = pcall(registry.get_package, package_name)
        if ok then return pkg end
    end)
end

function install(pkg, version)
    vim.notify(('installing %s'):format(pkg.name), vim.log.levels.INFO)
    return pkg:install({ version = version }):once(
        'closed',
        vim.schedule_wrap(function()
            if pkg:is_installed() then
                vim.notify(('%s was successfully installed'):format(pkg.name))
            else
                vim.notify(
                    ('failed to install %s. Installation logs are available in :Mason and :MasonLog'):format(
                        pkg.name
                    ),
                    vim.log.levels.ERROR
                )
            end
        end)
    )
end

local function mason_ensure_installed(opts)
    for _, installable in ipairs(opts.ensure_installed) do
        if installable then
            local Package = require 'mason-core.package'
            local Optional = require 'mason-core.optional'
            local server_name, version = Package.Parse(installable)
            local errmsg = 'Server %q is not a valid entry in ensure_installed.'
            resolve_package(server_name)
                :if_present(
                    ---@param pkg Package
                    function(pkg)
                        if not pkg:is_installed() then install(pkg, version) end
                    end
                )
                :if_not_present(
                    function() vim.notify((errmsg):format(server_name), vim.log.levels.WARN) end
                )
        end
    end
end

---@type LazyPluginSpec
lsp.lspconfig = {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        { 'folke/neodev.nvim', opts = {} },
        {
            'williamboman/mason.nvim',
            opts = { PATH = 'skip' },
            config = function(_, opts)
                require('mason').setup(opts)
                mason_ensure_installed(opts)
            end,
        },
        'williamboman/mason-lspconfig.nvim',
    },
    config = function(_, opts)
        local lspconfig = require 'lspconfig'
        ---@diagnostic disable-next-line: no-unknown
        for _, server in pairs(opts.servers) do
            server(lspconfig)
        end
    end,
}

---@return LspConfig
---@param config LspConfig
local function extend(config)
    local def_root = { '.git', '.gitignore', vim.fn.getcwd() }
    local roots
    if config['override_root'] then
        roots = config.root
    else
        roots = vim.list_extend(def_root, config.root or {})
    end
    config['root'] = nil
    local l = require 'lsp'
    local lspconfig = require 'lspconfig'
    local defaults = {
        on_attach = l.on_attach,
        capabilities = require('plugins.completion').get_capabilities(),
        root_dir = lspconfig.util.root_pattern(unpack(roots)),
    }
    local updated_config = vim.tbl_deep_extend('force', config, defaults)
    return updated_config
end

lsp.spec = {
    extend = extend,
    lsp.code_actions,
    lsp.mason,
    lsp.mason_lspconfig,
    lsp.mason_nulls,
    lsp.mason_update,
    lsp.null,
    lsp.lspconfig,
}

return lsp.spec
