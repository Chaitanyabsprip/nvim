local configure = require('plugins.lsp').configure

local function astrols()
    configure('astro', {
        init_options = {
            contentIntellisense = true,
            updateImportsOnFileMove = { enabled = true },
        },
        settings = {
            astro = {
                contentIntellisense = true,
                updateImportsOnFileMove = { enabled = true },
            },
        },
        root = {
            'tsconfig.json',
            'jsconfig.json',
            'astro.config.js',
            'astro.config.mjs',
            'astro.config.cjs',
        },
    })
end

---@type LazyPluginSpec[]
return {
    {
        'nvim-treesitter/nvim-treesitter',
        optional = true,
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(opts, 'ensure_installed', 'astro')
        end,
    },
    {
        'williamboman/mason.nvim',
        optional = true,
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(
                opts,
                'ensure_installed',
                -- 'prettierd',
                'astro-language-server'
            )
        end,
    },
    {
        'nvimtools/none-ls.nvim',
        optional = true,
        ft = function(_, filetypes)
            return vim.list_extend(
                filetypes,
                { 'astro', 'javascript', 'typescript', 'typescriptreact', 'javascriptreact' }
            )
        end,
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(
                opts,
                'sources',
                ---@param builtins NullBuiltin
                function(builtins)
                    return {
                        builtins.formatting.prettier.with {
                            filetypes = {
                                'astro',
                                'javascript',
                                'typescript',
                                'javascriptreact',
                                'typescriptreact',
                            },
                        },
                    }
                end
            )
        end,
    },
    {
        'neovim/nvim-lspconfig',
        optional = true,
        opts = { servers = { astro = astrols } },
    },
}
