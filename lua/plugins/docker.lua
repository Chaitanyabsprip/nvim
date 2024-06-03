local extend = require('plugins.lsp').extend

local function dockerls(lspconfig)
    lspconfig.dockerls.setup(extend { root = { '.sqllsrc.json' } })
    lspconfig.docker_compose_language_service.setup(extend {})
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
