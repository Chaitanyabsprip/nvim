local config = require 'config.theme'

local name = 'oxocarbon'

---@type LazySpec
return {
    'nyoom-engineering/oxocarbon.nvim',
    lazy = config.theme ~= name,
    priority = 1000,
    config = function()
        vim.g.lualine_theme = name
        vim.cmd.colorscheme(name)
    end,
}
