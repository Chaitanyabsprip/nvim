local config = require 'config.ui'

local name = 'material'

---@class Colorscheme
local material = {
  'marko-cerovac/material.nvim',
  lazy = config.theme ~= name,
  priority = 1000,
  opts = function()
    vim.g.lualine_theme = name
    ---@diagnostic disable-next-line: no-unknown
    local colors = require 'material.colors'
    vim.g.material_style = 'deep ocean'
    return {
      contrast = {
        terminal = true,
        sidebars = true,
        floating_windows = true,
        non_current_windows = false,
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
  config = function(_, opts)
    require('material').setup(opts)
    vim.cmd.colorscheme 'material'
  end,
}

function material.set() end

return material
