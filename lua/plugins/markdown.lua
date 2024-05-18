local extend = require('plugins.lsp').extend

local function marksman(lspconfig) lspconfig.marksman.setup(extend { root = { '.marksman.toml' } }) end
local function ltex(lspconfig)
    lspconfig.ltex.setup(extend {
        settings = { ltex = { language = 'en' } },
        filetypes = {
            'gitcommit',
            'markdown',
            'org',
            'plaintex',
            'rst',
            'pandoc',
            'rmd',
        },
    })
end
return {
    ---@type LazyPluginSpec
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
    ---@type LazyPluginSpec
    {
        'williamboman/mason.nvim',
        optional = true,
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(
                opts,
                'ensure_installed',
                'ltex-ls',
                'markdownlint',
                'marksman',
                'codespell'
            )
        end,
    },
    ---@type LazyPluginSpec
    {
        'nvimtools/none-ls.nvim',
        optional = true,
        ft = { 'markdown', 'md', 'rmd', 'rst' },
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(
                opts,
                'sources',
                function(builtins)
                    return {
                        builtins.formatting.markdownlint,
                        builtins.diagnostics.markdownlint.with {
                            extra_args = { '--disable', 'MD024' },
                        },
                        builtins.diagnostics.codespell.with { filetypes = { 'markdown' } },
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
        opts = { servers = { marksman = marksman, ltex = ltex } },
    },
    ---@type LazyPluginSpec
    {
        'lukas-reineke/headlines.nvim',
        ft = { 'markdown', 'md', 'rmd', 'rst' },
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
}
