local config = require 'config.ui'

---@class Colorscheme
local midnight = {}
local name = 'midnight'

vim.g.lualine_theme = 'auto'

midnight.spec = {
  'dasupradyumna/midnight.nvim',
  lazy = config.theme ~= name,
  priority = 1000,
}

midnight.set = function()
  if package.loaded['mignight'] then vim.cmd.colorscheme 'midnight' end
end

return midnight
