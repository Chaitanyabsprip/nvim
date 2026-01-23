local configure = require('plugins.lsp').configure

local function zuban()
    local config = {}
    configure('zuban', config)
end

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
                lint = {
                    enable = true,
                    select = { 'I', 'AIR', 'PLW', 'PLR', 'UP' },
                    preview = false,
                },
                format = { preview = false },
            },
        },
    }
    configure('ruff', config)
end

local function find_venv_dir(start_dir)
    local dir = vim.fn.fnamemodify(start_dir, ':p')
    while dir ~= '/' do
        local venv_path = dir .. '/.venv'
        if vim.fn.isdirectory(venv_path) == 1 then return venv_path end
        dir = vim.fn.fnamemodify(dir .. '/..', ':p')
    end
    return nil
end
---@module "lazy"
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
            ---@type string
            local link_path = vim.env.MASON .. '/bin/debugpy'
            local real_path = vim.fn.fnamemodify(vim.loop.fs_realpath(link_path) or '', ':h')
            local debugpy_path = real_path .. '/venv/bin/python'
            require('dap-python').setup(debugpy_path, {})
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
        cmd = { 'VenvSelect' },
        ft = { 'python' },
        opts = {
            dap_enabled = true,
            options = {
                cached_venv_automatic_activation = false,
                enable_cached_venvs = false,
            },
        },
        config = function(_, opts)
            vim.api.nvim_create_autocmd('FileType', {
                pattern = 'python',
                callback = function()
                    vim.schedule(function()
                        local buf_dir = vim.fn.expand '%:p:h'
                        local venv = find_venv_dir(buf_dir)
                        local venv_selector = require 'venv-selector'
                        if venv_selector.venv() ~= nil then return end
                        if venv ~= nil then
                            venv_selector.activate_from_path(venv .. '/bin/python')
                        end
                    end)
                end,
            })
            require('venv-selector').setup(opts)
        end,
    },
    {
        'neovim/nvim-lspconfig',
        optional = true,
        opts = { servers = { basedpyright = basedpyright, ruff = ruff } },
    },
}
