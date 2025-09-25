local configure = require('plugins.lsp').configure

local function marksman() configure('marksman', { root = { '.marksman.toml' } }) end
local function typos() configure('typos_lsp', {}) end
-- local function typos() configure('typos_lsp', { cmd = { 'axon', 'typos-lsp' } }) end
local function oxide() configure('markdown_oxide', {}) end
---@type LazySpec[]
return {
    {
        'nvim-treesitter/nvim-treesitter',
        optional = true,
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(
                opts,
                'ensure_installed',
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
                'ltex-ls',
                'typos-lsp',
                'cspell',
                'markdownlint',
                'markdown-oxide',
                'marksman'
            )
        end,
    },
    {
        'nvimtools/none-ls.nvim',
        dependencies = { { 'davidmh/cspell.nvim' } },
        optional = true,
        ft = function(_, filetypes)
            return vim.list_extend(filetypes, { 'markdown', 'md', 'rmd', 'rst' })
        end,
        opts = function(_, opts)
            local cspell = require 'cspell'
            require('config.lazy').extend_opts_list(
                opts,
                'sources',
                ---@param builtins NullBuiltin
                function(builtins)
                    return {
                        builtins.formatting.markdownlint,
                        builtins.diagnostics.markdownlint.with {
                            extra_args = { '--disable', 'MD024' },
                        },
                        builtins.hover.dictionary,
                        cspell.diagnostics.with { filetypes = { 'markdown', 'md', 'rmd', 'rst' } },
                        cspell.code_actions.with { filetypes = { 'markdown', 'md', 'rmd', 'rst' } },
                    }
                end
            )
        end,
    },
    ---@type LazyPluginSpec
    {
        'neovim/nvim-lspconfig',
        optional = true,
        opts = { servers = { marksman = marksman, typos = typos, oxide = oxide } },
    },
    {
        'OXY2DEV/markview.nvim',
        ft = { 'markdown', 'md', 'rmd', 'rst' },
        opts = {},
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'nvim-tree/nvim-web-devicons',
        },
    },
    -- {
    --     'MeanderingProgrammer/render-markdown.nvim',
    --     opts = {},
    --     ft = { 'markdown', 'md', 'rmd', 'rst' },
    --     dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    -- },
}
