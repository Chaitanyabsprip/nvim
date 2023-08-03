---@diagnostic disable: undefined-field
local statusline = {}
---@type any?{}
local client_names = {}

local function get_lsp_client(_)
  local count = #client_names
  for i = 0, count do
    ---@diagnostic disable-next-line: no-unknown
    client_names[i] = nil
  end
  local msg = 'No Active Lsp'
  local clients = vim.lsp.get_clients { bufnr = 0 }
  if next(clients) == nil then return msg end
  for _, client in ipairs(clients) do
    table.insert(client_names, client.name)
  end
  return #client_names == 0 and msg or table.concat(client_names, ' | ')
end

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
      lualine_b = {},
      lualine_c = {
        { get_lsp_client, icon = '', on_click = function() vim.cmd [[LspInfo]] end },
      },
      lualine_x = {
        {
          function() return require('noice').api.status.mode.get() end,
          cond = function()
            return package.loaded['noice'] and require('noice').api.status.mode.has()
          end,
        },
        'filetype',
      },
      lualine_y = {},
      lualine_z = { { 'datetime', style = '%R', icon = '', color = { gui = 'bold' } } },
    },
    extensions = { 'lazy', 'nvim-dap-ui', 'nvim-tree', 'toggleterm', 'quickfix' },
  },
}

statusline = statusline.lualine

return statusline
