local configure = require('plugins.lsp').configure

local function basedpyright()
    local config = {
        root = { 'pyproject.toml', 'pyrightconfig.json', '.venv' },
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
    configure('basedpyright', config)
end

local function ruff()
    local config = {
        capabilities = { hoverProvider = false },
        root = { '.venv' },
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
                lint = { enable = true, select = { 'I', 'AIR', 'PLW', 'PLR' }, preview = false },
                format = { preview = false },
            },
        },
    }
    configure('ruff', config)
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
                'debugpy' -- debugger
            )
        end,
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
        'neovim/nvim-lspconfig',
        optional = true,
        opts = { servers = { basedpyright = basedpyright, ruff = ruff } },
    },
}
