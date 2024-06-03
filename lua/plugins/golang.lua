local extend = require('plugins.lsp').extend

return {
    ---@type LazyPluginSpec
    {
        'jeniasaigak/goplay.nvim',
        opts = {
            -- a name of the directory under GOPATH/src where the
            -- playground will be saved
            playgroundDirName = 'playground',
            -- a name of the directory under GOPATH/src where the temporary playground will be
            -- saved. This option is used when you need to execute a file
            tempPlaygroundDirName = 'tmp_playground',
        },
        cmd = { 'GPOpen', 'GPToggle', 'GPClear' },
        keys = {
            { '<leader>gpo', '<cmd>GPOpen<cr>', noremap = true, silent = true },
            { '<leader>gpt', '<cmd>GPToggle<cr>', noremap = true, silent = true },
            { '<leader>gpe', '<cmd>GPExec<cr>', noremap = true, silent = true },
            { '<leader>gpf', '<cmd>GPExecFile<cr>', noremap = true, silent = true },
        },
    },
    ---@type LazyPluginSpec
    {
        'ray-x/go.nvim',
        dependencies = {
            'ray-x/guihua.lua',
            'neovim/nvim-lspconfig',
            'nvim-treesitter/nvim-treesitter',
        },
        lazy = false,
        cond = function()
            local stat = vim.loop.fs_stat
            return stat 'go.mod' or stat 'go.work' or stat '.golang'
        end,
        build = ':lua require("go.install").update_all_sync()',
        keys = {
            {
                '<leader>gfi',
                '<cmd>GoIfErr<cr>',
                noremap = true,
                desc = 'Go: Autofill If-err block',
            },
            {
                '<leader>gfs',
                '<cmd>GoFillStruct<cr>',
                noremap = true,
                desc = 'Go: Autofill Struct with fields',
            },
            {
                '<leader>gfw',
                '<cmd>GoFillSwitch<cr>',
                noremap = true,
                desc = 'Go: Autofill Switch with cases',
            },
            {
                '<leader>gfp',
                'GoFixPlurals',
                noremap = true,
                desc = 'Go: Auto collate plural params with same type',
            },
        },
        config = function()
            local capabilities = require 'lsp.capabilities'
            local ogcb = capabilities.formatting.callback
            vim.schedule(function() capabilities.formatting.callback = ogcb end)
            capabilities.formatting.callback = function(bufnr, _)
                vim.api.nvim_create_autocmd('BufWritePre', {
                    group = vim.api.nvim_create_augroup('auto_format', { clear = true }),
                    buffer = bufnr,
                    callback = function() require('go.format').goimports() end,
                })
            end
            local config = extend {
                root = { 'go.mod', 'go.work' },
                settings = {
                    gopls = {
                        gofumpt = true,
                        analyses = {
                            unusedparams = true,
                            nilness = true,
                            unusedwrite = true,
                            useany = true,
                            unusedvariable = true,
                        },
                        completeUnimported = true,
                        staticcheck = true,
                        usePlaceholders = true,
                    },
                },
            }
            require('go').setup {
                dap_debug_keymap = false,
                dap_debug_ui = false,
                dap_debug_vt = false,
                gofmt = 'gofumpt',
                goimports = 'goimports',
                lsp_gofumpt = true,
                lsp_keymaps = false,
                lsp_inlay_hints = { enable = false },
                lsp_cfg = config,
                lsp_on_attach = config.on_attach,
                luasnip = true,
            }
            -- local nullls = require 'null-ls'
            -- nullls.register(require('go.null_ls').gotest())
            -- nullls.register(require('go.null_ls').gotest_action())
            -- nullls.register(require('go.null_ls').golangci_lint())
        end,
    },
    ---@type LazyPluginSpec
    {
        'nvimtools/none-ls.nvim',
        ft = function(_, filetypes) return vim.list_extend(filetypes, { 'go' }) end,
        optional = true,
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(
                opts,
                'sources',
                function(builtins) return { builtins.diagnostics.revive } end,
                function(builtins)
                    return {
                        builtins.formatting.golines.with {
                            extra_args = { '--max-len=100', '--base-formatter=gofumpt' },
                        },
                    }
                end
            )
        end,
    },
    ---@type LazyPluginSpec
    {
        'williamboman/mason.nvim',
        optional = true,
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(opts, 'ensure_installed', 'revive', 'gopls')
        end,
    },
    ---@type LazyPluginSpec
    {
        'nvim-neotest/neotest',
        optional = true,
        dependencies = {
            'nvim-neotest/neotest-go',
        },
        opts = { adapters = { ['neotest-go'] = { recursive_run = true } } },
    },
    ---@type LazyPluginSpec
    {
        'nvim-treesitter/nvim-treesitter',
        optional = true,
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(
                opts,
                'ensure_installed',
                'go',
                'gomod',
                'gowork',
                'gotmpl'
            )
        end,
    },
}
