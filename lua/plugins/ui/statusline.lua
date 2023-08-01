---@diagnostic disable: undefined-field
local statusline = {}

local function get_lsp_client(msg)
  msg = msg or 'No Active Lsp'
  local buf_ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
  local clients = vim.lsp.get_clients()
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

local function clock() return ' ' .. os.date '%H:%M' end

statusline.lualine = {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  opts = {
    options = {
      component_separators = { '', '' },
      globalstatus = true,
      section_separators = '',
      theme = vim.g.lualine_theme or 'auto',
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
  },
}

statusline = statusline.lualine

return statusline
