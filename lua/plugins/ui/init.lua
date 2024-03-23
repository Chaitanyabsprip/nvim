local ui = {}

ui.noice = {
    'folke/noice.nvim',
    dependencies = {
        'MunifTanjim/nui.nvim',
        {
            'rcarriga/nvim-notify',
            opts = {
                max_height = function() return math.floor(vim.o.lines * 0.75) end,
                max_width = function() return math.floor(vim.o.columns * 0.75) end,
                render = 'compact',
                top_down = false,
                background_colour = '#000000',
            },
        },
    },
    event = 'VeryLazy',
    opts = {
        cmdline = {
            format = {
                substitute = {
                    pattern = '^:%%?s/',
                    icon = ' ',
                    ft = 'regex',
                    opts = { border = { text = { top = ' sub (old/new/) ' } } },
                },
            },
        },
        messages = { view_search = 'mini' },
        lsp = {
            override = {
                ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
                ['vim.lsp.util.stylize_markdown'] = true,
                ['cmp.entry.get_documentation'] = true,
            },
            message = { view = 'mini' },
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
            { filter = { event = 'msg_showmode' }, opts = { skip = true } },
        },
        views = {
            notify = { win_options = { winblend = 0 } },
            mini = {
                align = 'message-center',
                position = { col = '50%' },
                win_options = { winhighlight = {}, winblend = 0 },
            },
            popup = { position = { row = '23', col = '50%' } },
            popupmenu = { position = { row = '23', col = '50%' } },
            cmdline_popup = {
                border = { style = 'none', padding = { 1, 1 } },
                position = { row = '23', col = '50%' },
                win_options = { winhighlight = { Normal = 'NormalFloat' } },
            },
        },
    },
}

ui.statuscolumn = {
    'luukvbaal/statuscol.nvim',
    event = 'VeryLazy',
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
                    sign = { namespace = { 'diagnostic' }, maxwidth = 1, colwidth = 1, auto = true },
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
}

ui.treesitter = {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = 'BufReadPre',
    config = function(_, opts) require('nvim-treesitter.configs').setup(opts) end,
    opts = {
        ensure_installed = { 'regex', 'vim' },
        highlight = { enable = true, additional_vim_regex_highlighting = false },
        refactor = {
            highlight_definitions = { enable = true },
            highlihgt_scope = { enable = true },
        },
        indent = { enable = false, disable = { 'dart' } },
    },
}

ui.textobjects = {
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
                            [']['] = { query = '@class.outer', desc = 'Jump to end of next class' },
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
                },
            },
        },
    },
}

ui.treesitter_playground = {
    'nvim-treesitter/playground',
    keys = {
        {
            '<leader>tp',
            '<cmd>TSPlaygroundToggle<cr>',
            noremap = true,
            silent = true,
            desc = 'Toggle Treesitter Playground',
        },
    },
    dependencies = {
        {
            'nvim-treesitter/nvim-treesitter',
            opts = {
                query_linter = {
                    enable = true,
                    use_virtual_text = true,
                    lint_events = { 'BufWrite', 'CursorHold' },
                },
                playground = {
                    enable = true,
                    persist_queries = false, -- Whether the query persists across vim sessions
                    keybindings = {
                        toggle_query_editor = 'o',
                        toggle_hl_groups = 'i',
                        toggle_injected_languages = 't',
                        toggle_anonymous_nodes = 'a',
                        toggle_language_display = 'I',
                        focus_language = 'f',
                        unfocus_language = 'F',
                        update = 'R',
                        goto_node = '<cr>',
                        show_help = '?',
                    },
                },
            },
        },
    },
    cmd = { 'TSPlaygroundToggle' },
}

return {
    ui.noice,
    ui.statuscolumn,
    ui.treesitter,
    ui.textobjects,
    ui.treesitter_playground,
}
