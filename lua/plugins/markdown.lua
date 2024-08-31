local extend = require('plugins.lsp').extend

local function marksman(lspconfig) lspconfig.marksman.setup(extend { root = { '.marksman.toml' } }) end
local function typos(lspconfig) lspconfig.typos_lsp.setup(extend {}) end
local function oxide(lspconfig) lspconfig.markdown_oxide.setup(extend {}) end
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
                'markdownlint',
                'markdown-oxide',
                'marksman'
            )
        end,
    },
    {
        'nvimtools/none-ls.nvim',
        optional = true,
        ft = function(_, filetypes)
            return vim.list_extend(filetypes, { 'markdown', 'md', 'rmd', 'rst' })
        end,
        opts = function(_, opts)
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
        'lukas-reineke/headlines.nvim',
        ft = { 'markdown', 'md', 'rmd', 'rst' },
        enabled = false,
        opts = {
            markdown = {
                headline_highlights = {
                    'Headline1',
                    'Headline2',
                    'Headline3',
                    'Headline4',
                    'Headline5',
                    'Headline6',
                },
                codeblock_highlight = { 'CodeBlock' },
                fat_headline_lower_string = '▀',
                dash_string = '─',
                fat_headlines = true,
                fat_headline_upper_string = '▃',
            },
        },
    },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {},
        ft = { 'markdown', 'md', 'rmd', 'rst' },
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    },
}
