---@diagnostic disable: undefined-field
local statusline = {}

local function get_lsp_client(_)
  local msg = 'No Active Lsp'
  local filetype = vim.api.nvim_get_option_value('filetype', { buf = 0 })
  local clients = vim.lsp.get_clients()
  if next(clients) == nil then return msg end
  for _, client in ipairs(clients) do
    ---@type table
    local filetypes = client.config.filetypes
    local client_name = client.name
    if filetypes and vim.fn.index(filetypes, filetype) ~= -1 and client_name ~= 'null-ls' then
      return client.name or msg
    end
  end
  return msg
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
