local extend = require('plugins.lsp').extend
local function bashls(lspconfig) lspconfig.bashls.setup(extend {}) end

return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = { ensure_installed = { 'bash', 'fish', 'ssh_config' } },
    },
    {
        'williamboman/mason.nvim',
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            vim.list_extend(
                opts.ensure_installed,
                { 'bash-language-server', 'beautysh', 'shellcheck', 'shfmt' }
            )
        end,
    },
    {
        'jose-elias-alvarez/null-ls.nvim',
        ft = { 'bash', 'fish', 'sh', 'zsh' },
        opts = function(_, opts)
            opts.sources = opts.sources or {}
            vim.list_extend(opts.sources, {
                function(builtins)
                    return {
                        builtins.code_actions.shellcheck,
                        builtins.diagnostics.shellcheck,
                        builtins.diagnostics.zsh,
                        builtins.formatting.beautysh,
                        builtins.formatting.fish_indent,
                        builtins.formatting.shfmt.with { filetypes = { 'zsh', 'bash', 'sh' } },
                    }
                end,
            })
        end,
    },
    { 'neovim/nvim-lspconfig', opts = { servers = { bashls = bashls } } },
    { 'dag/vim-fish', ft = 'fish', cond = function() return vim.loop.fs_stat 'config.fish' end },
}
