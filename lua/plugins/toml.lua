local extend = require('plugins.lsp').extend

local function taplo(lspconfig)
    local config = extend {
        root = { 'pyproject.toml' },
    }
    lspconfig.taplo.setup(config)
end

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
