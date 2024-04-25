local tools = {}

tools.colorizer = {
    'NvChad/nvim-colorizer.lua',
    cmd = { 'ColorizerAttachToBuffer', 'ColorizerToggle' },
    event = 'BufReadPre',
    opts = {
        filetypes = { '*', '!lazy' },
        buftypes = { '*', '!prompt', '!nofile' },
        user_default_options = {
            names = false,
            RRGGBBAA = true,
            AARRGGBB = true,
            css_fn = true,
            mode = 'background', -- Available modes for `mode`: foreground, background,  virtualtext
            virtualtext = '███',
        },
    },
}

tools.peek = {
    'toppair/peek.nvim',
    build = 'deno task --quiet build:fast',
    keys = {
        {
            '<leader>op',
            function()
                local peek = require 'peek'
                if peek.is_open() then
                    peek.close()
                else
                    peek.open()
                end
            end,
            desc = 'Peek (Markdown Preview)',
        },
    },
    opts = { app = 'browser' },
}

tools.startuptime = {
    'dstein64/vim-startuptime',
    config = function() vim.g.startuptime_tries = 50 end,
    cmd = 'StartupTime',
}

tools.rest = {
    'rest-nvim/rest.nvim',
    ft = 'http',
    event = 'VeryLazy',
    version = '2.*',
    enabled = false,
    dependencies = {
        {
            'vhyrro/luarocks.nvim',
            priority = 1000,
            config = true,
            lazy = false,
        },
        {
            'nvim-treesitter/nvim-treesitter',
            opts = function(_, opts)
                opts.ensure_installed = opts.ensure_installed or {}
                vim.list_extend(opts.ensure_installed, { 'lua', 'http', 'graphql', 'xml', 'json' })
            end,
        },
    },
    config = function()
        require('rest-nvim').setup {
            result = {
                split = {
                    horizontal = true,
                },
            },
        }
    end,
}

tools.hurl = {
    'jellydn/hurl.nvim',
    dependencies = {
        'MunifTanjim/nui.nvim',
        'nvim-lua/plenary.nvim',
        {
            'nvim-treesitter/nvim-treesitter',
            opts = function(_, opts)
                opts.ensure_installed = opts.ensure_installed or {}
                vim.list_extend(opts.ensure_installed, { 'hurl' })
            end,
        },
    },
    ft = 'hurl',
    event = 'VeryLazy',
    opts = {
        debug = false,
        show_notification = false,
        mode = 'split',
        formatters = {
            json = { 'jq' },
            html = { 'prettierd', '--format', 'a.html' },
        },
    },
    keys = {
        -- { '<leader>A', '<cmd>HurlRunner<CR>', desc = 'Run All requests' },
        -- { '<leader>a', '<cmd>HurlRunnerAt<CR>', desc = 'Run Api request' },
        -- { '<leader>te', '<cmd>HurlRunnerToEntry<CR>', desc = 'Run Api request to entry' },
        -- { '<leader>tm', '<cmd>HurlToggleMode<CR>', desc = 'Hurl Toggle Mode' },
        -- { '<leader>tv', '<cmd>HurlVerbose<CR>', desc = 'Run Api in verbose mode' },
        -- { '<leader>h', ':HurlRunner<CR>', desc = 'Hurl Runner', mode = 'v' },
    },
}

tools.spec = {
    tools.colorizer,
    tools.peek,
    tools.rest,
    tools.startuptime,
}

return tools.spec
