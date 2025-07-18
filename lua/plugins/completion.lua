---@diagnostic disable: no-unknown
---@type LazyPluginSpec[] | function
return {
    {
        'saghen/blink.cmp',
        dependencies = { { 'rafamadriz/friendly-snippets' } },
        version = '1.*',
        event = { 'InsertEnter', 'CmdlineEnter' },
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = { preset = 'default' },
            appearance = { nerd_font_variant = 'mono' },
            completion = {
                documentation = { auto_show = true },
                menu = {
                    draw = {
                        padding = { 0, 1 }, -- padding only on right side
                        components = {
                            kind_icon = {
                                text = function(ctx)
                                    return ' ' .. ctx.kind_icon .. ctx.icon_gap .. ' '
                                end,
                            },
                        },
                    },
                },
            },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
                per_filetype = {
                    sql = { inherit_defaults = true, 'dadbod' },
                },
                providers = {
                    lsp = { fallbacks = {} }, -- defaults to `{ 'buffer' }`
                    dadbod = { module = 'vim_dadbod_completion.blink' },
                },
            },
            fuzzy = { implementation = 'prefer_rust_with_warning' },
            cmdline = {
                completion = { menu = { auto_show = true } },
                sources = function()
                    local type = vim.fn.getcmdtype()
                    if type == '/' or type == '?' then return { 'buffer' } end
                    return { 'lsp', 'path', 'cmdline' }
                end,
            },
            signature = { enabled = true, window = { show_documentation = true } },
        },
    },
    { 'Alexisvt/flutter-snippets', ft = { 'dart' } },
    { 'Nash0x7E2/awesome-flutter-snippets', ft = { 'dart' } },
    { 'natebosch/dartlang-snippets', ft = 'dart' },
    {
        'copilotlsp-nvim/copilot-lsp',
        event = 'InsertEnter',
        config = function()
            vim.g.copilot_nes_debounce = 500
            vim.lsp.enable 'copilot_ls'
            vim.keymap.set('n', '<c-s>', function()
                -- Try to jump to the start of the suggestion edit.
                -- If already at the start, then apply the pending suggestion and jump to the end of the edit.
                local _ = require('copilot-lsp.nes').walk_cursor_start_edit()
                    or (
                        require('copilot-lsp.nes').apply_pending_nes()
                        and require('copilot-lsp.nes').walk_cursor_end_edit()
                    )
            end)
            -- Clear copilot suggestion with Esc if visible, otherwise preserve default Esc behavior
            vim.keymap.set('n', '<esc>', function()
                if not require('copilot-lsp.nes').clear() then
                    _ = ''
                    -- fallback to other functionality
                end
            end, { desc = 'Clear Copilot suggestion or fallback' })
            require('copilot-lsp').setup {}
        end,
    },
    {
        'CopilotC-Nvim/CopilotChat.nvim',
        dependencies = {
            { 'zbirenbaum/copilot.lua' },
            -- { 'github/copilot.vim' }, -- or zbirenbaum/copilot.lua
            { 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
        },
        build = 'make tiktoken', -- Only on MacOS or Linux
        opts = {},
        keys = {
            {
                '<leader>ac',
                '<cmd>CopilotChatToggle<cr>',
                desc = 'Copilot Chat',
                mode = { 'n', 'v' },
                noremap = true,
                silent = true,
            },
        },
        cmd = {
            'CopilotChat',
            'CopilotChatOpen',
            'CopilotChatClose',
            'CopilotChatToggle',
            'CopilotChatStop',
            'CopilotChatReset',
            'CopilotChatSave',
            'CopilotChatLoad',
            'CopilotChatDebugInfo',
            'CopilotChatModels',
            'CopilotChatAgents',
        },
    },
    {
        'zbirenbaum/copilot.lua',
        event = 'InsertEnter',
        config = function()
            require('copilot').setup {
                panel = {
                    enabled = true,
                    auto_refresh = true,
                },
                suggestion = {
                    auto_trigger = true,
                    keymap = {
                        accept = '<C-a>',
                        accept_word = false,
                        accept_line = false,
                        next = '<M-]>',
                        prev = '<M-[>',
                        dismiss = '<C-]>',
                    },
                },
                copilot_model = 'Claude Sonnet 3.7',
            }
        end,
    },
    {
        'yetone/avante.nvim',
        build = 'make',
        event = 'VeryLazy',
        version = false, -- Never set this value to "*"! Never!
        dependencies = {
            'nvim-lua/plenary.nvim',
            'MunifTanjim/nui.nvim',
        },
        ---@module 'avante'
        ---@type avante.Config
        opts = { provider = 'copilot' },
    },
    get_capabilities = require('lsp').capabilities,
}
