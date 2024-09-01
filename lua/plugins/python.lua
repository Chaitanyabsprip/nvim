local extend = require('plugins.lsp').extend

local function basedpyright(lspconfig)
    local config = extend {
        root = { 'pyproject.toml', 'pyrightconfig.json' },
        settings = {
            basedpyright = {
                analysis = {
                    autoImportCompletions = true,
                    autoSearchPaths = true,
                    diagnosticMode = 'workspace',
                    typeCheckingMode = 'standard', -- standard, strict, all, off, basic
                },
            },
            python = { venvPath = '.' },
        },
    }
    lspconfig.basedpyright.setup(config)
end

local function ruff(lspconfig)
    local config = extend {
        init_options = {
            settings = {
                configurationPreferences = 'filesystemFirst',
                lineLength = 80, -- configure using editorconfig
                fixAll = true,
                organizeImports = true,
                showSyntaxErrors = true,
                codeAction = {
                    disableRuleComment = { enable = true },
                    fixViolation = { enable = true },
                },
                lint = { enable = true, select = { 'I', 'AIR', 'PLW', 'PlR' }, preview = false },
                format = { preview = false },
            },
        },
    }
    local on_attach = config.on_attach
    ---@param client vim.lsp.Client
    config.on_attach = function(client, ...)
        if client.name == 'ruff' then client.server_capabilities.hoverProvider = false end
        if on_attach ~= nil then on_attach(client, ...) end
    end
    lspconfig.ruff.setup(config)
end

---@type LazySpec[]
return {
    {
        'nvim-treesitter/nvim-treesitter',
        optional = true,
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(
                opts,
                'ensure_installed',
                'python',
                'toml',
                'rst',
                'ninja',
                'markdown',
                'markdown_inline'
            )
        end,
    },
    {
        'williamboman/mason.nvim',
        optional = true,
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(
                opts,
                'ensure_installed',
                'basedpyright', -- LSP for python
                'ruff', -- linter for python (includes flake8, pep8, etc.)
                'debugpy', -- debugger
                'black', -- formatter
                'isort', -- organize imports
                'taplo' -- LSP for toml (for pyproject.toml files)
            )
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
        ft = function(_, filetypes) return vim.list_extend(filetypes, { 'python' }) end,
        optional = true,
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(
                opts,
                'sources',
                function(builtins)
                    return {
                        builtins.formatting.black.with { extra_args = { '--quiet', '-l', '80' } },
                        builtins.formatting.isort.with { extra_args = { '--quiet' } },
                    }
                end
            )
        end,
    },
    {
        'neovim/nvim-lspconfig',
        optional = true,
        opts = { servers = { basedpyright = basedpyright, ruff = ruff } },
    },
}
