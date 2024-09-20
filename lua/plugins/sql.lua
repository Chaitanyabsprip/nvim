---@type LazySpec[]
return {
    {
        'nvim-treesitter/nvim-treesitter',
        optional = true,
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(opts, 'ensure_installed', 'sql')
        end,
    },
    {
        'williamboman/mason.nvim',
        optional = true,
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(
                opts,
                'ensure_installed',
                'sqlfluff',
                'sqlfmt'
                -- 'sql-formatter'
            )
        end,
    },
    {
        'nvimtools/none-ls.nvim',
        ft = function(_, filetypes) return vim.list_extend(filetypes, { 'sql' }) end,
        optional = true,
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(
                opts,
                'sources',
                ---@param builtins NullBuiltin
                function(builtins)
                    local fluff_opts =
                        { extra_args = { '--dialect', 'postgres', '--exclude-rules', 'RF05' } }
                    return {
                        builtins.diagnostics.sqlfluff.with(fluff_opts),
                        -- builtins.formatting.sqlfluff.with(fluff_opts),
                        -- builtins.formatting.pg_format,
                        -- builtins.formatting.sql_formatter,
                        builtins.formatting.sqlfmt,
                    }
                end
            )
        end,
    },
}
