local config = require 'config.theme'

local name = 'midnight'

---@class Colorscheme
local midnight = {
    'dasupradyumna/midnight.nvim',
    lazy = config.theme ~= name,
    priority = 1000,
    config = function() vim.cmd.colorscheme(name) end,
}

midnight.set = function() end

return midnight
