local extend = require('plugins.lsp').extend

local function dockerls(lspconfig) lspconfig.dockerls.setup(extend { root = { '.sqllsrc.json' } }) end

return {
    {
        'nvim-treesitter/nvim-treesitter',
        optional = true,
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(opts, 'ensure_installed', 'dockerfile')
        end,
    },
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
    { 'neovim/nvim-lspconfig', opts = { servers = { dockerls = dockerls } } },
}
