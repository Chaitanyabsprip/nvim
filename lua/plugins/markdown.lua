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
    {
        'nvim-treesitter/nvim-treesitter',
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            vim.list_extend(opts.ensure_installed, { 'markdown', 'markdown_inline' })
        end,
    },
    {
        'williamboman/mason.nvim',
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            vim.list_extend(
                opts.ensure_installed,
                { 'ltex-ls', 'markdownlint', 'marksman', 'codespell' }
            )
        end,
    },
    {
        'nvimtools/none-ls.nvim',
        ft = { 'markdown', 'md', 'rmd', 'rst' },
        opts = function(_, opts)
            opts.sources = opts.sources or {}
            vim.list_extend(opts.sources, {
                function(builtins)
                    return {
                        builtins.formatting.markdownlint,
                        builtins.diagnostics.markdownlint,
                        builtins.diagnostics.codespell.with { filetypes = { 'markdown' } },
                        builtins.hover.dictionary,
                    }
                end,
            })
        end,
    },
    { 'neovim/nvim-lspconfig', opts = { servers = { marksman = marksman, ltex = ltex } } },
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
