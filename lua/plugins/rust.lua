---@type LazySpec[]
return {
    {
        'mrcjkb/rustaceanvim',
        version = '^5',
        lazy = false,
        init = function()
            vim.g.rustaceanvim = { server = { on_attach = require('lsp').on_attach } }
        end,
    },
}
