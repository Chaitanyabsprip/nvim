local config = require 'config.theme'

local name = 'night-owl'

---@class Colorscheme
local nightowl = {
    'oxfist/night-owl.nvim',
    lazy = config.theme ~= name,
    priority = 1000,
    config = function() vim.cmd.colorscheme(name) end,
}

return nightowl
