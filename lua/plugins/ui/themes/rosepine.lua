local config = require 'config.theme'
local name = 'rosepine'

local highlight = {
    ColorColumn = { bg = '#1c1a30' },
    CmpItemAbbr = { fg = 'subtle' },
    CmpItemAbbrDeprecated = { fg = 'subtle' },
    CmpItemAbbrMatch = { fg = 'iris' },
    CmpItemAbbrMatchFuzzy = { fg = 'iris' },
    CmpItemKind = { fg = 'base', bg = 'iris' },
    CmpItemKindClass = { fg = 'base', bg = 'gold' },
    CmpItemKindColor = { fg = 'base', bg = 'love' },
    CmpItemKindConstant = { fg = 'base', bg = 'rose' },
    CmpItemKindConstructor = { fg = 'base', bg = 'foam' },
    CmpItemKindCopilot = { fg = 'base', bg = 'iris' },
    CmpItemKindEnum = { fg = 'base', bg = 'pine' },
    CmpItemKindEnumMember = { fg = 'base', bg = 'love' },
    CmpItemKindEvent = { fg = 'base', bg = 'foam' },
    CmpItemKindField = { fg = 'base', bg = 'pine' },
    CmpItemKindFile = { fg = 'base', bg = 'foam' },
    CmpItemKindFolder = { fg = 'base', bg = 'foam' },
    CmpItemKindFunction = { fg = 'base', bg = 'iris' },
    CmpItemKindInterface = { fg = 'base', bg = 'gold' },
    CmpItemKindKeyword = { fg = 'base', bg = 'love' },
    CmpItemKindMethod = { fg = 'base', bg = 'iris' },
    CmpItemKindModule = { fg = 'base', bg = 'foam' },
    CmpItemKindOperator = { fg = 'base', bg = 'foam' },
    CmpItemKindProperty = { fg = 'base', bg = 'pine' },
    CmpItemKindReference = { fg = 'base', bg = 'love' },
    CmpItemKindSnippet = { fg = 'base', bg = 'iris' },
    CmpItemKindStruct = { fg = 'base', bg = 'foam' },
    CmpItemKindText = { fg = 'base', bg = 'iris' },
    CmpItemKindTypeParameter = { fg = 'base', bg = 'foam' },
    CmpItemKindUnit = { fg = 'base', bg = 'pine' },
    CmpItemKindValue = { fg = 'base', bg = 'rose' },
    CmpItemKindVariable = { fg = 'base', bg = 'foam' },
    TelescopeBorder = { fg = 'surface', bg = 'surface' },
    TelescopeNormal = { bg = 'surface', fg = 'muted' },
    TelescopePromptCounter = { fg = 'text', bg = 'base' },
    TelescopePromptBorder = { fg = 'base', bg = 'base' },
    TelescopePromptNormal = { fg = 'text', bg = 'base' },
    TelescopePromptPrefix = { fg = 'gold' },
    TelescopeMatching = { fg = 'text' },
    TelescopeSelection = { fg = 'muted', bg = 'overlay' },
    TelescopeSelectionCaret = { fg = 'rose', bg = 'overlay' },
    TelescopeTitle = { fg = 'muted', bg = 'love' },
    TelescopePreviewTitle = { fg = 'base', bg = 'iris' },
    TelescopePromptTitle = { fg = 'base', bg = 'love' },
    TelescopeResultsTitle = { fg = 'base', bg = 'foam' },
    NotifyBackground = { bg = 'base' },
    MatchParen = { fg = 'none', bg = 'highlight_med' },
    LeapBackdrop = { fg = '#545c7e' },
    Headline1 = { fg = 'iris', bg = 'base', bold = true },
    Headline2 = { fg = 'foam', bg = 'base', bold = true },
    Headline3 = { fg = 'rose', bg = 'base', bold = true },
    Headline4 = { fg = 'gold', bg = 'base', bold = true },
    Headline5 = { fg = 'pine', bg = 'base', bold = true },
    Headline6 = { fg = 'love', bg = 'base', bold = true },
}

---@class Colorscheme
local rosepine = {
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = config.theme ~= name,
    priority = 1000,
    opts = function()
        vim.g.lualine_theme = 'rose-pine'
        return {
            dark_variant = 'main',
            disable_background = config.transparent,
            disable_float_background = true,
            highlight_groups = highlight,
        }
    end,
    config = function(_, opts)
        require('rose-pine').setup(opts)
        vim.cmd.colorscheme 'rose-pine'
    end,
}

rosepine.set = function() end

return rosepine
