local M = {}

M.nvim_tree = {
  'nvim-tree/nvim-tree.lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  cmd = { 'Explorer' },
  commit = '9c97e6449b0b0269bd44e1fd4857184dfa57bb4c',
  opts = function()
    vim.api.nvim_create_user_command('Explorer', 'NvimTreeToggle', { nargs = 0 })
    local function grep_at_current_tree_node()
      local node = require('nvim-tree.lib').get_node_at_cursor()
      if not node then return end
      require('telescope.builtin').live_grep { search_dirs = { node.absolute_path } }
    end

    local group = vim.api.nvim_create_augroup('nvim-tree', { clear = true })
    vim.api.nvim_create_autocmd({ 'WinEnter', 'BufWinEnter' }, {
      pattern = 'NvimTree*',
      group = group,
      callback = function() vim.cmd [[ setlocal statuscolumn= nonu nornu ]] end,
    })

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
    return {
      disable_netrw = true,
      hijack_cursor = true,
      hijack_netrw = true,
      hijack_unnamed_buffer_when_opening = true,
      reload_on_bufenter = true,
      respect_buf_cwd = true,
      on_attach = 'disable',
      select_prompts = true,
      view = {
        centralize_selection = true,
        cursorline = true,
        width = 40,
        side = 'right',
        mappings = mappings,
        float = {
          enable = true,
          quit_on_focus_loss = true,
          open_win_config = function()
            local HEIGHT_RATIO = 0.9
            local WIDTH_RATIO = 0.2
            local screen_w = vim.opt.columns:get()
            local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
            local window_w = screen_w * WIDTH_RATIO
            local window_h = screen_h * HEIGHT_RATIO
            local window_w_int = math.floor(window_w)
            local window_h_int = math.floor(window_h)
            local center_x = (screen_w - window_w - (screen_w * 0.03))
            local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
            return {
              border = 'rounded',
              relative = 'editor',
              row = center_y,
              col = center_x,
              width = window_w_int,
              height = window_h_int,
            }
          end,
        },
      },
      renderer = {
        add_trailing = true,
        highlight_git = true,
        full_name = true,
        highlight_opened_files = 'name',
        indent_width = 2,
        indent_markers = { enable = true },
        special_files = {
          'Cargo.toml',
          'Makefile',
          'README.md',
          'readme.md',
          'readme.rst',
          'README.rst',
          'README',
        },
      },
      update_focused_file = { enable = true },
      diagnostics = {
        enable = true,
        show_on_dirs = true,
        show_on_open_dirs = false,
        debounce_delay = 50,
      },
      modified = { enable = true },
      trash = { cmd = 'trash' },
    }
  end,
}

M.spec = {
  M.nvim_tree,
}

return M.spec
