local extend = require('plugins.lsp').extend

local function python(lspconfig)
    local config = extend {
        root = { 'pyproject.toml' },
        settings = {
            pylsp = {
                plugins = {
                    rope_autoimport = { enabled = true },
                    rope_completion = { enabled = true },
                },
            },
            python = { venvPath = '.', analysis = {} },
        },
    }
    lspconfig.pyright.setup(config)
end

local function taplo(lspconfig)
    local config = extend {
        root = { 'pyproject.toml' },
    }
    lspconfig.taplo.setup(config)
end

local function ruff(lspconfig)
    local config = extend {
        settings = { organizeImports = false },
    }
    local on_attach = config.on_attach
    config.on_attach = function(client, ...)
        client.server_capabilities.hoverProvider = false
        on_attach(client, ...)
    end
    lspconfig.ruff_lsp.setup(config)
end

return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            vim.list_extend(opts.ensure_installed, {
                'python',
                'toml',
                'rst',
                'ninja',
                'markdown',
                'markdown_inline',
            })
        end,
    },
    {
        'williamboman/mason.nvim',
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            vim.list_extend(opts.ensure_installed, {
                'pyright', -- LSP for python
                'ruff-lsp', -- linter for python (includes flake8, pep8, etc.)
                'debugpy', -- debugger
                'black', -- formatter
                'isort', -- organize imports
                'taplo', -- LSP for toml (for pyproject.toml files)
            })
        end,
        -- config = function(_, opts)
        --     require('mason').setup(opts)
        --     local pylsp = require('mason-registry').get_package 'python-lsp-server'
        --     pylsp:on('install:success', function()
        --         local function mason_package_path(package)
        --             local path =
        --                 vim.fn.resolve(vim.fn.stdpath 'data' .. '/mason/packages/' .. package)
        --             return path
        --         end
        --
        --         local path = mason_package_path 'python-lsp-server'
        --         local command = path .. '/venv/bin/pip'
        --         local args = { 'install', 'pylsp-rope' }
        --
        --         require('plenary.job')
        --             :new({
        --                 command = command,
        --                 args = args,
        --                 cwd = path,
        --             })
        --             :start()
        --     end)
        -- end,
    },
    {
        'mfussenegger/nvim-dap-python',
        dependencies = 'mfussenegger/nvim-dap',
        config = function()
            -- uses the debugypy installation by mason
            local debugpyPythonPath = require('mason-registry')
                .get_package('debugpy')
                :get_install_path() .. '/venv/bin/python3'
            require('dap-python').setup(debugpyPythonPath, {})
        end,
    },
    { 'Vimjas/vim-python-pep8-indent' },
    {
        'linux-cultist/venv-selector.nvim',
        dependencies = {
            'neovim/nvim-lspconfig',
            'nvim-telescope/telescope.nvim',
            'mfussenegger/nvim-dap-python',
        },
        opts = { dap_enabled = true },
    },
    {
        'nvimtools/none-ls.nvim',
        ft = { 'python' },
        opts = function(_, opts)
            opts.sources = opts.sources or {}
            vim.list_extend(opts.sources, {
                function(builtins)
                    return {
                        builtins.formatting.black.with { extra_args = { '--quiet', '-l', '80' } },
                        builtins.formatting.isort.with { extra_args = { '--quiet' } },
                    }
                end,
            })
        end,
    },
    {
        'neovim/nvim-lspconfig',
        opts = { servers = { python = python, ruff = ruff, taplo = taplo } },
    },
}
