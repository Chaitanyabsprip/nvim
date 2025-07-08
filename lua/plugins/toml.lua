local configure = require('plugins.lsp').configure

local function taplo() configure('taplo', { root = { 'pyproject.toml' } }) end

---@type LazySpec
return {
    {
        'williamboman/mason.nvim',
        optional = true,
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(opts, 'ensure_installed', 'taplo')
        end,
    },
    {
        'neovim/nvim-lspconfig',
        optional = true,
        opts = { servers = { taplo = taplo } },
    },
}
