---@diagnostic disable: no-unknown
local config = require 'config.theme'
local utils = require 'utils'

local name = 'catppuccin'
local function highlight(c)
    return {
        CmpItemKindConstructor = { fg = c.base, bg = c.blue },
        CmpItemKindEvent = { fg = c.base, bg = c.blue },
        CmpItemKindFile = { fg = c.base, bg = c.blue },
        CmpItemKindFolder = { fg = c.base, bg = c.blue },
        CmpItemKindFunction = { fg = c.base, bg = c.blue },
        CmpItemKindMethod = { fg = c.base, bg = c.blue },
        CmpItemKindModule = { fg = c.base, bg = c.blue },
        CmpItemKindOperator = { fg = c.base, bg = c.blue },
        CmpItemKindStruct = { fg = c.base, bg = c.blue },
        CmpItemKindTypeParameter = { fg = c.base, bg = c.blue },
        CmpItemKindEnum = { fg = c.base, bg = c.green },
        CmpItemKindField = { fg = c.base, bg = c.green },
        CmpItemKindProperty = { fg = c.base, bg = c.green },
        CmpItemKindUnit = { fg = c.base, bg = c.green },
        CmpItemKindKeyword = { fg = c.base, bg = c.red },
        CmpItemKindReference = { fg = c.base, bg = c.red },
        CmpItemKindEnumMember = { fg = c.base, bg = c.red },
        CmpItemKindColor = { fg = c.base, bg = c.red },
        CmpItemKindClass = { fg = c.base, bg = c.yellow },
        CmpItemKindInterface = { fg = c.base, bg = c.yellow },
        CmpItemKindValue = { fg = c.base, bg = c.peach },
        CmpItemKindConstant = { fg = c.base, bg = c.peach },
        CmpItemKindCopilot = { fg = c.base, bg = c.teal },
        CmpItemKindText = { fg = c.base, bg = c.teal },
        CmpItemKindSnippet = { fg = c.base, bg = c.mauve },
        CmpItemKindVariable = { fg = c.base, bg = c.flamingo },
        NotifyBackground = { bg = c.base, fg = c.text },
        LeapBackdrop = { fg = '#545c7e' },
        TelescopePromptPrefix = { bg = c.surface0, fg = c.red },
        TelescopePromptNormal = { bg = c.surface0 },
        TelescopePromptBorder = { bg = c.surface0 },
        TelescopePreviewTitle = { bg = utils.darken(c.sky, 0.30, c.base), fg = c.text },
        TelescopePromptTitle = { bg = c.red, fg = c.crust },
        TelescopeResultsTitle = { bg = c.mantle, fg = c.mantle },
        TelescopeNormal = { bg = c.mantle },
        TelescopeBorder = { bg = c.mantle },
    }
end

---@class Colorscheme: LazyPluginSpec
---@field set function
local catppuccin = {
    'catppuccin/nvim',
    name = name,
    lazy = config.theme ~= name,
    priority = 1000,
    opts = function()
        vim.g.lualine_theme = name
        return {
            flavor = 'mocha',
            term_colors = true,
            transparent_background = config.transparent,
            custom_highlights = highlight,
            integrations = {
                dap = { enabled = true, enable_ui = true },
                gitsigns = true,
                harpoon = true,
                headlines = true,
                leap = true,
                markdown = true,
                mason = true,
                mini = true,
                navic = { enabled = true },
                neotest = true,
                noice = true,
                notify = true,
                nvimtree = true,
                semantic_tokens = true,
                treesitter = true,
                ts_rainbow = true,
            },
        }
    end,
    config = function(_, opts)
        require(name).setup(opts)
        vim.cmd.colorscheme(name)
    end,
}

function catppuccin.set() end

return catppuccin
