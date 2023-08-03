local config = require 'config.ui'

---@class Colorscheme
local material = {}
local name = 'material'

vim.g.lualine_theme = 'material-stealth'

material.spec = {
  'marko-cerovac/material.nvim',
  lazy = config.theme ~= name,
  priority = 1000,
  opts = function()
    vim.g.material_style = 'deep ocean'
    ---@diagnostic disable-next-line: no-unknown
    local colors = require 'material.colors'
    return {
      contrast = {
        terminal = true,
        sidebars = true,
        floating_windows = true,
        non_current_windows = true,
      },
      disable = { background = config.transparent },
      styles = { comments = { italic = true } },
      plugins = {
        'dap',
        'dashboard',
        'gitsigns',
        'neogit',
        'mini',
        'nvim-cmp',
        'nvim-navic',
        'nvim-tree',
        'nvim-web-devicons',
        'telescope',
      },
      custom_highlights = {
        ---@diagnostic disable-next-line: no-unknown
        NotifyBackground = { bg = colors.editor.bg, fg = colors.editor.fg },
        CursorLine = { bg = '#1a1c25' },
        LeapBackdrop = { fg = '#545c7e' },
        ['@text.reference'] = { fg = 'cyan' },
      },
    }
  end,
}

function material.set()
  if package.loaded['material'] then vim.cmd.colorscheme 'material' end
end

return material
