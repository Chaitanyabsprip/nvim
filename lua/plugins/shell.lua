local extend = require('plugins.lsp').extend
local function bashls(lspconfig)
    lspconfig.bashls.setup(extend { filetypes = { 'bash', 'zsh', 'sh' } })
end
local function awkls(lspconfig) lspconfig.awk_ls.setup(extend {}) end

return {
    ---@type LazyPluginSpec
    {
        'nvim-treesitter/nvim-treesitter',
        optional = true,
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(
                opts,
                'ensure_installed',
                'bash',
                'fish',
                'ssh_config'
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
                'bash-language-server',
                'shfmt',
                'shellcheck',
                'awk-language-server'
            )
        end,
    },
    ---@type LazyPluginSpec
    {
        'nvimtools/none-ls.nvim',
        ft = { 'bash', 'fish', 'sh', 'zsh' },
        optional = true,
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(
                opts,
                'sources',
                function(builtins)
                    return {
                        builtins.diagnostics.zsh,
                        builtins.formatting.fish_indent,
                        builtins.formatting.shfmt.with { filetypes = { 'zsh', 'bash', 'sh' } },
                    }
                end
            )
        end,
    },
    ---@type LazyPluginSpec
    {
        'neovim/nvim-lspconfig',
        optional = true,
        opts = { servers = { bashls = bashls, awkls = awkls } },
    },
    ---@type LazyPluginSpec
    {
        'dag/vim-fish',
        ft = 'fish',
        cond = function() return vim.loop.fs_stat 'config.fish' end,
    },
}
