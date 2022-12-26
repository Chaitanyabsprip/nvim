local explorer = {}
local nnoremap = require('mappings.hashish').nnoremap

local highlight_override = function()
  local hl = vim.api.nvim_set_hl
  hl(0, 'TelescopePromptNormal', { link = 'NeogitHunkHeader' })
  hl(0, 'TelescopePromptBorder', { link = 'NeogitHunkHeader' })
  hl(0, 'TelescopePromptPrefix', { link = 'diffRemoved' })
  hl(0, 'TelescopePromptTitle', { link = 'Substitute' })
  hl(0, 'TelescopePreviewTitle', { link = 'Search' })
  hl(0, 'TelescopeResultsTitle', { link = 'EndOfBuffer' })
end

local setkeymaps = function()
  local builtins = require 'telescope.builtin'
  local themes = require 'telescope.themes'
  local ivy = themes.get_ivy { layout_config = { height = 12 } }
  local find_notes =
    function() builtins.fd { cwd = '/Users/chaitanyasharma/Projects/Notes', hidden = true } end
  nnoremap '<A-p>' '<cmd>Telescope projects<CR>' {} 'Telescope Projects'
  nnoremap '<leader>tht'(function() builtins.help_tags(ivy) end) {} 'Telescope Help tags'
  nnoremap '<leader>thk'(function() builtins.keymaps(ivy) end) {} 'Telescope Keymaps'
  nnoremap '<leader>thi'(builtins.highlights) {} 'Telescope Higlights'
  nnoremap '<leader>gb'(builtins.git_branches) {} 'Telescope Git Branches'
  nnoremap '<leader>gc'(builtins.git_status) { silent = true } 'Telescope git changes'
  nnoremap '<leader><space>'(builtins.fd) { silent = true } 'Telescope File Finder'
  nnoremap 'gb' '<cmd>Telescope buffers previewer=false theme=dropdown initial_mode=normal<CR>' {} 'Telescope Buffers'
  nnoremap 'go'(builtins.oldfiles) { silent = true } 'Telescope oldfiles'
  -- nnoremap 'gw'(builtins.live_grep) { silent = true } 'Telescope live grep'
  nnoremap 'gW'(builtins.grep_string) { silent = true } 'Telescope grep word under cursor'
  nnoremap 'gw'(
    function() builtins.grep_string { search = vim.fn.input { prompt = 'Grep > ' } } end
  ) {
    silent = true,
  } 'Telescope grep and filter'
  nnoremap 'gn'(find_notes) { silent = true } 'Find notes'
  vim.notify('Telescope keymaps setup', vim.log.levels.INFO)
end

explorer.harpoon = {
  spec = {
    'ThePrimeagen/harpoon',
    keys = { '<c-b>', '<c-e>', '<c-n>', '<c-l>', '<c-h>', '<c-;>' },
    config = function() require('plugins.explorer').harpoon.setup() end,
  },
  setup = function()
    require('harpoon').setup { global_settings = { mark_branch = true } }
    local mark = require 'harpoon.mark'
    local harpoon = require 'harpoon.ui'

    nnoremap '<c-b>'(mark.add_file) {} 'Add file to harpoon'
    nnoremap '<c-e>'(harpoon.toggle_quick_menu) {} 'Toggle harpoon menu'
    nnoremap '<c-n>'(function() harpoon.nav_file(1) end) {} 'Jump to file 1 in harpoon'
    nnoremap '<c-l>'(function() harpoon.nav_file(2) end) {} 'Jump to file 2 in harpoon'
    nnoremap '<c-h>'(function() harpoon.nav_file(3) end) {} 'Jump to file 3 in harpoon'
    nnoremap '<c-;>'(function() harpoon.nav_file(4) end) {} 'Jump to file 4 in harpoon'
  end,
}

explorer.telescope = {
  spec = {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = { 'Telescope' },
    config = function() require('plugins.explorer').telescope.setup() end,
  },

  setup = function()
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
  end,

  diagnostic_keymaps = function()
    local builtins = require 'telescope.builtin'
    local themes = require 'telescope.themes'
    local document_diagnostics_config =
      { layout_config = { height = 12 }, bufnr = 0, initial_mode = 'normal' }
    local workspace_diagnostics_config =
      { layout_config = { height = 12, preview_width = 80 }, initial_mode = 'normal' }

    nnoremap '<leader>dd'(
      function() builtins.diagnostics(themes.get_ivy(document_diagnostics_config)) end
    ) {} 'Document diagnostics'
    nnoremap '<leader>dw'(
      function() builtins.diagnostics(themes.get_ivy(workspace_diagnostics_config)) end
    ) {} 'Workspace diagnostics'
  end,
}

explorer.neotree = {
  spec = {
    'nvim-neo-tree/neo-tree.nvim',
    version = 'v2.x',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    cmd = { 'Explorer' },
    config = function() require('plugins.explorer').neotree.setup() end,
  },
  setup = function()
    vim.api.nvim_create_user_command('Explorer', 'NeoTreeFocusToggle', { nargs = 0 })
    require('neo-tree').setup {
      close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
      default_component_configs = {
        container = { enable_character_fade = true },
        indent = { padding = 0 },
        name = { trailing_slash = true },
        git_status = { symbols = { added = '✚', modified = '' } },
      },
      window = {
        position = 'right',
        width = 40,
        mappings = {
          ['l'] = 'open',
          ['s'] = 'split_with_window_picker',
          ['v'] = 'vsplit_with_window_picker',
          ['t'] = 'open_tabnew',
          ['<cr>'] = 'open_with_window_picker',
          ['h'] = 'close_node',
          ['z'] = 'close_all_nodes',
          ['Z'] = 'expand_all_nodes',
          ['a'] = { 'add', config = { show_path = 'absolute' } },
          ['A'] = 'add_directory', -- also accepts the optional config.show_path option like "add".
          ['d'] = 'delete',
          ['r'] = 'rename',
          ['y'] = 'copy_to_clipboard',
          ['x'] = 'cut_to_clipboard',
          ['p'] = 'paste_from_clipboard',
          ['c'] = 'copy', -- takes text input for destination, also accepts the optional config.show_path option like "add":
          -- ["c"] = {
          --  "copy",
          --  config = {
          --    show_path = "none" -- "none", "relative", "absolute"
          --  }
          --}
          ['m'] = 'move', -- takes text input for destination, also accepts the optional config.show_path option like "add".
        },
      },
      filesystem = {
        filtered_items = {
          visible = false,
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = false,
        },
        follow_current_file = true,
        hijack_netrw_behavior = 'open_current', -- netrw disabled, opening a directory opens neo-tree
        window = {
          mappings = {
            ['gp'] = 'prev_git_modified',
            ['gn'] = 'next_git_modified',
          },
        },
      },
    }
  end,
}

explorer.filetree = explorer.neotree

explorer.spec = {
  explorer.telescope.spec,
  explorer.filetree.spec,
  explorer.harpoon.spec,
}

return explorer
