local config = require 'config.ui'
---@class Colorscheme
local material = {}

vim.g.lualine_theme = 'material-nvim'

material.spec = {
  'marko-cerovac/material.nvim',
  lazy = false,
  priority = 1000,
  opts = function()
    vim.g.material_style = 'deep ocean'
    local colors = require 'material.colors'
    return {
      contrast = {
        terminal = true, -- Enable contrast for the built-in terminal
        sidebars = true, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
        floating_windows = true, -- Enable contrast for floating windows
        non_current_windows = true, -- Enable contrasted background for non-current windows
      },
      disable = { background = config.transparent },
      styles = { -- Give comments style such as bold, italic, underline etc.
        comments = { italic = true },
        -- strings = { bold = true },
      },
      plugins = { 'dap', 'gitsigns', 'mini', 'nvim-cmp', 'nvim-navic', 'nvim-tree', 'telescope' },
      custom_highlights = {
        NotifyBackground = { bg = colors.editor.bg, fg = colors.editor.fg },
        CursorLine = { bg = '#1a1c25' },
        LeapBackdrop = { fg = '#545c7e' },
        ['@text.reference'] = { fg = 'cyan' },
      },
    }
  end,
}

function material.set() vim.cmd.colorscheme 'material' end

return material
