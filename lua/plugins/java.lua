---@module "lazy"
---@type LazySpec[]
return {
    {
        'nvim-java/nvim-java',
        ft = { 'java' },
        config = function()
            require('java').setup()
            vim.lsp.enable 'jdtls'
        end,
    },
}
