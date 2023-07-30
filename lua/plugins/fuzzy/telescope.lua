local telescope = {}

local highlight_overrides = function()
  local hl = vim.api.nvim_set_hl
  hl(0, 'TelescopePromptPrefix', { link = 'diffRemoved' })
end

local setup_keymaps = function()
  local hashish = require 'hashish'
  local nnoremap = hashish.nnoremap
  local vnoremap = hashish.vnoremap
  local builtin = require 'telescope.builtin'
  local themes = require 'telescope.themes'
  local ivy = themes.get_ivy { layout_config = { height = 12 } }
  local find_notes = function() builtin.fd { cwd = os.getenv 'HOME' .. '/Projects/Notes' } end
  nnoremap '<leader>tht'(function() builtin.help_tags(ivy) end) 'Telescope Help tags'
  nnoremap '<leader>thk'(function() builtin.keymaps(ivy) end) 'Telescope Keymaps'
  nnoremap '<leader>thi'(builtin.highlights) 'Telescope Higlights'
  nnoremap '<leader>gb'(builtin.git_branches) 'Telescope Git Branches'
  nnoremap '<leader>gc'(builtin.git_status) 'Telescope git changes'
  nnoremap '<leader><space>'(builtin.fd) 'Telescope File Finder'
  nnoremap '<leader>n'(find_notes) 'Find notes using telescope'
  nnoremap 'gb' '<cmd>Telescope buffers previewer=false theme=dropdown initial_mode=normal<CR>' 'Telescope Buffers'
  nnoremap 'go'(builtin.oldfiles) 'Telescope oldfiles'
  nnoremap 'gW'(builtin.grep_string) 'Telescope grep word under cursor'
  vnoremap 'gw' '<esc><cmd>lua require("plugins.fuzzy.telescope").search_visual_selection()<cr>' 'Telescope grep visual selection'
  nnoremap 'gw'(function() builtin.grep_string { search = vim.fn.input { prompt = 'Grep > ' } } end) 'Telescope grep and filter'
end

---@diagnostic disable-next-line: unused-function, unused-local
local override_lsp_handler = function()
  local hashish = require 'hashish'
  local nnoremap = hashish.nnoremap
  local capabilities = require 'lsp.capabilities'
  local opts = { bufnr = 0, silent = true }
  capabilities.references.callback = function()
    local theme = require('telescope.themes').get_cursor {
      layout_strategy = 'cursor',
      layout_config = { width = 100, height = 10 },
      previewer = false,
    }
    local lsp_references = function() require('telescope.builtin').lsp_references(theme) end
    nnoremap 'gR'(lsp_references)(opts) 'Find references of symbol under cursor'
  end
  capabilities.definition.callback = function()
    nnoremap 'gd'(require('telescope.builtin').lsp_definitions)(opts) 'Go to definition of symbol under cursor'
  end
  capabilities.implementation.callback = function()
    nnoremap 'gi'(require('telescope.builtin').lsp_implementations)(opts) 'Show implementations of symbol under cursor'
  end
end

telescope = {
  spec = {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = { 'Telescope' },
    event = 'VeryLazy',
    config = function() require('plugins.fuzzy.telescope').setup() end,
  },

  setup = function()
    local actions = require 'telescope.actions'

    local mappings = {
      i = {
        ['<c-j>'] = actions.move_selection_next,
        ['<c-k>'] = actions.move_selection_previous,
        ['<c-d>'] = actions.delete_buffer,
        ['<esc>'] = actions.close,
      },
      n = { ['q'] = actions.close, ['<c-c>'] = actions.close, ['dd'] = actions.delete_buffer },
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
    -- override_lsp_handler()
    setup_keymaps()
    highlight_overrides()

    local dir = '/Users/chaitanyasharma/Projects/Notes'
    require('semantic_search').setup {
      directory = dir,
      embeddings_path = dir .. '/.embeddings',
    }
  end,

  diagnostic_keymaps = function()
    local hashish = require 'hashish'
    local nnoremap = hashish.nnoremap
    local builtins = require 'telescope.builtin'
    local themes = require 'telescope.themes'
    local document_diagnostics_config =
      { layout_config = { height = 12 }, bufnr = 0, initial_mode = 'normal' }
    local workspace_diagnostics_config =
      { layout_config = { height = 12, preview_width = 80 }, initial_mode = 'normal' }

    nnoremap '<leader>dd'(
      function() builtins.diagnostics(themes.get_ivy(document_diagnostics_config)) end
    ) 'Document diagnostics'
    nnoremap '<leader>dw'(
      function() builtins.diagnostics(themes.get_ivy(workspace_diagnostics_config)) end
    ) 'Workspace diagnostics'
  end,
}

telescope.get_visual_selection = function()
  local s_start = vim.fn.getpos "'<"
  local s_end = vim.fn.getpos "'>"
  local n_lines = math.abs(s_end[2] - s_start[2]) + 1
  local lines = vim.api.nvim_buf_get_lines(0, s_start[2] - 1, s_end[2], false)
  lines[1] = string.sub(lines[1], s_start[3], -1)
  if n_lines == 1 then
    lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3] - s_start[3] + 1)
  else
    lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3])
  end
  return table.concat(lines, '\n')
end

telescope.search_visual_selection = function()
  require('telescope.builtin').grep_string {
    search = require('plugins.fuzzy.telescope').get_visual_selection(),
  }
end

return telescope
