local config = require 'config.theme'

local name = 'koda'

---@module "lazy"
---@type LazySpec
return {
    'oskarnurm/koda.nvim',
    lazy = config.theme ~= name,
    priority = 1000, -- make sure to load this before all the other start plugins
    opts = {
        transparent = config.transparent,
        styles = {
            functions = { bold = false },
        },
        colors = {
            -- bg = '#07080d',
            -- fg = '#808080',
            -- line = '#131521',
            -- keyword = '#444444',
        },
    },
    config = function(_, opts)
        require(name).setup(opts)
        vim.cmd.colorscheme(name)
    end,
}
