local config = require 'config.theme'
local name = 'tundra'

---@class Colorscheme
local tundra = {
    'sam4llis/nvim-tundra',
    lazy = config.theme ~= name,
    priority = 1000,
    opts = function()
        vim.g.lualine_theme = name
        return {
            transparent_background = config.transparent,
            dim_inactive_windows = { enabled = true, color = '#0f111a' },
            sidebars = { enabled = true, color = nil },
            editor = { search = {}, substitute = {} },
            syntax = {
                booleans = { bold = true, italic = true },
                comments = { bold = true, italic = true },
                conditionals = {},
                constants = { bold = true },
                fields = {},
                functions = {},
                keywords = {},
                loops = {},
                numbers = { bold = true },
                operators = { bold = true },
                punctuation = {},
                strings = {},
                types = { italic = true },
            },
            diagnostics = { errors = {}, warnings = {}, information = {}, hints = {} },
            plugins = {
                lsp = true,
                semantic_tokens = true,
                treesitter = true,
                telescope = true,
                nvimtree = true,
                cmp = true,
                context = false,
                dbui = false,
                gitsigns = true,
                neogit = true,
                textfsm = false,
            },
            overwrite = {
                colors = { gray = { _900 = '#0f111a' } },
                highlights = { LspInlayHint = { link = 'Comment' } },
            },
        }
    end,
    config = function(_, opts)
        require('tundra').setup(opts)
        vim.g.tundra_biome = 'arctic'
        vim.cmd.colorscheme(name)
    end,
}
tundra.set = function() end

return tundra
