---@type LazySpec[]
return {
    {
        'folke/noice.nvim',
        enabled = false,
        dependencies = {
            'MunifTanjim/nui.nvim',
            {
                'rcarriga/nvim-notify',
                opts = {
                    max_height = function() return math.floor(vim.o.lines * 0.35) end,
                    max_width = function() return math.floor(vim.o.columns * 0.35) end,
                    render = 'compact',
                    background_colour = '#07080D',
                },
            },
            {
                'nvim-treesitter/nvim-treesitter',
                opts = function(_, opts)
                    require('config.lazy').extend_opts_list(
                        opts,
                        'bash',
                        'lua',
                        'markdown',
                        'markdown_inline',
                        'regex',
                        'vim'
                    )
                end,
            },
        },
        event = 'VeryLazy',
        ---@type NoiceConfig
        opts = {
            cmdline = {
                view = 'cmdline',
                format = {
                    cmdline = { icon = '▍' },
                    substitute = {
                        pattern = '^:%%?s/',
                        icon = ' ',
                        ft = 'regex',
                        opts = { border = { text = { top = ' sub (old/new/) ' } } },
                    },
                    input = { view = 'cmdline_input', icon = '▍' },
                },
            },
            cmdline_input = { view = 'cmdline' },
            messages = { view_search = 'mini' },
            lsp = {
                override = {
                    ['vim.lsp.util.convert_input_to_markdown_lines'] = false,
                    ['vim.lsp.util.stylize_markdown'] = false,
                    ['cmp.entry.get_documentation'] = false,
                },
                message = { view = 'mini' },
                hover = { opts = { win_options = { winhighlight = { Normal = 'NormalFloat' } } } },
                signature = {
                    enabled = true,
                    auto_open = {
                        enabled = true,
                        trigger = true,
                        luasnip = true,
                        throttle = 50,
                    },
                },
            },
            presets = {
                bottom_search = true,
                command_palette = true,
                long_message_to_split = true,
                inc_rename = false,
                lsp_doc_border = true,
            },
            routes = {
                { filter = { event = 'msg_show', find = '%d+L, %d+B' }, view = 'mini' },
                { filter = { event = 'msg_show', find = 'after #%d+' }, view = 'mini' },
                { filter = { event = 'msg_show', find = 'before #%d+' }, view = 'mini' },
                { filter = { event = 'msg_showmode' }, view = 'mini' },
            },
            views = {
                notify = { win_options = { winblend = 0 } },
                mini = {
                    -- align = 'message-center',
                    -- position = { col = '50%' },
                    win_options = { winhighlight = {}, winblend = 0 },
                },
                popup = { position = { row = '23', col = '50%' } },
                popupmenu = { position = { row = '23', col = '50%' } },
                cmdline_input = {
                    view = 'cmdline',
                    size = { height = 'auto', width = '100%' },
                    border = { style = { '', '', '', '', '', '', '', '' } },
                },
            },
        },
    },
    {
        'luukvbaal/statuscol.nvim',
        event = 'VeryLazy',
        enabled = false,
        config = function()
            local builtin = require 'statuscol.builtin'
            require('statuscol').setup {
                relculright = true,
                segments = {
                    {
                        sign = { name = { '.*' }, text = { '.*' } },
                        click = 'v:lua.ScSa',
                        maxwidth = 2,
                        auto = true,
                    },
                    {
                        sign = {
                            namespace = { 'diagnostic' },
                            maxwidth = 1,
                            colwidth = 1,
                            auto = true,
                        },
                        click = 'v:lua.ScSa',
                        auto = true,
                    },
                    {
                        text = { builtin.lnumfunc, ' ' },
                        condition = { true, builtin.not_empty },
                        click = 'v:lua.ScLa',
                    },
                    {
                        text = {
                            function(args)
                                args.fold.close = ''
                                args.fold.open = ''
                                args.fold.sep = ' '
                                return builtin.foldfunc(args)
                            end,
                            ' ',
                        },
                        click = 'v:lua.ScFa',
                        auto = true,
                    },
                    {
                        sign = { namespace = { 'gitsigns' }, colwidth = 1, wrap = true },
                        click = 'v:lua.ScSa',
                    },
                },
                -- segments = {
                --     { text = { builtin.foldfunc }, click = 'v:lua.ScFa' },
                --     { text = { '%s' }, click = 'v:lua.ScSa' },
                --     { text = { builtin.lnumfunc, ' ' }, click = 'v:lua.ScLa' },
                -- },
                -- segments = {
                --
                --   { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
                --   { text = { builtin.lnumfunc }, click = "v:lua.ScLa", },
                --   {
                --     sign = { name = { ".*" }, maxwidth = 2, colwidth = 1, auto = true, wrap = true },
                --     click = "v:lua.ScSa"
                --   },
                -- }
            }
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        event = 'BufReadPre',
        config = function(_, opts) require('nvim-treesitter.configs').setup(opts) end,
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            local config = {
                highlight = { enable = true, additional_vim_regex_highlighting = false },
                refactor = {
                    highlight_definitions = { enable = true },
                    highlihgt_scope = { enable = true },
                },
                indent = { enable = false, disable = { 'dart' } },
            }
            vim.list_extend(opts.ensure_installed, { 'regex', 'vim', 'make' })
            opts = vim.tbl_deep_extend('force', opts, config)
            return opts
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        event = 'BufReadPre',
        dependencies = {
            {
                'nvim-treesitter/nvim-treesitter',
                opts = {
                    textobjects = {
                        move = {
                            enable = true,
                            set_jumps = true,
                            goto_next_start = {
                                [']p'] = {
                                    query = '@parameter.inner',
                                    desc = 'Jump to start of next parameter',
                                },
                                [']f'] = {
                                    query = '@function.outer',
                                    desc = 'Jump to start of next function',
                                },
                                [']]'] = {
                                    query = '@class.outer',
                                    desc = 'Jump to start of next class',
                                },
                            },
                            goto_next_end = {
                                [']F'] = {
                                    query = '@function.outer',
                                    desc = 'Jump to end of next function',
                                },
                                [']['] = {
                                    query = '@class.outer',
                                    desc = 'Jump to end of next class',
                                },
                            },
                            goto_previous_start = {
                                ['[p'] = {
                                    query = '@parameter.inner',
                                    desc = 'Jump to start of previous parameter',
                                },
                                ['[f'] = {
                                    query = '@function.outer',
                                    desc = 'Jump to start of previous function',
                                },
                                ['[['] = {
                                    query = '@class.outer',
                                    desc = 'Jump to start of previous class',
                                },
                            },
                            goto_previous_end = {
                                ['[F'] = {
                                    query = '@function.outer',
                                    desc = 'Jump to end of previous function',
                                },
                                ['[]'] = {
                                    query = '@class.outer',
                                    desc = 'Jump to end of previous class',
                                },
                            },
                        },
                        select = {
                            enable = true,
                            lookahead = true,
                            keymaps = {
                                ['af'] = {
                                    query = '@function.outer',
                                    desc = 'Select outer part of a function',
                                },
                                ['if'] = {
                                    query = '@function.inner',
                                    desc = 'Select inner part of a function',
                                },
                                ['ac'] = {
                                    query = '@conditional.outer',
                                    desc = 'Select outer part of a conditional',
                                },
                                ['ic'] = {
                                    query = '@conditional.inner',
                                    desc = 'Select inner part of a conditional',
                                },

                                ['aa'] = {
                                    query = '@parameter.outer',
                                    desc = 'Select outer part of a parameter',
                                },
                                ['ia'] = {
                                    query = '@parameter.inner',
                                    desc = 'Select inner part of a parameter',
                                },

                                ['av'] = {
                                    query = '@variable.outer',
                                    desc = 'Select outer part of a variable',
                                },
                                ['iv'] = {
                                    query = '@variable.inner',
                                    desc = 'Select inner part of a variable',
                                },
                            },
                        },
                        lsp_interop = {
                            enable = true,
                            border = 'rounded',
                            floating_preview_opts = {},
                            peek_definition_code = {
                                ['<leader>gd'] = '@function.outer',
                                ['<leader>gD'] = '@class.outer',
                            },
                        },
                    },
                },
            },
        },
    },
    {
        'nvim-treesitter/nvim-treesitter-context',
        event = 'BufWinEnter',
        opts = {
            enable = true,
            max_lines = 3,
            trim_scope = 'outer',
            min_window_height = 18,
            mode = 'cursor',
            line_numbers = true,
        },
    },
}
