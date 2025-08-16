local configure = require('plugins.lsp').configure

local function astrols()
    configure('astro', {
        root = {
            'tsconfig.json',
            'jsconfig.json',
            'astro.config.js',
            'astro.config.mjs',
            'astro.config.cjs',
        },
    })
end

---@type LazyPluginSpec[]
return {
    {
        'nvim-treesitter/nvim-treesitter',
        optional = true,
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(opts, 'ensure_installed', 'astro')
        end,
    },
    {
        'williamboman/mason.nvim',
        optional = true,
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(
                opts,
                'ensure_installed',
                'astro-language-server'
            )
        end,
    },
    {
        'neovim/nvim-lspconfig',
        optional = true,
        opts = { servers = { astro = astrols } },
    },
}
