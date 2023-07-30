local tabline = {}
local nnoremap = require('hashish').nnoremap

tabline.bufferline = {
  spec = {
    'akinsho/bufferline.nvim',
    version = 'v2.*',
    config = function() require('plugs.ui.tabline').setup() end,
    event = 'BufReadPre',
  },

  setup = function()
    require('bufferline').setup {
      options = {
        always_show_bufferline = true,
        color_icons = true,
        diagnostics = 'nvim_lsp',
        enforce_regular_tabs = false,
        indicator = { icon = '▎', style = 'icon' },
        left_mouse_command = 'buffer %d',
        modified_icon = '●',
        numbers = 'none',
        separator_style = { '', '' },
        show_close_icon = false,
        show_tab_indicators = true,
        sort_by = 'id',
        tab_size = 18,
        function(buffer_a, buffer_b) return buffer_a.modified > buffer_b.modified end,
      },
    }

    nnoremap '<S-TAB>' '<CMD>BufferLineCyclePrev<CR>' 'Previous buffer'
    nnoremap '<TAB>' '<CMD>BufferLineCycleNext<CR>' 'Next buffer'
    nnoremap '[b' '<CMD>BufferLineMovePrev<CR>' 'Swap buffer position with previous buffer'
    nnoremap ']b' '<CMD>BufferLineMoveNext<CR>' 'Swap buffer position with next buffer'

    for i = 1, 9 do
      nnoremap('<A-' .. i .. '>')('<CMD>BufferLineGoToBuffer' .. i .. '<CR>') {}(
        'Jump to buffer' .. i
      )
    end
  end,
}

tabline.spec = tabline.bufferline.spec
tabline.setup = tabline.bufferline.setup

return tabline
