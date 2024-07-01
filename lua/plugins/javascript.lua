local extend = require('plugins.lsp').extend

local function tsserverls(lspconfig) lspconfig.tsserver.setup(extend {}) end

---@type LazyPluginSpec[]
return {
    {
        'nvim-treesitter/nvim-treesitter',
        optional = true,
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(
                opts,
                'ensure_installed',
                'javascript',
                'typescript',
                'jsdoc'
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
                'typescript-language-server',
                'prettierd',
                'js-debug-adapter'
            )
        end,
    },
    {
        'neovim/nvim-lspconfig',
        optional = true,
        opts = { servers = { tsserverls = tsserverls } },
    },
    {
        'nvimtools/none-ls.nvim',
        optional = true,
        ft = function(_, filetypes)
            return vim.list_extend(filetypes, { 'javascript', 'typescript' })
        end,
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(
                opts,
                'sources',
                function(builtins) return { builtins.formatting.prettierd } end
            )
        end,
    },
    {
        'pmizio/typescript-tools.nvim',
        dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
        opts = {},
        enabled = false,
    },
    {
        'mfussenegger/nvim-dap',
        opts = {
            adapters = {
                ['pwa-node'] = {
                    type = 'server',
                    host = 'localhost',
                    port = '${port}',
                    executable = {
                        command = 'js-debug-adapter',
                        args = { '${port}' },
                    },
                },
            },
            configurations = {
                javascript = {
                    {
                        type = 'pwa-node',
                        request = 'launch',
                        name = 'Launch file',
                        program = '${file}',
                        cwd = '${workspaceFolder}',
                    },
                },
            },
        },
    },
}
