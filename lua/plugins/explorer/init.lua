local explorer = {}

explorer.better_qf = {
  'kevinhwang91/nvim-bqf',
  ft = 'qf',
  dependencies = { 'yorickpeterse/nvim-pqf' },
  opts = {
    auto_resize_height = true,
    func_map = { open = 'o', openc = '<cr>' },
  },
}

local function harpoon_keys(keys)
  local mappings = {}
  for i = 1, 9 do
    local mapping = {
      string.format('<a-%d>', i),
      function() require('harpoon.ui').nav_file(i) end,
      noremap = true,
      desc = string.format('Jump to file %d in harpoon', i),
    }
    table.insert(mappings, mapping)
  end
  for _, obj in ipairs(keys) do
    table.insert(mappings, obj)
  end
  return mappings
end

explorer.harpoon = {
  'ThePrimeagen/harpoon',
  keys = harpoon_keys {
    {
      '<c-b>',
      function() require('harpoon.mark').add_file() end,
      noremap = true,
      desc = 'Add file to harpoon',
    },
    {
      '<c-f>',
      function() require('harpoon.ui').toggle_quick_menu() end,
      noremap = true,
      desc = 'Toggle harpoon marks list',
    },
    {
      '<c-n>',
      function() require('harpoon.ui').nav_file(1) end,
      noremap = true,
      desc = 'Jump to file 1 in harpoon',
    },
    {
      '<c-e>',
      function() require('harpoon.ui').nav_file(2) end,
      noremap = true,
      desc = 'Jump to file 2 in harpoon',
    },
    {
      '<c-o>',
      function() require('harpoon.ui').nav_file(3) end,
      noremap = true,
      desc = 'Jump to file 3 in harpoon',
    },
    {
      '<c-s>',
      function() require('harpoon.ui').nav_file(4) end,
      noremap = true,
      desc = 'Jump to file 4 in harpoon',
    },
  },
  opts = { global_settings = { mark_branch = true } },
}

explorer.oil = {
  'stevearc/oil.nvim',
  event = 'VeryLazy',
  cmd = { 'Oil', 'Explorer' },
  opts = function()
    vim.api.nvim_create_user_command('Explorer', function()
      if vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(0), 'filetype') == 'oil' then
        require('oil').close()
      else
        return require('oil').open_float()
      end
    end, { nargs = 0 })
    return {
      default_file_explorer = true,
      columns = { 'icon', 'permissions' }, -- See :help oil-columns
      buf_options = { buflisted = false, bufhidden = 'hide' },
      win_options = {
        wrap = false,
        signcolumn = 'no',
        cursorcolumn = false,
        foldcolumn = '0',
        spell = false,
        list = false,
        conceallevel = 3,
        concealcursor = 'nvic',
      },
      delete_to_trash = false,
      skip_confirm_for_simple_edits = false, -- Skip the confirmation popup for simple operations
      trash_command = 'trash', -- Change this to customize the command used when deleting to trash
      -- Selecting a new/moved/renamed file or directory will prompt you to save changes first
      prompt_save_on_select_new_entry = true,
      keymaps = { -- See :help oil-actions for a list of all available actions
        ['g?'] = 'actions.show_help',
        ['<CR>'] = 'actions.select',
        ['L'] = 'actions.select',
        ['s'] = 'actions.select_split',
        ['S'] = 'actions.select_vsplit',
        ['<C-t>'] = 'actions.select_tab',
        ['<C-p>'] = 'actions.preview',
        ['<C-c>'] = 'actions.close',
        ['q'] = 'actions.close',
        ['<C-l>'] = 'actions.refresh',
        ['H'] = 'actions.parent',
        ['_'] = 'actions.open_cwd',
        ['`'] = 'actions.cd',
        ['~'] = 'actions.tcd',
        ['gs'] = 'actions.change_sort',
        ['g.'] = 'actions.toggle_hidden',
      },
      use_default_keymaps = false, -- Set to false to disable all of the above keymaps
      view_options = {
        show_hidden = true, -- Show files and directories that start with "."
        is_hidden_file = function(name, bufnr) return vim.startswith(name, '.') end,
        is_always_hidden = function(name, bufnr) return false end,
        sort = { { 'type', 'asc' }, { 'name', 'asc' } }, -- see :help oil-columns to see sortable cols
      },
      float = {
        padding = 1,
        max_width = 50,
        max_height = 20,
        border = 'rounded',
        win_options = { winblend = 0 },
        override = function(conf)
          local HEIGHT_RATIO = 0.9
          local WIDTH_RATIO = 0.3
          local screen_w = vim.opt.columns:get()
          local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
          local window_w = screen_w * WIDTH_RATIO
          local window_h = screen_h * HEIGHT_RATIO
          local window_w_int = math.floor(window_w)
          local window_h_int = math.floor(window_h)
          local center_x = (screen_w - window_w - (screen_w * 0.03))
          local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
          conf.row = center_y
          conf.col = center_x
          conf.width = window_w_int
          conf.height = window_h_int
          return conf
        end,
      },
      preview = {
        max_width = { 80, 0.6 },
        min_width = { 40, 0.4 },
        width = nil,
        max_height = { 30, 0.9 },
        min_height = { 5, 0.1 },
        height = nil,
        border = 'rounded',
        win_options = { winblend = 0 },
      },
      progress = {
        max_width = 0.9,
        min_width = { 40, 0.4 },
        width = nil,
        max_height = { 10, 0.9 },
        min_height = { 5, 0.1 },
        height = nil,
        border = 'rounded',
        minimized_border = 'none',
        win_options = { winblend = 0 },
      },
    }
  end,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
}

explorer.pretty_qf = {
  'yorickpeterse/nvim-pqf',
  event = 'Filetype qf',
  opts = {},
}

explorer.spec = {
  explorer.better_qf,
  explorer.harpoon,
  explorer.oil,
  explorer.pretty_qf,
}

return explorer.spec
