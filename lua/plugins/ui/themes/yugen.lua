local config = require 'config.theme'
local name = 'yugen'

---@type LazySpec
return {
    'bettervim/yugen.nvim',
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
    config = function()
        vim.cmd.colorscheme(name)
        vim.api.nvim_set_hl(0, 'ColorColumn', { bg = '#0D0D0D' })
    end,
}
