local config = require 'config.theme'

local name = 'gruvbox'

---@type LazySpec
return {
    'ellisonleao/gruvbox.nvim',
    lazy = config.theme ~= name,
    priority = 1000,
    opts = function()
        vim.g.lualine_theme = name
        return {
            terminal_colors = true,
            undercurl = true,
            underline = true,
            bold = true,
            italic = {
                strings = false,
                emphasis = true,
                comments = true,
                operators = false,
                folds = true,
            },
            strikethrough = true,
            invert_selection = true,
            invert_signs = false,
            invert_tabline = false,
            invert_intend_guides = false,
            inverse = true, -- invert background for search, diffs, statuslines and errors
            contrast = '', -- can be "hard", "soft" or empty string
            palette_overrides = {
                dark0 = '#000000',
                dark1 = '#000000',
            },
            overrides = {},
            dim_inactive = false,
            transparent_mode = false,
        }
    end,
    config = function(_, opts)
        require(name).setup(opts)
        vim.cmd.colorscheme(name)
    end,
}
