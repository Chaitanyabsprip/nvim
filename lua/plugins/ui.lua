local ui = {}
local prequire = require('utils').preq
local nnoremap = prequire('utils').nnoremap

ui.notify = function()
  prequire('notifier').setup {
    ignore_messages = {}, -- Ignore message from LSP servers with this name
    -- status_width = something, -- COmputed using 'columns' and 'textwidth'
    components = { -- Order of the components to draw from top to bottom (first nvim notifications, then lsp)
      'nvim', -- Nvim notifications (vim.notify and such)
      'lsp', -- LSP status updates
    },
    notify = {
      clear_time = 5000, -- Time in milliseconds before removing a vim.notify notification, 0 to make them sticky
      min_level = vim.log.levels.INFO, -- Minimum log level to print the notification
    },
    component_name_recall = true, -- Whether to prefix the title of the notification by the component name
    zindex = 50, -- The zindex to use for the floating window. Note that changing this value may cause visual bugs with other windows overlapping the notifier window
  }
end

ui.bufferline = function()
  prequire('bufferline').setup {
    options = {
      always_show_bufferline = true, -- true | false,
      buffer_close_icon = '',
      close_command = 'bdelete! %d', -- can be a string | function, see "Mouse actions"
      close_icon = '',
      diagnostics = 'nvim_lsp', -- false | "nvim_lsp",
      enforce_regular_tabs = false, -- false | true,
      indicator = {
        icon = '▎',
        style = 'icon',
      },
      left_mouse_command = 'buffer %d', -- can be a string | function, see "Mouse actions"
      left_trunc_marker = '',
      max_name_length = 18,
      max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
      middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
      modified_icon = '●',
      numbers = 'none', -- "none" | "ordinal" | "buffer_id" | "both",
      persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
      right_mouse_command = 'bdelete! %d', -- can be a string | function, see "Mouse actions"
      right_trunc_marker = '',
      separator_style = { '', '' }, -- "slant" | "thick" | "thin" | {'any', 'any'}, [focused and unfocused]. eg: { '|', '|' }
      show_buffer_close_icons = true, -- true | false,
      show_buffer_icons = true, -- true | false, -- disable filetype icons for buffers
      show_close_icon = false, -- true | false,
      show_tab_indicators = true, -- true | false,
      sort_by = 'id', -- 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' |
      tab_size = 18,
      offsets = {
        {
          filetype = 'NvimTree',
          text = 'File Explorer',
          text_align = 'center', -- "left" | "center" | "right"
        },
      },
      name_formatter = function(buf) -- buf contains a "name", "path" and "bufnr"
        if buf.name:match '%.md' then
          return vim.fn.fnamemodify(buf.name, ':t:r')
        end
      end,

      function(buffer_a, buffer_b)
        return buffer_a.modified > buffer_b.modified
      end,
    },
  }

  nnoremap('<S-TAB>', '<CMD>BufferLineCyclePrev<CR>', true)
  nnoremap('<TAB>', '<CMD>BufferLineCycleNext<CR>', true)
  nnoremap('[b', '<CMD>BufferLineMovePrev<CR>', true)
  nnoremap(']b', '<CMD>BufferLineMoveNext<CR>', true)

  for i = 1, 9 do
    nnoremap(
      '<A-' .. i .. '>',
      '<CMD>BufferLineGoToBuffer' .. i .. '<CR>',
      true
    )
  end
end

return ui
