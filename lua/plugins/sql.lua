local extend = require('plugins.lsp').extend

local function sqlls(lspconfig) lspconfig.sqlls.setup(extend { root = { '.sqllsrc.json' } }) end

return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = { ensure_installed = { 'sql' } },
    },
    {
        'williamboman/mason.nvim',
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            vim.list_extend(opts.ensure_installed, { 'sqlls' })
        end,
    },
    { 'neovim/nvim-lspconfig', opts = { servers = { sqlls = sqlls } } },
}
