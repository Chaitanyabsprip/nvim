local ui = {}

local config = require 'config.ui'

ui.colorscheme = require('plugins.ui.themes.' .. config.theme)
ui.statusline = require 'plugins.ui.statusline'

ui.incline = {
  'b0o/incline.nvim',
  dependencies = { 'folke/tokyonight.nvim' },
  event = 'BufReadPre',
  opts = function()
    local function get_diagnostic_label(bufnr)
      local icons = { error = '', warn = '', info = '', hint = '' }
      local label = {}
      for severity, icon in pairs(icons) do
        local n =
          #vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity[string.upper(severity)] })
        if n > 0 then
          table.insert(label, { icon .. ' ' .. n .. ' ', group = 'DiagnosticSign' .. severity })
        end
      end
      if #label > 0 then table.insert(label, { '| ' }) end
      return label
    end
    local function get_git_diff(bufnr)
      local icons = { removed = '', changed = '', added = '' }
      local labels = {}
      local signs = vim.api.nvim_buf_get_var(bufnr, 'gitsigns_status_dict')
      for name, icon in pairs(icons) do
        if tonumber(signs[name]) and signs[name] > 0 then
          table.insert(labels, { icon .. ' ' .. signs[name] .. ' ', group = 'Diff' .. name })
        end
      end
      if #labels > 0 then table.insert(labels, { '| ' }) end
      return labels
    end

    local colors = require('tokyonight.colors').setup()

    return {
      highlight = {
        groups = {
          InclineNormal = { guibg = colors.black, guifg = colors.purple },
          InclineNormalNC = { guifg = colors.purple, guibg = colors.black },
        },
      },
      window = {
        margin = { horizontal = 2, vertical = 0 },
        options = { winblend = 5 },
        padding = 0,
      },
      render = function(props)
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
        local icon, color = require('nvim-web-devicons').get_icon_color(filename)
        local modified = vim.api.nvim_get_option_value('modified', { buf = props.buf }) and { '~ ' }
          or { '' }
        return {
          props.focused and { '▍ ', group = 'VertSplit' } or { ' ' },
          { get_diagnostic_label(props.buf) },
          { get_git_diff(props.buf) },
          modified,
          { icon, guifg = color },
          { ' ' },
          filename,
        }
      end,
    }
  end,
}

return {
  ui.incline,
  ui.colorscheme.spec,
  ui.statusline,
}
