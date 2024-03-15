---@diagnostic disable: no-unknown
local config = require 'config.theme'

local name = 'darcubox'

---@class Colorscheme: LazyPluginSpec
local darcubox = {
    'dotsilas/darcubox-nvim',
    lazy = config.theme ~= name,
    priority = 1000,
    config = function()
        require('darcubox').setup {
            options = {
                transparent = config.transparent,
            },
        }
        vim.cmd.colorscheme(name)
    end,
}

return darcubox
