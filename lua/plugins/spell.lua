local configure = require('plugins.lsp').configure

local function codebook() configure 'codebook' end
---@module "lazy"
---@type LazySpec[]
return {
    {
        'williamboman/mason.nvim',
        optional = true,
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(opts, 'ensure_installed', 'codebook')
        end,
    },
    {
        'neovim/nvim-lspconfig',
        optional = true,
        opts = { servers = { codebook = codebook } },
    },
}
