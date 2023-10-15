local config = require 'config.theme'

local name = 'poimandres'

---@class Colorscheme
local poimandres = {
    'olivercederborg/poimandres.nvim',
    lazy = config.theme ~= name,
    priority = 1000,
    opts = function()
        vim.g.lualine_theme = name
        return {
            bold_vert_split = false,
            dim_nc_background = false,
            disable_background = config.transparent,
            disable_float_background = false,
            disable_italics = false,
        }
    end,
    config = function() vim.cmd.colorscheme(name) end,
}

poimandres.set = function() end

return poimandres
