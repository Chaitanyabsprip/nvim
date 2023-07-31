local config = require 'config.ui'

---@class Colorscheme
local kanagawa = {}

vim.g.lualine_theme = 'kanagawa'

kanagawa.spec = {
  'rebelot/kanagawa.nvim',
  lazy = false,
  opts = {
    -- compile = false, -- enable compiling the colorscheme
    -- undercurl = true, -- enable undercurls
    -- commentStyle = { italic = true },
    -- functionStyle = {},
    -- keywordStyle = { italic = true },
    -- statementStyle = { bold = true },
    -- typeStyle = {},
    transparent = config.transparent, -- do not set background color
    -- dimInactive = false, -- dim inactive window `:h hl-NormalNC`
    -- terminalColors = true, -- define vim.g.terminal_color_{0,17}
    -- colors = { -- add/modify theme and palette colors
    --   palette = {},
    --   theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
    -- },
    ---@diagnostic disable-next-line: unused-local
    -- overrides = function(colors) -- add/modify highlights
    --   return {}
    -- end,
    -- theme = 'dragon', -- Load "wave" theme when 'background' option is not set
    -- background = { -- map the value of 'background' option to a theme
    --   dark = 'dragon', -- try "dragon" !
    --   light = 'lotus',
    -- },
  },
}

kanagawa.set = function() vim.cmd.colorscheme 'kanagawa' end

return kanagawa
