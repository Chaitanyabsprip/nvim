local config = require 'config.ui'
---@class Colorscheme
---@field spec LazyPluginSpec
---@field set function
local tokyonight = {}

vim.g.lualine_theme = 'tokyonight'

tokyonight.spec = {
  'folke/tokyonight.nvim',
  lazy = false,
  opts = {
    style = 'night',
    transparent = config.transparent,
    terminal_colors = true,
    styles = {
      comments = 'italic',
      keywords = 'italic',
      functions = 'italic',
      variables = 'italic',
      sidebars = 'dark',
      floats = 'dark',
    },
    sidebars = config.sidebars,
    day_brightness = 0.3,
    hide_inactive_statusline = false,
    dim_inactive = false,
    lualine_bold = true,
    on_highlights = function(hl, c)
      hl.NotifyBackground = { bg = c.bg, fg = c.fg }
      -- hl.Cursor = { fg = c.black, bg = c.fg }
    end,
    on_colors = function(colors)
      -- colors.border = '#7aa2f7'
      colors.bg = '#0f111a'
    end,
  },
}
tokyonight.set = function() require('tokyonight').load() end

return tokyonight
