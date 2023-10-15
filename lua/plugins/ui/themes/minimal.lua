local config = require 'config.theme'

local name = 'minimal'

---@class Colorscheme
local minimal = {
    'Yazeed1s/minimal.nvim',
    lazy = config.theme ~= name,
    priority = 1000,
    config = function()
        vim.g.minimal_italic_comments = true
        vim.g.minimal_italic_keywords = false
        vim.g.minimal_italic_functions = false
        vim.g.minimal_italic_booleans = false
        vim.g.minimal_italic_variables = false
        vim.g.minimal_transparent_background = config.transparent
        vim.cmd.colorscheme(name)
    end,
}

function minimal.set() end

return minimal
