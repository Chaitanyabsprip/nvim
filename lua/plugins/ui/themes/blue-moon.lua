local config = require 'config.theme'

local name = 'blue-moon'

---@type LazySpec
return {
    'kyazdani42/blue-moon',
    lazy = config.theme ~= name,
    priority = 1000,
    config = function() vim.cmd.colorscheme 'blue-moon' end,
}
