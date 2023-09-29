local extend = require('plugins.lsp').extend

local function pyls(lspconfig)
    local config = extend {
        root = { 'pyproject.toml' },
        settings = { python = { venvPath = '.', analysis = {} } },
    }
    lspconfig.pyright.setup(config)
end

return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = { ensure_installed = { 'python' } },
    },
    {
        'williamboman/mason.nvim',
        opts = { ensure_installed = { 'pyright', 'black', 'isort' } },
    },
    {
        'jose-elias-alvarez/null-ls.nvim',
        ft = { 'python' },
        opts = function(_, opts)
            opts.sources = opts.sources or {}
            vim.list_extend(opts.sources, {
                function(builtins)
                    return {
                        builtins.formatting.black.with { extra_args = { '--quiet', '-l', '80' } },
                        builtins.formatting.isort.with { extra_args = { '--quiet' } },
                    }
                end,
            })
        end,
    },
    { 'neovim/nvim-lspconfig', opts = { servers = { pyls = pyls } } },
}
