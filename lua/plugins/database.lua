return {
    ---@type LazyPluginSpec
    {
        'kristijanhusak/vim-dadbod-completion',
        dependencies = { 'hrsh7th/nvim-cmp' },
        config = function()
            require('cmp').setup.filetype({ 'sql' }, {
                sources = {
                    { name = 'vim-dadbod-completion' },
                    { name = 'buffer' },
                },
            })
        end,
    },
    ---@type LazyPluginSpec
    {
        'kristijanhusak/vim-dadbod-ui',
        dependencies = { 'tpope/vim-dadbod' },
        config = function()
            vim.g.db_ui_use_nerd_fonts = true
            vim.g.db_ui_show_database_icon = true
            vim.g.db_ui_use_nvim_notify = true
        end,
        cmd = { 'DBUI', 'DBUIToggle', 'DBUIAddConnection', 'DBUIFindBuffer' },
        keys = {
            {
                '<leader>dt',
                '<cmd>DBUIToggle<cr>',
                noremap = true,
                silent = true,
                desc = 'DB: Toggle database ui',
            },
        },
    },
    ---@type LazyPluginSpec
    {
        'tpope/vim-dadbod',
        dependencies = { 'kristijanhusak/vim-dadbod-completion' },
        cmd = 'DB',
    },
    ---@type LazyPluginSpec
    {
        'kndndrj/nvim-dbee',
        dependencies = {
            'MunifTanjim/nui.nvim',
        },
        build = function()
            -- Install tries to automatically detect the install method.
            -- if it fails, try calling it with one of these parameters:
            --    "curl", "wget", "bitsadmin", "go"
            require('dbee').install()
        end,
        config = function()
            require('dbee').setup(--[[optional config]])
        end,
        keys = {
            {
                '<leader>db',
                function() require('dbee').toggle() end,
                noremap = true,
                silent = true,
            },
        },
    },
}
