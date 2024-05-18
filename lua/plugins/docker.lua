local extend = require('plugins.lsp').extend

local function dockerls(lspconfig) lspconfig.dockerls.setup(extend { root = { '.sqllsrc.json' } }) end

return {
    ---@type LazyPluginSpec
    {
        'nvim-treesitter/nvim-treesitter',
        optional = true,
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(opts, 'ensure_installed', 'dockerfile')
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
                'dockerfile-language-server'
            )
        end,
    },
    ---@type LazyPluginSpec
    { 'neovim/nvim-lspconfig', opts = { servers = { dockerls = dockerls } } },
}
