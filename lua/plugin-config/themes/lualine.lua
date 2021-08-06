local get_lsp_client = function(msg)
  msg = msg or 'No Active Lsp'
  local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
  local clients = vim.lsp.get_active_clients()
  if next(clients) == nil then
    return msg
  end

  for _, client in ipairs(clients) do
    local filetypes = client.config.filetypes
    local client_name = client.name
    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 and client_name ~=
        "efm" then
      return "  " .. client.name
    end
  end
  return msg
end

local function trailing_whitespace()
  local trail = vim.fn.search("\\s$", "nw")
  if trail ~= 0 then
    return ''
  else
    return nil
  end
end

require('lualine').setup {
  options = {
    -- theme = 'ayu_mirage',
    -- theme = 'github',
    -- theme = 'moonlight',
    -- theme = 'palenight',
    theme = 'tokyonight',
    section_separators = {"", ""},
    component_separators = {"", ""}
    -- disabled_filetypes = {"startify"}
  },
  sections = {
    lualine_a = {{'mode', icon = ''}},
    lualine_b = {
      'branch',
      {'diff', symbols = {added = ' ', modified = ' ', removed = '  '}}
    },
    lualine_c = {
      'filename', trailing_whitespace, {
        'diagnostics',
        sources = {'nvim_lsp'},
        symbols = {error = '   ', warn = '   '}
      }
    },
    lualine_x = {
      {
        'lsp_progress',
        display_components = {'spinner', {'title', 'percentage', 'message'}},
        spinner_symbols = {
          '🌑 ', '🌘 ', '🌗 ', '🌖 ', '🌕 ', '🌔 ', '🌓 ', '🌒 '
        }
      }, get_lsp_client, 'filetype'
    },
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {'nvim-tree'}
}
