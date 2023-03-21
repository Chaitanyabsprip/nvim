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

local function theme()
  if vim.g.colors_name == 'noirbuddy' then return require('noirbuddy.plugins.lualine').theme end
  if vim.g.colors_name == 'material' then return 'material-nvim' end
  if vim.g.colors_name == 'rose-pine' then return 'rose-pine' end
  if vim.g.colors_name == 'catppuccin' then return 'catppuccin' end
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
        globalstatus = true,
        section_separators = '',
        theme = theme(),
      },
      sections = {
        lualine_a = { 'branch' },
        lualine_b = { get_lsp_client },
        lualine_c = {},
        lualine_x = { 'filetype' },
        lualine_y = { 'location' },
        lualine_z = { { clock, color = { gui = 'bold' } } },
      },
      extensions = { 'nvim-tree', 'toggleterm' },
    }
  end,
}

statusline.setup = statusline.lualine.setup
statusline.spec = statusline.lualine.spec

return statusline
