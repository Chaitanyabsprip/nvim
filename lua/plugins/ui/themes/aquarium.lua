local config = require 'config.ui'

local name = 'aquarium'

---@class Colorscheme
local aquarium = {
  'FrenyExists/aquarium-vim',
  lazy = config.theme ~= name,
  priority = 1000,
  config = function()
    vim.g.aqua_bold = 1
    vim.g.aqua_transparency = config.transparent and 1 or 0
    vim.g.aquarium_style = 'dark'
    vim.cmd.colorscheme(name)
  end,
}

function aquarium.set() end

return aquarium
