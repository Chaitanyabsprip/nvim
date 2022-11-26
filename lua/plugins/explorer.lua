---@diagnostic disable: undefined-global

local M = {}
local nnoremap = require('utils').nnoremap
local notesdir = vim.fn.expand '$HOME' .. '/Projects/Notes'

M.filetree = function()
  local fileTree = require 'filetree'
  local mapping = fileTree.Mapping
  fileTree:setup {
    view = {
      line_width = 6,
      show_dot_files = true,
    },
    mapping = {
      wrap_cursor = true,
      close_children = true,
      yank_file_names = 'path',
      keymaps = {
        ['j'] = mapping:cursor_down(),
        ['k'] = mapping:cursor_up(),
        ['l'] = mapping:open(),
        ['h'] = mapping:close(),
        ['<Enter>'] = mapping:enter(),
        ['w'] = mapping:mark(false),
        ['W'] = mapping:mark(true),
        ['N'] = mapping:make_file(),
        ['a'] = mapping:make_file(),
        ['K'] = mapping:make_directory(),
        ['A'] = mapping:make_directory(),
        ['r'] = mapping:rename(),
        ['R'] = mapping:rename 'name',
        ['e'] = mapping:rename 'ext',
        ['c'] = mapping:copy(),
        ['m'] = mapping:move(),
        ['x'] = mapping:move(),
        ['d'] = mapping:remove(),
        ['y'] = mapping:yank(),
        ['p'] = mapping:paste(),
        ['P'] = mapping:pack(false),
        ['C'] = mapping:compress(false),
        ['i'] = mapping:info(),
        ['v'] = mapping:preview(),
        ['H'] = mapping:toggle_hidden(),
        [','] = mapping:redraw(),
        [';'] = mapping:reload(),
        ['<Esc>'] = mapping:clear(),
      },
    },
    file_preview = {
      quit_on_esc = true,
      type = 'float',
      relative = 'editor',
      absolute = false,
      width = 0.9,
      height = 0.7,
      row = 0.5,
      col = 0.5,
      border = 'single',
      number = true,
      relativenumber = true,
    },
    filters = {
      exclude = {
        dot_files = false,
        pattern = '',
      },
    },
    actions = {
      sort_nodes = {
        method = 'name',
        directories = 'top',
        reverse = false,
      },
      open_file = {
        quit_tree = false,
        window_picker = {
          enable = true,
          ids = 'aoeuhtns',
          exclude = {
            buftypes = { 'nofile', 'help' },
            bufnames = {},
          },
        },
      },
    },
  }
  -- _G.filetree:enable_extension('icons', { position = 'first' })
  -- vim.cmd 'FTreeOpen'
end

M.lir = function()
  local actions = require 'lir.actions'
  local mark_actions = require 'lir.mark.actions'
  local clipboard_actions = require 'lir.clipboard.actions'
  require('lir').setup {
    show_hidden_files = true,
    mappings = {
      ['l'] = actions.edit,
      ['<cr>'] = actions.edit,
      ['<C-s>'] = actions.split,
      ['<C-v>'] = actions.vsplit,
      ['<C-t>'] = actions.tabedit,
      ['h'] = actions.up,
      ['q'] = actions.quit,
      ['A'] = actions.mkdir,
      ['a'] = actions.newfile,
      ['r'] = actions.rename,
      ['cd'] = actions.cd,
      ['Y'] = actions.yank_path,
      ['.'] = actions.toggle_show_hidden,
      ['d'] = actions.delete,
      ['<space>'] = function()
        mark_actions.toggle_mark()
        vim.cmd 'normal! j'
      end,
      ['c'] = clipboard_actions.copy,
      ['x'] = clipboard_actions.cut,
      ['p'] = clipboard_actions.paste,
    },
    -- float = {
    --   winblend = 10,
    --   curdir_window = {
    --     enable = false,
    --     highlight_dirname = false,
    --   },
    --   -- -- You can define a function that returns a table to be passed as the third
    --   -- -- argument of nvim_open_win().
    --   -- win_opts = function()
    --   --   local width = math.floor(vim.o.columns * 0.8)
    --   --   local height = math.floor(vim.o.lines * 0.8)
    --   --   return {
    --   --     border = require("lir.float.helper").make_border_opts({
    --   --       "+", "─", "+", "│", "+", "─", "+", "│",
    --   --     }, "Normal"),
    --   --     width = width,
    --   --     height = height,
    --   --     row = 1,
    --   --     col = math.floor((vim.o.columns - width) / 2),
    --   --   }
    --   -- end,
    -- },
  }
  nnoremap('<M-e>', '<cmd>lua require("lir.float").toggle(vim.fn.getcwd())<CR>')
  nnoremap(
    '<M-n>',
    "<cmd>lua require('lir.float').toggle('" .. notesdir .. "')<CR>"
  )
end

