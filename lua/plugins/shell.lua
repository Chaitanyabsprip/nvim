local extend = require('plugins.lsp').extend
local function bashls(lspconfig)
    lspconfig.bashls.setup(extend { filetypes = { 'bash', 'zsh', 'sh' } })
end
local function awkls(lspconfig) lspconfig.awk_ls.setup(extend {}) end

return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            vim.list_extend(opts.ensure_installed, { 'bash', 'fish', 'ssh_config' })
        end,
    },
    {
        'williamboman/mason.nvim',
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            vim.list_extend(
                opts.ensure_installed,
                { 'bash-language-server', 'shfmt', 'shellcheck', 'awk-language-server' }
            )
        end,
    },
    {
        'nvimtools/none-ls.nvim',
        ft = { 'bash', 'fish', 'sh', 'zsh' },
        opts = function(_, opts)
            opts.sources = opts.sources or {}
            vim.list_extend(opts.sources, {
                function(builtins)
                    return {
                        builtins.diagnostics.zsh,
                        builtins.formatting.fish_indent,
                        builtins.formatting.shfmt.with { filetypes = { 'zsh', 'bash', 'sh' } },
                    }
                end,
            })
        end,
    },
    { 'neovim/nvim-lspconfig', opts = { servers = { bashls = bashls, awkls = awkls } } },
    { 'dag/vim-fish', ft = 'fish', cond = function() return vim.loop.fs_stat 'config.fish' end },
}
