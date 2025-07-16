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
                menu = { auto_show = true },
            },
            signature = { enabled = true, window = { show_documentation = true } },
        },
        -- config = function(_, opts)
        --     require('blink-cmp').setup(opts)
        -- vim.api.nvim_create_autocmd('User', {
        --     pattern = 'BlinkCmpMenuOpen',
        --     callback = function()
        --         require('copilot.suggestion').dismiss()
        --         vim.b.copilot_suggestion_hidden = true
        --     end,
        -- })
        -- vim.api.nvim_create_autocmd('User', {
        --     pattern = 'BlinkCmpMenuClose',
        --     callback = function() vim.b.copilot_suggestion_hidden = false end,
        -- })
        -- end,
    },
    { 'Alexisvt/flutter-snippets', ft = { 'dart' } },
    { 'Nash0x7E2/awesome-flutter-snippets', ft = { 'dart' } },
    { 'natebosch/dartlang-snippets', ft = 'dart' },
    {
        'CopilotC-Nvim/CopilotChat.nvim',
        dependencies = {
            { 'zbirenbaum/copilot.lua' },
            -- { 'github/copilot.vim' }, -- or zbirenbaum/copilot.lua
            { 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
        },
        build = 'make tiktoken', -- Only on MacOS or Linux
        opts = {
            -- See Configuration section for options
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
        opts = {
            provider = 'copilot',
        },
    },
    get_capabilities = function()
        local capabilities = require('lsp').capabilities()
        local ok, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
        if ok then
            return vim.tbl_deep_extend('force', capabilities, cmp_lsp.default_capabilities())
        end
        return capabilities
    end,
}
