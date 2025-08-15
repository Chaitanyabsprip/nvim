---@diagnostic disable: no-unknown

local function resolve_package(pkg_name)
    local Optional = require 'mason-core.optional'
    local registry = require 'mason-registry'

    return Optional.of_nilable(pkg_name):map(function(package_name)
        local ok, pkg = pcall(registry.get_package, package_name)
        if ok then return pkg end
    end)
end

local function install(pkg, version)
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
    local defaults = {
        on_attach = l.on_attach,
        capabilities = require('plugins.completion').get_capabilities(),
        root_markers = roots,
    }
    local updated_config = vim.tbl_deep_extend('force', defaults, config)
    return updated_config
end

---@type LazySpec[]
return {
    extend = extend,
    ---@param server string
    ---@param config LspConfig?
    configure = function(server, config)
        config = config or {}
        vim.lsp.config(server, extend(config))
        vim.lsp.enable(server)
    end,
    {
        dir = vim.env.HOME .. '/projects/fastaction.nvim',
        ---@type FastActionConfig
        opts = {
            brackets = { '', '' },
            popup = { title = false },
            dismiss_keys = { '<Esc>', '<C-c>', 'j', 'k', 'q' },
            register_ui_select = true,
            priority = {
                default = {
                    { order = 1, pattern = 'organize', key = 'o' },
                    { order = 1, pattern = 'import', key = 'i' },
                    { order = 1, pattern = 'fix all', key = 'f' },
                },
                dart = {
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
        event = 'VeryLazy',
    },
    { 'williamboman/mason.nvim' },
    {
        'nvimtools/none-ls.nvim',
        dependencies = { 'jay-babu/mason-null-ls.nvim' },
        config = function(_, opts)
            local get_capabilities = require('plugins.completion').get_capabilities
            local builtins = require('null-ls').builtins
            ---@type NullSource[]
            local sources = {}
            ---@type NullSource[]
            local optSources = opts.sources
            for _, source_fn in pairs(optSources) do
                vim.list_extend(sources, source_fn(builtins))
            end
            local config = {
                on_attach = require('lsp').on_attach,
                capabilities = get_capabilities(),
                sources = sources,
            }
            require('null-ls').setup(config)
        end,
    },
    {
        'neovim/nvim-lspconfig',
        event = { 'User BufReadPreNotOil', 'BufNewFile' },
        dependencies = {
            {
                'folke/lazydev.nvim',
                opts = { library = { 'lazy.nvim', vim.env.HOME .. '/projects/fastaction.nvim' } },
            },
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
    },
}
