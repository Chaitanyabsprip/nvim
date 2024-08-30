local config = require 'config.theme'

local name = 'night-owl'

---@type LazySpec
return {
    'oxfist/night-owl.nvim',
    lazy = config.theme ~= name,
    priority = 1000,
    config = function() vim.cmd.colorscheme(name) end,
}
