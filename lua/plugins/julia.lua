local configure = require('plugins.lsp').configure

local function julials() configure 'julials' end

---@type LazyPluginSpec[]
return {
    {
        'nvim-treesitter/nvim-treesitter',
        optional = true,
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(opts, 'ensure_installed', 'julia')
        end,
    },
    -- {
    --     'williamboman/mason.nvim',
    --     optional = true,
    --     opts = function(_, opts)
    --         require('config.lazy').extend_opts_list(opts, 'ensure_installed', 'julia-lsp')
    --     end,
    -- },
    {
        'neovim/nvim-lspconfig',
        optional = true,
        opts = { servers = { julials = julials } },
    },
    -- {
    --     'nvimtools/none-ls.nvim',
    --     optional = true,
    --     ft = function(_, filetypes) return vim.list_extend(filetypes, { 'json' }) end,
    --     opts = function(_, opts)
    --         require('config.lazy').extend_opts_list(
    --             opts,
    --             'sources',
    --             ---@param builtins NullBuiltin
    --             function(builtins)
    --                 return { builtins.formatting.prettier.with { filetypes = { 'json', 'jsonc' } } }
    --             end
    --         )
    --     end,
    -- },
}
