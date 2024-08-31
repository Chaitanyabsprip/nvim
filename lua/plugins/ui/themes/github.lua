---@diagnostic disable: no-unknown
local config = require 'config.theme'

local name = 'github'

---@type LazySpec
return {
    'projekt0n/github-nvim-theme',
    lazy = config.theme ~= name,
    priority = 1000,
    config = function()
        require('github-theme').setup {
            options = {
                hide_end_of_buffer = config.hide_eob,
                hide_nc_statusline = false,
                transparent = config.transparent,
                terminal_colors = true,
                dim_inactive = false,
                module_default = false,
                styles = { -- Style to be applied to different syntax groups
                    comments = 'italic', -- Value is any valid attr-list value `:help attr-list`
                    functions = 'NONE',
                    keywords = 'NONE',
                    variables = 'NONE',
                    conditionals = 'NONE',
                    constants = 'bold',
                    numbers = 'NONE',
                    operators = 'NONE',
                    strings = 'NONE',
                    types = 'NONE',
                },
                inverse = { -- Inverse highlight for different types
                    match_paren = true,
                    visual = false,
                    search = false,
                },
                darken = { -- Darken floating windows and sidebar-like windows
                    floats = true,
                    sidebars = {
                        enable = true,
                        list = {}, -- Apply dark background to specific windows
                    },
                },
                modules = {
                    cmp = true,
                    dapui = true,
                    dashboard = true,
                    diagnostic = { enable = true },
                    diffchar = true,
                    fzf = true,
                    gitsigns = true,
                    native_lsp = { enable = true },
                    neogit = true,
                    notify = true,
                    telescope = true,
                    treesitter = true,
                    treesitter_context = true,
                },
            },
        }

        vim.cmd.colorscheme 'github_dark_default'
    end,
}
