local statusline = {}

local function get_lsp_client(msg)
  msg = msg or 'No Active Lsp'
  local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
  local clients = vim.lsp.get_active_clients()
  if next(clients) == nil then return msg end
  for _, client in ipairs(clients) do
    local filetypes = client.config.filetypes
    local client_name = client.name
    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 and client_name ~= 'null-ls' then
      return '  ' .. client.name
    end
  end
  return msg
end

local function trailing_whitespace()
  local trail = vim.fn.search('\\s$', 'nw')
  if trail ~= 0 then
    return ''
  else
    return ''
  end
end

local function theme()
  if vim.g.colors_name == 'noirbuddy' then return require('noirbuddy.plugins.lualine').theme end
  if vim.g.colors_name == 'material' then return 'material-nvim' end
  return 'auto'
end

local function clock() return ' ' .. os.date '%H:%M' end

statusline.lualine = {
  spec = {
    'hoob3rt/lualine.nvim',
    config = function() require('plugins.ui.statusline').setup() end,
    event = 'VeryLazy',
  },
  setup = function()
    require('lualine').setup {
      options = {
        component_separators = { '', '' },
        disabled_filetypes = {},
        globalstatus = true,
        section_separators = '',
        theme = theme(),
      },
      sections = {
        lualine_a = {
          {
            'mode',
            icon = '',
            fmt = function(mode_name) return mode_name:sub(1, 1) end,
          },
        },
        lualine_b = {
          'branch',
          {
            'diff',
            symbols = { added = ' ', modified = ' ', removed = '  ' },
          },
        },
        lualine_c = {
          'filename',
          trailing_whitespace,
          {
            'diagnostics',
            sources = { 'nvim_diagnostic' },
            symbols = { error = '   ', warn = '   ' },
          },
        },
        lualine_x = {
          get_lsp_client,
          'filetype',
        },
        lualine_y = { 'location' },
        lualine_z = { clock },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = { 'nvim-tree', 'toggleterm' },
    }
  end,
}

statusline.setup = statusline.lualine.setup
statusline.spec = statusline.lualine.spec

return statusline
