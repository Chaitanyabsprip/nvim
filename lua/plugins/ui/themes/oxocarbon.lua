local config = require 'config.ui'

---@class Colorscheme
local oxocarbon = {}
local name = 'oxocarbon'

vim.g.lualine_theme = 'oxocarbon'

oxocarbon.spec = {
  'nyoom-engineering/oxocarbon.nvim',
  lazy = config.theme ~= name,
  priority = 1000,
}

oxocarbon.set = function()
  if package.loaded['oxocarbon'] then vim.cmd.colorscheme 'oxocarbon' end
end

return oxocarbon
