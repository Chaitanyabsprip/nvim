local config = require 'config.ui'

local name = 'oxocarbon'

---@class Colorscheme
oxocarbon = {
  'nyoom-engineering/oxocarbon.nvim',
  lazy = config.theme ~= name,
  priority = 1000,
  config = function() vim.g.lualine_theme = 'oxocarbon' end,
}

oxocarbon.set = function()
  if package.loaded['oxocarbon'] then vim.cmd.colorscheme 'oxocarbon' end
end

return oxocarbon
