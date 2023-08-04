local config = require 'config.ui'

local name = 'oxocarbon'

---@class Colorscheme
local oxocarbon = {
  'nyoom-engineering/oxocarbon.nvim',
  lazy = config.theme ~= name,
  priority = 1000,
  config = function()
    vim.g.lualine_theme = name
    vim.cmd.colorscheme(name)
  end,
}

oxocarbon.set = function() end

return oxocarbon
