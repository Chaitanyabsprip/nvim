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

tools.obsidian = {
    'epwalsh/obsidian.nvim',
    enabled = false,
    cmd = {
        'ObsidianNew',
        'ObsidianSearch',
        'Today',
        'Yesterday',
    },
    ft = { 'md', 'markdown', 'rmd', 'rst' },
    keys = {
        {
            'gf',
            function()
                return require('obsidian').util.cursor_on_markdown_link()
                        and '<cmd>ObsidianFollowLink<CR>'
                    or 'gf'
            end,
            expr = true,
            desc = 'Notes: Open link or file under cursor',
        },
    },
    opts = function()
        local command = vim.api.nvim_create_user_command
        command('Today', 'ObsidianToday', {})
        command('Yesterday', 'ObsidianYesterday', {})
        command('SearchNotes', 'ObsidianSemanticSearch', {})
        command('Notes', 'ObsidianSemanticSearch', {})
        return {
            dir = '~/Projects/Notes',
            -- Optional, if you keep notes in a specific subdirectory of your vault.
            notes_subdir = 'transient',
            completion = {
                nvim_cmp = true,
                min_chars = 2,
                new_notes_location = 'notes_subdir',
            },
            daily_notes = {
                folder = 'transient',
                date_format = '%Y-%m-%d',
            },
            mappings = {},
            -- Optional, alternatively you can customize the frontmatter data.
            follow_url_func = function(url) vim.fn.jobstart { 'open', url } end,
            use_advanced_uri = true,
            open_app_foreground = true,
            finder = 'telescope.nvim',
            disable_frontmatter = true,
        }
    end,
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
    dependencies = {
        {
            'vhyrro/luarocks.nvim',
            priority = 1000,
            config = true,
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
    tools.obsidian,
    tools.peek,
    tools.rest,
    tools.startuptime,
}

return tools.spec
