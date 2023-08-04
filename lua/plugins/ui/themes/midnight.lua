local config = require 'config.ui'

local name = 'midnight'

---@class Colorscheme
midnight = {
  'dasupradyumna/midnight.nvim',
  lazy = config.theme ~= name,
  priority = 1000,
  config = function() vim.g.lualine_theme = 'auto' end,
}

midnight.set = function()
  if package.loaded['mignight'] then vim.cmd.colorscheme 'midnight' end
end

return midnight
