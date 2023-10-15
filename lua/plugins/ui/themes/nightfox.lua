local config = require 'config.theme'

local name = 'nightfox'

---@class Colorscheme
local nightfox = {
    'EdenEast/nightfox.nvim',
    lazy = config.theme ~= name,
    priority = 1000,
    opts = function()
        vim.g.lualine_theme = name
        return {
            options = {
                compile_path = vim.fn.stdpath 'cache' .. '/nightfox',
                compile_file_suffix = '_compiled',
                transparent = config.transparent,
                terminal_colors = true,
                dim_inactive = false,
                -- module_default = true,
                styles = {
                    comments = 'italic', -- Value is any valid attr-list value `:help attr-list`
                    conditionals = 'NONE',
                    constants = 'NONE',
                    functions = 'NONE',
                    keywords = 'NONE',
                    numbers = 'NONE',
                    operators = 'NONE',
                    strings = 'NONE',
                    types = 'NONE',
                    variables = 'NONE',
                },
                inverse = {
                    match_paren = false,
                    visual = false,
                    search = false,
                },
                modules = {
                    alpha = true,
                    cmp = true,
                    dashboard = true,
                    ['dap-ui'] = true,
                    diagnostic = { enabled = true, background = true },
                    gitsigns = true,
                    leap = { enabled = true, background = true, harsh = true },
                    mini = true,
                    modes = true,
                    native_lsp = { enabled = true, background = true },
                    navic = true,
                    neogit = true,
                    neotest = true,
                    notify = true,
                    nvimtree = true,
                    telescope = true,
                    treesitter = true,
                    whichkey = true,
                },
            },
            palettes = {},
            specs = {},
            groups = {},
        }
    end,
    config = function(_, opts)
        require(name).setup(opts)
        require(name).set()
    end,
}

return nightfox
