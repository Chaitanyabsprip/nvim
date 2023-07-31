local explorer = {}

explorer.better_qf = {
  'kevinhwang91/nvim-bqf',
  ft = 'qf',
  dependencies = { 'yorickpeterse/nvim-pqf' },
  opts = {},
}

local function on_attach(bufnr)
  local api = require 'nvim-tree.api'
  local function opts(desc)
    return {
      desc = 'nvim-tree: ' .. desc,
      buffer = bufnr,
      noremap = true,
      silent = true,
      nowait = true,
    }
  end
  local function grep_at_current_tree_node()
    local node = require('nvim-tree.lib').get_node_at_cursor()
    if not node then return end
    require('telescope.builtin').live_grep { search_dirs = { node.absolute_path } }
  end

  api.config.mappings.default_on_attach(bufnr)

  vim.keymap.del('n', ']e', { buffer = bufnr })
  vim.keymap.del('n', '[e', { buffer = bufnr })

  vim.keymap.set('n', 'l', api.node.open.edit, opts 'Open')
  vim.keymap.set('n', 'cd', api.tree.change_root_to_node, opts 'CD')
  vim.keymap.set('n', 'v', api.node.open.vertical, opts 'Open: Vertical Split')
  vim.keymap.set('n', 's', api.node.open.horizontal, opts 'Open: Horizontal Split')
  vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts 'Close Directory')
  vim.keymap.set('n', '<S-CR>', api.node.navigate.parent_close, opts 'Close Directory')
  vim.keymap.set('n', 'o', api.node.run.system, opts 'Run System')
  vim.keymap.set('n', ',n', api.node.navigate.diagnostics.next, opts 'Next Diagnostic')
  vim.keymap.set('n', ',p', api.node.navigate.diagnostics.prev, opts 'Prev Diagnostic')
  vim.keymap.set('n', 'gr', grep_at_current_tree_node, opts 'Telescope Live Grep at node')
end

explorer.nvim_tree = {
  'nvim-tree/nvim-tree.lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  cmd = { 'Explorer' },
  opts = function()
    vim.api.nvim_create_user_command('Explorer', 'NvimTreeToggle', { nargs = 0 })
    local group = vim.api.nvim_create_augroup('nvim-tree', { clear = true })
    vim.api.nvim_create_autocmd({ 'BufWinEnter' }, {
      pattern = 'NvimTree*',
      group = group,
      callback = function() vim.cmd [[ setlocal statuscolumn= nonu nornu ]] end,
    })
    return {
      disable_netrw = true,
      hijack_cursor = true,
      hijack_netrw = true,
      hijack_unnamed_buffer_when_opening = true,
      reload_on_bufenter = true,
      respect_buf_cwd = true,
      on_attach = on_attach,
      select_prompts = true,
      view = {
        centralize_selection = true,
        cursorline = true,
        width = 40,
        side = 'right',
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

explorer.pretty_qf = {
  'yorickpeterse/nvim-pqf',
  event = 'Filetype qf',
  opts = {},
}

explorer.project = {
  'ahmedkhalf/project.nvim',
  dependencies = {
    {
      'nvim-telescope/telescope.nvim',
      keys = {
        {
          '<c-p>',
          function() require('telescope').extensions.projects.projects() end,
          noremap = true,
          desc = 'Search projects',
        },
      },
    },
  },
  config = function()
    require('project_nvim').setup { ignore_lsp = { 'null-ls' } }
    require('telescope').load_extension 'projects'
  end,
}

explorer.spec = {
  explorer.better_qf,
  explorer.nvim_tree,
  explorer.pretty_qf,
  explorer.project,
}

return explorer.spec
