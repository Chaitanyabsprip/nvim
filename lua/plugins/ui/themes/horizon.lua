local config = require 'config.theme'

local name = 'horizon'

---@class Colorscheme
horizon = {
    'akinsho/horizon.nvim',
    version = '*',
    lazy = config.theme ~= name,
    priority = 1000,
    opts = function()
        vim.g.lualine_theme = name
        return {
            plugins = {
                cmp = true,
                indent_blankline = false,
                nvim_tree = true,
                telescope = true,
                which_key = true,
                barbar = false,
                notify = true,
                symbols_outline = false,
                neo_tree = false,
                gitsigns = true,
                crates = false,
                hop = false,
                navic = true,
                quickscope = true,
                flash = true,
            },
        }
    end,
    config = function(_, opts)
        require(name).setup(opts)
        vim.cmd.colorscheme(name)
    end,
}

function horizon.set() end

return horizon
