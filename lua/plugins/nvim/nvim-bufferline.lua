local u = require 'utils'
local p = require 'rose-pine.palette'
local nnoremap = require('utils').nnoremap

require('bufferline').setup {
  options = {
    always_show_bufferline = true, -- true | false,
    buffer_close_icon = '',
    close_command = 'bdelete! %d', -- can be a string | function, see "Mouse actions"
    close_icon = '',
    diagnostics = 'nvim_lsp', -- false | "nvim_lsp",
    enforce_regular_tabs = false, -- false | true,
    indicator_icon = '▎',
    left_mouse_command = 'buffer %d', -- can be a string | function, see "Mouse actions"
    left_trunc_marker = '',
    max_name_length = 18,
    max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
    middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
    modified_icon = '●',
    -- number_style = "subscript", -- superscript" | "" | { "none", "subscript" }, -- buffer_id at index 1, ordinal at index 2
    numbers = 'none', -- "none" | "ordinal" | "buffer_id" | "both",
    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
    right_mouse_command = 'bdelete! %d', -- can be a string | function, see "Mouse actions"
    right_trunc_marker = '',
    separator_style = 'thin', -- "slant" | "thick" | "thin" | {'any', 'any'}, [focused and unfocused]. eg: { '|', '|' }
    show_buffer_close_icons = true, -- true | false,
    show_buffer_icons = true, -- true | false, -- disable filetype icons for buffers
    show_close_icon = false, -- true | false,
    show_tab_indicators = true, -- true | false,
    sort_by = 'id', -- 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' |
    tab_size = 18,

    custom_areas = {
      right = function()
        local result = {}
        local error = vim.lsp.diagnostic.get_count(0, [[Error]])
        local warning = vim.lsp.diagnostic.get_count(0, [[Warning]])
        local info = vim.lsp.diagnostic.get_count(0, [[Information]])
        local hint = vim.lsp.diagnostic.get_count(0, [[Hint]])
        local day = os.date():sub(0, 3)
        local date = os.date():sub(8, 10)
        local month = os.date():sub(4, 7)
        local time = os.date():sub(11, 16)
        if error ~= 0 then
          table.insert(result, {
            gui = 'NONE',
            guibg = p.highlight_inactive,
            guifg = p.love,
            text = '  ' .. error .. ' ',
          })
        end
        if warning ~= 0 then
          table.insert(result, {
            gui = 'NONE',
            guibg = p.highlight_inactive,
            guifg = p.gold,
            text = '  ' .. warning .. ' ',
          })
        end
        if hint ~= 0 then
          table.insert(result, {
            gui = 'NONE',
            guibg = p.highlight_inactive,
            guifg = p.iris,
            text = '  ' .. hint .. ' ',
          })
        end
        if info ~= 0 then
          table.insert(result, {
            gui = 'NONE',
            guibg = p.highlight_inactive,
            guifg = p.foam,
            text = '  ' .. info .. ' ',
          })
        end
        table.insert(result, {
          gui = 'NONE',
          guibg = p.highlight,
          guifg = p.rose,
          text = ' ' .. day .. ',' .. date .. month .. ' ',
        })
        table.insert(result, {
          gui = 'NONE',
          guibg = p.rose,
          guifg = p.base,
          text = time .. ' ',
        })
        return result
      end,
    },

    ---@diagnostic disable-next-line: unused-local
    custom_filter = function(buf_number)
      -- filter out filetypes you don't want to see
      -- if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
      --   return true
      -- end
      -- filter out by buffer name
      -- if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
      --   return true
      -- end
      -- filter out based on arbitrary rules
      -- e.g. filter out vim wiki buffer from tabline in your work repo
      -- if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~=
      --     "wiki" then
      --   return true
      -- end
      return true
    end,

    ---@diagnostic disable-next-line: unused-local
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local icon = level:match 'error' and ' ' or ' '
      return ' ' .. icon .. count
    end,

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

nnoremap('<A-S-b>', '<CMD>BufferLineCyclePrev<CR>', true)
nnoremap('<A-b>', '<CMD>BufferLineCycleNext<CR>', true)
nnoremap('[b', '<CMD>BufferLineMovePrev<CR>', true)
nnoremap(']b', '<CMD>BufferLineMoveNext<CR>', true)
nnoremap('<leader>b', '<CMD>BufferLinePick<CR>', true)
nnoremap('<leader>x', ':bd<CR>', true)

for i = 1, 9 do
  nnoremap('<A-' .. i .. '>', '<CMD>BufferLineGoToBuffer' .. i .. '<CR>', true)
end
