local config = require 'config.theme'

local name = 'moonlight'

---@class Colorscheme
local moonlight = {
    'shaunsingh/moonlight.nvim',
    lazy = config.theme ~= name,
    priority = 1000,
    config = function(_, opts)
        vim.g.lualine_theme = name
        vim.g.moonlight_italic_comments = true
        vim.g.moonlight_italic_keywords = false
        vim.g.moonlight_italic_functions = false
        vim.g.moonlight_italic_variables = false
        vim.g.moonlight_contrast = true
        vim.g.moonlight_borders = false
        vim.g.moonlight_disable_background = config.transparent
        require(name).setup(opts)
        require(name).set()
    end,
}

function moonlight.set() end

return moonlight
