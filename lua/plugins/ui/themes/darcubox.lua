---@diagnostic disable: no-unknown
local config = require 'config.ui'

local name = 'darcubox'

---@class Colorscheme: LazyPluginSpec
local darcubox = {
  'dotsilas/darcubox-nvim',
  lazy = config.theme ~= name,
  priority = 1000,
  config = function() vim.cmd.colorscheme(name) end,
}

return darcubox
