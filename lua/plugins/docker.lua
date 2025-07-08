local configure = require('plugins.lsp').configure

local function dockerls()
    configure('dockerls', { root = { '.sqllsrc.json' } })
    configure('dockerfilels', {})
end

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
                'dockerfile-language-server',
                'docker-compose-language-service'
            )
        end,
    },
    ---@type LazyPluginSpec
    { 'neovim/nvim-lspconfig', opts = { servers = { dockerls = dockerls } } },
}
