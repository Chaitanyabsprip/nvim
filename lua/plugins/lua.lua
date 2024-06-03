local extend = require('plugins.lsp').extend

local function lua_ls(lspconfig)
    local config = extend {
        root = { '.stylua' },
        settings = {
            Lua = {
                workspace = { checkThirdParty = false },
                completion = {
                    workspaceword = true,
                    showWord = 'Disable',
                    callSnippet = 'Both',
                    displayContext = true,
                },
                diagnostics = {
                    disable = { 'incomplete-signature-doc' },
                    groupFileStatus = {
                        ['ambiguity'] = 'Any',
                        ['await'] = 'Any',
                        ['codestyle'] = 'None',
                        ['duplicate'] = 'Any',
                        ['global'] = 'Any',
                        ['luadoc'] = 'Any',
                        ['redefined'] = 'Any',
                        ['strict'] = 'Any',
                        ['strong'] = 'Any',
                        ['type-check'] = 'Any',
                        ['unbalanced'] = 'Any',
                        ['unused'] = 'Any',
                    },
                    unusedLocalExclude = { '_*' },
                },
                hint = {
                    enable = true,
                    semicolon = 'Disable',
                    arrayIndex = 'Disable',
                },
                type = { castNumberToInteger = true },
                telemetry = { enable = false },
                format = { enable = false },
            },
        },
    }
    lspconfig.lua_ls.setup(config)
end
return {
    ---@type LazyPluginSpec
    {
        'nvim-treesitter/nvim-treesitter',
        optional = true,
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(
                opts,
                'ensure_installed',
                'lua',
                'luadoc',
                'luap'
            )
        end,
    },
    ---@type LazyPluginSpec
    {
        'williamboman/mason.nvim',
        optional = true,
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(
                opts,
                'ensure_installed',
                'stylua',
                'lua-language-server'
            )
        end,
    },
    ---@type LazyPluginSpec
    {
        'nvimtools/none-ls.nvim',
        ft = function(_, filetypes) return vim.list_extend(filetypes, { 'lua' }) end,
        optional = true,
        opts = function(_, opts)
            require('config.lazy').extend_opts_list(
                opts,
                'sources',
                function(builtins) return { builtins.formatting.stylua } end
            )
        end,
    },
    ---@type LazyPluginSpec
    { 'neovim/nvim-lspconfig', opts = { servers = { lua_ls = lua_ls } } },
}
