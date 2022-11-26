local M = {}
local nnoremap = require('mappings').nnoremap

local highlight_override = function()
  vim.api.nvim_set_hl(0, 'TelescopePromptNormal', { link = 'NeogitHunkHeader' })
  vim.api.nvim_set_hl(0, 'TelescopePromptBorder', { link = 'NeogitHunkHeader' })
  vim.api.nvim_set_hl(0, 'TelescopePromptPrefix', { link = 'diffRemoved' })
  vim.api.nvim_set_hl(0, 'TelescopePromptTitle', { link = 'Substitute' })
  vim.api.nvim_set_hl(0, 'TelescopePreviewTitle', { link = 'Search' })
  vim.api.nvim_set_hl(0, 'TelescopeResultsTitle', { link = 'EndOfBuffer' })
end

local setkeymaps = function()
  local builtins = require 'telescope.builtin'
  local themes = require 'telescope.themes'
  nnoremap '<A-p>' '<cmd>Telescope projects<CR>' {} 'Telescope Projects'
  nnoremap '<leader>tht'(function()
    builtins.help_tags(themes.get_ivy { layout_config = { height = 12 } })
  end) {} 'Telescope Help tags'
  nnoremap '<leader>thk'(function()
    builtins.keymaps(themes.get_ivy { layout_config = { height = 12 } })
  end) {} 'Telescope Keymaps'
  nnoremap '<leader>thi'(function()
    builtins.higlights()
  end) {} 'Telescope Higlights'
  nnoremap '<leader>gb' '<cmd> Telescope git_branches<CR>' {} 'Telescope Git Branches'
  nnoremap '<leader>gc' '<cmd> Telescope git_status<cr>' { silent = true } 'Telescope git changes'
  local ok, _ = pcall(require, 'snap')
  if not ok then
    nnoremap '<leader><space>'(function()
      builtins.fd()
    end) { silent = true } 'Telescope File Finder'
    nnoremap '<leader>fb' '<cmd>Telescope buffers previewer=false theme=dropdown initial_mode=normal<CR>' {
      silent = true,
    } 'Telescope Buffers'
    nnoremap '<leader>fo' '<cmd> Telescope oldfiles<cr>' { silent = true } 'Telescope oldfiles'
    nnoremap '<leader>fg' '<cmd> Telescope live_grep<cr>' { silent = true } 'Telescope live grep'
    nnoremap '<leader>fw' '<cmd> Telescope grep_string<cr>' { silent = true } 'Telescope grep word under cursor'
    nnoremap '<leader>fn'(function()
      builtins.fd {
        cwd = '/Users/chaitanyasharma/Projects/Notes',
        hidden = true,
      }
    end) { silent = true } 'Word Search'
  end
end

M.lsp_keymaps = function()
  local builtins = require 'telescope.builtin'
  local themes = require 'telescope.themes'
  local document_diagnostics_config = {
    layout_config = { height = 12 },
    bufnr = 0,
    initial_mode = 'normal',
  }
  local workspace_diagnostics_config = {
    layout_config = { height = 12, preview_width = 80 },
    initial_mode = 'normal',
  }
  nnoremap '<leader>dd'(function()
    builtins.diagnostics(themes.get_ivy(document_diagnostics_config))
  end) {} 'Document diagnostics'
  nnoremap '<leader>dw'(function()
    builtins.diagnostics(themes.get_ivy(workspace_diagnostics_config))
  end) {} 'Workspace diagnostics'
end

M.setup = function()
  local actions = require 'telescope.actions'

  local mappings = {
    i = {
      ['<c-j>'] = actions.move_selection_next,
      ['<c-k>'] = actions.move_selection_previous,
      ['<esc>'] = actions.close,
    },
    n = {
      ['q'] = actions.close,
      ['<c-c>'] = actions.close,
    },
  }

  require('telescope').setup {
    defaults = {
      border = nil,
      borderchars = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
      color_devicons = true,
      extensions = { file_browser = {} },
      file_ignore_patterns = {},
      file_sorter = require('telescope.sorters').get_fuzzy_file,
      generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
      initial_mode = 'insert',
      layout_config = {
        horizontal = { mirror = false },
        vertical = { mirror = false },
        prompt_position = 'top',
        height = 0.8,
        width = 0.9,
      },
      layout_strategy = 'horizontal',
      mappings = mappings,
      path_display = { shorten = { len = 1, exclude = { -1 } } },
      prompt_prefix = '   ',
      selection_strategy = 'reset',
      set_env = { ['COLORTERM'] = 'truecolor' },
      sorting_strategy = 'ascending',
      winblend = 0,
    },
  }
  setkeymaps()
  highlight_override()
end

return M
