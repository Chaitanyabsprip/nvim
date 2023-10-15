local config = require 'config.theme'
local name = 'palenightfall'

---@class Colorscheme
local rosepine = {
    'JoosepAlviste/palenightfall.nvim',
    lazy = config.theme ~= name,
    priority = 1000,
    opts = { transparent = config.transparent },
    config = function(_, opts)
        require(name).setup(opts)
        vim.cmd.colorscheme(name)
    end,
}

rosepine.set = function() end

return rosepine
