local config = require 'config.theme'
local name = 'tokyodark'

---@class Colorscheme
local tokyodark = {
    'tiagovla/tokyodark.nvim',
    lazy = config.theme ~= name,
    priority = 1000,
    opts = function()
        vim.g.lualine_theme = name
        return {
            transparent_background = config.transparent, -- set background to transparent
            gamma = 0.80, -- adjust the brightness of the theme
            terminal_colors = true, -- enable terminal colors
            styles = {
                comments = { italic = true }, -- style for comments
                keywords = { italic = true }, -- style for keywords
                identifiers = { italic = true }, -- style for identifiers
                functions = {}, -- style for functions
                variables = {}, -- style for variables
            },
            -- custom_highlights = {} or function(highlights, palette) return {} end, -- extend highlights
            custom_palette = function(_)
                return {
                    orange = '#d4936c',
                    red = '#ab5b69',
                }
            end, -- extend palette
        }
    end,
    config = function(_, opts)
        require('tokyodark').setup(opts)
        vim.cmd.colorscheme(name)
    end,
}
tokyodark.set = function() end

return tokyodark
