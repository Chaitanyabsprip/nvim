local golang = {}
local extend = require('plugins.lsp').extend

golang.treesitter = {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts) vim.list_extend(opts.ensure_installed, { 'go' }) end,
}

golang.plugin = {
    'ray-x/go.nvim',
    dependencies = {
        'neovim/nvim-lspconfig',
        'nvim-treesitter/nvim-treesitter',
    },
    keys = {
        { '<leader>gfi', '<cmd>GoIfErr<cr>', noremap = true, desc = 'Go: Autofill If-err block' },
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
    opts = function()
        local config = extend {
            root = { 'go.mod', 'go.work' },
            settings = {
                gopls = {
                    -- gofumpt = true,
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
        return {
            gofmt = 'gofumpt',
            lsp_gofumpt = true,
            lsp_keymaps = false,
            lsp_inlay_hints = { enable = false },
            lsp_cfg = true,
            lsp_on_attach = config.on_attach,
        }
    end,
    lazy = false,
    cond = function()
        local stat = vim.loop.fs_stat
        return stat 'go.mod' or stat 'go.work' or stat '.golang'
    end,
    build = ':lua require("go.install").update_all_sync()',
}
golang.spec = { golang.plugin }
return golang.spec
