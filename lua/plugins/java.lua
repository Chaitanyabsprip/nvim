local configure = require('plugins.lsp').configure
local function jdtls() configure 'jdtls' end
---@module "lazy"
---@type LazySpec[]
return {
    {
        'nvim-java/nvim-java',
        ft = { 'java' },
        opts = {},
    },
    {
        'neovim/nvim-lspconfig',
        optional = true,
        opts = { servers = { jdtls = jdtls } },
    },
    {
        'nvim-treesitter/nvim-treesitter',
        optional = true,
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(opts, 'ensure_installed', 'java')
        end,
    },
}
