local config = require 'config.ui'

local name = 'blue-moon'

---@class Colorscheme
local bluemoon = {
  'kyazdani42/blue-moon',
  lazy = config.theme ~= name,
  priority = 1000,
}

function bluemoon.set() vim.cmd.colorscheme 'blue-moon' end

return bluemoon
