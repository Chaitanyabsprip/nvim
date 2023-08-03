local config = require 'config.ui'

---@class Colorscheme
local horizon = {}
local name = 'horizon'

vim.g.lualine_theme = name

horizon.spec = {
  'akinsho/horizon.nvim',
  version = '*',
  lazy = config.theme ~= name,
  priority = 1000,
  opts = {
    plugins = {
      cmp = true,
      indent_blankline = false,
      nvim_tree = true,
      telescope = true,
      which_key = true,
      barbar = false,
      notify = true,
      symbols_outline = false,
      neo_tree = false,
      gitsigns = true,
      crates = false,
      hop = false,
      navic = true,
      quickscope = true,
      flash = true,
    },
  },
}

function horizon.set()
  if package.loaded['material'] then vim.cmd.colorscheme 'material' end
end

return horizon
