local extend = require('plugins.lsp').extend

local function dockerls(lspconfig) lspconfig.dockerls.setup(extend { root = { '.sqllsrc.json' } }) end

return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            vim.list_extend(opts.ensure_installed, { 'dockerfile' })
        end,
    },
    {
        'williamboman/mason.nvim',
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            vim.list_extend(opts.ensure_installed, { 'dockerfile-language-server' })
        end,
    },
    { 'neovim/nvim-lspconfig', opts = { servers = { dockerls = dockerls } } },
}
