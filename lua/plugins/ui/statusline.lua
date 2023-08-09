---@diagnostic disable: undefined-field
local statusline = {}

statusline.lualine = {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  opts = function()
    local function get_lsp_client(_)
      ---@type any?{}
      local client_names = {}
      local msg = 'No Active Lsp'
      local clients = vim.lsp.get_clients { bufnr = 0 }
      if next(clients) == nil then return msg end
      for _, client in ipairs(clients) do
        table.insert(client_names, client.name)
      end
      return #client_names == 0 and msg or table.concat(client_names, ' | ')
    end
    local function wordcount() return tostring(vim.fn.wordcount().words) .. ' words' end
    local function readingtime()
      return tostring(math.ceil(vim.fn.wordcount().words / 200.0)) .. ' min'
    end
    local function is_markdown()
      return vim.bo.filetype == 'markdown' or vim.bo.filetype == 'asciidoc'
    end
    local function navic() return require('nvim-navic').get_location() end
    local function navic_is_available()
      return package.loaded['nvim-navic'] and require('nvim-navic').is_available()
    end
    local cmd_mode = function() return require('noice').api.status.mode.get() end
    local show_mode = function()
      return package.loaded['noice'] and require('noice').api.status.mode.has() or ''
    end
    return {
      options = {
        component_separators = { '', '' },
        globalstatus = true,
        section_separators = '',
        theme = vim.g.lualine_theme or 'auto',
      },
      sections = {
        lualine_a = { 'branch' },
        lualine_b = {
          { get_lsp_client, icon = '', on_click = function() vim.cmd [[LspInfo]] end },
        },
        lualine_c = { { navic, cond = navic_is_available } },
        lualine_x = { { cmd_mode, cond = show_mode }, 'filetype' },
        lualine_y = { { wordcount, cond = is_markdown }, { readingtime, cond = is_markdown } },
        lualine_z = { { 'datetime', style = '%R', icon = '', color = { gui = 'bold' } } },
      },
      extensions = { 'lazy', 'nvim-dap-ui', 'nvim-tree', 'toggleterm', 'c_quickfix' },
    }
  end,
}

statusline.bufferline = {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  opts = function()
    return {
      options = {
        mode = 'tabs',
        style_preset = require('bufferline').style_preset.minimal,
        always_show_bufferline = false,
      },
    }
  end,
  event = #vim.fn.gettabinfo() > 1 and 'VeryLazy' or 'TabNew',
}

return { statusline.lualine, statusline.bufferline }
