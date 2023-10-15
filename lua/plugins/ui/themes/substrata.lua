local config = require 'config.theme'

local name = 'substrata'

---@class Colorscheme
local substrata = {
    'kvrohit/substrata.nvim',
    lazy = config.theme ~= name,
    priority = 1000,
    opts = function()
        return {
            bold_vert_split = false,
            dim_nc_background = false,
            disable_background = config.transparent,
            disable_float_background = false,
            disable_italics = false,
        }
    end,
    config = function()
        vim.g.substrata_italic_comments = true
        vim.g.substrata_italic_keywords = false
        vim.g.substrata_italic_booleans = false
        vim.g.substrata_italic_functions = false
        vim.g.substrata_italic_variables = false
        vim.g.substrata_transparent = config.transparent
        vim.g.substrata_variant = 'default' -- defualt, brighter
        vim.cmd.colorscheme(name)
    end,
}

substrata.set = function() end

return substrata
