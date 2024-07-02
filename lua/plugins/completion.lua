---@diagnostic disable: no-unknown
---@type LazyPluginSpec[] | function
return {
    {
        'L3MON4D3/LuaSnip',
        build = 'make install_jsregexp',
        version = '2.*',
        dependencies = {
            {
                'rafamadriz/friendly-snippets',
                config = function() require('luasnip.loaders.from_vscode').lazy_load() end,
            },
        },
        opts = function()
            local types = require 'luasnip.util.types'
            return {
                history = true,
                updateevents = 'TextChanged,TextChangedI',
                enable_autosnippets = true,
                ext_opts = {
                    [types.choiceNode] = { active = { virt_text = { { '●', 'Error' } } } },
                    [types.insertNode] = { active = { virt_text = { { '●', 'Comment' } } } },
                },
            }
        end,
    },
    {
        'hrsh7th/nvim-cmp',
        event = { 'InsertEnter', 'CmdlineEnter' },
        dependencies = {
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
            'L3MON4D3/LuaSnip',
            'onsails/lspkind.nvim',
        },
        opts = function()
            local cmp = require 'cmp'
            local luasnip = require 'luasnip'
            local lspkind = require 'lspkind'
            local function has_words_before()
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0
                    and vim.api
                            .nvim_buf_get_lines(0, line - 1, line, true)[1]
                            :sub(col, col)
                            :match '%s'
                        == nil
            end

            local cmdline_map_presets = cmp.config.mapping.preset.cmdline()
            local search_opts = { mapping = cmdline_map_presets, sources = { { name = 'buffer' } } }
            local cmdline_opt = {
                mapping = cmdline_map_presets,
                sources = cmp.config.sources {
                    { name = 'path' },
                    { name = 'cmdline' },
                    { name = 'nvim_lsp' },
                },
            }

            cmp.setup.cmdline('/', search_opts)
            cmp.setup.cmdline(':', cmdline_opt)

            return {
                snippet = { expand = function(args) require('luasnip').lsp_expand(args.body) end },
                sources = cmp.config.sources(
                    { { name = 'luasnip' }, { name = 'nvim_lsp' }, { name = 'path' } },
                    { { name = 'buffer' } }
                ),
                window = {
                    completion = {
                        winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None',
                    },
                    documentation = {
                        border = 'rounded',
                        winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None',
                    },
                },
                experimental = { ghost_text = { hl_group = 'Comment' } },
                formatting = {
                    fields = { 'kind', 'abbr', 'menu' },
                    format = function(entry, vim_item)
                        local fmt = lspkind.cmp_format {
                            mode = 'symbol_text',
                            maxwidth = 50,
                            menu = {
                                buffer = 'Buffer',
                                nvim_lsp = 'LSP',
                                luasnip = 'LuaSnip',
                                nvim_lua = 'Lua',
                                latex_symbols = 'Latex',
                                path = 'Path',
                            },
                        }(entry, vim_item)
                        local strings = vim.split(fmt.kind, '%s', { trimempty = true })
                        fmt.kind = ' ' .. (strings[1] or '') .. ' '
                        fmt.menu = '\t\t(' .. (fmt.menu or '') .. ')'
                        return fmt
                    end,
                },
                mapping = {
                    ['<c-y>'] = cmp.mapping.confirm { select = true },
                    ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
                    ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
                    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
                    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
                    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete {}, { 'i', 'c' }),
                    ['<C-e>'] = cmp.mapping { i = cmp.mapping.abort(), c = cmp.mapping.close() },
                    ['<C-d>'] = cmp.mapping(cmp.mapping.open_docs(), { 'i', 'c' }),
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                },
            }
        end,
    },
    { 'Alexisvt/flutter-snippets', ft = { 'dart' } },
    { 'Nash0x7E2/awesome-flutter-snippets', ft = { 'dart' } },
    { 'natebosch/dartlang-snippets', ft = 'dart' },
    {
        'Exafunction/codeium.vim',
        event = 'BufEnter',
        config = function()
            vim.g.codeium_no_map_tab = 1
            vim.keymap.set(
                'i',
                '<C-a>',
                function() return vim.fn['codeium#Accept']() end,
                { expr = true, silent = true }
            )
            vim.keymap.set(
                'i',
                '<m-]>',
                function() return vim.fn['codeium#CycleCompletions'](1) end,
                { expr = true, silent = true }
            )
            vim.keymap.set(
                'i',
                '<m-[>',
                function() return vim.fn['codeium#CycleCompletions'](-1) end,
                { expr = true, silent = true }
            )
            vim.keymap.set(
                'i',
                '<c-]>',
                function() return vim.fn['codeium#Clear']() end,
                { expr = true, silent = true }
            )
            vim.keymap.set(
                'i',
                '<m-Bslash>',
                function() return vim.fn['codeium#Complete']() end,
                { expr = true, silent = true }
            )
        end,
    },
    -- {
    --     'Exafunction/codeium.nvim',
    --     dependencies = {
    --         'nvim-lua/plenary.nvim',
    --         'hrsh7th/nvim-cmp',
    --     },
    --     event = 'BufEnter',
    --     opts = {
    --         enable_chat = true,
    --     },
    --     config = function(_, opts)
    --         require('codeium').setup(opts)
    --         local cmp = require 'cmp'
    --         local config = cmp.get_config()
    --         table.insert(config.sources, { name = 'codeium' })
    --         cmp.setup(config)
    --     end,
    -- },
    get_capabilities = function()
        local cmp_lsp = require 'cmp_nvim_lsp'
        local capabilities = require('lsp').capabilities()
        local cmp_capabilities = cmp_lsp.default_capabilities()
        return vim.tbl_deep_extend('force', capabilities, cmp_capabilities)
    end,
}