M.neofs = function()
  require('neofs').setup {
    devicons = true,
    mappings = {
      ['r'] = function(_)
        NeofsRename()
      end,
      ['a'] = function(_)
        NeofsCreateFile()
      end,
      ['A'] = function(_)
        NeofsCreateDirectory()
      end,
      ['d'] = function(fm)
        if fm.navigator.item().type == 'directory' then
          NeofsDelete(true)
        else
          NeofsDelete(false)
        end
      end,
    },
  }
  nnoremap('<leader>FF', "<cmd>lua require('neofs').open()<cr>", true)
  nnoremap(
    '<leader>FN',
    "<cmd>lua require('neofs').open('" .. notesdir .. "')<cr>",
    true
  )
end

M.nvim_tree = function()
  function M.grep_at_current_tree_node()
    local node = require('nvim-tree.lib').get_node_at_cursor()
    if not node then
      return
    end
    require('telescope.builtin').live_grep {
      search_dirs = { node.absolute_path },
    }
  end

  local tree_cb = require('nvim-tree.config').nvim_tree_callback
  local mappings = {
    custom_only = false,
    list = {
      {
        key = { '<Leader>gr', 'gr' },
        cb = ":lua require'plugins.explorer'.grep_at_current_tree_node()<CR>",
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
    actions = { change_dir = { restrict_above_cwd = false } },
    auto_reload_on_write = true,
    diagnostics = {
      enable = true,
      show_on_dirs = true,
      icons = { hint = '', info = '', warning = '', error = '' },
    },
    update_focused_file = { enable = true, update_cwd = false },
    disable_netrw = true,
    filters = { dotfiles = false, custom = {}, exclude = {} },
    git = { enable = true, ignore = true, timeout = 400 },
    hijack_directories = { enable = true, auto_open = true },
    hijack_netrw = true,
    hijack_unnamed_buffer_when_opening = true,
    ignore_buffer_on_setup = false,
    renderer = {
      indent_markers = { enable = true },
      highlight_git = true,
      highlight_opened_files = '4',
      group_empty = true,
    },
    sort_by = 'name',
    trash = { cmd = 'trash', require_confirm = true },
    update_cwd = true,
    view = {
      width = 40,
      side = 'right',
      preserve_window_proportions = false,
      mappings = mappings,
    },
  }
  nnoremap('<leader>e', ':NvimTreeToggle<CR>', true)
  nnoremap('<leader>n', '<CMD>NvimTreeFindFile<CR>', true)
end

M.project = function()
  require('project_nvim').setup {
    manual_mode = false,
    detection_methods = { 'lsp', 'pattern' },
    patterns = {
      '.git',
      '.gitignore',
      'pubspec.yaml',
      'cargo.toml',
      'config.py',
      'go.mod',
      'makefile',
      'setup.py',
      vim.fn.getcwd(),
    },
    ignore_lsp = { 'null-ls' },
    show_hidden = true,
    silent_chdir = false,
    datapath = vim.fn.stdpath 'data',
  }
  require('telescope').load_extension 'projects'
end

M.snap = function()
  local snap = require 'snap'
  snap.register.map({ 'n' }, { '<leader>fg' }, function()
    snap.run {
      producer = snap.get 'consumer.limit'(
        100000,
        snap.get 'producer.ripgrep.vimgrep'
      ),
      select = snap.get('select.vimgrep').select,
      multiselect = snap.get('select.vimgrep').multiselect,
      views = { snap.get 'preview.vimgrep' },
    }
  end)
  snap.register.map({ 'n' }, { '<leader><leader>' }, function()
    snap.run {
      producer = snap.get 'consumer.fzf'(snap.get 'producer.ripgrep.file'),
      select = snap.get('select.file').select,
      multiselect = snap.get('select.file').multiselect,
      views = { snap.get 'preview.file' },
    }
  end)
  snap.register.map({ 'n' }, { '<leader>fb' }, function()
    snap.run {
      producer = snap.get 'consumer.fzf'(snap.get 'producer.vim.buffer'),
      select = snap.get('select.file').select,
      multiselect = snap.get('select.file').multiselect,
      views = { snap.get 'preview.file' },
    }
  end)
  snap.register.map({ 'n' }, { '<leader>fo' }, function()
    snap.run {
      producer = snap.get 'consumer.fzf'(snap.get 'producer.vim.oldfile'),
      select = snap.get('select.file').select,
      multiselect = snap.get('select.file').multiselect,
      views = { snap.get 'preview.file' },
    }
  end)
  snap.register.map({ 'n' }, { '<leader>fn' }, function()
    snap.run {
      producer = snap.get 'consumer.fzf'(
        snap
          .get('producer.ripgrep.file')
          .args({}, vim.fn.expand '$HOME' .. '/Projects/Notes')
      ),
      select = snap.get('select.file').select,
      multiselect = snap.get('select.file').multiselect,
      views = { snap.get 'preview.file' },
    }
  end)
end

return M
