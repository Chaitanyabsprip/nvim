local config = require 'config.theme'
local name = 'ayu'

---@class Colorscheme
local rosepine = {
    'Shatur/neovim-ayu',
    lazy = config.theme ~= name,
    priority = 1000,
    opts = function()
        vim.g.lualine_theme = name
        return {}
    end,
    config = function(_, opts)
        require(name).setup(opts)
        vim.cmd.colorscheme(name)
    end,
}

rosepine.set = function() end

return rosepine
