local config = require 'config.theme'

local name = 'blue-moon'

---@class Colorscheme
local bluemoon = {
    'kyazdani42/blue-moon',
    lazy = config.theme ~= name,
    priority = 1000,
    config = function() vim.cmd.colorscheme 'blue-moon' end,
}

function bluemoon.set() end

return bluemoon
