local config = require 'config.theme'

local name = 'midnight'

---@type LazySpec
return {
    'dasupradyumna/midnight.nvim',
    lazy = config.theme ~= name,
    priority = 1000,
    config = function() vim.cmd.colorscheme(name) end,
}
