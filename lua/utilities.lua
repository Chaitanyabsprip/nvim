local M = {}
local nnoremap = require('utils').nnoremap
local bmap = require('utils').bmap
local ntst = require('utils').ntst

M.highlight = function()
  local high_str = require 'high-str'
  high_str.setup {
    verbosity = 0,
    saving_path = '/tmp/highstr/',
    highlight_colors = {
      -- color_id = {"bg_hex_code",<"fg_hex_code"/"smart">}
      color_0 = { '#0c0d0e', 'smart' }, -- Cosmic charcoal
      color_1 = { '#e5c07b', 'smart' }, -- Pastel yellow
      color_2 = { '#7FFFD4', 'smart' }, -- Aqua menthe
      color_3 = { '#8A2BE2', 'smart' }, -- Proton purple
      color_4 = { '#FF4500', 'smart' }, -- Orange red
      color_5 = { '#008000', 'smart' }, -- Office green
      color_6 = { '#0000FF', 'smart' }, -- Just blue
      color_7 = { '#FFC0CB', 'smart' }, -- Blush pink
      color_8 = { '#FFF9E3', 'smart' }, -- Cosmic latte
      color_9 = { '#7d5c34', 'smart' }, -- Fallow brown
    },
  }
end

M.jabs = function()
  local ui = vim.api.nvim_list_uis()[1]
  require('jabs').setup {
    position = 'corner', -- center, corner
    width = 70,
    height = 10,
    border = 'rounded', -- none, single, double, rounded, solid, shadow, (or an array or chars)
    preview_position = 'bottom', -- top, bottom, left, right
    preview = {
      width = 100,
      height = 30,
      border = 'double', -- none, single, double, rounded, solid, shadow, (or an array or chars)
    },
    col = ui.width * 0.65, -- Window appears on the right
    row = ui.height * 0.73, -- Window appears in the vertical middle
  }
  nnoremap('<c-b>', '<cmd>JABS<cr>', true)
end

M.twilight = function()
  require('twilight').setup {
    dimming = {
      alpha = 0.25,
      inactive = true,
    },
    context = 15,
  }
end

M.venn = function()
  bmap(0, '', '<a-v>', "<cmd>lua require('utilities').toggle_venn()<cr>", ntst)
end

M.toggle_venn = function()
  local venn_enabled = vim.inspect(vim.b.venn_enabled)
  if venn_enabled == 'nil' then
    vim.b.venn_enabled = true
    vim.cmd [[setlocal ve=all]]
    vim.api.nvim_buf_set_keymap(0, 'v', 'b', ':VBox<CR>', { noremap = true })
  else
    vim.cmd [[setlocal ve=]]
    vim.cmd [[mapclear <buffer>]]
    vim.b.venn_enabled = nil
  end
end

M.which_key = function()
  require('which-key').setup {
    plugins = {
      spelling = {
        enabled = true,
        suggestions = 20,
      },
      presets = {
        operators = true,
        motions = true,
        text_objects = true,
        windows = true,
        nav = true,
        z = true,
        g = true,
      },
    },
  }
end

M.zen_mode = function()
  require('zen-mode').setup {
    window = {
      backdrop = 0.75,
      width = 0.8,
    },
    plugins = {
      gitsigns = { enabled = true },
      kitty = { enabled = true, font = '+4' },
    },
    on_open = function(_)
      print 'ZEN MODE'
    end,
    on_close = function()
      print 'NORMAL MODE'
    end,
  }
end

return M
