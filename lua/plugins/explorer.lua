local explorer = {}
local nnoremap = require('mappings.hashish').nnoremap
explorer.fuzzy = require 'plugins.fuzzy.telescope'

explorer.bqf = {
  spec = {
    'kevinhwang91/nvim-bqf',
    ft = 'qf',
    config = function() require('bqf').setup {} end,
  },
}

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

    nnoremap '<c-b>'(mark.add_file) 'Add file to harpoon'
    nnoremap '<c-e>'(harpoon.toggle_quick_menu) 'Toggle harpoon menu'
    nnoremap '<c-n>'(function() harpoon.nav_file(1) end) 'Jump to file 1 in harpoon'
    nnoremap '<c-l>'(function() harpoon.nav_file(2) end) 'Jump to file 2 in harpoon'
    nnoremap '<c-h>'(function() harpoon.nav_file(3) end) 'Jump to file 3 in harpoon'
    nnoremap '<c-;>'(function() harpoon.nav_file(4) end) 'Jump to file 4 in harpoon'
  end,
}

explorer.nvim_tree = {
  spec = {
    'kyazdani42/nvim-tree.lua',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    cmd = { 'Explorer' },
    config = function() require('plugins.explorer').nvim_tree.setup() end,
  },
  setup = function()
    vim.api.nvim_create_user_command('Explorer', 'NvimTreeToggle', { nargs = 0 })
    local function grep_at_current_tree_node()
      local node = require('nvim-tree.lib').get_node_at_cursor()
      if not node then return end
      require('telescope.builtin').live_grep { search_dirs = { node.absolute_path } }
    end

    local tree_cb = require('nvim-tree.config').nvim_tree_callback
    local mappings = {
      custom_only = false,
      list = {
        {
          key = { '<Leader>gr', 'gr' },
          cb = grep_at_current_tree_node,
          mode = 'n',
        },
        { key = { '<CR>', '<2-LeftMouse>', 'l' }, cb = tree_cb 'edit' },
        { key = { '<2-RightMouse>', '<C-]>', 'cd' }, cb = tree_cb 'cd' },
        { key = { '<C-v>', 'v' }, cb = tree_cb 'vsplit' },
        { key = { '<C-x>', 's' }, cb = tree_cb 'split' },
        { key = { '<BS>', 'h', '<S-CR>' }, cb = tree_cb 'close_node' },
        { key = { 'o' }, cb = tree_cb 'system_open' },
      },
    }
    require('nvim-tree').setup {
      diagnostics = {
        debounce_delay = 400,
        enable = true,
        show_on_dirs = true,
        show_on_open_dirs = false,
      },
      filters = { dotfiles = false },
      git = { enable = true, ignore = true, show_on_open_dirs = false, timeout = 400 },
      renderer = {
        add_trailing = true,
        full_name = true,
        highlight_git = true,
        indent_markers = { enable = true },
      },
      trash = { cmd = 'trash', require_confirm = true },
      sync_root_with_cwd = true,
      update_focused_file = { enable = true },
      view = {
        centralize_selection = true,
        mappings = mappings,
        preserve_window_proportions = true,
        side = 'right',
        width = 40,
      },
    }
  end,
}

explorer.filetree = explorer.nvim_tree

explorer.spec = {
  explorer.bqf.spec,
  explorer.filetree.spec,
  explorer.harpoon.spec,
  explorer.fuzzy.spec,
}

return explorer
